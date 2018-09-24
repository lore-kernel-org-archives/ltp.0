From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 24 Sep 2018 10:51:47 +0200
Subject: [LTP] [RFC PATCH 0/3] Remove some userspace related tests
Message-ID: <20180924085150.17555-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

there was some discussion to remove userspace related tests in the past
[1]. This patchset does something similar for ftp and ssh login
commands and cron tests (part of EAL2 testsuite) + EAL2 testsuite script
itself. They're unmaintained and related to userspace security rather
than kernel security.  Other non-filesystem or non-kernel related
commands (e.g. tar, gzip, file) should be deleted as well, as Sebastian
proposed [2].

We've recently discussed with Cyril the idea of ltp-userspace package.
We can create this project and move this code there if anyone step up
being a maintainer of it.


Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2018-April/007899.html
[2] http://lists.linux.it/pipermail/ltp/2018-April/007898.html

Petr Vorel (3):
  testscripts: Remove EAL2 testsuite script
  net: Remove network_commands (ftp, ssh)
  Remove cron tests

 runtest/admin_tools                           |   9 -
 runtest/commands                              |   1 -
 runtest/network_commands                      |   8 -
 scenario_groups/default                       |   1 -
 scenario_groups/network                       |   1 -
 testcases/commands/.gitignore                 |   1 -
 testcases/commands/cron/00_Descriptions.txt   |   4 -
 testcases/commands/cron/Makefile              |  29 --
 testcases/commands/cron/README.tests          |  25 --
 testcases/commands/cron/cron02                |  80 -----
 testcases/commands/cron/cron03                |  83 ------
 testcases/commands/cron/cron_allow01          | 202 -------------
 testcases/commands/cron/cron_deny01           | 192 ------------
 testcases/commands/cron/cron_dirs_check.c     |  44 ---
 testcases/commands/cron/cron_dirs_checks01    |  46 ---
 .../commands/cron/cron_illegal_cron_lines     |  39 ---
 testcases/commands/cron/cron_neg_tests.sh     | 141 ---------
 testcases/commands/cron/cron_pos_tests.sh     | 118 --------
 testcases/commands/cron/cron_tests.sh         | 276 ------------------
 testcases/network/tcp_cmds/ftp/ftp02          |  98 -------
 testcases/network/tcp_cmds/ftp/ftp03          | 106 -------
 testcases/network/tcp_cmds/ftp/ftp04          |  81 -----
 testcases/network/tcp_cmds/ftp/ftp05          | 110 -------
 testcases/network/tcp_cmds/ssh/Makefile       |  31 --
 testcases/network/tcp_cmds/ssh/ssh01          |  57 ----
 testcases/network/tcp_cmds/ssh/ssh01_s1       |  72 -----
 testcases/network/tcp_cmds/ssh/ssh02          |  57 ----
 testcases/network/tcp_cmds/ssh/ssh02_s1       |  73 -----
 testcases/network/tcp_cmds/ssh/ssh03          |  52 ----
 testcases/network/tcp_cmds/ssh/ssh03_s1       |  67 -----
 testcases/network/tcp_cmds/ssh/ssh_setup      |  54 ----
 testscripts/runEALtests.sh                    | 235 ---------------
 32 files changed, 2393 deletions(-)
 delete mode 100644 runtest/admin_tools
 delete mode 100644 runtest/network_commands
 delete mode 100644 testcases/commands/cron/00_Descriptions.txt
 delete mode 100644 testcases/commands/cron/Makefile
 delete mode 100644 testcases/commands/cron/README.tests
 delete mode 100755 testcases/commands/cron/cron02
 delete mode 100755 testcases/commands/cron/cron03
 delete mode 100755 testcases/commands/cron/cron_allow01
 delete mode 100755 testcases/commands/cron/cron_deny01
 delete mode 100644 testcases/commands/cron/cron_dirs_check.c
 delete mode 100755 testcases/commands/cron/cron_dirs_checks01
 delete mode 100644 testcases/commands/cron/cron_illegal_cron_lines
 delete mode 100755 testcases/commands/cron/cron_neg_tests.sh
 delete mode 100755 testcases/commands/cron/cron_pos_tests.sh
 delete mode 100644 testcases/commands/cron/cron_tests.sh
 delete mode 100755 testcases/network/tcp_cmds/ftp/ftp02
 delete mode 100755 testcases/network/tcp_cmds/ftp/ftp03
 delete mode 100755 testcases/network/tcp_cmds/ftp/ftp04
 delete mode 100755 testcases/network/tcp_cmds/ftp/ftp05
 delete mode 100644 testcases/network/tcp_cmds/ssh/Makefile
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh01
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh01_s1
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh02
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh02_s1
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh03
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh03_s1
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh_setup
 delete mode 100755 testscripts/runEALtests.sh

-- 
2.19.0

