From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 28 Sep 2018 10:17:47 +0800
Subject: [LTP] [RFC PATCH v2 0/3] Remove some userspace related tests
In-Reply-To: <20180927145720.31014-1-pvorel@suse.cz>
References: <20180927145720.31014-1-pvorel@suse.cz>
Message-ID: <5BAD8F4B.2030202@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

This patch set looks good to me.

Thanks,
Xiao Yang
On 2018/09/27 22:57, Petr Vorel wrote:
> Hi,
>
> Changes v1->v2:
> change in 3rd patch:
> * at: removed at_allow01, at_deny01, Makefiles
> * Removed also su and acls tests.
>
> Petr Vorel (3):
>    testscripts: Remove EAL2 testsuite script
>    net: Remove network_commands (ftp, ssh)
>    Remove admin_tools test
>
>   runtest/admin_tools                           |   9 -
>   runtest/commands                              |   1 -
>   runtest/network_commands                      |   8 -
>   scenario_groups/default                       |   1 -
>   scenario_groups/network                       |   1 -
>   testcases/commands/.gitignore                 |   1 -
>   testcases/commands/at/Makefile                |  31 --
>   testcases/commands/at/at_allow01              | 188 -------
>   testcases/commands/at/at_deny01               | 195 -------
>   testcases/commands/cron/00_Descriptions.txt   |   4 -
>   testcases/commands/cron/Makefile              |  29 --
>   testcases/commands/cron/README.tests          |  25 -
>   testcases/commands/cron/cron02                |  80 ---
>   testcases/commands/cron/cron03                |  83 ---
>   testcases/commands/cron/cron_allow01          | 202 --------
>   testcases/commands/cron/cron_deny01           | 192 -------
>   testcases/commands/cron/cron_dirs_check.c     |  44 --
>   testcases/commands/cron/cron_dirs_checks01    |  46 --
>   .../commands/cron/cron_illegal_cron_lines     |  39 --
>   testcases/commands/cron/cron_neg_tests.sh     | 141 -----
>   testcases/commands/cron/cron_pos_tests.sh     | 118 -----
>   testcases/commands/cron/cron_tests.sh         | 276 ----------
>   testcases/commands/su/Makefile                |  31 --
>   testcases/commands/su/su01                    | 181 -------
>   testcases/commands/su/su01_s1                 | 486 ------------------
>   testcases/commands/su/su_set_passwd           |  14 -
>   testcases/kernel/fs/acls/.gitignore           |   2 -
>   testcases/kernel/fs/acls/Makefile             |  40 --
>   testcases/kernel/fs/acls/acl_file_test.c      |  73 ---
>   testcases/kernel/fs/acls/acl_link_test.c      |  56 --
>   testcases/kernel/fs/acls/acl_test01           | 186 -------
>   testcases/network/tcp_cmds/ftp/ftp02          |  98 ----
>   testcases/network/tcp_cmds/ftp/ftp03          | 106 ----
>   testcases/network/tcp_cmds/ftp/ftp04          |  81 ---
>   testcases/network/tcp_cmds/ftp/ftp05          | 110 ----
>   testcases/network/tcp_cmds/ssh/Makefile       |  31 --
>   testcases/network/tcp_cmds/ssh/ssh01          |  57 --
>   testcases/network/tcp_cmds/ssh/ssh01_s1       |  72 ---
>   testcases/network/tcp_cmds/ssh/ssh02          |  57 --
>   testcases/network/tcp_cmds/ssh/ssh02_s1       |  73 ---
>   testcases/network/tcp_cmds/ssh/ssh03          |  52 --
>   testcases/network/tcp_cmds/ssh/ssh03_s1       |  67 ---
>   testcases/network/tcp_cmds/ssh/ssh_setup      |  54 --
>   testscripts/runEALtests.sh                    | 235 ---------
>   44 files changed, 3876 deletions(-)
>   delete mode 100644 runtest/admin_tools
>   delete mode 100644 runtest/network_commands
>   delete mode 100644 testcases/commands/at/Makefile
>   delete mode 100755 testcases/commands/at/at_allow01
>   delete mode 100755 testcases/commands/at/at_deny01
>   delete mode 100644 testcases/commands/cron/00_Descriptions.txt
>   delete mode 100644 testcases/commands/cron/Makefile
>   delete mode 100644 testcases/commands/cron/README.tests
>   delete mode 100755 testcases/commands/cron/cron02
>   delete mode 100755 testcases/commands/cron/cron03
>   delete mode 100755 testcases/commands/cron/cron_allow01
>   delete mode 100755 testcases/commands/cron/cron_deny01
>   delete mode 100644 testcases/commands/cron/cron_dirs_check.c
>   delete mode 100755 testcases/commands/cron/cron_dirs_checks01
>   delete mode 100644 testcases/commands/cron/cron_illegal_cron_lines
>   delete mode 100755 testcases/commands/cron/cron_neg_tests.sh
>   delete mode 100755 testcases/commands/cron/cron_pos_tests.sh
>   delete mode 100644 testcases/commands/cron/cron_tests.sh
>   delete mode 100644 testcases/commands/su/Makefile
>   delete mode 100755 testcases/commands/su/su01
>   delete mode 100755 testcases/commands/su/su01_s1
>   delete mode 100755 testcases/commands/su/su_set_passwd
>   delete mode 100644 testcases/kernel/fs/acls/.gitignore
>   delete mode 100644 testcases/kernel/fs/acls/Makefile
>   delete mode 100644 testcases/kernel/fs/acls/acl_file_test.c
>   delete mode 100644 testcases/kernel/fs/acls/acl_link_test.c
>   delete mode 100755 testcases/kernel/fs/acls/acl_test01
>   delete mode 100755 testcases/network/tcp_cmds/ftp/ftp02
>   delete mode 100755 testcases/network/tcp_cmds/ftp/ftp03
>   delete mode 100755 testcases/network/tcp_cmds/ftp/ftp04
>   delete mode 100755 testcases/network/tcp_cmds/ftp/ftp05
>   delete mode 100644 testcases/network/tcp_cmds/ssh/Makefile
>   delete mode 100755 testcases/network/tcp_cmds/ssh/ssh01
>   delete mode 100755 testcases/network/tcp_cmds/ssh/ssh01_s1
>   delete mode 100755 testcases/network/tcp_cmds/ssh/ssh02
>   delete mode 100755 testcases/network/tcp_cmds/ssh/ssh02_s1
>   delete mode 100755 testcases/network/tcp_cmds/ssh/ssh03
>   delete mode 100755 testcases/network/tcp_cmds/ssh/ssh03_s1
>   delete mode 100755 testcases/network/tcp_cmds/ssh/ssh_setup
>   delete mode 100755 testscripts/runEALtests.sh
>



