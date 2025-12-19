import socket
import datetime
from flask import Flask, render_template, request

app = Flask(__name__)

# 定义版本号（修改这里来演示版本更新）
APP_VERSION = "v3.0 (测试版)"

@app.route('/')
def index():
    # 获取容器的主机名（在 Docker 中，这通常是容器 ID）
    container_id = socket.gethostname()
    
    # 获取当前时间
    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # 获取访问者的 IP
    client_ip = request.remote_addr

    return render_template('index.html', 
                           version=APP_VERSION,
                           hostname=container_id,
                           current_time=now,
                           client_ip=client_ip)
if __name__ == '__main__':
    # 监听所有 IP，端口 5000
    app.run(host='0.0.0.0', port=5000)