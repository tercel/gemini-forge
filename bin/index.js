#!/usr/bin/env node

const { spawn } = require('child_process');
const path = require('path');

// Point to your original Bash script
const scriptPath = path.join(__dirname, 'gemini-forge');

// Run directly on Unix, try to run via bash on Windows (if it exists)
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
