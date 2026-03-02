#!/usr/bin/env node

const { spawn } = require('child_process');
const path = require('path');

// 指向你原来的 Bash 脚本
const scriptPath = path.join(__dirname, 'gemini-forge');

// 在 Unix 上直接运行，在 Windows 上尝试通过 bash 运行（如果存在）
const isWindows = process.platform === 'win32';
const shell = isWindows ? 'bash' : true;

const child = spawn(isWindows ? 'bash' : scriptPath, 
    isWindows ? [scriptPath, ...process.argv.slice(2)] : process.argv.slice(2), 
    { 
        stdio: 'inherit',
        shell: isWindows
    }
);

child.on('exit', (code) => {
    process.exit(code);
});
