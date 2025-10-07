from flask import Flask, request, jsonify
import subprocess
import logging
import os

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)

PLAYBOOK = os.environ.get('ANSIBLE_PLAYBOOK', '/playbooks/heal_nginx.yml')

@app.route('/alert', methods=['POST'])
def alert():
    data = request.get_json(force=True)
    app.logger.info('Received alert: %s', data)

    alerts = data.get('alerts', [])
    firing = [a for a in alerts if a.get('status') == 'firing']
    if not firing:
        return jsonify({'result': 'no firing alerts'}), 200

    try:
        app.logger.info('Running ansible-playbook %s', PLAYBOOK)
        res = subprocess.run(['ansible-playbook', PLAYBOOK], capture_output=True, text=True)
        app.logger.info('Ansible return code: %s', res.returncode)
        app.logger.info('Ansible stdout:\n%s', res.stdout)
        app.logger.info('Ansible stderr:\n%s', res.stderr)
        return jsonify({'returncode': res.returncode, 'stdout': res.stdout, 'stderr': res.stderr}), 200
    except Exception as e:
        app.logger.exception('Failed to run ansible')
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
