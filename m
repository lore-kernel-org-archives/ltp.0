From: Li Wang <liwang@redhat.com>
Date: Wed,  8 Aug 2018 13:54:28 +0800
Subject: [LTP] [PATCH 0/6] rewrite exec() family tests to newlib
Message-ID: <20180808055434.26293-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch set are base on Cyril's new patch(lib: Fix result propagation after exec() + tst_reinit())
to rewrite all exec[lvpe] testcase in new API. 

Change Log:

  exec[lv]e01: Put IPC_ENV_VAR in envp[] to propagate environment vairiable
               to child in execve().

  execve05: Verify execve(2) system call by spawning a few(nchild) children,
            each of which would execute "execve_child" at the same instant
            when the last forked child mark "start" in a share memory area.

New test pass on x86_64 with kernel-4.18-rc8:

Test Start Time: Wed Aug  8 01:45:06 2018
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
execl01                        PASS       0
execle01                       PASS       0
execlp01                       PASS       0
execv01                        PASS       0
execve01                       PASS       0
execve02                       PASS       0
execve03                       PASS       0
execve04                       PASS       0
execve05                       PASS       0
execvp01                       PASS       0

-----------------------------------------------
Total Tests: 10
Total Skipped Tests: 0
Total Failures: 0
Kernel Version: 4.18.0-rc8
Machine Architecture: x86_64

New test pass on ppc64 with kernel-4.18-rc7:

Test Start Time: Wed Aug  8 01:49:33 2018
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
execl01                        PASS       0
execle01                       PASS       0
execlp01                       PASS       0
execv01                        PASS       0
execve01                       PASS       0
execve02                       PASS       0
execve03                       PASS       0
execve04                       PASS       0
execve05                       PASS       0
execvp01                       PASS       0

-----------------------------------------------
Total Tests: 10
Total Skipped Tests: 0
Total Failures: 0
Kernel Version: 4.18.0-rc7
Machine Architecture: ppc64

-- 
2.9.5

