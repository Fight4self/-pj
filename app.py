from flask import Flask
app = Flask(__name__)

# 定义版本号（修改这里来演示版本更新）
APP_VERSION = "v3.0 (测试版)"

@app.route('/')
def hello():
    return 'Hello, Docker CI/CD World! v3.0 . Try to dep'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)