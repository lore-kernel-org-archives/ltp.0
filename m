From: Sebastian Chlad <schlad@suse.de>
Date: Thu, 26 Apr 2018 15:24:18 +0200
Subject: [LTP] [PATCH] commands: Remove all test cases
In-Reply-To: <20180426132418.19495-1-schlad@suse.de>
References: <20180426132418.19495-1-schlad@suse.de>
Message-ID: <20180426132418.19495-2-schlad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test cases testing commands are often outdated or not maintained.
Those test cases also do not fit in with current LTP project status.

Signed-off-by: Sebastian Chlad <schlad@suse.de>
---
 runtest/commands                                   |  43 --
 testcases/commands/.gitignore                      |   5 -
 testcases/commands/Makefile                        |  31 --
 testcases/commands/ar/Makefile                     |  29 --
 testcases/commands/ar/ar01                         | 356 ---------------
 testcases/commands/ar/datafiles/Makefile           |  19 -
 testcases/commands/ar/datafiles/file1.in           |   1 -
 testcases/commands/ar/datafiles/file10.in          |   1 -
 testcases/commands/ar/datafiles/file2.in           |   1 -
 testcases/commands/ar/datafiles/file3.in           |   1 -
 testcases/commands/ar/datafiles/file4.in           |   1 -
 testcases/commands/at/Makefile                     |  31 --
 testcases/commands/at/at_allow01                   | 188 --------
 testcases/commands/at/at_deny01                    | 195 ---------
 testcases/commands/cp/Makefile                     |  31 --
 testcases/commands/cp/cp_tests.sh                  | 111 -----
 testcases/commands/cpio/Makefile                   |  31 --
 testcases/commands/cpio/cpio_tests.sh              |  54 ---
 testcases/commands/cron/00_Descriptions.txt        |   4 -
 testcases/commands/cron/Makefile                   |  29 --
 testcases/commands/cron/README.tests               |  25 --
 testcases/commands/cron/cron02                     |  80 ----
 testcases/commands/cron/cron03                     |  83 ----
 testcases/commands/cron/cron_allow01               | 202 ---------
 testcases/commands/cron/cron_deny01                | 192 --------
 testcases/commands/cron/cron_dirs_check.c          |  44 --
 testcases/commands/cron/cron_dirs_checks01         |  46 --
 testcases/commands/cron/cron_illegal_cron_lines    |  39 --
 testcases/commands/cron/cron_neg_tests.sh          | 141 ------
 testcases/commands/cron/cron_pos_tests.sh          | 118 -----
 testcases/commands/cron/cron_tests.sh              | 276 ------------
 testcases/commands/df/Makefile                     |  28 --
 testcases/commands/df/df01.sh                      | 231 ----------
 testcases/commands/du/Makefile                     |  27 --
 testcases/commands/du/du01.sh                      | 126 ------
 testcases/commands/eject/Makefile                  |  29 --
 testcases/commands/eject/eject-tests.sh            | 165 -------
 testcases/commands/eject/eject_check_tray.c        |  53 ---
 testcases/commands/file/Makefile                   |  29 --
 testcases/commands/file/datafiles/.gitignore       |   1 -
 testcases/commands/file/datafiles/Makefile         |  19 -
 testcases/commands/file/datafiles/in.ar            |  10 -
 testcases/commands/file/datafiles/in.bash          |   4 -
 testcases/commands/file/datafiles/in.c             |   7 -
 testcases/commands/file/datafiles/in.csh           |   4 -
 testcases/commands/file/datafiles/in.jpg           | Bin 542 -> 0 bytes
 testcases/commands/file/datafiles/in.ksh           |   4 -
 testcases/commands/file/datafiles/in.m4            |   5 -
 testcases/commands/file/datafiles/in.mp3           | Bin 1152 -> 0 bytes
 testcases/commands/file/datafiles/in.pl            |   3 -
 testcases/commands/file/datafiles/in.png           | Bin 159 -> 0 bytes
 testcases/commands/file/datafiles/in.py            |   3 -
 testcases/commands/file/datafiles/in.sh            |   3 -
 testcases/commands/file/datafiles/in.src.rpm       | Bin 1798 -> 0 bytes
 testcases/commands/file/datafiles/in.tar           | Bin 10240 -> 0 bytes
 testcases/commands/file/datafiles/in.tar.bz2       | Bin 181 -> 0 bytes
 testcases/commands/file/datafiles/in.tar.gz        | Bin 183 -> 0 bytes
 testcases/commands/file/datafiles/in.txt           |   2 -
 testcases/commands/file/datafiles/in.wav           | Bin 8044 -> 0 bytes
 testcases/commands/file/datafiles/in.zip           | Bin 499 -> 0 bytes
 testcases/commands/file/file01.sh                  | 106 -----
 testcases/commands/gdb/Makefile                    |  26 --
 testcases/commands/gdb/gdb01.sh                    |  41 --
 testcases/commands/gzip/Makefile                   |  31 --
 testcases/commands/gzip/gzip_tests.sh              | 170 -------
 testcases/commands/insmod/Makefile                 |  36 --
 testcases/commands/insmod/insmod01.sh              |  60 ---
 testcases/commands/insmod/ltp_insmod01.c           |  35 --
 testcases/commands/keyctl/Makefile                 |  24 -
 testcases/commands/keyctl/keyctl01.sh              | 126 ------
 testcases/commands/ld/Makefile                     |  29 --
 testcases/commands/ld/datafiles/Makefile           |  22 -
 testcases/commands/ld/datafiles/d1.c               |   1 -
 testcases/commands/ld/datafiles/f1.c               |   7 -
 testcases/commands/ld/datafiles/main.c             |  10 -
 testcases/commands/ld/datafiles/rd1.c              |   8 -
 testcases/commands/ld/datafiles/rf1.c              |  10 -
 testcases/commands/ld/ld01                         |  97 ----
 testcases/commands/ldd/Makefile                    |  25 --
 testcases/commands/ldd/datafiles/Makefile          |  37 --
 testcases/commands/ldd/datafiles/lddfile1.c        |   5 -
 testcases/commands/ldd/datafiles/lddfile2.c        |   5 -
 testcases/commands/ldd/datafiles/lddfile3.c        |   5 -
 testcases/commands/ldd/datafiles/lddfile4.c        |   5 -
 testcases/commands/ldd/datafiles/lddfile5.c        |   5 -
 testcases/commands/ldd/datafiles/main.c            |  18 -
 testcases/commands/ldd/ldd01                       |  64 ---
 testcases/commands/ln/Makefile                     |  31 --
 testcases/commands/ln/ln_tests.sh                  |  98 -----
 testcases/commands/logrotate/00_Descriptions.txt   |   2 -
 testcases/commands/logrotate/Makefile              |  31 --
 testcases/commands/logrotate/logrotate_tests.sh    | 375 ----------------
 testcases/commands/lsmod/Makefile                  |  22 -
 testcases/commands/lsmod/lsmod01.sh                |  50 ---
 testcases/commands/mkdir/Makefile                  |  31 --
 testcases/commands/mkdir/mkdir_tests.sh            |  70 ---
 testcases/commands/mkfs/Makefile                   |  24 -
 testcases/commands/mkfs/mkfs01.sh                  | 197 ---------
 testcases/commands/mkswap/Makefile                 |  22 -
 testcases/commands/mkswap/mkswap01.sh              | 176 --------
 testcases/commands/mv/Makefile                     |  31 --
 testcases/commands/mv/mv_tests.sh                  | 170 -------
 testcases/commands/nm/Makefile                     |  29 --
 testcases/commands/nm/datafiles/.gitignore         |   3 -
 testcases/commands/nm/datafiles/Makefile           |  24 -
 testcases/commands/nm/datafiles/f1.c               |   7 -
 testcases/commands/nm/datafiles/f2.c               |   7 -
 testcases/commands/nm/datafiles/f3.c               |   7 -
 testcases/commands/nm/nm01                         | 137 ------
 testcases/commands/su/Makefile                     |  31 --
 testcases/commands/su/su01                         | 181 --------
 testcases/commands/su/su01_s1                      | 486 ---------------------
 testcases/commands/su/su_set_passwd                |  14 -
 testcases/commands/sysctl/Makefile                 |  25 --
 testcases/commands/sysctl/sysctl01.sh              |  55 ---
 testcases/commands/tar/Makefile                    |  31 --
 testcases/commands/tar/tar_tests.sh                | 152 -------
 testcases/commands/tpm-tools/Makefile              |  27 --
 testcases/commands/tpm-tools/tpm/Makefile          |  27 --
 .../tpm/tpm_changeauth/00_Descriptions.txt         |   6 -
 .../commands/tpm-tools/tpm/tpm_changeauth/Makefile |  31 --
 .../tpm/tpm_changeauth/tpm_changeauth_tests.sh     | 146 -------
 .../tpm_changeauth/tpm_changeauth_tests_exp01.sh   |  39 --
 .../tpm_changeauth/tpm_changeauth_tests_exp02.sh   |  40 --
 .../tpm_changeauth/tpm_changeauth_tests_exp03.sh   |  44 --
 .../tpm-tools/tpm/tpm_clear/00_Descriptions.txt    |   2 -
 .../commands/tpm-tools/tpm/tpm_clear/Makefile      |  31 --
 .../tpm-tools/tpm/tpm_clear/tpm_clear_tests.sh     | 100 -----
 .../tpm/tpm_clear/tpm_clear_tests_exp01.sh         |  33 --
 .../tpm-tools/tpm/tpm_getpubek/00_Descriptions.txt |   2 -
 .../commands/tpm-tools/tpm/tpm_getpubek/Makefile   |  31 --
 .../tpm/tpm_getpubek/tpm_getpubek_tests.sh         | 100 -----
 .../tpm/tpm_getpubek/tpm_getpubek_tests_exp01.sh   |  42 --
 .../tpm/tpm_restrictpubek/00_Descriptions.txt      |   6 -
 .../tpm-tools/tpm/tpm_restrictpubek/Makefile       |  31 --
 .../tpm_restrictpubek/tpm_restrictpubek_tests.sh   | 146 -------
 .../tpm_restrictpubek_tests_exp01.sh               |  33 --
 .../tpm_restrictpubek_tests_exp02.sh               |  33 --
 .../tpm_restrictpubek_tests_exp03.sh               |  42 --
 .../tpm-tools/tpm/tpm_selftest/00_Descriptions.txt |   4 -
 .../commands/tpm-tools/tpm/tpm_selftest/Makefile   |  31 --
 .../tpm/tpm_selftest/tpm_selftest_tests.sh         | 109 -----
 .../tpm/tpm_takeownership/00_Descriptions.txt      |   2 -
 .../tpm-tools/tpm/tpm_takeownership/Makefile       |  31 --
 .../tpm_takeownership/tpm_takeownership_tests.sh   | 100 -----
 .../tpm_takeownership_tests_exp01.sh               |  39 --
 .../tpm-tools/tpm/tpm_version/00_Descriptions.txt  |   2 -
 .../commands/tpm-tools/tpm/tpm_version/Makefile    |  31 --
 .../tpm-tools/tpm/tpm_version/tpm_version_tests.sh |  94 ----
 testcases/commands/tpm-tools/tpmtoken/Makefile     |  27 --
 .../tpmtoken/tpmtoken_import/00_Descriptions.txt   |  20 -
 .../tpm-tools/tpmtoken/tpmtoken_import/Makefile    |  31 --
 .../tpmtoken_import/tpmtoken_import_openssl.cnf    | 258 -----------
 .../tpmtoken_import/tpmtoken_import_tests.sh       | 323 --------------
 .../tpmtoken_import/tpmtoken_import_tests_exp01.sh |  40 --
 .../tpmtoken_import/tpmtoken_import_tests_exp02.sh |  47 --
 .../tpmtoken_import/tpmtoken_import_tests_exp03.sh |  42 --
 .../tpmtoken_import/tpmtoken_import_tests_exp04.sh |  38 --
 .../tpmtoken_import/tpmtoken_import_tests_exp05.sh |  45 --
 .../tpmtoken_import/tpmtoken_import_tests_exp06.sh |  40 --
 .../tpmtoken_import/tpmtoken_import_tests_exp07.sh |  45 --
 .../tpmtoken_import/tpmtoken_import_tests_exp08.sh |  44 --
 .../tpmtoken/tpmtoken_init/00_Descriptions.txt     |   6 -
 .../tpm-tools/tpmtoken/tpmtoken_init/Makefile      |  31 --
 .../tpmtoken/tpmtoken_init/tpmtoken_init_tests.sh  | 160 -------
 .../tpmtoken_init/tpmtoken_init_tests_exp00.sh     |  39 --
 .../tpmtoken_init/tpmtoken_init_tests_exp01.sh     |  57 ---
 .../tpmtoken_init/tpmtoken_init_tests_exp02.sh     |  60 ---
 .../tpmtoken_init/tpmtoken_init_tests_exp03.sh     |  55 ---
 .../tpmtoken/tpmtoken_objects/00_Descriptions.txt  |   4 -
 .../tpm-tools/tpmtoken/tpmtoken_objects/Makefile   |  31 --
 .../tpmtoken_objects/tpmtoken_objects_tests.sh     | 125 ------
 .../tpmtoken_objects_tests_exp01.sh                |  33 --
 .../tpmtoken/tpmtoken_protect/00_Descriptions.txt  |   4 -
 .../tpm-tools/tpmtoken/tpmtoken_protect/Makefile   |  31 --
 .../tpmtoken_protect/tpmtoken_protect_data.txt     |  17 -
 .../tpmtoken_protect/tpmtoken_protect_tests.sh     | 153 -------
 .../tpmtoken_protect_tests_exp01.sh                |  36 --
 .../tpmtoken_protect_tests_exp02.sh                |  36 --
 .../tpmtoken_setpasswd/00_Descriptions.txt         |   8 -
 .../tpm-tools/tpmtoken/tpmtoken_setpasswd/Makefile |  31 --
 .../tpmtoken_setpasswd/tpmtoken_setpasswd_tests.sh | 171 --------
 .../tpmtoken_setpasswd_tests_exp01.sh              |  39 --
 .../tpmtoken_setpasswd_tests_exp02.sh              |  39 --
 .../tpmtoken_setpasswd_tests_exp03.sh              |  39 --
 .../tpmtoken_setpasswd_tests_exp04.sh              |  39 --
 testcases/commands/unshare/Makefile                |  22 -
 testcases/commands/unshare/unshare01.sh            | 171 --------
 testcases/commands/unzip/Makefile                  |  29 --
 testcases/commands/unzip/datafiles/Makefile        |  19 -
 testcases/commands/unzip/datafiles/dir.out         |  16 -
 testcases/commands/unzip/datafiles/test.zip        | Bin 2544 -> 0 bytes
 testcases/commands/unzip/unzip01.sh                |  98 -----
 testcases/commands/wc/Makefile                     |  22 -
 testcases/commands/wc/wc01.sh                      |  81 ----
 testcases/commands/which/Makefile                  |  22 -
 testcases/commands/which/which01.sh                | 118 -----
 197 files changed, 10965 deletions(-)
 delete mode 100644 runtest/commands
 delete mode 100644 testcases/commands/.gitignore
 delete mode 100644 testcases/commands/Makefile
 delete mode 100644 testcases/commands/ar/Makefile
 delete mode 100644 testcases/commands/ar/ar01
 delete mode 100644 testcases/commands/ar/datafiles/Makefile
 delete mode 100644 testcases/commands/ar/datafiles/file1.in
 delete mode 100644 testcases/commands/ar/datafiles/file10.in
 delete mode 100644 testcases/commands/ar/datafiles/file2.in
 delete mode 100644 testcases/commands/ar/datafiles/file3.in
 delete mode 100644 testcases/commands/ar/datafiles/file4.in
 delete mode 100644 testcases/commands/at/Makefile
 delete mode 100755 testcases/commands/at/at_allow01
 delete mode 100755 testcases/commands/at/at_deny01
 delete mode 100644 testcases/commands/cp/Makefile
 delete mode 100755 testcases/commands/cp/cp_tests.sh
 delete mode 100644 testcases/commands/cpio/Makefile
 delete mode 100755 testcases/commands/cpio/cpio_tests.sh
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
 delete mode 100644 testcases/commands/df/Makefile
 delete mode 100755 testcases/commands/df/df01.sh
 delete mode 100644 testcases/commands/du/Makefile
 delete mode 100755 testcases/commands/du/du01.sh
 delete mode 100644 testcases/commands/eject/Makefile
 delete mode 100755 testcases/commands/eject/eject-tests.sh
 delete mode 100644 testcases/commands/eject/eject_check_tray.c
 delete mode 100644 testcases/commands/file/Makefile
 delete mode 100644 testcases/commands/file/datafiles/.gitignore
 delete mode 100644 testcases/commands/file/datafiles/Makefile
 delete mode 100644 testcases/commands/file/datafiles/in.ar
 delete mode 100644 testcases/commands/file/datafiles/in.bash
 delete mode 100644 testcases/commands/file/datafiles/in.c
 delete mode 100644 testcases/commands/file/datafiles/in.csh
 delete mode 100644 testcases/commands/file/datafiles/in.jpg
 delete mode 100644 testcases/commands/file/datafiles/in.ksh
 delete mode 100644 testcases/commands/file/datafiles/in.m4
 delete mode 100644 testcases/commands/file/datafiles/in.mp3
 delete mode 100755 testcases/commands/file/datafiles/in.pl
 delete mode 100644 testcases/commands/file/datafiles/in.png
 delete mode 100755 testcases/commands/file/datafiles/in.py
 delete mode 100755 testcases/commands/file/datafiles/in.sh
 delete mode 100644 testcases/commands/file/datafiles/in.src.rpm
 delete mode 100644 testcases/commands/file/datafiles/in.tar
 delete mode 100644 testcases/commands/file/datafiles/in.tar.bz2
 delete mode 100644 testcases/commands/file/datafiles/in.tar.gz
 delete mode 100644 testcases/commands/file/datafiles/in.txt
 delete mode 100644 testcases/commands/file/datafiles/in.wav
 delete mode 100644 testcases/commands/file/datafiles/in.zip
 delete mode 100755 testcases/commands/file/file01.sh
 delete mode 100644 testcases/commands/gdb/Makefile
 delete mode 100755 testcases/commands/gdb/gdb01.sh
 delete mode 100644 testcases/commands/gzip/Makefile
 delete mode 100755 testcases/commands/gzip/gzip_tests.sh
 delete mode 100644 testcases/commands/insmod/Makefile
 delete mode 100755 testcases/commands/insmod/insmod01.sh
 delete mode 100644 testcases/commands/insmod/ltp_insmod01.c
 delete mode 100644 testcases/commands/keyctl/Makefile
 delete mode 100644 testcases/commands/keyctl/keyctl01.sh
 delete mode 100644 testcases/commands/ld/Makefile
 delete mode 100644 testcases/commands/ld/datafiles/Makefile
 delete mode 100644 testcases/commands/ld/datafiles/d1.c
 delete mode 100644 testcases/commands/ld/datafiles/f1.c
 delete mode 100644 testcases/commands/ld/datafiles/main.c
 delete mode 100644 testcases/commands/ld/datafiles/rd1.c
 delete mode 100644 testcases/commands/ld/datafiles/rf1.c
 delete mode 100755 testcases/commands/ld/ld01
 delete mode 100644 testcases/commands/ldd/Makefile
 delete mode 100644 testcases/commands/ldd/datafiles/Makefile
 delete mode 100644 testcases/commands/ldd/datafiles/lddfile1.c
 delete mode 100644 testcases/commands/ldd/datafiles/lddfile2.c
 delete mode 100644 testcases/commands/ldd/datafiles/lddfile3.c
 delete mode 100644 testcases/commands/ldd/datafiles/lddfile4.c
 delete mode 100644 testcases/commands/ldd/datafiles/lddfile5.c
 delete mode 100644 testcases/commands/ldd/datafiles/main.c
 delete mode 100755 testcases/commands/ldd/ldd01
 delete mode 100644 testcases/commands/ln/Makefile
 delete mode 100755 testcases/commands/ln/ln_tests.sh
 delete mode 100644 testcases/commands/logrotate/00_Descriptions.txt
 delete mode 100644 testcases/commands/logrotate/Makefile
 delete mode 100755 testcases/commands/logrotate/logrotate_tests.sh
 delete mode 100644 testcases/commands/lsmod/Makefile
 delete mode 100755 testcases/commands/lsmod/lsmod01.sh
 delete mode 100644 testcases/commands/mkdir/Makefile
 delete mode 100755 testcases/commands/mkdir/mkdir_tests.sh
 delete mode 100644 testcases/commands/mkfs/Makefile
 delete mode 100755 testcases/commands/mkfs/mkfs01.sh
 delete mode 100644 testcases/commands/mkswap/Makefile
 delete mode 100755 testcases/commands/mkswap/mkswap01.sh
 delete mode 100644 testcases/commands/mv/Makefile
 delete mode 100755 testcases/commands/mv/mv_tests.sh
 delete mode 100644 testcases/commands/nm/Makefile
 delete mode 100644 testcases/commands/nm/datafiles/.gitignore
 delete mode 100644 testcases/commands/nm/datafiles/Makefile
 delete mode 100644 testcases/commands/nm/datafiles/f1.c
 delete mode 100644 testcases/commands/nm/datafiles/f2.c
 delete mode 100644 testcases/commands/nm/datafiles/f3.c
 delete mode 100755 testcases/commands/nm/nm01
 delete mode 100644 testcases/commands/su/Makefile
 delete mode 100755 testcases/commands/su/su01
 delete mode 100755 testcases/commands/su/su01_s1
 delete mode 100755 testcases/commands/su/su_set_passwd
 delete mode 100644 testcases/commands/sysctl/Makefile
 delete mode 100755 testcases/commands/sysctl/sysctl01.sh
 delete mode 100644 testcases/commands/tar/Makefile
 delete mode 100755 testcases/commands/tar/tar_tests.sh
 delete mode 100644 testcases/commands/tpm-tools/Makefile
 delete mode 100644 testcases/commands/tpm-tools/tpm/Makefile
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_changeauth/00_Descriptions.txt
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_changeauth/Makefile
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests.sh
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests_exp01.sh
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests_exp02.sh
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests_exp03.sh
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_clear/00_Descriptions.txt
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_clear/Makefile
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_clear/tpm_clear_tests.sh
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_clear/tpm_clear_tests_exp01.sh
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_getpubek/00_Descriptions.txt
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_getpubek/Makefile
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_getpubek/tpm_getpubek_tests.sh
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_getpubek/tpm_getpubek_tests_exp01.sh
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_restrictpubek/00_Descriptions.txt
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_restrictpubek/Makefile
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests.sh
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests_exp01.sh
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests_exp02.sh
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests_exp03.sh
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_selftest/00_Descriptions.txt
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_selftest/Makefile
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_selftest/tpm_selftest_tests.sh
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_takeownership/00_Descriptions.txt
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_takeownership/Makefile
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_takeownership/tpm_takeownership_tests.sh
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_takeownership/tpm_takeownership_tests_exp01.sh
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_version/00_Descriptions.txt
 delete mode 100644 testcases/commands/tpm-tools/tpm/tpm_version/Makefile
 delete mode 100755 testcases/commands/tpm-tools/tpm/tpm_version/tpm_version_tests.sh
 delete mode 100644 testcases/commands/tpm-tools/tpmtoken/Makefile
 delete mode 100644 testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/00_Descriptions.txt
 delete mode 100644 testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/Makefile
 delete mode 100644 testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_openssl.cnf
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp01.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp02.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp03.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp04.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp05.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp06.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp07.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp08.sh
 delete mode 100644 testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/00_Descriptions.txt
 delete mode 100644 testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/Makefile
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp00.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp01.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp02.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp03.sh
 delete mode 100644 testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/00_Descriptions.txt
 delete mode 100644 testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/Makefile
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/tpmtoken_objects_tests.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/tpmtoken_objects_tests_exp01.sh
 delete mode 100644 testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/00_Descriptions.txt
 delete mode 100644 testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/Makefile
 delete mode 100644 testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_data.txt
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_tests.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_tests_exp01.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_tests_exp02.sh
 delete mode 100644 testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/00_Descriptions.txt
 delete mode 100644 testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/Makefile
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp01.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp02.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp03.sh
 delete mode 100755 testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp04.sh
 delete mode 100644 testcases/commands/unshare/Makefile
 delete mode 100755 testcases/commands/unshare/unshare01.sh
 delete mode 100644 testcases/commands/unzip/Makefile
 delete mode 100644 testcases/commands/unzip/datafiles/Makefile
 delete mode 100644 testcases/commands/unzip/datafiles/dir.out
 delete mode 100644 testcases/commands/unzip/datafiles/test.zip
 delete mode 100755 testcases/commands/unzip/unzip01.sh
 delete mode 100644 testcases/commands/wc/Makefile
 delete mode 100755 testcases/commands/wc/wc01.sh
 delete mode 100644 testcases/commands/which/Makefile
 delete mode 100755 testcases/commands/which/which01.sh

diff --git a/runtest/commands b/runtest/commands
deleted file mode 100644
index ee7e9f440..000000000
--- a/runtest/commands
+++ /dev/null
@@ -1,43 +0,0 @@
-#DESCRIPTION:General Linux commands
-ar export TCdat=$LTPROOT/testcases/bin; ar01
-ld01 ld01
-ldd01 ldd01
-nm01 nm01
-file01 file01.sh
-tar01  tar_tests.sh
-cron cron_tests.sh
-logrotate export TCdat=$LTPROOT/testcases/bin; logrotate_tests.sh
-cpio01 cpio_tests.sh
-unzip01 unzip01.sh
-gzip01 gzip_tests.sh
-cp01 cp_tests.sh
-ln01 ln_tests.sh
-mkdir01 mkdir_tests.sh
-mv01 mv_tests.sh
-du01 du01.sh
-df01_ext2 df01.sh -f ext2
-df01_ext3 df01.sh -f ext3
-df01_ext4 df01.sh -f ext4
-df01_xfs df01.sh -f xfs
-df01_vfat df01.sh -f vfat
-df01_exfat df01.sh -f exfat
-df01_ntfs df01.sh -f ntfs
-mkfs01 mkfs01.sh
-mkfs01_ext2 mkfs01.sh -f ext2
-mkfs01_ext3 mkfs01.sh -f ext3
-mkfs01_ext4 mkfs01.sh -f ext4
-mkfs01_xfs mkfs01.sh -f xfs
-mkfs01_btrfs mkfs01.sh -f btrfs
-mkfs01_minix mkfs01.sh -f minix
-mkfs01_msdos mkfs01.sh -f msdos
-mkfs01_vfat mkfs01.sh -f vfat
-mkfs01_ntfs mkfs01.sh -f ntfs
-mkswap01 mkswap01.sh
-which01 which01.sh
-lsmod01 lsmod01.sh
-insmod01 insmod01.sh
-wc01 wc01.sh
-keyctl01 keyctl01.sh
-gdb01 gdb01.sh
-unshare01 unshare01.sh
-sysctl01 sysctl01.sh
diff --git a/testcases/commands/.gitignore b/testcases/commands/.gitignore
deleted file mode 100644
index 9aa1caf6c..000000000
--- a/testcases/commands/.gitignore
+++ /dev/null
@@ -1,5 +0,0 @@
-/ldd/datafiles/lddfile.out
-/ldd/datafiles/*.obj.so
-/cron/cron_dirs_check
-/eject/eject_check_tray
-/insmod/ltp_insmod01.ko
diff --git a/testcases/commands/Makefile b/testcases/commands/Makefile
deleted file mode 100644
index fba3a521b..000000000
--- a/testcases/commands/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#    Copyright (C) 2010, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../..
-
-ifneq ($(WITH_EXPECT),yes)
-FILTER_OUT_SUBDIRS	:= tpm-tools
-endif
-
-include $(top_srcdir)/include/mk/env_pre.mk
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/ar/Makefile b/testcases/commands/ar/Makefile
deleted file mode 100644
index 3b694a359..000000000
--- a/testcases/commands/ar/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    commands/ade/ar testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= ar01
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/ar/ar01 b/testcases/commands/ar/ar01
deleted file mode 100644
index ddab2e0f0..000000000
--- a/testcases/commands/ar/ar01
+++ /dev/null
@@ -1,356 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2000
-#  06/01 Robbie Williamson (robbiew@us.ibm.com)
-# Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
-#
-# This program is free software;  you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY;  without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-# the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#-----------------------------------------------------------------------
-#
-# This is a basic ar command test.
-#
-TST_CNT=17
-TST_TESTFUNC=test
-TST_NEEDS_TMPDIR=1
-. tst_test.sh
-
-test1()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
-	ROD ar -ra file1.in lib.a $TST_DATAROOT/file2.in
-	ROD ar -t lib.a \> ar.out
-
-	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
-
-	if diff ar.out ar.exp >/dev/null; then
-		tst_res TPASS "ar added new file after another (-a)"
-	else
-		tst_res TFAIL "ar failed to add new file after another (-a)"
-		cat ar.out
-	fi
-
-	ROD rm lib.a
-}
-
-test2()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
-		         $TST_DATAROOT/file3.in $TST_DATAROOT/file4.in
-	ROD ar -ma file1.in lib.a file4.in
-	ROD ar -t lib.a \> ar.out
-
-	printf "file1.in\nfile4.in\nfile2.in\nfile3.in\n" > ar.exp
-
-	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar moved file correctly (-ma)"
-	else
-		tst_res TFAIL "ar failed to move file (-ma)"
-		cat ar.out
-	fi
-
-	ROD rm lib.a
-}
-
-test3()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
-	ROD ar -rb file3.in lib.a $TST_DATAROOT/file2.in
-	ROD ar -t lib.a \> ar.out
-
-	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
-
-	if diff ar.out ar.exp; then
-		tst_res TPASS "ar added new file before another (-b)"
-	else
-		tst_res TFAIL "ar failed to add new file before another (-b)"
-		cat ar.out
-	fi
-
-	ROD rm lib.a
-}
-
-test4()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
-	                 $TST_DATAROOT/file2.in
-	ROD ar -mb file3.in lib.a file2.in
-	ROD ar -t lib.a \> ar.out
-
-	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
-
-	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar moved file correctly (-mb)"
-	else
-		tst_res TFAIL "ar failed to move file (-mb)"
-		cat ar.out
-	fi
-
-	ROD rm lib.a
-}
-
-test5()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in \> ar.out
-
-	if [ -s ar.out ]; then
-		tst_res TFAIL "ar produced output unexpectedly (-c)"
-		cat ar.out
-	else
-		tst_res TPASS "ar haven't produced output (-c)"
-	fi
-
-	ROD rm lib.a
-}
-
-test6()
-{
-	ROD ar -qc lib.a $TST_DATAROOT/file1.in \> ar.out
-
-	if [ -s ar.out ]; then
-		tst_res TFAIL "ar produced output unexpectedly (-qc)"
-		cat ar.out
-	else
-		tst_res TPASS "ar haven't produced output (-qc)"
-	fi
-
-	ROD rm lib.a
-}
-
-test7()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
-	                 $TST_DATAROOT/file3.in
-	ROD ar -d lib.a file1.in file2.in
-	ROD ar -t lib.a \> ar.out
-
-	printf "file3.in\n" > ar.exp
-
-	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar deleted files correctly (-d)"
-	else
-		tst_res TFAIL "ar messed up when deleting files (-d)"
-		cat ar.out
-	fi
-
-	ROD rm lib.a
-}
-
-test8()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
-	                 $TST_DATAROOT/file3.in
-	ROD ar -d lib.a
-	ROD ar -t lib.a \> ar.out
-
-	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
-
-	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar deleted nothing (-d with empty list)"
-	else
-		tst_res TFAIL "ar deleted files (-d with empty list)"
-		cat ar.out
-	fi
-
-	ROD rm lib.a
-}
-
-test9()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
-	ROD ar -ri file3.in lib.a $TST_DATAROOT/file2.in
-	ROD ar -t lib.a \> ar.out
-
-	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
-
-	if diff ar.out ar.exp >/dev/null; then
-		tst_res TPASS "ar added new file before another (-i)"
-	else
-		tst_res TFAIL "ar failed to add new file before another (-i"
-		cat ar.out
-	fi
-
-	ROD rm lib.a
-}
-
-test10()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
-	                 $TST_DATAROOT/file2.in
-	ROD ar -mi file3.in lib.a file2.in
-	ROD ar -t lib.a \> ar.out
-
-	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
-
-	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar moved file correctly (-mi)"
-	else
-		tst_res TFAIL "ar failed to move file (-mi)"
-		cat ar.out
-	fi
-
-	ROD rm lib.a
-}
-
-test11()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
-	                 $TST_DATAROOT/file2.in
-	ROD ar -m lib.a file3.in
-	ROD ar -t lib.a \> ar.out
-
-	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
-
-	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar moved file correctly (-m)"
-	else
-		tst_res TFAIL "ar failed to move file (-m)"
-		cat ar.out
-	fi
-
-	ROD rm lib.a
-}
-
-test12()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
-	                 $TST_DATAROOT/file3.in
-	ROD ar -p lib.a \> ar.out
-
-	printf "This is file one\nThis is file two\nThis is file three\n" > ar.exp
-
-	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar printed file content correctly (-p)"
-	else
-		tst_res TFAIL "ar failed to print file content (-p)"
-		cat ar.out
-	fi
-
-	ROD rm lib.a
-}
-
-test13()
-{
-
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
-	                 $TST_DATAROOT/file3.in
-	ROD ar -q lib.a $TST_DATAROOT/file4.in
-	ROD ar -t lib.a \> ar.out
-
-	printf "file1.in\nfile2.in\nfile3.in\nfile4.in\n" > ar.exp
-
-	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar appended file correctly (-q)"
-	else
-		tst_res TFAIL "ar failed to append file (-q)"
-		cat ar.out
-	fi
-
-	ROD rm lib.a
-}
-
-test14()
-{
-	ROD touch file0.in
-	ROD ar -cr lib.a file0.in $TST_DATAROOT/file1.in
-
-	file0_mtime1=$(ar -tv lib.a | grep file0.in)
-	file1_mtime1=$(ar -tv lib.a | grep file1.in)
-
-	touch -c -t $(date --date='next day' +"%Y%m%d%H%M") file0.in
-
-	ROD ar -ru lib.a file0.in $TST_DATAROOT/file1.in
-
-	file0_mtime2=$(ar -tv lib.a | grep file0.in)
-	file1_mtime2=$(ar -tv lib.a | grep file1.in)
-
-	if [ "$file0_mtime1" = "$file0_mtime2" ]; then
-		tst_res TFAIL "ar haven't updated modified file0 (-u)"
-	else
-		tst_res TPASS "ar updated modified file0 (-u)"
-	fi
-
-	if [ "$file1_mtime1" = "$file1_mtime2" ]; then
-		tst_res TPASS "ar haven't updated unmodified file1 (-u)"
-	else
-		tst_res TFAIL "ar updated unmodified file1 (-u)"
-	fi
-
-	ROD rm lib.a file0.in
-}
-
-test15()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in
-	ROD ar -tv lib.a \> ar.out
-
-	if grep -q '[rwx-]\{9\} [0-9].*/[0-9].*\s*[0-9].*.*file1.in' ar.out; then
-		tst_res TPASS "ar verbose listing works (-tv)"
-	else
-		tst_res TFAIL "ar verbose listing failed (-tv)"
-		cat ar.out
-	fi
-
-	ROD rm lib.a
-}
-
-test16()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
-	                 $TST_DATAROOT/file3.in
-	ROD ar -xv lib.a \> ar.out
-
-	printf "x - file1.in\nx - file2.in\nx - file3.in\n" > ar.exp
-
-	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar printed extracted filenames (-xv)"
-	else
-		tst_res TFAIL "ar failed to print extracted filenames (-xv)"
-		cat ar.out
-	fi
-
-	if [ -e file1.in -a -e file2.in -a -e file3.in ]; then
-		tst_res TPASS "ar extracted files correctly"
-	else
-		tst_res TFAIL "ar failed to extract files"
-	fi
-
-	ROD rm -f lib.a file1.in file2.in file3.in
-}
-
-test17()
-{
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in
-	ROD ar -xv lib.a file2.in \> ar.out
-
-	printf "x - file2.in\n" > ar.exp
-
-	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar printed extracted filename (-xv)"
-	else
-		tst_res TFAIL "ar failed to print extracted filename (-xv)"
-		cat ar.out
-	fi
-
-	if [ -e file2.in ]; then
-		tst_res TPASS "ar extracted file correctly"
-	else
-		tst_res TFAIL "ar failed to extract file"
-	fi
-
-	ROD rm -f lib.a file2.in
-}
-
-tst_run
diff --git a/testcases/commands/ar/datafiles/Makefile b/testcases/commands/ar/datafiles/Makefile
deleted file mode 100644
index ef99bca85..000000000
--- a/testcases/commands/ar/datafiles/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-#    Copyright (C) 2016, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-INSTALL_DIR		:= testcases/data/ar01
-INSTALL_TARGETS		:= file*
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/ar/datafiles/file1.in b/testcases/commands/ar/datafiles/file1.in
deleted file mode 100644
index fa97e4437..000000000
--- a/testcases/commands/ar/datafiles/file1.in
+++ /dev/null
@@ -1 +0,0 @@
-This is file one
diff --git a/testcases/commands/ar/datafiles/file10.in b/testcases/commands/ar/datafiles/file10.in
deleted file mode 100644
index 63157302b..000000000
--- a/testcases/commands/ar/datafiles/file10.in
+++ /dev/null
@@ -1 +0,0 @@
-This is file ten
diff --git a/testcases/commands/ar/datafiles/file2.in b/testcases/commands/ar/datafiles/file2.in
deleted file mode 100644
index 0fc4dd0d4..000000000
--- a/testcases/commands/ar/datafiles/file2.in
+++ /dev/null
@@ -1 +0,0 @@
-This is file two
diff --git a/testcases/commands/ar/datafiles/file3.in b/testcases/commands/ar/datafiles/file3.in
deleted file mode 100644
index 9c9a80933..000000000
--- a/testcases/commands/ar/datafiles/file3.in
+++ /dev/null
@@ -1 +0,0 @@
-This is file three
diff --git a/testcases/commands/ar/datafiles/file4.in b/testcases/commands/ar/datafiles/file4.in
deleted file mode 100644
index 75ecf115b..000000000
--- a/testcases/commands/ar/datafiles/file4.in
+++ /dev/null
@@ -1 +0,0 @@
-This is file four
diff --git a/testcases/commands/at/Makefile b/testcases/commands/at/Makefile
deleted file mode 100644
index ca3fb04fe..000000000
--- a/testcases/commands/at/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/at testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= at_allow01 at_deny01
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/at/at_allow01 b/testcases/commands/at/at_allow01
deleted file mode 100755
index c0e9335cf..000000000
--- a/testcases/commands/at/at_allow01
+++ /dev/null
@@ -1,188 +0,0 @@
-#!/bin/sh -u
-#
-#   Copyright (C) 2008 CAI Qian <caiqian@cclom.cn>
-#   Copyright (c) International Business Machines  Corp., 2003
-#
-#   This program is free software; you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful, but
-#   WITHOUT ANY WARRANTY; without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-#   General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program; if not, write to the Free Software
-#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
-#   USA
-#
-#   FILE: /etc/at.allow
-#
-#   PURPOSE: Test that /etc/at.allow , only allows those in the file to
-#   run cron jobs.
-#
-#   HISTORY:
-#		   04/03 Jerone Young (jyoung5@us.ibm.com)
-#
-
-export TCID=at_allow01
-export TST_TOTAL=1
-export TST_COUNT=1
-TMP=${TMP:=/tmp}
-allow="/etc/at.allow"
-test_user1="test_user_1"
-test_user2="test_user_2"
-test_user1_home="/home/${test_user1}"
-test_user2_home="/home/${test_user2}"
-tmpfile="$TMP/at_allow_test"
-
-if [ "$(id -ru)" = 0 ]; then
-	. cmdlib.sh
-fi
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup()
-{
-	# Move any files that may get in the way.
-	rm "${tmpfile}" >/dev/null 2>&1
-	mv "${allow}" "${allow}.old" >/dev/null 2>&1
-
-	# Remove users for clean enviroment.
-	rm -rf "${test_user1_home}" "${test_user2_home}"
-	userdel -r "${test_user1}" >/dev/null 2>&1
-	userdel -r "${test_user2}" >/dev/null 2>&1
-
-	# Create the 1st user.
-	if ! useradd -g users -d "${test_user1_home}" -m "${test_user1}"; then
-		echo "Could not add test user ${test_user1} to system."
-		exit 1
-	fi
-
-	# Create the 2nd user.
-	if ! useradd -g users -d "${test_user2_home}" -m "${test_user2}"; then
-		echo "Could not add test user ${test_user2} to system."
-		exit 1
-	fi
-
-	# This is the workaround for a potential bug.
-	# [Bug 468337] At Refuse to Work with Non-login Shell
-	# https://bugzilla.redhat.com/show_bug.cgi?id=468337
-	# As we are running in non-login shell now, we cannot run the script
-	# by simply given it a relative path. Therefore, we copy it to test
-	# users' home directories, and run it from there.
-	cp "$0" "${test_user1_home}/." &&
-	cp "$0" "${test_user2_home}/." &&
-	echo "export LTPROOT='$LTPROOT'" > "${test_user1_home}/cached_ltproot" &&
-	echo "export LTPROOT='$LTPROOT'" > "${test_user2_home}/cached_ltproot"
-	if [ $? -ne 0 ]; then
-		tst_resm TBROK "Couldn't copy over req'd files for test users"
-		exit 1
-	fi
-
-	restart_daemon atd
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-	# We forcefully remove those files anyway. Otherwise userdel may
-	# give us bad warnings.
-	rm -rf "${test_user1_home}" "${test_user2_home}"
-	userdel -r "${test_user1}" >/dev/null 2>&1
-	userdel -r "${test_user2}" >/dev/null 2>&1
-	rm "${allow}"
-	mv "${allow}.old" "${allow}" >/dev/null 2>&1
-	rm "${tmpfile}" >/dev/null 2>&1
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  run_test
-#-----------------------------------------------------------------------
-run_test()
-{
-	if [ $(whoami) = "${test_user1}" ]; then
-		. "${test_user1_home}/cached_ltproot" || exit 1
-		export PATH="$PATH:$LTPROOT/testcases/bin"
-
-		echo "TEST: $allow should allow only those who in the file to run jobs."
-		echo "(1) TEST THAT PERSON IN ${allow} IS ABLE TO RUN JOB."
-		echo "echo 'TEST JOB RAN' >>\"${tmpfile}\" 2>&1" |
-		if ! at -m now + 1 minutes ; then
-			echo "Error while adding job using at for user ${test_user1}."
-			exit 1
-		fi
-		echo " Sleeping for 75 seconds...."
-		sleep 75
-
-		exit_code=1
-		test -e "${tmpfile}" && exit_code=0
-		if [ ${exit_code} -eq 1 ]; then
-			tst_resm TFAIL "At did not allow user to execute job"
-		else
-			tst_resm TPASS "At allowed user to execute test job"
-		fi
-
-		rm -f "${tmpfile}" >/dev/null 2>&1
-		exit ${exit_code}
-
-	elif [ $(whoami) = "${test_user2}" ]; then
-
-		. "${test_user2_home}/cached_ltproot" || exit 1
-		export PATH="$PATH:$LTPROOT/testcases/bin"
-
-		echo "(2) TEST PERSON THAT IS NOT IN ${allow} IS NOT ABLE TO RUN JOB."
-
-		echo "echo 'TEST JOB RAN' >>\"${tmpfile}\" 2>&1" |
-		if ! at -m now + 1 minutes; then
-			echo "Expected error while adding job user at for user ${test_user2}"
-		fi
-		echo "Sleeping for 75 seconds...."
-		sleep 75
-
-		exit_code=1
-		test -e "${tmpfile}" || exit_code=0
-		if [ ${exit_code} -eq 1 ]; then
-			tst_resm TFAIL "At allowed user to execute test job"
-		else
-			tst_resm TPASS "At did not allow user to execute job"
-		fi
-
-		rm -f "${tmpfile}" >/dev/null 2>&1
-		exit ${exit_code}
-
-	fi
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION: main
-#-----------------------------------------------------------------------
-if ! type at > /dev/null; then
-	tst_resm TCONF "at command not found on system"
-elif [ "$(id -ru)" = 0 ]; then
-	if do_setup; then
-
-		if ! echo "${test_user1}" >"${allow}"; then
-			exit_code=1
-		elif ! su "${test_user1}" -lc "${test_user1_home}/${0##*/}"; then
-			exit_code=1
-		elif ! su "${test_user2}" -lc "${test_user2_home}/${0##*/}"; then
-			exit_code=1
-		else
-			exit_code=0
-		fi
-		do_cleanup
-	else
-		exit_code=1
-	fi
-	exit ${exit_code}
-else
-	run_test
-	exit 0
-fi
diff --git a/testcases/commands/at/at_deny01 b/testcases/commands/at/at_deny01
deleted file mode 100755
index 176da14f6..000000000
--- a/testcases/commands/at/at_deny01
+++ /dev/null
@@ -1,195 +0,0 @@
-#!/bin/sh -u
-#
-#   Copyright (C) 2008 CAI Qian <caiqian@cclom.cn>
-#   Copyright (c) International Business Machines  Corp., 2003
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
-#
-#   FILE: /etc/at.deny
-#
-#   PURPOSE: Test that /etc/at.deny , does not allow those in the file
-#   to run cron jobs.
-#
-#   HISTORY:
-#		04/03 Jerone Young (jyoung5@us.ibm.com)
-#
-
-export TCID=at_deny01
-export TST_TOTAL=1
-export TST_COUNT=1
-TMP=${TMP:=/tmp}
-deny="/etc/at.deny"
-test_user1="test_user_1"
-test_user2="test_user_2"
-test_user1_home="/home/${test_user1}"
-test_user2_home="/home/${test_user2}"
-tmpfile="$TMP/at_deny_test"
-
-if [ "$(id -ru)" = 0 ]; then
-	. cmdlib.sh
-fi
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup()
-{
-	# Move any files that may get in the way.
-	rm "${tmpfile}" >/dev/null 2>&1
-	mv "${deny}" "${deny}.old" >/dev/null 2>&1
-
-	# if /etc/at.allow is there, /etc/at.deny will be ignored. So, we
-	# need to remove it first.
-	if [ -f "/etc/at.allow" ]; then
-		mv /etc/at.allow /etc/at.allow.old
-	fi
-
-	# Remove users for clean enviroment.
-	rm -rf "${test_user1_home}" "${test_user2_home}"
-	userdel -r "${test_user1}" >/dev/null 2>&1
-	userdel -r "${test_user2}" >/dev/null 2>&1
-
-	# Create the 1st user.
-	if ! useradd -g users -d "${test_user1_home}" -m "${test_user1}"; then
-		echo "Could not add test user ${test_user1} to system."
-		exit 1
-	fi
-
-	# Create the 2nd user.
-	if ! useradd -g users -d "${test_user2_home}" -m "${test_user2}"; then
-		echo "Could not add test user ${test_user2} to system."
-		exit 1
-	fi
-
-	# This is the workaround for a potential bug.
-	# [Bug 468337] At Refuse to Work with Non-login Shell
-	# https://bugzilla.redhat.com/show_bug.cgi?id=468337
-	# As we are running in non-login shell now, we cannot run the script
-	# by simply given it a relative path. Therefore, we copy it to test
-	# users' home directories, and run it from there.
-	cp "$0" "${test_user1_home}/." &&
-	cp "$0" "${test_user2_home}/." &&
-	echo "export LTPROOT='$LTPROOT'" > "${test_user1_home}/cached_ltproot" &&
-	echo "export LTPROOT='$LTPROOT'" > "${test_user2_home}/cached_ltproot"
-	if [ $? -ne 0 ]; then
-		tst_resm TBROK "Couldn't copy over req'd files for test users"
-		exit 1
-	fi
-
-	restart_daemon atd
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-	# We forcefully remove those files anyway. Otherwise userdel may
-	# give us bad warnings.
-	rm -rf "${test_user1_home}" "${test_user2_home}"
-	userdel -r "${test_user1}" >/dev/null 2>&1
-	userdel -r "${test_user2}" >/dev/null 2>&1
-	rm "${deny}"
-	mv "${deny}.old" "${deny}" >/dev/null 2>&1
-	rm "${tmpfile}" >/dev/null 2>&1
-
-	if [ -f /etc/at.allow.old ]; then
-		mv /etc/at.allow.old /etc/at.allow
-	fi
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  run_test
-#-----------------------------------------------------------------------
-run_test()
-{
-	if [ $(whoami) = "${test_user1}" ]; then
-		. "${test_user1_home}/cached_ltproot" || exit 1
-		export PATH="$PATH:$LTPROOT/testcases/bin"
-
-		echo "TEST: ${deny} should deny only those who are not in the file to run jobs."
-		echo "(1) TEST THAT PERSON NOT IN ${deny} IS ABLE TO RUN JOB."
-		echo "echo 'TEST JOB RAN' >>\"${tmpfile}\" 2>&1" |
-		if ! at -m now + 1 minutes; then
-			echo "Error while adding job using at for user ${test_user1}."
-			exit 1
-		fi
-		echo " Sleeping for 75 seconds...."
-		sleep 75
-
-		exit_code=1
-		test -e "${tmpfile}" && exit_code=0
-		if [ ${exit_code} -eq 1 ]; then
-			tst_resm TFAIL "At denyed user to execute test job"
-		else
-			tst_resm TPASS "At did not deny user to execute job"
-		fi
-
-		rm -f "${tmpfile}" >/dev/null 2>&1
-		exit ${exit_code}
-
-	elif [ $(whoami) = "${test_user2}" ]; then
-
-		. "${test_user2_home}/cached_ltproot" || exit 1
-		export PATH="$PATH:$LTPROOT/testcases/bin"
-
-		echo "(2) TEST THAT PERSON IN ${deny} IS NOT ABLE TO RUN JOB."
-
-		echo "echo 'TEST JOB RAN' >>\"${tmpfile}\" 2>&1" |
-		if ! at -m now + 1 minutes; then
-			echo "Expected error while adding job user at for user ${test_user2}"
-		fi
-		echo "Sleeping for 75 seconds...."
-		sleep 75
-
-		exit_code=1
-		test -e "${tmpfile}" || exit_code=0
-		if [ ${exit_code} -eq 1 ]; then
-			echo "At did not deny user to execute job, TEST FAILED."
-		else
-			echo "At denyed user to execute test job, TEST PASSED."
-		fi
-
-		rm -f "${tmpfile}" >/dev/null 2>&1
-		exit ${exit_code}
-
-	fi
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION: main
-#-----------------------------------------------------------------------
-if ! type at > /dev/null; then
-	tst_resm TCONF "at command not found on system"
-elif [ "$(id -ru)" = 0 ]; then
-	if do_setup ; then
-		if ! echo "${test_user2}" >"${deny}"; then
-			exit_code=1
-		elif ! su "${test_user1}" -lc "${test_user1_home}/${0##*/}"; then
-			exit_code=1
-		elif ! su "${test_user2}" -lc "${test_user2_home}/${0##*/}"; then
-			exit_code=1
-		else
-			exit_code=0
-		fi
-		do_cleanup
-	else
-		exit_code=1
-	fi
-	exit ${exit_code}
-else
-	run_test
-	exit 0
-fi
diff --git a/testcases/commands/cp/Makefile b/testcases/commands/cp/Makefile
deleted file mode 100644
index f71e9f3e8..000000000
--- a/testcases/commands/cp/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/fileutils/cp testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= cp_tests.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/cp/cp_tests.sh b/testcases/commands/cp/cp_tests.sh
deleted file mode 100755
index 30bb183a7..000000000
--- a/testcases/commands/cp/cp_tests.sh
+++ /dev/null
@@ -1,111 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author:       Manoj Iyer, manjo@mail.utexas.edu                           ##
-## Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>                          ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
-#
-# Tests basic cp functionality
-#
-TST_CNT=5
-TST_TESTFUNC=do_test
-TST_SETUP=setup
-TST_NEEDS_TMPDIR=1
-. tst_test.sh
-
-create_tree()
-{
-	local dirname=$1
-	local dircnt=$2
-	local filecnt=$3
-
-	tst_res TINFO "Creating $dircnt directories."
-	tst_res TINFO "Filling each dir with $filecnt files".
-	while [ $dircnt -gt 0 ]; do
-		dirname=$dirname/dir$dircnt
-	        ROD mkdir -p $dirname
-
-		local fcnt=0
-	        while [ $fcnt -lt $filecnt ]; do
-			ROD touch $dirname/file$fcnt
-			fcnt=$((fcnt+1))
-		done
-		dircnt=$((dircnt-1))
-	done
-}
-
-setup()
-{
-	create_tree "dir" 10 10
-	ROD echo LTP > file
-}
-
-compare_dirs()
-{
-	local src="$1"
-	local dst="$2"
-
-	if diff -r $src $dst; then
-		tst_res TPASS "Directories $src and $dst are equal"
-	else
-		tst_res TFAIL "Directories $src and $dst differs"
-		ls -R $src
-		echo
-		ls -R $dst
-	fi
-}
-
-compare_files()
-{
-	local src="$1"
-	local dst="$2"
-
-	if diff $src $dst; then
-		tst_res TPASS "Files $src and $dst are equal"
-	else
-		tst_res TFAIL "Files $src and $dst differs"
-	fi
-}
-
-cp_test()
-{
-	local args="$1"
-	local src="$2"
-	local dst="$3"
-	EXPECT_PASS cp $args $src $dst
-	if [ -f $src ]; then
-		compare_files $src $dst
-	else
-		compare_dirs $src $dst
-	fi
-	ROD rm -r $dst
-}
-
-do_test()
-{
-	case $1 in
-	1) cp_test ""  "file" "file_copy";;
-	2) cp_test -l  "file" "file_copy";;
-	3) cp_test -s  "file" "file_copy";;
-	4) cp_test -R  "dir"  "dir_copy";;
-	5) cp_test -lR "dir"  "dir_copy";;
-	esac
-}
-
-tst_run
diff --git a/testcases/commands/cpio/Makefile b/testcases/commands/cpio/Makefile
deleted file mode 100644
index 55a8912cb..000000000
--- a/testcases/commands/cpio/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/cpio testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= cpio_tests.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/cpio/cpio_tests.sh b/testcases/commands/cpio/cpio_tests.sh
deleted file mode 100755
index 9ebfb10ad..000000000
--- a/testcases/commands/cpio/cpio_tests.sh
+++ /dev/null
@@ -1,54 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author: Manoj Iyer, manjo@mail.utexas.edu                                 ##
-## Copyright (c) Cyril Hrubis <chrubis@suse.cz>                               ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
-#
-# Test basic functionality of cpio command
-#
-TST_TESTFUNC=cpio_test
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="cpio"
-. tst_test.sh
-
-cpio_test()
-{
-	ROD mkdir "dir"
-	for i in a b c d e f g h i j k l m n o p q r s t u v w x y z; do
-		ROD echo "Test" > "dir/$i"
-	done
-
-	ROD find dir -type f > filelist
-	EXPECT_PASS cpio -o \> cpio.out \< filelist
-	ROD mv "dir" "dir_orig"
-	ROD mkdir "dir"
-	EXPECT_PASS cpio -i \< cpio.out
-
-	if diff -r "dir" "dir_orig"; then
-		tst_res TPASS "Directories dir and dir_orig are equal"
-	else
-		tst_res TFAIL "Directories dir and dir_orig differ"
-		ls -R dir_orig
-		echo
-		ls -R dir
-	fi
-}
-
-tst_run
diff --git a/testcases/commands/cron/00_Descriptions.txt b/testcases/commands/cron/00_Descriptions.txt
deleted file mode 100644
index 9566e0aaa..000000000
--- a/testcases/commands/cron/00_Descriptions.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-cron01
-	Test that crontab <filename> installs the cron-job-file and cron will
-	schedule the job correctly.
-
diff --git a/testcases/commands/cron/Makefile b/testcases/commands/cron/Makefile
deleted file mode 100644
index 4969ec7bb..000000000
--- a/testcases/commands/cron/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    commands/cron testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= cron0[23] cron_illegal_cron_lines cron_allow01 cron_deny01 cron_dirs_checks01 *.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/cron/README.tests b/testcases/commands/cron/README.tests
deleted file mode 100644
index 0d5db7113..000000000
--- a/testcases/commands/cron/README.tests
+++ /dev/null
@@ -1,25 +0,0 @@
-This directory contains two scripts and one data file to test cron. Both
-shouldn't be run as root but they warn for themselves. If a username is
-given as parameter they run as this user.
-
-Both scripts save the current crontab and restore it after finishing.
-
-* Positive tests
-
-	cron_pos_tests.sh [username]
-
-	- add new job
-	- check correct execution of job
-	- delete job
-
-* Negative tests
-
-	cron_neg_tests.sh [username]
-
-	- try to edit the crontab of root
-	- try to set illegal or nondefined execution times
-	  Here the script uses file illegal_cron_lines which contains two
-	  fields per line: the cron line to be tested (without script name),
-	  and the description of this test. The description is written to
-	  stdout during execution of the test.
-	- try to do things you aren't allowed as non-root (cron runs as root)
diff --git a/testcases/commands/cron/cron02 b/testcases/commands/cron/cron02
deleted file mode 100755
index 16b425de3..000000000
--- a/testcases/commands/cron/cron02
+++ /dev/null
@@ -1,80 +0,0 @@
-#!/bin/sh
-#*********************************************************************
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#  FILE   : cron02
-#
-#  PURPOSE: Test a postive cron job
-#			- add new job
-#   		- check correct execution of job
-#   		- delete job
-#
-#  HISTORY:
-#     	SUSE
-#
-
-TEST_USER="c01_user"
-TEST_USER_GROUP="users"
-TEST_USER_HOMEDIR="/home/$TEST_USER"
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup(){
-	#erase any data from potential defunt cron test
-	rm -rf /tmp/crontest > /dev/null 2>&1
-
-    #erase user if he may exist , so we can have a clean env
-        rm -rf /home/$TEST_USER
-        userdel $TEST_USER
-	sleep 1
-
-        useradd -m -g $TEST_USER_GROUP $TEST_USER
-        if [ $? != 0 ]
-        then {
-                echo "Could not add test user $TEST_USER to system $RHOST."
-                exit 1
-        }
-        fi
-
-	if [ -n "$CROND_DAEMON" ]; then
-		restart_daemon $CROND_DAEMON
-	else
-		tst_brkm TBROK "Couldn't find crond or cron"
-	fi
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
-
-do_cleanup(){
-        rm -rf /home/$TEST_USER
-        userdel $TEST_USER
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  MAIN
-#-----------------------------------------------------------------------
-. cmdlib.sh
-
-do_setup
-cron_pos_tests.sh $TEST_USER
-EXIT_CODE=$?
-do_cleanup
-exit $EXIT_CODE
diff --git a/testcases/commands/cron/cron03 b/testcases/commands/cron/cron03
deleted file mode 100755
index 7ba7bf40c..000000000
--- a/testcases/commands/cron/cron03
+++ /dev/null
@@ -1,83 +0,0 @@
-#!/bin/sh
-#*********************************************************************
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#  FILE   : cron
-#
-#  PURPOSE: Test a bad (negative) cron job
-#			- try to edit the crontab of root
-#   		- try to set illegal or nondefined execution times
-#      	 	  Here the script uses file illegal_cron_lines which contains two
-#      		  fields per line: the cron line to be tested (without script name),
-#      		  and the description of this test. The description is written to
-#      		  stdout during execution of the test.
-#    		- try to do things you aren't allowed as non-root (cron runs as root)
-
-#
-#  HISTORY:
-#     	SUSE
-#
-
-
-TEST_USER="c02_user"
-TEST_USER_GROUP="users"
-TEST_USER_HOMEDIR="/home/$TEST_USER"
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup(){
-
-    #erase user if he may exist , so we can have a clean env
-        rm -rf /home/$TEST_USER
-        userdel $TEST_USER
-	sleep 1
-
-        useradd -m -g $TEST_USER_GROUP $TEST_USER
-        if [ $? != 0 ]
-        then {
-                echo "Could not add test user $TEST_USER to system $RHOST."
-                exit 1
-        }
-        fi
-        # restart cron daemon
-	# Red Hat uses crond, SuSE/Other uses cron.
-	if [ -f /etc/init.d/crond ]; then
-		/etc/init.d/crond restart
-	else
-		/etc/init.d/cron restart
-	fi
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
-
-do_cleanup(){
-        rm -rf /home/$TEST_USER
-        userdel $TEST_USER
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  MAIN
-#-----------------------------------------------------------------------
-do_setup
-cron_neg_tests.sh $TEST_USER
-EXIT_CODE=$?
-do_cleanup
-exit $EXIT_CODE
diff --git a/testcases/commands/cron/cron_allow01 b/testcases/commands/cron/cron_allow01
deleted file mode 100755
index 9a5e4d240..000000000
--- a/testcases/commands/cron/cron_allow01
+++ /dev/null
@@ -1,202 +0,0 @@
-#!/bin/bash
-#
-#   Copyright (c) International Business Machines  Corp., 2003
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#	FILE: /var/spool/cron/allow
-#
-#	PURPOSE: Test that /var/spool/cron/allow , only allows those in the file to run cron jobs.
-#
-#	HISTORY:
-#		04/03 Jerone Young (jyoung5@us.ibm.com)
-#
-
-echo "This script contains bashism that needs to be fixed!"
-
-iam=`whoami`
-
-tvar=${MACHTYPE%-*}
-tvar=${tvar#*-}
-
-if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ]
-then
-CRON_ALLOW="/etc/cron.allow"
-else
-CRON_ALLOW="/var/spool/cron/allow"
-fi
-
-TEST_USER1="ca_user1"
-TEST_USER1_HOME="/home/$TEST_USER1"
-TEST_USER2="ca_user2"
-TEST_USER2_HOME="/home/$TEST_USER2"
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup() {
-	#move any files that may get in the way
-	rm /tmp/cron_allow_test > /dev/null 2>&1
-	rm /tmp/cron_allow_test1 > /dev/null 2>&1
-	mv $CRON_ALLOW $CRON_ALLOW.old > /dev/null 2>&1
-
-	#remove users for clean enviroment
-    su $TEST_USER1 -c "crontab -r"
-    su $TEST_USER2 -c "crontab -r"
-        rm -rf /home/$TEST_USER1
-        rm -rf /home/$TEST_USER2
-	userdel $TEST_USER1
-	userdel $TEST_USER2
-	sleep 1
-
-#create 1st user
-	useradd -m -g users $TEST_USER1
-	if [ $? != 0 ]
-    then {
-        echo "Could not add test user $TEST_USER1 to system."
-        exit 1
-    }
-    fi
-
-#create 2nd user
-	useradd -m -g users $TEST_USER2
-    if [ $? != 0 ]
-    then {
-        echo "Could not add test user $TEST_USER2 to system."
-        exit 1
-    }
-    fi
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
-do_cleanup(){
-    su $TEST_USER1 -c "crontab -r"
-    su $TEST_USER2 -c "crontab -r"
-        rm -rf /home/$TEST_USER1
-        rm -rf /home/$TEST_USER2
-	userdel $TEST_USER1
-	userdel $TEST_USER2
-	rm $CRON_ALLOW
-	mv $CRON_ALLOW.old $CRON_ALLOW > /dev/null 2>&1
-	rm /tmp/cron_allow_test >/dev/null 2>&1
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  run_test
-#-----------------------------------------------------------------------
-run_test() {
-
-if [ $iam = $TEST_USER1 ]
-then
-	echo "TEST: $CRON_ALLOW should only allow those in the file to
-run cron jobs."
-
-	echo "(1) TEST THAT PERSON IN $CRON_ALLOW IS ABLE TO RUN JOB."
-
-	echo "backup crontab...."
-    crontab -l | grep '^[^#]' > /tmp/crontab-cronallow-save-$iam
-
-	crontab - << EOF
-        `date '+%M' | awk '{ORS=""; print ($1+2)%60 " * * * * "}'` echo "TEST JOB RAN" >> /tmp/cron_allow_test 2>&1
-EOF
-	if [ $? != 0 ]; then
-	echo Error while adding crontab for user $TEST_USER1
-	exit 1
-	fi
-
-	echo "sleeping for 130 seconds...."
-	sleep 130
-
-	EXIT_CODE=1
-	test -e /tmp/cron_allow_test && EXIT_CODE=0
-
-	if [ $EXIT_CODE = 1 ]; then
-		echo "Cron did not allow user to execute job , TEST FAILED"
-	else
-		echo "Cron allowed user to execute test job, TEST PASSED"
-	fi
-
-	 echo "restore old crontab..."
-     crontab /tmp/crontab-cronallow-save-$iam
-     rm -f /tmp/crontab-cronallow-save-$iam
-
-
-	rm -f /tmp/cron_allow_test
-
-	exit $EXIT_CODE
-fi
-
-if [ $iam = $TEST_USER2 ]
-then
-        echo "(2) TEST THAT PERSON NOT IN $CRON_ALLOW IS NOT ABLE TO RUN JOB."
-
-		echo "backup crontab...."
-    	crontab -l | grep '^[^#]' > /tmp/crontab-cronallow-save-$iam
-
-        crontab - << EOF
-        `date '+%M' | awk '{ORS=""; print ($1+2)%60 " * * * * "}'` echo "TEST JOB RAN" >> /tmp/cron_allow_test1 2>&1
-EOF
-        if [ $? != 0 ]; then
-        echo Error while adding crontab for user $TEST_USER2
-        fi
-
-        echo "sleeping for 130 seconds...."
-        sleep 130
-
-        EXIT_CODE=0
-        test -e /tmp/cron_allow_test1 && EXIT_CODE=1
-
-        if [ $EXIT_CODE = 0 ]; then
-                echo "Cron did not allow user to execute job , TEST PASSED"
-        else
-                echo "Cron allowed user to execute test job, TEST FAILED"
-        fi
-
-		echo "restore old crontab..."
-     	crontab /tmp/crontab-cronallow-save-$iam
-     	rm -f /tmp/crontab-cronallow-save-$iam
-
-        rm -f /tmp/cron_allow_test1
-
-        exit $EXIT_CODE
-fi
-
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION: main
-#-----------------------------------------------------------------------
-if [ $iam = "root" ]
-then
-	do_setup
-	echo $TEST_USER1 > $CRON_ALLOW
-	EXIT_CODE=0
-	su $TEST_USER1 -c "$0"
-	if [ $? != 0 ]
-	then
-	   EXIT_CODE=1
-	fi
-	su $TEST_USER2 -c "$0"
-	if [ $? != 0 ]
-	then EXIT_CODE=1
-	fi
-	do_cleanup
-	exit $EXIT_CODE
-else
-	run_test
-fi
diff --git a/testcases/commands/cron/cron_deny01 b/testcases/commands/cron/cron_deny01
deleted file mode 100755
index 9d3203925..000000000
--- a/testcases/commands/cron/cron_deny01
+++ /dev/null
@@ -1,192 +0,0 @@
-#!/bin/bash
-#
-#   Copyright (c) International Business Machines  Corp., 2003
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#	FILE: /var/spool/cron/allow
-#
-#	PURPOSE: Test that /var/spool/cron/deny , does not allow those in the file to run cron jobs.
-#
-#	HISTORY:
-#		04/03 Jerone Young (jyoung5@us.ibm.com)
-#
-
-echo "This script contains bashism that needs to be fixed!"
-
-iam=`whoami`
-
-tvar=${MACHTYPE%-*}
-tvar=${tvar#*-}
-
-if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ]
-then
-CRON_DENY="/etc/cron.deny"
-CRON_ALLOW="/etc/cron.allow"
-else
-CRON_DENY="/var/spool/cron/deny"
-CRON_ALLOW="/var/spool/cron/allow"
-fi
-
-TEST_USER1="cd_user1"
-TEST_USER1_HOME="/home/$TEST_USER1"
-TEST_USER2="cd_user2"
-TEST_USER2_HOME="/home/$TEST_USER2"
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup() {
-	#move any files that may get in the way
-	rm /tmp/cron_deny_test > /dev/null 2>&1
-        rm /tmp/cron_deny_test1 > /dev/null 2>&1
-
-	mv $CRON_DENY $CRON_DENY.old > /dev/null 2>&1
-	mv $CRON_ALLOW $CRON_ALLOW.old > /dev/null 2>&1
-
-	#remove users for clean enviroment
-    su $TEST_USER1 -c "crontab -r"
-    su $TEST_USER2 -c "crontab -r"
-        rm -rf /home/$TEST_USER1
-        rm -rf /home/$TEST_USER2
-	userdel $TEST_USER1
-	userdel $TEST_USER2
-	sleep 1
-
-#create 1st user
-	useradd -m -g users $TEST_USER1
-	if [ $? != 0 ]
-    then {
-        echo "Could not add test user $TEST_USER1 to system."
-        exit 1
-    }
-    fi
-
-#create 2nd user
-	useradd -m -g users $TEST_USER2
-    if [ $? != 0 ]
-    then {
-        echo "Could not add test user $TEST_USER2 to system."
-        exit 1
-    }
-    fi
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
-do_cleanup(){
-    su $TEST_USER1 -c "crontab -r"
-    su $TEST_USER2 -c "crontab -r"
-        rm -rf /home/$TEST_USER1
-        rm -rf /home/$TEST_USER2
-	userdel $TEST_USER1
-	userdel $TEST_USER2
-	rm $CRON_DENY
-	mv $CRON_DENY.old $CRON_DENY > /dev/null 2>&1
-	mv $CRON_ALLOW.old $CRON_ALLOW > /dev/null 2>&1
-	rm /tmp/cron_allow_test >/dev/null 2>&1
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  run_test
-#-----------------------------------------------------------------------
-run_test() {
-
-if [ $iam = $TEST_USER1 ]
-then
-	echo "TEST: $CRON_DENY should allow only allow those who are not in the file to
-run cron jobs."
-
-	echo "(1) TEST THAT PERSON NOT IN $CRON_DENY IS ABLE TO RUN JOB."
-
-	crontab - << EOF
-	`date '+%M' | awk '{ORS=""; print ($1+2)%60" * * * * "}'` echo "TEST JOB RAN" >> /tmp/cron_deny_test 2>&1
-EOF
-	if [ $? != 0 ]; then
-	echo Error while adding crontab for user $TEST_USER1
-	exit 1
-	fi
-
-	echo "sleeping for 130 seconds...."
-	sleep 130
-
-	EXIT_CODE=1
-	test -e /tmp/cron_deny_test && EXIT_CODE=0
-
-	if [ $EXIT_CODE = 1 ]; then
-		echo "Cron did not allow user to execute job , TEST FAILED"
-	else
-		echo "Cron allowed user to execute test job, TEST PASSED"
-	fi
-
-	rm -f /tmp/cron_deny_test
-
-	exit $EXIT_CODE
-fi
-
-if [ $iam = $TEST_USER2 ]
-then
-        echo "(2) TEST THAT PERSON IN $CRON_DENY IS NOT ABLE TO RUN JOB."
-
-        crontab - << EOF
-        `date '+%M' | awk '{ORS=""; print ($1+2)%60 " * * * * "}'` echo "TEST JOB RAN" >> /tmp/cron_deny_test 2>&1
-EOF
-        if [ $? != 0 ]; then
-        echo Error while adding crontab for user $TEST_USER2
-        fi
-
-        echo "sleeping for 130 seconds...."
-        sleep 130
-
-        EXIT_CODE=0
-        test -e /tmp/cron_deny_test1 && EXIT_CODE=1
-
-        if [ $EXIT_CODE = 0 ]; then
-                echo "Cron did not allow user to execute job , TEST PASSED"
-        else
-                echo "Cron allowed user to execute test job, TEST FAILED"
-        fi
-
-        rm -f /tmp/cron_deny_test1
-
-        exit $EXIT_CODE
-fi
-
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION: main
-#-----------------------------------------------------------------------
-if [ $iam = "root" ]
-then
-	do_setup
-	echo $TEST_USER2 > $CRON_DENY
-	EXIT_CODE=0
-	su $TEST_USER1 -c "$0"
-	if [ $? != 0 ]
-	then
-	   EXIT_CODE=1
-	fi
-	su $TEST_USER2 -c "$0"
-	if [ $? != 0 ]
-	then EXIT_CODE=1
-	fi
-	do_cleanup
-	exit $EXIT_CODE
-else
-	run_test
-fi
diff --git a/testcases/commands/cron/cron_dirs_check.c b/testcases/commands/cron/cron_dirs_check.c
deleted file mode 100644
index cc9e0ad25..000000000
--- a/testcases/commands/cron/cron_dirs_check.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include <sys/types.h>
-#include <sys/param.h>
-#include <sys/stat.h>
-#include <stdio.h>
-#include <unistd.h>
-
-/* Check directory Access */
-int check_directory_access(char *directory)
-{
-
-	struct stat statbuf;
-
-	printf("Checking %s\n", directory);
-
-	if (stat(directory, &statbuf) == -1) {
-		printf("FAIL: %s. Could not obtain directory status\n",
-		       directory);
-		return 1;
-	}
-
-	if (statbuf.st_uid != 0) {
-		printf("FAIL: %s. Invalid owner\n", directory);
-		return 1;
-	}
-
-	if ((statbuf.st_mode & S_IWGRP) || (statbuf.st_mode & S_IWOTH)) {
-		printf("FAIL: %s. Invalid write access\n", directory);
-		return 1;
-	}
-
-	printf("PASS: %s\n", directory);
-	return 0;
-}
-
-int main(int argc, char *argv[])
-{
-
-	if (argc != 2) {
-		printf("Please enter target directory");
-		return 1;
-	}
-
-	return check_directory_access(argv[1]);
-}
diff --git a/testcases/commands/cron/cron_dirs_checks01 b/testcases/commands/cron/cron_dirs_checks01
deleted file mode 100755
index ea1215e8d..000000000
--- a/testcases/commands/cron/cron_dirs_checks01
+++ /dev/null
@@ -1,46 +0,0 @@
-#!/bin/sh
-#*********************************************************************
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#  FILE   : cron
-#
-#  PUROPOSE: Ensure that the following directories only have root write access
-#			/etc/cron.d
-#			/etc/cron.daily
-#			/etc/cron.hourly
-#			/etc/cron.monthly
-#			/etc/cron.weekly
-#			/var/spool/cron
-#	HISTORY:
-#		Jerone Young (jyoung5@us.ibm.com)
-#
-
-DIRS="/etc/cron.d /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly /var/spool/cron"
-
-EXIT_CODE=0
-for i in $DIRS
-do
-	cron_dirs_check $i
-	if [ $? != 0 ]
-	then
-		echo "$i FAILED TEST!!!!!"
-		EXIT_CODE=1
-	fi
-
-done
-
-exit $EXIT_CODE
diff --git a/testcases/commands/cron/cron_illegal_cron_lines b/testcases/commands/cron/cron_illegal_cron_lines
deleted file mode 100644
index 3b32dc844..000000000
--- a/testcases/commands/cron/cron_illegal_cron_lines
+++ /dev/null
@@ -1,39 +0,0 @@
-# Collection of illegal cron lines
-# Comment lines must habe its '#' as first character.
-# The cron conf line and its description is seperated by '|'.
-# cron job command 'true' is appended automatically
-
-# Illegal Minutes
-61 * * * * | Minute 61
--1 * * * * | Minute -1 (might be interpreted as range)
-0.5 * * * * | Minute 0.5
--1-10 * * * *| Minute Range -1-10
-0-61 * * * * | Minute Range 0-61
-
-# Illegal hours
-0 25 * * * | Hour 25
-0 -2 * * * | Hour -2
-0 3.5 * * *| Hour 3.5
-0 -4-10 * * *| Hour Range -4-10
-0 0-25 * * * | Hour Range 0-25
-
-# Illegal day of month
-0 0 32 * * | Day 32
-0 0 -1 * * | Day -1
-0 0 3.5 * *| Day 3.5
-0 0 -3-3 * *| Day Range -3-3
-0 0 0-32 * *| Day Range 0-32
-
-# Illegal month
-0 0 1 13 * | Month 13
-0 0 1 -1 * | Month -1
-0 0 1 2.5 * | Month 2.5
-0 0 1 -2-3 * | Month Range -2-3
-0 0 1 0-13 * | Month Range 0-13
-
-# Illegal day of week
-0 0 * * 8 | Day of Week 8
-0 0 * * -2 | Day of Week -2
-0 0 * * 2.5 | Day of Week 2.5
-0 0 * * -7-7 | Day of Week Range -7-7
-0 0 * * 0-8 | Day of Week Range 0-8
diff --git a/testcases/commands/cron/cron_neg_tests.sh b/testcases/commands/cron/cron_neg_tests.sh
deleted file mode 100755
index 9c3d6f6c7..000000000
--- a/testcases/commands/cron/cron_neg_tests.sh
+++ /dev/null
@@ -1,141 +0,0 @@
-#!/bin/bash
-########################################################
-#
-# CHANGE ACTIVITY
-#
-#    10/01/04  Kris Wilson    RHEL4 only allows super user
-#                               to use crontab.
-#                               to use crontab.
-#    12/03/04  Marty Ridgeway Pull RHEl4 tests out from script
-########################################################
-
-iam=`whoami`
-
-if [ $iam = "root" ]; then
-	if [ $# -lt 1 ] ; then
-		echo Either do not run this script as root or start it like
-		echo "  $0 <user>"
-		exit 1
-	fi
-
-	su $1 -c "$0 $*"
-	exit $?
-fi
-
-#
-# 1. root einen cronjob unterjubeln
-#
-
-finalrc=0
-
-
-crontab -u root - << EOF
-0 * * * * true
-EOF
-
-rc=$?
-
-if [ $rc = "0" ]; then
-	echo root has now an interesting cron job
-	echo "crontab has a severe security breach (FAIL)"
-	echo
-	finalrc=1
-else
-	echo "Editing a crontab of another user failed successfully (PASS)"
-	echo
-fi
-
-
-#
-# 2. write some illegal crontabs
-#
-
-# Save crontab
-
-#crontab -l > /dev/null 2> /dev/null
-#if [ $? = "0" ]; then
-#	echo Saving current crontab...
-#	echo
-#	crontab -l > /tmp/save-crontab-`whoami`
-#	savedcrontab=1
-#	crontab -r
-#fi
-
-#for line in `cat cron_illegal_cron_lines | grep '^[^#]' | sed -e 's/[ \t][ \t]*/_/g'` ; do
-#	line=`echo $line | sed -e 's/_/ /g'`
-	# echo Line: "$line"
-#	cronconf=`echo "$line" | cut -f 1 -d '|'`
-#	desc=`echo "$line" | cut -f 2 -d '|'`
-
-#	echo "Test: $desc"
-#	echo "$cronconf true" | crontab -
-	# echo "$cronconf"
-#	if [ $? = "0" ]; then
-#		echo 'Test FAILED (or crontab returned wrong exit code)'
-#		echo 'crontab -l:'
-#		crontab -l
-#		finalrc=1
-#	fi
-#	echo
-#done
-
-
-# Test whether cron uses setuid correctly
-
-echo
-echo setuid test
-echo
-
-tmpscript=cron_neg01_test
-rm -rf $tmpscript.out >/dev/null 2>&1
-
-
-cat > /tmp/$tmpscript << EOF
-touch /root/halloichwarhier
-sleep 1
-cat /root/halloichwarhier ; echo "res:$?"
-rm /root/halloichwarhier
-EOF
-
-chmod 755 /tmp/$tmpscript
-
-#
-cronline=`date '+%M' | awk '{print ($1+2)%60 " * * * * "}'`
-(echo "$cronline /tmp/$tmpscript >> /tmp/$tmpscript.out 2>> /tmp/$tmpscript.out" ; \
- echo "$cronline /tmp/$tmpscript >> /$tmpscript.out 2>> /$tmpscript.out") \
- | crontab -
-
-echo "sleeping 130 secs..."
-sleep 130
-
-echo
-echo "Results:"
-if [ "1" = `cat /tmp/$tmpscript.out | grep "res:0" | wc -l` ]; then
-	echo "setuid test part 1 successfully failed (PASS)"
-else
-	echo "cron executed scripts have root privileges! (FAIL)"
-	finalrc=1
-fi
-
-CODE=0
-test -e /tmp/$tmpscript.out && CODE=1
-if [ $CODE = "1" ]; then
-	echo "setuid test part 2 successfully failed (PASS)"
-else
-	echo "cron writes script output with root privileges! (FAIL)"
-	finalrc=1
-fi
-echo
-
-rm /tmp/$tmpscript* >/dev/null 2>&1
-crontab -r
-
-# Restore crontab
-
-if [ "$savedcrontab" = "1" ]; then
-	echo "Restoring crontab..."
-	cat /tmp/save-crontab-`whoami` | grep '^[^#]' | crontab -
-	# rm -r /tmp/save-crontab-`whoami`
-fi
-
-exit $finalrc
diff --git a/testcases/commands/cron/cron_pos_tests.sh b/testcases/commands/cron/cron_pos_tests.sh
deleted file mode 100755
index ece114c84..000000000
--- a/testcases/commands/cron/cron_pos_tests.sh
+++ /dev/null
@@ -1,118 +0,0 @@
-#!/bin/bash
-
-# Positive tests for cron, that means these tests have to pass
-
-iam=`whoami`
-
-tvar=${MACHTYPE%-*}
-tvar=${tvar#*-}
-
-if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ]
-then
-	CRON_ALLOW="/etc/cron.allow"
-else
-	CRON_ALLOW="/var/spool/cron/allow"
-fi
-
-
-if [ $iam = "root" ]; then
-	if [ $# -lt 1 ] ; then
-		echo Either do not run this script as root or start it like
-		echo "  $0 <user>"
-		exit 1
-	fi
-
-	mv $CRON_ALLOW $CRON_ALLOW.old >/dev/null 2>&1
-	su $1 -c "$0 $*"
-        RC=$?
-	mv $CRON_ALLOW.old $CRON_ALLOW >/dev/null 2>&1
-	exit $RC
-fi
-
-function restorecrontab () {
-	test -e /tmp/crontab-save-$iam && \
-		crontab /tmp/crontab-save-$iam && \
-		rm -f /tmp/crontab-save-$iam && \
-		echo restored old crontab
-}
-
-echo Running as user $iam...
-
-# Save current users crontab
-
-test -e /tmp/crontab-save-$iam && rm -f /tmp/crontab-save-$iam
-
-if [ "0" -lt `crontab -l 2>/dev/null | wc -l` ]; then
-
-	echo 'crontab of this user exists -> creating backup'
-	crontab -l | grep '^[^#]' > /tmp/crontab-save-$iam
-fi
-
-
-# Do tests
-
-# 1. Add new job
-
-rm -rf /tmp/crontest >/dev/null 2>&1
-mkdir -p /tmp/crontest
-
-cat > /tmp/crontest/testjob_cron01 << EOF
-echo Testjob running
-date
-EOF
-
-chmod 755 /tmp/crontest/testjob_cron01
-
-crontab - << EOF
-`date '+%M' | awk '{ print ($1+2)%60 " * * * * "
-}'` /tmp/crontest/testjob_cron01 >> /tmp/crontest/output_cron01 2>&1
-EOF
-
-rc=$?
-
-if [ $rc = "1" ]; then
-	echo Error while adding crontab for user $iam
-	restorecrontab
-	exit 1
-fi
-
-echo new job added successfully
-
-# 2. Wait for execution of job
-
-echo 'sleeping for 130 seconds...'
-sleep 130
-
-rc=1
-test -e /tmp/crontest/output_cron01 && rc=0
-
-if [ $rc = "1" ]; then
-	echo Job has not been executed
-	restorecrontab
-	exit 1
-fi
-
-grep "Testjob running" /tmp/crontest/output_cron01
-rc=$?
-if [ $rc = "1" ]; then
-	echo Job has not produced valid output
-	restorecrontab
-fi
-
-echo 'job has been executed :-)'
-echo "testjob's output:"
-echo
-
-rm -rf /tmp/crontest
-
-# 3. Delete crontab
-
-crontab -r
-
-echo removed crontab
-
-# Restore old crontab file
-
-restorecrontab
-
-exit $rc
diff --git a/testcases/commands/cron/cron_tests.sh b/testcases/commands/cron/cron_tests.sh
deleted file mode 100644
index 47614f9e3..000000000
--- a/testcases/commands/cron/cron_tests.sh
+++ /dev/null
@@ -1,276 +0,0 @@
-#!/bin/sh
-
-# Copyright (c) International Business Machines Corp., 2001
-# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-# Author: Manoj Iyer <manjo@mail.utexas.edu>
-
-TST_CNT=3
-TST_TESTFUNC=do_test
-TST_NEEDS_TMPDIR=1
-TST_SETUP=setup
-TST_CLEANUP=cleanup
-. tst_test.sh
-
-. daemonlib.sh
-
-SYSLOG_STARTED=
-CROND_STARTED=
-LOGS=
-
-grep_logs()
-{
-	local pattern="$1"
-	local fail_msg="$2"
-	local pass_msg="${3:-}"
-	local n="${4:-10}"
-
-	local lines=10
-	local out=out.$$
-	local err=err.$$
-	local i ret
-
-	for i in $(seq 1 $n); do
-		if [ "$LOGS" ]; then
-			tail -n $lines $LOGS | grep "$pattern" > $out 2> $err
-		else
-			journalctl -n $lines | grep "$pattern" > $out 2> $err
-		fi
-		ret=$?
-		[ $ret -eq 0 ] && break
-		sleep 1
-	done
-
-	if [ $ret -ne 0 ]; then
-		tst_res TFAIL "$fail_msg: `cat $err`"
-	else
-		[ "$pass_msg" ] && tst_res TPASS "$pass_msg"
-	fi
-}
-
-create_crontab()
-{
-	local crontab=cronjob.cron
-	local script=$1
-	local out=out.$$
-
-	tst_res TINFO "creating crontab: $script"
-
-	cat > $crontab <<EOF
-* * * * * $script
-EOF
-
-	tst_res TINFO "installing crontab file"
-	crontab $crontab > $out 2>&1
-	if [ $? -ne 0 ]; then
-		tst_brk TBROK "crontab: error while installing crontab file: `cat $out`"
-		return 1
-	fi
-	return 0
-}
-
-remove_crontab()
-{
-	local out=out.$$
-	tst_res TINFO "removing crontab file"
-	crontab -r > $out 2>&1
-	if [ $? -ne 0 ]; then
-		tst_brk TBROK "crontab: error while removing crontab file `cat $out`"
-		return 1
-	fi
-	return 0
-}
-
-create_hello_script()
-{
-	local script=$1
-
-	cat > $script <<EOF
-#!/bin/sh
-echo "Hello Hell"
-exit 0
-EOF
-	chmod +x $script
-}
-
-install_cron_test()
-{
-	local script=$PWD/cronprg.sh
-	local cron_out=$PWD/tst1_cron.out
-	local err=err.log
-	local sleep_sec
-	local ts_min1 ts_min2 fail
-
-	tst_res TINFO "test install cron job"
-
-	cat > $script <<EOF
-#! /bin/sh
-DATE=\`LC_ALL=C date\`
-echo "Hello Hell today is \$DATE" > $cron_out 2>&1
-exit 0
-EOF
-	chmod +x $script
-
-	create_crontab $script 2> $err
-
-	if [ $? -ne 0 ]; then
-		tst_brk TBROK "crontab: error while creating cron job: `cat $err`"
-	else
-		tst_res TINFO "cron job installed successfully"
-	fi
-
-	grep_logs 'crontab.*REPLACE' \
-		"cron activity not recorded" \
-		"cron activity logged"
-
-	# Sleep 3s after next minute since the loop below sleeps for 62 seconds, we
-	# should start this 5-iteration loop closely following the start of a
-	# minute.
-	sleep_sec=$((123-`date +%-S`))
-	tst_res TINFO "sleep for ${sleep_sec}s"
-	sleep $sleep_sec
-
-	# $script executed by the cron job will record the date and time into file
-	# $cron_out. Get the minute recorded by the program, sleep to allow the cron
-	# job to update file after 1m, and check if the value is advanced by 1.
-	for i in $(seq 1 5); do
-		tst_res TINFO "loop: $i: start"
-
-		if [ ! -f "$cron_out" ]; then
-			tst_res TFAIL "loop $i: file $cron_out doesn't exist"
-			fail=1
-			break
-		fi
-
-		ts_min1=$(awk '{print $8}' $cron_out | awk -F: '{printf("%d", $2);}')
-
-		# wait for the cron job to update output file
-		sleep 62
-
-		# Check the time recorded in output file, this should be 1 minute ahead of
-		# what was recored earlier.
-		ts_min2=$(awk '{print $8}' $cron_out | awk -F: '{printf("%d", $2);}')
-
-		if [ "x${ts_min1}" = "x" ] || [ "x${ts_min2}" = "x" ]; then
-			tst_res TFAIL "loop $i: failed to get time: ts_min1: $ts_min1, ts_min2: $ts_min2"
-			fail=1
-			break
-		fi
-
-		[ $ts_min1 -eq 59 ] && ts_min1=0 || ts_min1=$(( $ts_min1+1 ))
-
-		if [ $ts_min2 -ne $ts_min1 ]; then
-			tst_res TFAIL "loop $i: failed to update every minute: expected: $ts_min1, received: $ts_min2"
-			fail=1
-			break
-		fi
-	done
-
-	if [ ! "$fail" ]; then
-		grep_logs "CMD ($script)" \
-			"failed to install cron job installed and execute it" \
-			"cron job installed and executed" 1
-	fi
-
-	remove_crontab
-}
-
-remove_cron_job_test()
-{
-	local script=$PWD/cronprg.sh
-
-	tst_res TINFO "test remove cron job"
-
-	create_hello_script $script
-	create_crontab $script
-
-	grep_logs 'crontab.*REPLACE' \
-		"crontab activity not recorded"
-
-	remove_crontab && grep_logs DELETE \
-		"crontab activity not recorded" \
-		"crontab removed the cron job" 1
-}
-
-list_cron_jobs_test()
-{
-	local script=$PWD/cronprg.sh
-	local out=cron.out
-
-	tst_res TINFO "test list installed cron jobs"
-
-	create_hello_script $script
-	create_crontab $script
-
-	tst_res TINFO "crontab: listing cron jobs"
-	crontab -l | grep "$script" > $out 2>&1 || \
-		tst_brk TBROK "crontab failed while listing installed cron jobs: `cat $out`"
-
-	remove_crontab
-
-	crontab -l > $out 2>&1
-	if [ $? -ne 0 ]; then
-		grep -q "no crontab for" $out
-		if [ $? -ne 0 ]; then
-			tst_res TFAIL "crontab failed removing cron job: `cat $out`"
-		else
-			tst_res TPASS "crontab did not list any cron jobs"
-		fi
-	else
-		tst_res TFAIL "crontab failed removing cron job: `cat $out`"
-	fi
-}
-
-setup()
-{
-	if [ "$SYSLOG_DAEMON" ]; then
-		status_daemon $SYSLOG_DAEMON
-		if [ $? -ne 0 ]; then
-			restart_daemon $SYSLOG_DAEMON
-			SYSLOG_STARTED=1
-		fi
-	fi
-
-	if [ "$CROND_DAEMON" ]; then
-		status_daemon $CROND_DAEMON
-		if [ $? -ne 0 ]; then
-			restart_daemon $CROND_DAEMON
-			CROND_STARTED=1
-		fi
-	fi
-
-	for f in /var/log/syslog /var/log/messages /var/log/cron /var/log/cron.log; do
-		[ -f "$f" ] && LOGS="$f $LOGS"
-	done
-}
-
-cleanup()
-{
-	[ "$SYSLOG_STARTED" = "1" ] && stop_daemon $SYSLOG_DAEMON
-	[ "$CROND_STARTED" = "1" ] && stop_daemon $CROND_DAEMON
-}
-
-do_test()
-{
-	case $1 in
-	1) install_cron_test;;
-	2) remove_cron_job_test;;
-	3) list_cron_jobs_test;;
-	esac
-}
-
-tst_run
diff --git a/testcases/commands/df/Makefile b/testcases/commands/df/Makefile
deleted file mode 100644
index e1a38c891..000000000
--- a/testcases/commands/df/Makefile
+++ /dev/null
@@ -1,28 +0,0 @@
-#
-#    commands/df testcases Makefile.
-#
-#    Copyright (c) 2015 Fujitsu Ltd.
-#    Author:Zhang Jin <jy_zhangjin@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= df01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
deleted file mode 100755
index fbf1e2f2a..000000000
--- a/testcases/commands/df/df01.sh
+++ /dev/null
@@ -1,231 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2015 Fujitsu Ltd.
-# Author: Zhang Jin <jy_zhangjin@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
-# Test df command with some basic options.
-#
-
-TST_CNT=12
-TST_SETUP=setup
-TST_CLEANUP=cleanup
-TST_TESTFUNC=test
-TST_OPTS="f:"
-TST_USAGE=usage
-TST_PARSE_ARGS=parse_args
-TST_NEEDS_ROOT=1
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_DEVICE=1
-. tst_test.sh
-
-usage()
-{
-	cat << EOF
-usage: $0 [-f <ext2|ext3|ext4|vfat|...>]
-
-OPTIONS
--f	Specify the type of filesystem to be built.  If not
-	specified, the default filesystem type (currently ext2)
-	is used.
-EOF
-}
-
-FS_TYPE=ext2
-
-parse_args()
-{
-	FS_TYPE="$2"
-}
-
-setup()
-{
-	if [ -n "$FS_TYPE" ]; then
-		tst_check_cmds mkfs.${FS_TYPE}
-	fi
-
-	tst_mkfs ${FS_TYPE} ${TST_DEVICE}
-
-	ROD_SILENT mkdir -p mntpoint
-
-	mount ${TST_DEVICE} mntpoint
-	ret=$?
-	if [ $ret -eq 32 ]; then
-		tst_brk TCONF "Cannot mount ${FS_TYPE}, missing driver?"
-	fi
-
-	if [ $ret -ne 0 ]; then
-		tst_brk TBROK "Failed to mount device: mount exit = $ret"
-	fi
-
-	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk '{print $5}')
-}
-
-cleanup()
-{
-	tst_umount ${TST_DEVICE}
-}
-
-df_test()
-{
-	cmd="$1 -P"
-
-	df_verify $cmd
-	if [ $? -ne 0 ]; then
-		return
-	fi
-
-	df_check $cmd
-	if [ $? -ne 0 ]; then
-		tst_res TFAIL "'$cmd' failed, not expected."
-		return
-	fi
-
-	ROD_SILENT dd if=/dev/zero of=mntpoint/testimg bs=1024 count=1024
-
-	df_verify $cmd
-
-	df_check $cmd
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "'$cmd' passed."
-	else
-		tst_res TFAIL "'$cmd' failed."
-	fi
-
-	ROD_SILENT rm -rf mntpoint/testimg
-
-	# flush file system buffers, then we can get the actual sizes.
-	sync
-}
-
-df_verify()
-{
-	$@ >output 2>&1
-	if [ $? -ne 0 ]; then
-		grep -q -E "unrecognized option | invalid option" output
-		if [ $? -eq 0 ]; then
-			tst_res TCONF "'$1' not supported."
-			return 32
-		else
-			tst_res TFAIL "'$1' failed."
-			cat output
-			return 1
-		fi
-	fi
-}
-
-df_check()
-{
-	if [ "$(echo $@)" = "df -i -P" ]; then
-		local total=$(stat -f mntpoint --printf=%c)
-		local free=$(stat -f mntpoint --printf=%d)
-		local used=$((total-free))
-	else
-		local total=$(stat -f mntpoint --printf=%b)
-		local free=$(stat -f mntpoint --printf=%f)
-		local used=$((total-free))
-		local bsize=$(stat -f mntpoint --printf=%s)
-		total=$(($total * $bsize / 1024))
-		used=$(($used * $bsize / 1024))
-	fi
-
-	grep ${TST_DEVICE} output | grep -q "${total}.*${used}"
-	if [ $? -ne 0 ]; then
-		return 1
-	fi
-}
-
-test1()
-{
-	df_test "df"
-}
-
-test2()
-{
-	df_test "df -a"
-}
-
-test3()
-{
-	df_test "df -i"
-}
-
-test4()
-{
-	df_test "df -k"
-}
-
-test5()
-{
-	df_test "df -t ${DF_FS_TYPE}"
-}
-
-test6()
-{
-	df_test "df -T"
-}
-
-test7()
-{
-	df_test "df -v ${TST_DEVICE}"
-}
-
-test8()
-{
-	df_verify "df -h"
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "'df -h' passed."
-	fi
-}
-
-test9()
-{
-	df_verify "df -H"
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "'df -H' passed."
-	fi
-}
-
-test10()
-{
-	df_verify "df -m"
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "'df -m' passed."
-	fi
-}
-
-test11()
-{
-	df_verify "df --version"
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "'df --version' passed."
-	fi
-}
-
-test12()
-{
-	cmd="df -x ${DF_FS_TYPE} -P"
-
-	df_verify $cmd
-	if [ $? -ne 0 ]; then
-		return
-	fi
-
-	grep ${TST_DEVICE} output | grep -q mntpoint
-	if [ $? -ne 0 ]; then
-		tst_res TPASS "'$cmd' passed."
-	else
-		tst_res TFAIL "'$cmd' failed."
-	fi
-}
-
-tst_run
diff --git a/testcases/commands/du/Makefile b/testcases/commands/du/Makefile
deleted file mode 100644
index c1664460d..000000000
--- a/testcases/commands/du/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-#
-# commands/du testcases Makefile.
-#
-# Copyright (c) 2015 Fujitsu Ltd.
-# Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= du01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
deleted file mode 100755
index ed1df568f..000000000
--- a/testcases/commands/du/du01.sh
+++ /dev/null
@@ -1,126 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2015 Fujitsu Ltd.
-# Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-# Test du command with some basic options.
-#
-
-TST_CNT=23
-TST_SETUP=setup
-TST_TESTFUNC=do_test
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="dd du stat"
-. tst_test.sh
-
-setup()
-{
-	ROD_SILENT mkdir basedir
-	ROD_SILENT cd basedir
-
-	ROD_SILENT dd if=/dev/zero of=testfile bs=1M count=10
-
-	ROD_SILENT mkdir -p testdir
-
-	ROD_SILENT ln -s ../testfile testdir/testsymlink
-
-	# Display values are in units of the first available SIZE
-	# from --block-size, and the DU_BLOCK_SIZE, BLOCK_SIZE and
-	# BLOCKSIZE environment variables. Here we need to
-	# set DU_BLOCK_SIZE to 1024 to ensure the result is expected.
-	export DU_BLOCK_SIZE=1024
-}
-
-du_test()
-{
-	local test_return
-
-	$1 > ../temp 2>&1
-	test_return=$?
-
-	if [ ${test_return} -ne 0 ]; then
-		grep -q -E "unrecognized option|invalid option" ../temp
-		if [ $? -eq 0 ]; then
-			tst_res TCONF "'$1' not supported"
-		else
-			tst_res TFAIL "'$1' failed"
-		fi
-		return
-	fi
-
-	grep -q $2 ../temp
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "'$1' passed"
-	else
-		tst_res TFAIL "'$1' failed"
-		tst_res TINFO "Looking for '$2' in:"
-		cat ../temp
-	fi
-}
-
-block_size=512
-page_size=$(getconf PAGESIZE)
-if [ "$page_size" -lt 1024 ]; then
-	tst_brk TBROK "Page size < 1024"
-fi
-page_size=$((page_size / 1024))
-
-# The output could be different in some systems, if we use du to
-# estimate file space usage with the same filesystem and the same size.
-# So we use the approximate value to check.
-check1="^10[2-3][0-9][0-9][[:space:]]\."
-check2="^10[2-3][0-9][0-9][[:space:]]testfile"
-check3="^\(0\|${page_size}\)[[:space:]]\.\/testdir\/testsymlink"
-check5="^20[4-6][0-9][0-9][[:space:]]\."
-check7="^10[4-5][0-9][0-9]\{4\}[[:space:]]\."
-check9="^10[2-3][0-9][0-9][[:space:]]total"
-check11="^10[2-3][0-9][0-9][[:space:]]testdir\/testsymlink"
-check14="^1[0,1]M[[:space:]]\."
-check16="^10[2-3][0-9][0-9][[:space:]]testdir\/"
-check20="^11M[[:space:]]\."
-check23="^[0-9]\{1,2\}[[:space:]]\."
-
-do_test()
-{
-	case $1 in
-	1) du_test "du" ${check1};;
-	2) du_test "du testfile" ${check2};;
-	3) du_test "du -a" ${check3};;
-	4) du_test "du --all" ${check3};;
-	5) du_test "du -B ${block_size}" ${check5};;
-	6) du_test "du --block-size=${block_size}" ${check5};;
-	7) du_test "du -b" ${check7};;
-	8) du_test "du --bytes" ${check7};;
-	9) du_test "du -c" ${check9};;
-	10) du_test "du --total" ${check9};;
-	11) du_test "du -D testdir/testsymlink" ${check11};;
-	12) du_test "du --dereference-args testdir/testsymlink" ${check11};;
-	13) du_test "du --max-depth=1" ${check1};;
-	14) du_test "du --human-readable" ${check14};;
-	15) du_test "du -k" ${check1};;
-	16) du_test "du -L testdir/" ${check16};;
-	17) du_test "du --dereference testdir/" ${check16};;
-	18) du_test "du -P" ${check1};;
-	19) du_test "du --no-dereference" ${check1};;
-	20) du_test "du --si" ${check20};;
-	21) du_test "du -s" ${check1};;
-	22) du_test "du --summarize" ${check1};;
-	23) du_test "du --exclude=testfile" ${check23};;
-	esac
-}
-
-tst_run
diff --git a/testcases/commands/eject/Makefile b/testcases/commands/eject/Makefile
deleted file mode 100644
index d805ac555..000000000
--- a/testcases/commands/eject/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    commands/eject testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-INSTALL_TARGETS		:= eject-tests.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/eject/eject-tests.sh b/testcases/commands/eject/eject-tests.sh
deleted file mode 100755
index c1dcd584f..000000000
--- a/testcases/commands/eject/eject-tests.sh
+++ /dev/null
@@ -1,165 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author: Manoj Iyer, manjo@mail.utexas.edu                                 ##
-## Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>                          ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
-#
-# Tests basic functionality of eject command.
-#
-
-TST_CNT=4
-TST_SETUP=setup
-TST_CLEANUP=cleanup
-TST_TESTFUNC=test
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="eject"
-. tst_test.sh
-
-setup()
-{
-	CD_DRIVE="/dev/cdrom"
-
-	if ! [ -e "$CD_DRIVE" ]; then
-		tst_brk TCONF "There is no "$CD_DRIVE""
-	fi
-
-	if grep -q "$CD_DRIVE" /proc/mounts; then
-		tst_brk TCONF "$CD_DRIVE is already mounted"
-	fi
-
-	ROD mkdir "cdrom"
-}
-
-cleanup()
-{
-	# We have to use the mount point since /dev/cdrom may be link to
-	# /dev/sr0 and because of that /dev/cdrom is not listed in /proc/mounts
-	tst_umount "$PWD/cdrom"
-}
-
-test1()
-{
-	EXPECT_PASS eject -d \> eject.out
-
-	if grep -q "eject: default device:" eject.out; then
-		tst_res TPASS "Eject listed default device"
-	else
-		tst_res TFAIL "Eject failed to list default device"
-		cat eject.out
-	fi
-}
-
-test2()
-{
-	EXPECT_PASS eject -v $CD_DRIVE \> eject.out
-
-	if grep -q "CD-ROM eject command succeeded" eject.out; then
-		# Close the tray if it is supported.
-	        eject -t $CD_DRIVE > /dev/null 2>&1
-		tst_res TPASS "Drive successfully ejected"
-	else
-		tst_res TFAIL "Eject failed"
-		cat eject.out
-	fi
-}
-
-mount_cdrom()
-{
-	local tries=100
-
-	# Wait for the drive to spin up the disk
-	while [ $tries -gt 0 ]; do
-		eject_check_tray $CD_DRIVE
-		if [ $? -eq 4 ]; then
-			break
-		fi
-		tst_sleep 100ms
-		tries=$((tries-1))
-	done
-
-	mount "$CD_DRIVE" cdrom/ > mount.out 2>&1
-	if [ $? -eq 32 ]; then
-		tst_res TCONF "Failed to mount $CD_DRIVE, no disk in drive?"
-		cat mount.out
-		return 0
-	fi
-
-	tst_res TINFO "$CD_DRIVE mounted sucessfully"
-
-	return 1
-}
-
-test3()
-{
-	if mount_cdrom; then
-		return
-	fi
-
-	test2
-
-	if grep -q "$CD_DRIVE" /proc/mounts; then
-		tst_res TFAIL "$CD_DRIVE is stil moutned"
-	else
-		tst_res TPASS "$CD_DRIVE umounted succesfully"
-	fi
-}
-
-test4()
-{
-	if mount_cdrom; then
-		return
-	fi
-
-	EXPECT_PASS eject -a on $CD_DRIVE
-
-	eject_check_tray $CD_DRIVE
-	if [ $? -eq 2 ]; then
-		tst_brk TBROK "$CD_DRIVE is mounted but tray is open"
-	fi
-
-	EXPECT_PASS umount $CD_DRIVE
-
-	eject_check_tray $CD_DRIVE
-	if [ $? -eq 2 ]; then
-		tst_res TPASS "$CD_DRIVE was auto-ejected"
-	else
-		tst_res TFAIL "$CD_DRIVE was not auto-ejected"
-	fi
-
-	EXPECT_PASS eject -a off $CD_DRIVE
-
-	eject -t $CD_DRIVE > /dev/null 2>&1
-
-	if mount_cdrom; then
-		return
-	fi
-
-	EXPECT_PASS umount $CD_DRIVE
-
-	eject_check_tray $CD_DRIVE
-	if [ $? -eq 2 ]; then
-		tst_res TFAIL "$CD_DRIVE was auto-ejected"
-	else
-		tst_res TPASS "$CD_DRIVE was not auto-ejected"
-	fi
-}
-
-tst_run
diff --git a/testcases/commands/eject/eject_check_tray.c b/testcases/commands/eject/eject_check_tray.c
deleted file mode 100644
index 07e81534b..000000000
--- a/testcases/commands/eject/eject_check_tray.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) International Business Machines  Corp., 2001                 */
-/*  Jan 8 2003 - Created - Manoj Iyer manjo@mail.utexas.edu                   */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful, but        */
-/* WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY */
-/* or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   */
-/* for more details.                                                          */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software Foundation,   */
-/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
-/******************************************************************************/
-
-/*
- *
- * Description: This program checks the status of the cdrom drive, it will
- *              return the status as to if the cdrom device is open or is
- *              ready for use.
- */
-
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <linux/cdrom.h>
-#include <sys/ioctl.h>
-#include <stdlib.h>
-
-/*
- * Exit Vaules:
- * 0 - No information.
- * 1 - No disk in the drive.
- * 2 - CD tray is open.
- * 3 - CD drive not ready.
- * 4 - CD disk in drive & drive closed.
- */
-int main(int argc, char *argv[])
-{
-	int fd;
-
-	if (argc != 2)
-		exit(-1);
-
-	if ((fd = open(argv[1], O_RDONLY | O_NONBLOCK)) == -1)
-		exit(-2);
-
-	exit(ioctl(fd, CDROM_DRIVE_STATUS));
-}
diff --git a/testcases/commands/file/Makefile b/testcases/commands/file/Makefile
deleted file mode 100644
index 776db3226..000000000
--- a/testcases/commands/file/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    commands/ade/file testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= file01.sh
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/file/datafiles/.gitignore b/testcases/commands/file/datafiles/.gitignore
deleted file mode 100644
index 6bd63c963..000000000
--- a/testcases/commands/file/datafiles/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/in
diff --git a/testcases/commands/file/datafiles/Makefile b/testcases/commands/file/datafiles/Makefile
deleted file mode 100644
index d3cb847fe..000000000
--- a/testcases/commands/file/datafiles/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-#    Copyright (C) 2016, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-INSTALL_DIR		:= testcases/data/file01
-INSTALL_TARGETS		:= in*
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/file/datafiles/in.ar b/testcases/commands/file/datafiles/in.ar
deleted file mode 100644
index 25608352f..000000000
--- a/testcases/commands/file/datafiles/in.ar
+++ /dev/null
@@ -1,10 +0,0 @@
-!<arch>
-file1/          1477324017  1000  1000  100644  21        `
-This is simple file.
-
-file2/          1477324022  1000  1000  100644  21        `
-This is simple file.
-
-file3/          1477324026  1000  1000  100644  21        `
-This is simple file.
-
diff --git a/testcases/commands/file/datafiles/in.bash b/testcases/commands/file/datafiles/in.bash
deleted file mode 100644
index a964cd120..000000000
--- a/testcases/commands/file/datafiles/in.bash
+++ /dev/null
@@ -1,4 +0,0 @@
-#! /bin/bash
-
-echo "this is a shell script"
-echo "used to test file command"
diff --git a/testcases/commands/file/datafiles/in.c b/testcases/commands/file/datafiles/in.c
deleted file mode 100644
index 87b871604..000000000
--- a/testcases/commands/file/datafiles/in.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include <stdio.h>
-
-int main(void)
-{
-	printf("Hello Hell\n");
-	return 0;
-}
diff --git a/testcases/commands/file/datafiles/in.csh b/testcases/commands/file/datafiles/in.csh
deleted file mode 100644
index c475aef9c..000000000
--- a/testcases/commands/file/datafiles/in.csh
+++ /dev/null
@@ -1,4 +0,0 @@
-#! /bin/csh
-
-echo "this is a shell script"
-echo "used to test file command"
diff --git a/testcases/commands/file/datafiles/in.jpg b/testcases/commands/file/datafiles/in.jpg
deleted file mode 100644
index 0488574a699b8dcf2e9cdd48ac8896aa339d3805..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 542
zcmb7<T}lHn6ot=CCY?0Nj7gi+zI9y52!(2eQnw&j&{rwA50~LG#6|e?;!2EnC<^|x
z#gqGV`A*Kc`6<7_pUvho5D`xKA-`idy;)tXSC`H0_4=wgnJ>=sE2fY_bi*omlvb)J
zlqt)ecE&kttgY&Suj)`+>qkBeV@k;#9F9kEJcucFpO9ovq54YoV`Z!OZ{-IB4Fe-7
zKm?M3@*@)W$9HL7$6s6I7dS}}UV4D;kIN48Kg|ten$4udqyxg=fFx>Z7a+cXtr5L;
d6R{Pb_Gt3i8j_FncgsDU{Ju^bU`Hea&mS2iNcjK&

diff --git a/testcases/commands/file/datafiles/in.ksh b/testcases/commands/file/datafiles/in.ksh
deleted file mode 100644
index 3ae45125c..000000000
--- a/testcases/commands/file/datafiles/in.ksh
+++ /dev/null
@@ -1,4 +0,0 @@
-#! /bin/ksh
-
-echo "this is a shell script"
-echo "used to test file command"
diff --git a/testcases/commands/file/datafiles/in.m4 b/testcases/commands/file/datafiles/in.m4
deleted file mode 100644
index cf30df086..000000000
--- a/testcases/commands/file/datafiles/in.m4
+++ /dev/null
@@ -1,5 +0,0 @@
-dnl
-dnl This is a M4 script
-dnl
-define(TEST, This is a test)dnl
-TEST
diff --git a/testcases/commands/file/datafiles/in.mp3 b/testcases/commands/file/datafiles/in.mp3
deleted file mode 100644
index ae2200c1057a9579b0eddafd675bad98cb64925e..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1152
zcmezWSmFo+&xx=LjGhdP%!xY%Secm`9TnC}nPgmC>~@Pyfq{WR4hSTGG%8~P<Nf#l
z|7r<&FmRPHI{XKk!_K$h(Gkt50t^X1J2HY&4|dMe3p}eSnEy#9$!~i7VMeY1q5r=a
zSseq#e|)%@dH;Xts{g-3ts?jT-?HUpmVLRuk?~?rh&d8wHjMWf7`zOA9&|I%aM){*
z%h+h3)u3s>!k}Uxbs)rm^#Bta16KkUgV3kc|3L7o9z^~%)qZsx#Q1+1WDY0u0X7?k
z9}Em&p_d3b5T8gc$Q)CcIhP>@`8fKz8tYkF>Y0W@0h-a63PM5VB*M&rX~Uq2GpCnI
z=IkWZ95WfGCWCrsO@rwNZ4HbMtT*630P@#mm^l#!QVmuHoD6aT3_>;xR_5!}3;#?@
z)}H=UditwL$F*-?wcW^&ATKzdMV9?a@jr>DvWK}!7B@>IEM6*uVvfWKk#e4*t^@z=
zzQ4CIsC!#?dEd<bFS|CaJRFu^{`vc_sw~s`8Bb5uefpb~^Yh$?81)tj&cj?wDy3v}
zQOx0XIK$hp@M46(={_b_8E#Roxk7W;S&LiM1tTw93|wAc{wQ>=ieljX{~x*5gt9&>
zyzh0i`olAJR)LQ#DCQha*#7g+{qMKS6@N8qr|zw{e_R-`CsA|xg9L>dE_S|J-v44E
z!lL2|8y2ar|9?(P&oR-tPu&0i|Bp`sLFW7yl_(2gjF(_I?)XqZ+Wz0<29r6AOP>G#
z$Lx7PidoEI5;LoS{>MLMlU4gaRqTmWuRqkp#KXh>A4Dzkn*aY%PoV<HoTn0++>8@v
zNH8og;rsspNHjHE5dVMJ;ev<>FQaq(|7M4P3nr|H#J36y0GYF2Tubi^<17sZEb_z(
Sfy|jJ$mq3!ak2m<<^TW<Ycn_i

diff --git a/testcases/commands/file/datafiles/in.pl b/testcases/commands/file/datafiles/in.pl
deleted file mode 100755
index 29c2a3032..000000000
--- a/testcases/commands/file/datafiles/in.pl
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/usr/bin/perl
-
-print "This is a test.\n"
diff --git a/testcases/commands/file/datafiles/in.png b/testcases/commands/file/datafiles/in.png
deleted file mode 100644
index 24272b6926f2571191c5b50f3032ef3f91f6830a..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 159
zcmeAS@N?(olHy`uVBq!ia0vp^AT}2V6Od#Ih<F90I14-?iy0WWg+Z8+Vb&Z8pdfpR
zr>`sf11<@EWA5Ax-7=t%Y-UJAiF1B#Zfaf$kjuc}T$GwvlA5AWo>`Ki;O^-gkfN8$
w4ip#lba4!kxSagw|9^YtyaPuX#Ct+A8J0d~7W{v~awkZqr>mdKI;Vst0M;5P1^@s6

diff --git a/testcases/commands/file/datafiles/in.py b/testcases/commands/file/datafiles/in.py
deleted file mode 100755
index 802e7bf98..000000000
--- a/testcases/commands/file/datafiles/in.py
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/usr/bin/python3
-
-print("This is a test.")
diff --git a/testcases/commands/file/datafiles/in.sh b/testcases/commands/file/datafiles/in.sh
deleted file mode 100755
index 4e9b64a1c..000000000
--- a/testcases/commands/file/datafiles/in.sh
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh
-
-echo "This is a test."
diff --git a/testcases/commands/file/datafiles/in.src.rpm b/testcases/commands/file/datafiles/in.src.rpm
deleted file mode 100644
index b0c57d72b89de4cf1399230107106d98cf5f1c97..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1798
zcmbW1e^3-<7{}k^&iJJUV<1qYSK0s;=k4y@-ksr(36xB6h|DPob#HGE7VnM|xI_u+
zP_$7)L(_pE5=bf0qOS1=I!>807BM#B*bs=8Fo_6c+9ilw&vU#@S^xFUJp0|xKF|BS
z&-3oPJ8)>QQ%Q(|C}c;1R-@Gz5;*dIhk{J__tf&k*A?^``j&&u0}BL81`8uZc^y;*
zh67@iH$l;l&%m#k1o{xzBVgzs0!80~ah@<3{`95DmebC&xnU{mcc06A+@ci?oStV{
zMl^GJlUXOQjKRdSg2`-Vj2y2uGMuDmS(pz)X@iTuCZEsuDcr-Fg#4rKSXlNjJem&%
zbt!5<F~$NG1cn3a!alIh0Lp!ov2XO>pd3mW`wRxd{?I=_Sx<Qo6#LAkjD2H%tQX^N
zfug^FvKJKng_Q4tV*b}DkAPym+bG`$#rU0+$0)x$&MM4}Rt*L{sW29f3TdE>xse+w
zhk#;y6J_iZ*Yi-GNEz$IeAqX}W1YwkgF-yCHqN-m$T$!E5ugySh@y;&tOkWis%TJ*
zpGi4}@&d|npwNTjIm#)ZI3Ld>=EvvAuTowNiuo**@j3dlDQ8l@lkzIc#h_RZ&cpRe
zC`*(#QMOWki}E7M{`ZqaWC!tokAx%1F1vk$+9`-@g)B+!%9kwaf?RchlwY8>$~H+Y
z=GyIo!$RZI(^4OdwdUsegJnn71MwPI@a4&~%kv~zV-p-e0m_uLrDW;ywDIJkkS{?U
z8j;v!hpUhj8u`_{4&n&xm7>Mn;KnnHId*_8<OG(}OT1O9vkE+K(TO^iGaD=xfnf}i
z$XkioD(N{^5IHL+8TFi`(~BH@q@vCOAF5W58$yTLE)_sU|GmOD>L0MdA$d-_O*Y3R
z<=UNjQa<d;BG`;&f?djwCmj6BbO{X6X&44>8JZUl*Ix$j{O{rK5-#~pNhCyc%DE(K
zqwFLmLU%{a=nMvq)$v9iXZe2yKHvRaa33~(JDd|30m`@2?Q1)=VcuWvMeMV=Rn`=F
ziuvT!?7phVlTR8u=1nSnqP4OyL9R$#@w~4{YH=TE${5;IaIol3SAF|Crpn#HeNC6I
z1=m!Z?zBWsDM|mjDfHm2Ys13);-9*2UJZ(FRu|5g`BZ=PwZQ(o{dKjqWY(-6r)vG1
z-Jb9Z5og9CW-lpg8%gq}40S%{o6)uF?$v4MUL1(6dF_2)#yw9v+cB`}qq!w@mvaVt
z1N%>W+;}|o*RP&A+8E!mzo`6+Uelbi@{FxzaVECc&2Ig~^K)=W@Rj4u&wis?oLpzJ
zob0(caxuQ4bX~`>?JtFd*5}l$Iq{0i^4+F2hjY#(s$&e9n{Th&v*Ey=CC<_Js+teo
zDRjmbe|XRNL(h)$iivrS%J3hDKl{F~ZN=(x{nT$guFYN3`^raM_G4Szy+<xZjr|sw
zaMX9?(e5z&zC&$Zc5X(~eD9TMXNz}6T$r<R@0wW?Q{4$yM>|~`o7?ubPD(t$c%oJq
zYuk3o_1^RA+S(JNZ=b4|{lb?Ygb!}mmh{Hxna~^6(OZV9mU&u(O6x0!YfnY~(KY$=
ag?vYcYsA$5`^FMmY2dAxDWNv_hy4jC^QL_O

diff --git a/testcases/commands/file/datafiles/in.tar b/testcases/commands/file/datafiles/in.tar
deleted file mode 100644
index 8002b15b9f4aef65259a0e2d553166de7b9e04f4..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 10240
zcmeIx(F%ev6vpvg_Y`}AINNl4kzT+HB|#(7-oMRm0>KKlF!&E);K8%QZ+=}rv__R(
z5|^(k6*m)VdEHY<#Ma6<5m#C7yisB#c(1gS9qZZsKF!TdYc;lWbJ;lXU47%zJ(o`B
ze$w%o`tdrnx{JTV@v!HCnJue8x^SDd<GNXj_~-feOa4Pe{@0TE-;n?OrvKD2<=+(^
z_^bQ}`^>*3|Ant*X;1!tq0AWwAb<b@2q1s}0tg_000IagfB*srAb<b@2q1s}0tg_0
HKzV@&f#yty

diff --git a/testcases/commands/file/datafiles/in.tar.bz2 b/testcases/commands/file/datafiles/in.tar.bz2
deleted file mode 100644
index d304d3ed6cb18c8efa5875b012e73c1e2757cb98..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 181
zcmV;m080NtT4*^jL0KkKSxpR}V*miq`-Q>~0DwRNe}DuCV`p9f0096%00=MuxC~)2
zGGHbE0~kz9m<fOYMIa(%&`k%avYu0&TzX}bMy><`#l#0rxLjo8I%w6f^<fZ`8ZgcF
z$@z8|Xxwfg>9P_Y?3p2(e5TQXpTXtq&h1;atAjVQL6JGQw46j-Zt&E9kl78#yQe0u
j!|C0#!@%b5$>4KgklE$@9*-_4hxogaDZ+$;Xk`N!X&g~s

diff --git a/testcases/commands/file/datafiles/in.tar.gz b/testcases/commands/file/datafiles/in.tar.gz
deleted file mode 100644
index 57aae6973d8e0bb24e4fc99b78f6800b3870561b..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 183
zcmb2|=HOt_<%?io&dk#*Ni1S`d)b%kkbywk!!@?9ehQQ4tBHSPirpfS;p($@|KFQC
zf_8bh)XFn$_DEn;i=W?iZpEe)u|4stI(u!d_vTJ1R62M2K~rFoO51`hBJ;9K&j(ju
zj_SR8B`$7Hb@~6Le$S_TttpaP@4Wo?Piq<e`Ep!Wb-1^;R=+u2AMsh<_UHP>KmWI<
iK3rGOAN#Yv?DT%s|E3e_8Q|atFMs-k^}!4p3=9COAyE+k

diff --git a/testcases/commands/file/datafiles/in.txt b/testcases/commands/file/datafiles/in.txt
deleted file mode 100644
index bf06024f2..000000000
--- a/testcases/commands/file/datafiles/in.txt
+++ /dev/null
@@ -1,2 +0,0 @@
-This is a text file
-to test file command.
diff --git a/testcases/commands/file/datafiles/in.wav b/testcases/commands/file/datafiles/in.wav
deleted file mode 100644
index 5aa92741ccc1d09c19894c543fd5d66038710e0e..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 8044
zcmWIYbaP9QXJ80-40BD(Em06)U|?VbLI<E22s1KpFr*}wB!bxgN5N<ajE2By2#kin
zXb6mkz-S1JhQMeDjE2By2#kinXb6mkz-S1JhQMeDjE2By2#kinXb6mkz-S1JhQMeD
zjE2Av3IX8c->?QE3`}7Eaqt2uHU>5=FLpz90R|Zzc4q??b`FNH+SsWL>D3dK_0DW<
hm~?dO=FLYgY<YP8`-eZkNc{C;2*u>6QwLuN005OtBU=Cf

diff --git a/testcases/commands/file/datafiles/in.zip b/testcases/commands/file/datafiles/in.zip
deleted file mode 100644
index d5e5873cc7d760b49af7260dd872065f2f9df40b..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 499
zcmWIWW@h1H0D-%`5uTA+ZY82XHVCsa$S|a3=A;^ihHx@4f7IcNsP^THD6QaTU}Sm0
z%)kI9LNYRo6@aKXGq)foRRN@4k1GIf=0hB28iCFHMwXe6ahPcgHuD!rW->C#G2`;R
z1Sn7#7=d_6BZvhJ3sy*2poK$#H^L}PPa_)@0yPR41VE!eL4e07Our%<wE}7s(C0v-
WKt9JXij@uIbY>uY2&DgjI1B*8vtv^L

diff --git a/testcases/commands/file/file01.sh b/testcases/commands/file/file01.sh
deleted file mode 100755
index 5a81b3b93..000000000
--- a/testcases/commands/file/file01.sh
+++ /dev/null
@@ -1,106 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-## Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>                          ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
-#
-# This program tests the file command. The tests are aimed at
-# testing if the file command can recognize some of the commonly
-# used file formats like, tar, tar.gz, rpm, C, ASCII, ELF etc.
-#
-TST_CNT=20
-TST_SETUP=setup
-TST_TESTFUNC=do_test
-TST_NEEDS_TMPDIR=1
-. tst_test.sh
-
-setup()
-{
-	case $(readelf -h /bin/sh) in
-	*Data:*"big endian"*) TEST_ARCH=MSB;;
-	*Data:*"little endian"*) TEST_ARCH=LSB;;
-        *) tst_brk TBROK "Failed to determine CPU endianess";;
-	esac
-}
-
-file_test()
-{
-	local fname="$1"
-	local fpath
-	local i
-	shift
-
-	if ! [ -f "$fname" ]; then
-		fpath="$TST_DATAROOT/$fname"
-	else
-		fpath="$fname"
-	fi
-
-	EXPECT_PASS file "$fpath" \> file.out
-
-	while [ $# -gt 0 ]; do
-		if grep -q "$1" file.out; then
-			break
-		fi
-		shift
-	done
-
-	if [ $# -gt 0 ]; then
-		tst_res TPASS "$fname: recognized as $1"
-	else
-		tst_res TFAIL "$fname: was not recognized"
-		cat file.out
-	fi
-}
-
-do_test()
-{
-	case $1 in
-	 1) file_test in.txt "ASCII text";;
-	 2) file_test in.bash "Bourne-Again shell script";;
-	 3) file_test in.sh "POSIX shell script, ASCII text executable" \
-			    "POSIX shell script text executable" \
-			    "POSIX shell script text" \
-			    "Bourne shell script text executable";;
-	 4) file_test in.ksh "Korn shell script";;
-	 5) file_test in.csh "C shell script";;
-	 6) file_test in.c "ASCII C program text" "C source, ASCII text";;
-	 7) file_test in.pl "[pP]erl script, ASCII text executable" \
-			    "[pP]erl script text executable" \
-			    "a /usr/bin/perl script text";;
-	 8) file_test in.py "[pP]ython3\{0,1\} script, ASCII text executable" \
-			    "[pP]ython3\{0,1\} script text executable";;
-	 9) file_test in.m4 "M4 macro processor script, ASCII text" \
-			    "ASCII M4 macro language pre-processor text";;
-	10) file_test in "ELF .*-bit $TEST_ARCH executable, .*" \
-			 "ELF .*-bit $TEST_ARCH shared object, .*";;
-	11) file_test in.ar "current ar archive";;
-	12) file_test in.tar "tar archive";;
-	13) file_test in.tar.gz "gzip compressed data, .*";;
-	14) file_test in.tar.bz2 "bzip2 compressed data, .*";;
-	15) file_test in.src.rpm "RPM v3 src" "RPM v3.0 src";;
-	16) file_test in.jpg "JPEG image data";;
-	17) file_test in.png "PNG image data";;
-	18) file_test in.wav "RIFF (little-endian) data, WAVE audio, Microsoft PCM";;
-	19) file_test in.mp3 "MPEG ADTS, layer III";;
-	20) file_test in.zip "Zip archive data";;
-	esac
-}
-
-tst_run
diff --git a/testcases/commands/gdb/Makefile b/testcases/commands/gdb/Makefile
deleted file mode 100644
index 1ebbf653d..000000000
--- a/testcases/commands/gdb/Makefile
+++ /dev/null
@@ -1,26 +0,0 @@
-#
-#    misc/gdb test suite Makefile.
-#
-#    Copyright (C) 2017 Red Hat, Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-#    General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, see <http://www.gnu.org/licenses/>.
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/gdb/gdb01.sh b/testcases/commands/gdb/gdb01.sh
deleted file mode 100755
index e3a5b5193..000000000
--- a/testcases/commands/gdb/gdb01.sh
+++ /dev/null
@@ -1,41 +0,0 @@
-#!/bin/sh
-
-# Copyright (C) 2017 Red Hat, Inc.
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
-
-# Test description: See if gdb can successfully attach to a process and
-#                   this process exits normally.
-
-# Usage
-# ./gdb01.sh
-
-TST_TESTFUNC=simple_test
-TST_NEEDS_CMDS="gdb /bin/cat"
-
-. tst_test.sh
-
-simple_test()
-{
-	gdb /bin/cat -ex "run /etc/passwd" -ex quit < /dev/null
-	RC=$?
-	if [ $RC -eq 0 ] ; then
-		tst_res TPASS "gdb attached to process and completed run"
-	else
-		tst_res TFAIL "gdb test failed with" $RC
-	fi
-}
-
-tst_run
diff --git a/testcases/commands/gzip/Makefile b/testcases/commands/gzip/Makefile
deleted file mode 100644
index 502781b57..000000000
--- a/testcases/commands/gzip/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/gzip testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= gzip_tests.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/gzip/gzip_tests.sh b/testcases/commands/gzip/gzip_tests.sh
deleted file mode 100755
index 05ecb6fcd..000000000
--- a/testcases/commands/gzip/gzip_tests.sh
+++ /dev/null
@@ -1,170 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-## Author:       Manoj Iyer, manjo@mail.utexas.edu                            ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
-#
-# Description:  Test basic functionality of gzip and gunzip command
-#		- Test #1:  Test that gzip -r will travel directories and
-#			    compress all the files available.
-#
-#		- Test #2:  Test that gunzip -r will travel directories and
-#			    uncompress all the files available.
-#
-
-TST_CNT=2
-TST_TESTFUNC=test
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="gzip gunzip"
-. tst_test.sh
-
-creat_dirnfiles()
-{
-	local numdirs=$2
-	local numfiles=$3
-	local dirname=$4
-	local dircnt=0
-	local fcnt=0
-
-	tst_res TINFO "Test #$1: Creating $numdirs directories"
-	tst_res TINFO "Test #$1: filling each dir with $numfiles files"
-	while [ $dircnt -lt $numdirs ]; do
-		dirname=$dirname/d.$dircnt
-		ROD_SILENT mkdir -p $dirname
-
-		fcnt=0
-		while [ $fcnt -lt $numfiles ]; do
-			ROD_SILENT touch $dirname/f.$fcnt
-			fcnt=$(($fcnt+1))
-		done
-		dircnt=$(($dircnt+1))
-	done
-}
-
-creat_expout()
-{
-	local numdir=$1
-	local numfile=$2
-	local dirname=$3
-	local ext=$4
-	local dircnt=0
-	local fcnt=0
-
-	echo "$dirname:"  1> tst_gzip.exp
-	echo "d.$dircnt"  1>> tst_gzip.exp
-	while [ $dircnt -lt $numdirs ]; do
-		dirname=$dirname/d.$dircnt
-		dircnt=$(($dircnt+1))
-		echo "$dirname:"  1>> tst_gzip.exp
-		if [ $dircnt -lt $numdirs ]; then
-			echo "d.$dircnt"  1>> tst_gzip.exp
-		fi
-		fcnt=0
-		while [ $fcnt -lt $numfiles ]; do
-			echo "f.$fcnt$ext " 1>> tst_gzip.exp
-			fcnt=$(($fcnt+1))
-		done
-		printf "\n\n" 1>> tst_gzip.exp
-	done
-}
-
-test1()
-{
-	numdirs=10
-	numfiles=10
-	dircnt=0
-	fcnt=0
-
-	ROD_SILENT mkdir tst_gzip.tmp
-
-	tst_res TINFO "Test #1: gzip -r will recursively compress contents" \
-			"of directory"
-
-	creat_dirnfiles 1 $numdirs $numfiles tst_gzip.tmp
-
-	gzip -r tst_gzip.tmp > tst_gzip.err 2>&1
-	if [ $? -ne 0 ]; then
-		cat tst_gzip.err
-		tst_brk TFAIL "Test #1: gzip -r failed"
-	fi
-
-	tst_res TINFO "Test #1: creating output file"
-	ls -R tst_gzip.tmp > tst_gzip.out 2>&1
-
-	tst_res TINFO "Test #1: creating expected output file"
-	creat_expout $numdirs $numfiles tst_gzip.tmp .gz
-
-	diff -w -B tst_gzip.out tst_gzip.exp > tst_gzip.err 2>&1
-	if [ $? -ne 0 ]; then
-		cat tst_gzip.err
-		tst_res TFAIL "Test #1: gzip failed"
-	else
-		tst_res TPASS "Test #1: gzip -r success"
-	fi
-
-	ROD_SILENT rm -rf tst_gzip.tmp/
-}
-
-test2()
-{
-	numdirs=10
-	numfiles=10
-	dircnt=0
-	fcnt=0
-
-	ROD_SILENT mkdir tst_gzip.tmp
-
-	tst_res TINFO "Test #2: gunzip -r will recursively uncompress" \
-			"contents of directory"
-
-	creat_dirnfiles 2 $numdirs $numfiles tst_gzip.tmp
-
-	gzip -r tst_gzip.tmp > tst_gzip.err 2>&1
-	if [ $? -ne 0 ]; then
-		cat tst_gzip.err
-		tst_brk TBROK "Test #2: compressing directory tst_gzip.tmp" \
-				"failed"
-	fi
-
-	gunzip -r tst_gzip.tmp > tst_gzip.err 2>&1
-	if [ $? -ne 0 ]; then
-		cat tst_gzip.err
-		tst_brk TBROK "Test #2: uncompressing directory" \
-				" tst_gzip.tmp failed"
-	fi
-
-	tst_res TINFO "Test #2: creating output file"
-	ls -R tst_gzip.tmp > tst_gzip.out 2>&1
-
-	tst_res TINFO "Test #2: creating expected output file"
-	creat_expout $numdirs $numfiles tst_gzip.tmp
-
-	tst_res TINFO "Test #2: comparing expected out and actual output file"
-	diff -w -B tst_gzip.out tst_gzip.exp > tst_gzip.err 2>&1
-	if [ $? -ne 0 ]; then
-		cat tst_gzip.err
-		tst_res TFAIL "Test #2: gunzip failed"
-	else
-		tst_res TPASS "Test #2: gunzip -r success"
-	fi
-
-	ROD_SILENT rm -rf tst_gzip.tmp/
-}
-
-tst_run
diff --git a/testcases/commands/insmod/Makefile b/testcases/commands/insmod/Makefile
deleted file mode 100644
index e5e68b695..000000000
--- a/testcases/commands/insmod/Makefile
+++ /dev/null
@@ -1,36 +0,0 @@
-#
-#    Copyright (c) 2016 Fujitsu Ltd.
-#    Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-
-ifneq ($(KERNELRELEASE),)
-
-obj-m := ltp_insmod01.o
-
-else
-
-top_srcdir		?= ../../..
-include $(top_srcdir)/include/mk/testcases.mk
-
-REQ_VERSION_MAJOR       := 2
-REQ_VERSION_PATCH       := 6
-MAKE_TARGETS            := ltp_insmod01.ko
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= insmod01.sh
-
-include $(top_srcdir)/include/mk/module.mk
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
-
-endif
diff --git a/testcases/commands/insmod/insmod01.sh b/testcases/commands/insmod/insmod01.sh
deleted file mode 100755
index a7835f9b9..000000000
--- a/testcases/commands/insmod/insmod01.sh
+++ /dev/null
@@ -1,60 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2016 Fujitsu Ltd.
-# Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
-# Test the basic functionality of insmod command.
-#
-
-TST_CLEANUP=cleanup
-TST_TESTFUNC=do_test
-TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="rmmod insmod"
-TST_NEEDS_MODULE="ltp_insmod01.ko"
-. tst_test.sh
-
-inserted=0
-
-cleanup()
-{
-	if [ $inserted -ne 0 ]; then
-		tst_res TINFO "running rmmod ltp_insmod01"
-		rmmod ltp_insmod01
-		if [ $? -ne 0 ]; then
-			tst_res TWARN "failed to rmmod ltp_insmod01"
-		fi
-		inserted=0
-	fi
-}
-
-do_test()
-{
-	insmod "$TST_MODPATH"
-	if [ $? -ne 0 ]; then
-		tst_res TFAIL "insmod failed"
-		return
-	fi
-	inserted=1
-
-	grep -q ltp_insmod01 /proc/modules
-	if [ $? -ne 0 ]; then
-		tst_res TFAIL "ltp_insmod01 not found in /proc/modules"
-		return
-	fi
-
-	cleanup
-
-	tst_res TPASS "insmod passed"
-}
-
-tst_run
diff --git a/testcases/commands/insmod/ltp_insmod01.c b/testcases/commands/insmod/ltp_insmod01.c
deleted file mode 100644
index 398714e78..000000000
--- a/testcases/commands/insmod/ltp_insmod01.c
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Copyright (c) 2016 Fujitsu Ltd.
- * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
- * the GNU General Public License for more details.
- *
- * Description:
- *  This is a kernel loadable module programme used by insmod01.sh
- *  testcase which inserts this module for test of insmod command.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-static int test_init(void)
-{
-	return 0;
-}
-
-static void test_exit(void)
-{
-
-}
-
-module_init(test_init);
-module_exit(test_exit);
diff --git a/testcases/commands/keyctl/Makefile b/testcases/commands/keyctl/Makefile
deleted file mode 100644
index 144beed7c..000000000
--- a/testcases/commands/keyctl/Makefile
+++ /dev/null
@@ -1,24 +0,0 @@
-#
-#    commands/keyctl testcases Makefile.
-#
-#    Copyright (c) 2017 Fujitsu Ltd.
-#    Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= keyctl01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
deleted file mode 100644
index 3fda3893b..000000000
--- a/testcases/commands/keyctl/keyctl01.sh
+++ /dev/null
@@ -1,126 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2017 Fujitsu Ltd.
-# Ported: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program, if not, see <http://www.gnu.org/licenses/>.
-#
-# This is a regression test about potential uninitialized variable,
-# the test can crash the buggy kernel, and the bug has been fixed in:
-#
-#   commit 38327424b40bcebe2de92d07312c89360ac9229a
-#   Author: Dan Carpenter <dan.carpenter@oracle.com>
-#   Date:   Thu Jun 16 15:48:57 2016 +0100
-#
-#   KEYS: potential uninitialized variable
-#
-
-TST_SETUP=setup
-TST_CLEANUP=cleanup
-TST_TESTFUNC=do_test
-TST_NEEDS_ROOT=1
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="keyctl"
-. tst_test.sh
-
-check_keyctl()
-{
-	local nosup
-	for op in $@; do
-		nosup=0
-
-		if ! keyctl 2>&1 | grep -q "keyctl $op"; then
-			nosup=1
-		fi
-
-		if [ "$op" = "request2" ]; then
-			local key=`keyctl request2 user debug:foo bar`
-			if [ $? -ne 0 ]; then
-				nosup=1
-			fi
-		fi
-
-		if [ "$op" = "unlink" ]; then
-			if ! keyctl unlink $key @s; then
-				nosup=1
-			fi
-		fi
-
-		if [ $nosup -ne 0 ]; then
-			tst_brk TCONF "keyctl operation $op not supported"
-		fi
-	done
-}
-
-setup()
-{
-	check_keyctl negate request2 show unlink
-
-	PATH_KEYSTAT="/proc/key-users"
-	PATH_KEYQUOTA="/proc/sys/kernel/keys/root_maxbytes"
-
-	if [ ! -f "$PATH_KEYSTAT" ] || [ ! -f "$PATH_KEYQUOTA" ]; then
-		tst_brk TCONF "'${PATH_KEYSTAT}' or '${PATH_KEYQUOTA}' \
-			does not exist"
-	fi
-
-	ORIG_KEYSZ=`awk -F' +|/' '/ 0:/ {print $8}' $PATH_KEYSTAT`
-	ORIG_MAXKEYSZ=`cat $PATH_KEYQUOTA`
-}
-
-cleanup()
-{
-	if [ -n "$ORIG_MAXKEYSZ" ]; then
-		echo $ORIG_MAXKEYSZ >$PATH_KEYQUOTA
-	fi
-}
-
-do_test()
-{
-	local quota_excd=0
-	local maxkeysz=$((ORIG_KEYSZ + 100))
-
-	while [ $maxkeysz -ge 0 ]
-	do
-		echo $maxkeysz >$PATH_KEYQUOTA
-
-		keyctl request2 user debug:fred negate @t >temp 2>&1
-		grep -q -E "quota exceeded" temp
-		if [ $? -eq 0 ]; then
-			quota_excd=1
-			break
-		fi
-
-		local key=`keyctl show | awk '/debug:fred/ {print $1}'`
-		if [ -z "$key" ]; then
-			key=`keyctl show | \
-				awk -F ':' '/inaccessible/ {print $1}'`
-		fi
-
-		if [ -n "$key" ]; then
-			keyctl unlink $key @s >/dev/null
-			tst_sleep 50ms
-		fi
-
-		maxkeysz=$((maxkeysz - 4))
-	done
-
-	if [ $quota_excd -eq 0 ]; then
-		tst_res TWARN "Failed to trigger the quota excess"
-	fi
-
-	tst_res TPASS "Bug not reproduced"
-}
-
-tst_run
diff --git a/testcases/commands/ld/Makefile b/testcases/commands/ld/Makefile
deleted file mode 100644
index 4b7ca9630..000000000
--- a/testcases/commands/ld/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    commands/ade/ld testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= ld01
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/ld/datafiles/Makefile b/testcases/commands/ld/datafiles/Makefile
deleted file mode 100644
index 4eb64ad00..000000000
--- a/testcases/commands/ld/datafiles/Makefile
+++ /dev/null
@@ -1,22 +0,0 @@
-#
-#    Copyright (C) 2016, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_DIR		:= testcases/data/ld01
-MAKE_TARGETS		:=
-INSTALL_TARGETS		:= *.c
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/ld/datafiles/d1.c b/testcases/commands/ld/datafiles/d1.c
deleted file mode 100644
index 13b7af199..000000000
--- a/testcases/commands/ld/datafiles/d1.c
+++ /dev/null
@@ -1 +0,0 @@
-int d1 = 1;
diff --git a/testcases/commands/ld/datafiles/f1.c b/testcases/commands/ld/datafiles/f1.c
deleted file mode 100644
index ebb5e10bd..000000000
--- a/testcases/commands/ld/datafiles/f1.c
+++ /dev/null
@@ -1,7 +0,0 @@
-
-void f1(void)
-{
-	int i = 69;
-	i = i;
-	return;
-}
diff --git a/testcases/commands/ld/datafiles/main.c b/testcases/commands/ld/datafiles/main.c
deleted file mode 100644
index 6f9c47aef..000000000
--- a/testcases/commands/ld/datafiles/main.c
+++ /dev/null
@@ -1,10 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-
-extern void use_s1();
-
-int main(void)
-{
-	use_s1();
-	return (0);
-}
diff --git a/testcases/commands/ld/datafiles/rd1.c b/testcases/commands/ld/datafiles/rd1.c
deleted file mode 100644
index d9496bd50..000000000
--- a/testcases/commands/ld/datafiles/rd1.c
+++ /dev/null
@@ -1,8 +0,0 @@
-#include <stdio.h>
-
-extern int d1;
-
-void use_s1(void)
-{
-	d1 = d1 + d1;
-}
diff --git a/testcases/commands/ld/datafiles/rf1.c b/testcases/commands/ld/datafiles/rf1.c
deleted file mode 100644
index 57a23f1b2..000000000
--- a/testcases/commands/ld/datafiles/rf1.c
+++ /dev/null
@@ -1,10 +0,0 @@
-#include <stdlib.h>
-#include <stdio.h>
-
-extern void f1();
-
-void use_s1(void)
-{
-//      printf("calling function f1");
-	f1();
-}
diff --git a/testcases/commands/ld/ld01 b/testcases/commands/ld/ld01
deleted file mode 100755
index f24f6f97e..000000000
--- a/testcases/commands/ld/ld01
+++ /dev/null
@@ -1,97 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2000
-#  06/01 Robbie Williamson (robbiew@us.ibm.com)
-# Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
-#
-# This program is free software;  you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY;  without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-# the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#---------------------------------------------------------------------------
-#
-# Test the basic functionality of the `ld` command.
-#
-
-CC=${CC:=gcc}
-LD=${LD:=ld}
-
-TST_CNT=5
-TST_TESTFUNC=test
-TST_SETUP=setup
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="$CC $LD"
-. tst_test.sh
-
-setup()
-{
-	for i in rf1 f1 rd1 d1 main; do
-		ROD $CC -fPIC -c -o ${i}.o $TST_DATAROOT/${i}.c
-	done
-}
-
-test1()
-{
-	EXPECT_FAIL $LD x.o y.o 2\> ld.out
-
-	if grep -q "$LD:.*[xy]\.o.*No such file or directory" ld.out; then
-		tst_res TPASS "Missing files were reported"
-	else
-		tst_res TFAIL "Missing files were not reported"
-		cat ld.out
-	fi
-}
-
-test2()
-{
-	EXPECT_FAIL $CC x.o y.o 2\> cc.out
-
-	if grep -q "$CC:.*[xy]\.o.*No such file or directory" cc.out; then
-		tst_res TPASS "Missing files were reported"
-	else
-		tst_res TFAIL "Missing files were not reported"
-		cat cc.out
-	fi
-}
-
-test3()
-{
-	EXPECT_PASS $LD -shared f1.o d1.o -o test.so
-
-	if file test.so |grep -q shared; then
-		tst_res TPASS "Shared library could be build"
-	else
-		tst_res TFAIL "Failed to build shared library"
-	fi
-}
-
-test4()
-{
-	EXPECT_PASS $LD -Bdynamic -shared f1.o d1.o -o test.so
-	EXPECT_FAIL $LD -Bstatic -L. main.o rd1.o test.so -o a.out
-}
-
-test5()
-{
-	EXPECT_PASS $LD -Bdynamic -shared main.o f1.o rf1.o -o test.so -L/usr/lib/
-	EXPECT_FAIL $LD -Bstatic -r main.o f1.o rf1.o test.so -L/usr/lib/ 2\> ld.out
-	cat ld.out
-
-	if grep -q "$LD: attempted static link of dynamic object" ld.out; then
-		tst_res TPASS "Got expected error message"
-	else
-		tst_res TFAIL "Unexpected error message"
-		cat ld.out
-	fi
-}
-
-tst_run
diff --git a/testcases/commands/ldd/Makefile b/testcases/commands/ldd/Makefile
deleted file mode 100644
index 6a6af0798..000000000
--- a/testcases/commands/ldd/Makefile
+++ /dev/null
@@ -1,25 +0,0 @@
-#
-#    commands/ade/ldd testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= ldd01
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/ldd/datafiles/Makefile b/testcases/commands/ldd/datafiles/Makefile
deleted file mode 100644
index d8bcf5c06..000000000
--- a/testcases/commands/ldd/datafiles/Makefile
+++ /dev/null
@@ -1,37 +0,0 @@
-#
-#    commands/ade/ldd/datafiles testcases Makefile.
-#
-#    Copyright (C) 2014, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-CPPFLAGS		+= -fpic
-
-INSTALL_TARGETS		:= ldd*.so lddfile.out
-
-LDD_C_FILES		:= $(wildcard $(abs_srcdir)/lddfile*.c)
-LDD_SO_FILES		:= $(patsubst $(abs_srcdir)/%.c,%.obj.so,$(LDD_C_FILES))
-MAKE_TARGETS		:= lddfile.out
-CLEAN_TARGETS		+= *.obj $(LDD_SO_FILES)
-
-%.obj.so: %.o
-	$(CC) $(CFLAGS) -shared -o $@ $^
-
-lddfile.out: main.o $(LDD_SO_FILES)
-	$(CC) $(CFLAGS) -O -o $@ $?
-
-INSTALL_DIR		:= testcases/data/ldd01
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/ldd/datafiles/lddfile1.c b/testcases/commands/ldd/datafiles/lddfile1.c
deleted file mode 100644
index ccb5786a9..000000000
--- a/testcases/commands/ldd/datafiles/lddfile1.c
+++ /dev/null
@@ -1,5 +0,0 @@
-#include <stdio.h>
-void file1(void)
-{
-	printf("Control in function %s\n", __func__);
-}
diff --git a/testcases/commands/ldd/datafiles/lddfile2.c b/testcases/commands/ldd/datafiles/lddfile2.c
deleted file mode 100644
index 20aede313..000000000
--- a/testcases/commands/ldd/datafiles/lddfile2.c
+++ /dev/null
@@ -1,5 +0,0 @@
-#include <stdio.h>
-void file2(void)
-{
-	printf("Control in function %s\n", __func__);
-}
diff --git a/testcases/commands/ldd/datafiles/lddfile3.c b/testcases/commands/ldd/datafiles/lddfile3.c
deleted file mode 100644
index a4529f7ac..000000000
--- a/testcases/commands/ldd/datafiles/lddfile3.c
+++ /dev/null
@@ -1,5 +0,0 @@
-#include <stdio.h>
-void file3(void)
-{
-	printf("Control in function %s\n", __func__);
-}
diff --git a/testcases/commands/ldd/datafiles/lddfile4.c b/testcases/commands/ldd/datafiles/lddfile4.c
deleted file mode 100644
index 9dc339df4..000000000
--- a/testcases/commands/ldd/datafiles/lddfile4.c
+++ /dev/null
@@ -1,5 +0,0 @@
-#include <stdio.h>
-void file4(void)
-{
-	printf("Control in function %s\n", __func__);
-}
diff --git a/testcases/commands/ldd/datafiles/lddfile5.c b/testcases/commands/ldd/datafiles/lddfile5.c
deleted file mode 100644
index 3fbb7f607..000000000
--- a/testcases/commands/ldd/datafiles/lddfile5.c
+++ /dev/null
@@ -1,5 +0,0 @@
-#include <stdio.h>
-void file5(void)
-{
-	printf("Control in function %s\n", __func__);
-}
diff --git a/testcases/commands/ldd/datafiles/main.c b/testcases/commands/ldd/datafiles/main.c
deleted file mode 100644
index 69e278e86..000000000
--- a/testcases/commands/ldd/datafiles/main.c
+++ /dev/null
@@ -1,18 +0,0 @@
-#include <stdio.h>
-
-void file1(void);
-void file2(void);
-void file3(void);
-void file4(void);
-void file5(void);
-
-int main(void)
-{
-	file1();
-	file2();
-	file3();
-	file4();
-	file5();
-	printf("All Functions Executed\n");
-	return 0;
-}
diff --git a/testcases/commands/ldd/ldd01 b/testcases/commands/ldd/ldd01
deleted file mode 100755
index cf2aac3c1..000000000
--- a/testcases/commands/ldd/ldd01
+++ /dev/null
@@ -1,64 +0,0 @@
-#!/bin/sh
-#
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#
-#
-#  FILE   : ldd01
-#
-#  PURPOSE: To test the basic functionality of the `ldd` command.
-#
-#  HISTORY:
-#    06/01 Robbie Williamson (robbiew@us.ibm.com)
-#     -Ported
-#---------------------------------------------------------------------------
-
-TST_CNT=2
-TST_SETUP=setup
-TST_TESTFUNC=test
-. tst_test.sh
-
-LDD=${LDD:=ldd}
-
-setup()
-{
-	export LD_LIBRARY_PATH="$TST_DATAROOT:$LD_LIBRARY_PATH"
-	LDDTESTFILE="$TST_DATAROOT/lddfile.out"
-}
-
-test1()
-{
-
-	$LDD $LDDTESTFILE | grep -q -E "lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "Found lddfile*.obj.so"
-	else
-		tst_res TFAIL "Haven't found lddfile*.obj.so"
-	fi
-}
-
-test2()
-{
-	$LDD -v $LDDTESTFILE | grep -q -E "GLIBC|lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "Found GLIBC"
-	else
-		tst_res TFAIL "Haven't found GLIBC"
-	fi
-}
-
-tst_run
diff --git a/testcases/commands/ln/Makefile b/testcases/commands/ln/Makefile
deleted file mode 100644
index c32fe5c54..000000000
--- a/testcases/commands/ln/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/fileutils/ln testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= ln_tests.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/ln/ln_tests.sh b/testcases/commands/ln/ln_tests.sh
deleted file mode 100755
index bc48bedb3..000000000
--- a/testcases/commands/ln/ln_tests.sh
+++ /dev/null
@@ -1,98 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author:       Manoj Iyer, manjo@mail.utexas.edu                           ##
-## Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>                          ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
-#
-# Basic test for ln
-#
-TST_CNT=6
-TST_TESTFUNC=do_test
-TST_SETUP=setup
-TST_NEEDS_TMPDIR=1
-. tst_test.sh
-
-setup()
-{
-	ROD mkdir -p dir/subdir
-	ROD echo "LTP" > file
-	ROD touch dir/file
-}
-
-check_dir_link()
-{
-	local dname="$1"
-	local lname="$2"
-
-	ROD ls "$lname" > lname.out
-	ROD ls "$dname" > dname.out
-
-	if diff lname.out dname.out; then
-		tst_res TPASS "Directory and link content is equal"
-	else
-		tst_res TFAIL "Directory and link content differs"
-		cat lname.out
-		echo
-		cat dname.out
-	fi
-}
-
-check_file_link()
-{
-	local fname="$1"
-	local lname="$2"
-
-	if diff $fname $lname; then
-		tst_res TPASS "File and link content is equal"
-	else
-		tst_res TFAIL "File and link content differs"
-	fi
-}
-
-ln_test()
-{
-	local args="$1"
-	local src="$2"
-	local link="$3"
-
-	EXPECT_PASS ln $args $src $link
-
-	if [ -f $src ]; then
-		check_file_link $src $link
-	else
-		check_dir_link $src $link
-	fi
-
-	ROD rm $link
-}
-
-do_test()
-{
-	case $1 in
-	1) ln_test ""   "file"      "file_link";;
-	2) ln_test "-s" "file"      "file_link";;
-	3) ln_test "-s" "dir"       "dir_link";;
-	4) ln_test ""   "$PWD/file" "file_link";;
-	5) ln_test "-s" "$PWD/file" "file_link";;
-	6) ln_test "-s" "$PWD/dir"  "dir_link";;
-	esac
-}
-
-tst_run
diff --git a/testcases/commands/logrotate/00_Descriptions.txt b/testcases/commands/logrotate/00_Descriptions.txt
deleted file mode 100644
index 07ffcd3e6..000000000
--- a/testcases/commands/logrotate/00_Descriptions.txt
+++ /dev/null
@@ -1,2 +0,0 @@
-logrotate01
-	test basic functionality of logrotate. use logrotate -f <config> to force rotation. 1. rotate /var/log/tst_logfile file. 2. compresses it.
diff --git a/testcases/commands/logrotate/Makefile b/testcases/commands/logrotate/Makefile
deleted file mode 100644
index c3a701b87..000000000
--- a/testcases/commands/logrotate/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/logrotate testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= logrotate_tests.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
deleted file mode 100755
index f5a22ddde..000000000
--- a/testcases/commands/logrotate/logrotate_tests.sh
+++ /dev/null
@@ -1,375 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
-#
-# File :        logrotate_tests.sh
-#
-# Description:    Test Basic functionality of logrotate command.
-#                Test #1: Test that logrotate -f <file.conf> rotates the logfile
-#                as per the specifications in the conf file. Create a file
-#                tst_logfile in /var/log/. Create a conf file such that this
-#                logfile is set for rotation every week. Execute the command
-#                logrotate -f <file.conf>, check to see if it forced rotation.
-#                Test #2: Check if logrotate running as a cronjob will rotate a
-#                logfile when it exceeds a specific size. Create two cronjobs
-#                1. runs a command to log a string to a logfile. 2. runs
-#                logrotate <file.conf> every minute. The conf file specifies
-#                that the rotation happen only if the log file exceeds 2k file
-#                size.
-#
-# Author:        Manoj Iyer, manjo@mail.utexas.edu
-#
-# History:       Dec 23 2002 - Created - Manoj Iyer.
-#                Dec 24 2002 - Added   - Test #2 - Test to run logrotate as a
-#                                        cron job.
-#                Feb 28 2003 - Fixed   - Modified testcase to use functions.
-#
-# Function: 	chk_ifexists
-#
-# Description:  - Check if command required for this test exits.
-#
-# Input:        - $1 - calling test case.
-#               - $2 - command that needs to be checked.
-#
-# Return:		- zero on success.
-# 				- non-zero on failure.
-chk_ifexists()
-{
-	RC=0
-
-	which $2 > $LTPTMP/tst_logrotate.err 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brkm TBROK NULL "$1: command $2 not found."
-	fi
-	return $RC
-}
-
-
-# Function: init
-#
-# Description:  - Check if command required for this test exits.
-#               - Create temporary directories required for this test.
-#               - Initialize global variables.
-#
-# Return:		- zero on success.
-# 				- non-zero on failure.
-init()
-{
-	# Initialize global variables.
-	export RC=0
-	export TST_TOTAL=2
-	export TCID="logrotate"
-	export TST_COUNT=0
-
-	# Inititalize cleanup function.
-	trap "cleanup" 0
-
-	# create the temporary directory used by this testcase
-	if [ -z $TMP ]
-	then
-		LTPTMP=/tmp/tst_logrotate.$$
-	else
-		LTPTMP=$TMP/tst_logrotate.$$
-	fi
-
-	mkdir -p $LTPTMP > /dev/null 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		 tst_brkm TBROK "INIT: Unable to create temporary directory"
-		 return $RC
-	fi
-
-	# check if commands tst_*, logrotate, awk exists.
-	chk_ifexists INIT tst_resm  || return $RC
-	chk_ifexists INIT logrotate || return $RC
-	chk_ifexists INIT awk       || return $RC
-
-	return $RC
-}
-
-
-# Function: 	cleanup
-#
-# Description:  - remove temporaty files and directories. Stop all jobs stated
-#                 by this testcase.
-#
-# Return:		- zero on success.
-# 				- non-zero on failure.
-cleanup()
-{
-	#remove all cronjobs that were installed.
-	tst_resm TINFO "CLEAN: removing all cron jobs."
-	crontab -r > /dev/null 2>&1
-
-	# remove all the temporary files created by this test.
-	tst_resm TINFO "CLEAN: removing $LTPTMP"
-	rm -fr $LTPTMP
-}
-
-
-# Function: 	test01
-#
-# Description:  - Test that logrotate logrotate will rotate the logfile
-#                 according to the specifications in the config file.
-#               - create a config file that will rotate the /var/log/tst_logfile
-#                 file.
-#               - use force option to force logrotate to cause the log file to
-#                 be rotated.
-#               - compress the file after rotation.
-#
-# Return:		- zero on success.
-# 				- non-zero on failure.
-test01()
-{
-	count=0
-	files=" "
-	filesize=0
-
-	TCID=logrotate01
-	TST_COUNT=1
-
-	tst_resm TINFO "Test #1: create a configfile $LTPTMP/var_mesg.config"
-	tst_resm TINFO "Test #1: use logrotate -f <config> to force rotation"
-	tst_resm TINFO "Test #1: this will rotate the log file according to"
-	tst_resm TINFO "Test #1: the specification in the configfile."
-	tst_resm TINFO "Test #1: 1. rotate /var/log/tst_logfile file."
-	tst_resm TINFO "Test #1: 2. compresses it."
-
-	# create config file.
-	cat >$LTPTMP/tst_logrotate.conf <<-EOF
-	#****** Begin Config file *******
-	# create new (empty) log files after rotating old ones
-	create
-
-	# compress the log files
-	compress
-
-	/var/log/tst_logfile {
-		rotate 5
-		weekly
-	}
-	#****** End Config file *******
-	EOF
-
-	# create a log file in /var/log/
-	cat >/var/log/tst_logfile <<-EOF
-	#****** Begin Log File ********
-	# This is a dummy log file.
-	#****** End Log File ********
-	EOF
-
-	while [ $count -lt 10 ]
-	do
-		echo "This a dummy log file used to test logrotate command." >> \
-			/var/log/tst_logfile
-		 		 count=$(( $count+1 ))
-	done
-
-	# remove all old-n-stale logfiles.
-	for files in /var/log/tst_logfile.*
-	do
-		rm -f $files > /dev/null 2>&1
-	done
-
-	chmod 644 $LTPTMP/tst_logrotate.conf
-	logrotate -fv $LTPTMP/tst_logrotate.conf > $LTPTMP/tst_logrotate.out 2>&1 \
-		|| RC=$?
-	if [ $RC -eq 0 ]
-	then
-		# check if config file $LTPTMP/tst_logrotate.conf is read
-		# check if  /etc/logrotate.d is included/
-		# check if 5 rotations are forced.
-        # check if compression is done.
-		grep "reading config file $LTPTMP/tst_logrotate.conf" \
-			$LTPTMP/tst_logrotate.out   > $LTPTMP/tst_logrotate.err 2>&1 || RC=$?
-		grep "forced from command line (5 rotations)" \
-			$LTPTMP/tst_logrotate.out   > $LTPTMP/tst_logrotate.err 2>&1 || RC=$?
-		egrep "compressing new|log with" \
-			$LTPTMP/tst_logrotate.out   > $LTPTMP/tst_logrotate.err 2>&1 || RC=$?
-		if [ $RC -ne 0 ]
-		then
-			tst_res TFAIL > $LTPTMP/tst_logrotate.err 2>&1 \
-				"Test #1: logrotate command failed. Reason:"
-		else
-			# Check if compressed log file is created.
-			if [ -f /var/log/tst_logfile.1.gz ]
-			then
-				file /var/log/tst_logfile.1.gz | grep "gzip compressed data" \
-					> $LTPTMP/tst_logrotate.out 2>&1 || RC=$?
-				if [ $RC -eq 0 ]
-				then
-					tst_resm TPASS \
-						"Test #1: logrotate created a compressed file."
-				else
-					tst_res TFAIL $LTPTMP/tst_logrotate.out \
-						"Test #1: Failed to create a compressed file. Reason:"
-				fi
-				return $RC
-			else
-				 tst_res TFAIL  $LTPTMP/tst_logrotate.out \
-				  "Test #1: Failed create /var/log/tst_logfile.1.gz. Reason:"
-				return $RC
-			fi
-		fi
-	else
-		tst_res TFAIL $LTPTMP/tst_logrotate.out \
-		"Test #1: logrotate command exited with $RC return code. Output:"
-	fi
-	return $RC
-}
-
-
-test02()
-{
-# Test #2
-# Test that logrotate logrotate will rotate the logfile if the logfile
-# exceeds a certain size.
-#     - create a config file that will rotate the /var/log/tst_largelogfile.
-#     - run logrotate in a cron job that runs every minute.
-#     - add messages to the logfile until it gets rotated when a re-dittermined
-#        size is reached.
-
-export TCID=logrotate02
-export TST_COUNT=2
-RC=0
-
-tst_resm TINFO "Test #2: create a configfile $LTPTMP/tst_largelog.conf"
-tst_resm TINFO "Test #2: logrotate $LTPTMP/tst_largelog.conf - cronjob"
-tst_resm TINFO "Test #2: set to rotate tst_largelogfile when size > 2K"
-
-
-# create config file.
-cat >$LTPTMP/tst_largelog.conf <<EOF
-# create new (empty) log files after rotating old ones
-create
-
-# compress the log files
-compress
-
-# RPM packages drop log rotation information into this directory
-include /etc/logrotate.d
-
-/var/log/tst_largelogfile {
-    rotate 5
-    size=2k
-}
-EOF
-
-# create the pseudo-log file.
-cat >/var/log/tst_largelogfile <<EOF
-# This is a psuedo-log file. This file will grow to a 2k size before
-# getting rotated.
-EOF
-
-# create logrotate cron job.
-cat >$LTPTMP/tst_logrotate.cron <<EOF
-* * * * * logrotate $LTPTMP/tst_largelog.conf
-EOF
-
-chmod 777 $LTPTMP/tst_logrotate.cron > /dev/null 2>&1
-
-tst_resm TINFO "Test #2: Installing cron job to run logrotate"
-crontab $LTPTMP/tst_logrotate.cron > $LTPTMP/tst_logrotate.out 2>&1 || RC=$?
-if [ $RC -ne 0 ]
-then
-    echo "Exit status of crontab command: $RC" >> tst_logrotate.out 2>/dev/null
-    tst_brk TBROK $LTPTMP/tst_logrotate.out NULL \
-        "Test #2: crontab Broke while installing cronjob. Reason:"
-    TFAILCNT=$(( $TFAILCN+1 ))
-else
-    tst_resm TINFO "Test #2: Cronjob installed successfully"
-fi
-
-# cron job to increase the log file size.
-cat >$LTPTMP/tst_addtolog.cron <<EOF
-
-* * * * * echo "To Err Is Human, To Really Screw Up You Need A Computer."  >>/var/log/tst_largelogfile 2>/dev/null
-EOF
-
-tst_resm TINFO "Test #2: Installing cron job to increase logsize"
-crontab $LTPTMP/tst_addtolog.cron > $LTPTMP/tst_logrotate.out 2>&1 || RC=$?
-if [ $RC -ne 0 ]
-then
-    echo "Exit status of crontab command: $RC" >> tst_logrotate.out 2>/dev/null
-    tst_brk TBROK $LTPTMP/tst_logrotate.out NULL \
-        "Test #2: crontab Broke while installing cronjob. Reason:"
-    TFAILCNT=$(( $TFAILCN+1 ))
-else
-    tst_resm TINFO "Test #2: Cronjob installed successfully"
-fi
-
-# let cron jobs get started.
-sleep 10s
-
-# increase the log file size.
-
-# wait for the /var/log/tst_largelogfile to be filled to a size greater than 2k
-tst_resm TINFO "Test #2: Checking if file size is > 2k"
-tst_resm TINFO "Test #2: Pls be patient this will take some time."
-tst_resm TINFO "Test #2: or killall -9 logrotate02 to skip.."
-if [ -f `which awk` ]
-then
-    while [ $filesize -lt 2046 ]
-    do
-        filesize=`ls -l /var/log/tst_largelogfile | awk '{print $5}'`
-    done
-	# wait for 1m  and check if logrotate has rotated the logfile. The cron job
-	# that does a logrotate runs every 1 minute so give the cron a minute...
-	sleep 1m
-else
-	tst_resm TINFO "Test #2: No AWK installed ... sleeping for 10mts"
-	sleep 10m
-fi
-
-
-if [ -f /var/log/tst_largelogfile.1.gz ]
-then
-    file /var/log/tst_largelogfile.1.gz | grep "gzip compressed data" \
-        > $LTPTMP/tst_logrotate.out 2>&1 || RC=$?
-    if [ $RC -eq 0 ]
-    then
-        tst_resm TPASS \
-            "Test #1: logrotate worked as cron, created a compressed file."
-    else
-        tst_res TFAIL $LTPTMP/tst_logrotate.out \
-            "Test #1: Failed to create a compressed file. Reason:"
-    fi
-else
-    tst_res TFAIL  $LTPTMP/tst_logrotate.out \
-        "Test #1: Failed to create /var/log/tst_largelogfile.1.gz. Reason:"
-    TFAILCNT=$(( $TFAILCNT+1 ))
-fi
-
-}
-
-# Function:	main
-#
-# Description:	- Execute all tests and report results.
-#
-# Exit:			- zero on success
-#               - non-zero on failure.
-
-RC=0
-init || exit $?
-
-test01 || RC=$?
-
-exit $RC
diff --git a/testcases/commands/lsmod/Makefile b/testcases/commands/lsmod/Makefile
deleted file mode 100644
index 2af91b3de..000000000
--- a/testcases/commands/lsmod/Makefile
+++ /dev/null
@@ -1,22 +0,0 @@
-#
-#    Copyright (c) 2015 Fujitsu Ltd.
-#    Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= lsmod01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
deleted file mode 100755
index 132a446c9..000000000
--- a/testcases/commands/lsmod/lsmod01.sh
+++ /dev/null
@@ -1,50 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2015 Fujitsu Ltd.
-# Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
-# Test the basic functionality of lsmod command.
-#
-TST_TESTFUNC=lsmod_test
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="lsmod"
-. tst_test.sh
-
-lsmod_test()
-{
-	lsmod_output=$(lsmod | awk '!/Module/{print $1, $2, $3}' | sort)
-	if [ -z "$lsmod_output" ]; then
-		tst_res TFAIL "Failed to parse the output from lsmod"
-		return
-	fi
-
-	modules_output=$(awk '{print $1, $2, $3}' /proc/modules | sort)
-	if [ -z "$modules_output" ]; then
-		tst_res TFAIL "Failed to parse /proc/modules"
-		return
-	fi
-
-	if [ "$lsmod_output" != "$modules_output" ]; then
-		tst_res TFAIL "lsmod output different from /proc/modules."
-
-		echo "$lsmod_output" > temp1
-		echo "$modules_output" > temp2
-		diff temp1 temp2
-
-		return
-	fi
-
-	tst_res TPASS "'lsmod' passed."
-}
-
-tst_run
diff --git a/testcases/commands/mkdir/Makefile b/testcases/commands/mkdir/Makefile
deleted file mode 100644
index 285a3a288..000000000
--- a/testcases/commands/mkdir/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/fileutils/mkdir testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= mkdir_tests.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/mkdir/mkdir_tests.sh b/testcases/commands/mkdir/mkdir_tests.sh
deleted file mode 100755
index 990162bdb..000000000
--- a/testcases/commands/mkdir/mkdir_tests.sh
+++ /dev/null
@@ -1,70 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author:       Manoj Iyer, manjo@mail.utexas.edu                           ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
-#
-# Basic mkdir tests
-#
-TST_CNT=3
-TST_SETUP=setup
-TST_TESTFUNC=test
-TST_NEEDS_TMPDIR=1
-. tst_test.sh
-
-setup()
-{
-	ROD mkdir "dir"
-	LONG_PATH="some/long/path/of/several/directories"
-}
-
-test1()
-{
-	EXPECT_FAIL mkdir "dir" 2\> mkdir.out
-
-	if grep -q "dir.*File exists" mkdir.out; then
-		tst_res TPASS "Got correct error message"
-	else
-		tst_res TFAIL "Got wrong error message"
-		cat mkdir.out
-	fi
-}
-
-test2()
-{
-	EXPECT_FAIL mkdir "$LONG_PATH" 2\> mkdir.out
-
-	if grep -q "$LONG_PATH.*No such file or directory" mkdir.out; then
-		tst_res TPASS "Got correct error message"
-	else
-		tst_res TFAIL "Got wrong error message"
-		cat mkdir.out
-	fi
-
-	ROD rm -rf "$LONG_PATH"
-}
-
-test3()
-{
-	EXPECT_PASS mkdir -p "$LONG_PATH"
-
-	ROD rm -rf "$LONG_PATH"
-}
-
-tst_run
diff --git a/testcases/commands/mkfs/Makefile b/testcases/commands/mkfs/Makefile
deleted file mode 100644
index 609901770..000000000
--- a/testcases/commands/mkfs/Makefile
+++ /dev/null
@@ -1,24 +0,0 @@
-#
-#    commands/mkfs testcases Makefile.
-#
-#    Copyright (c) 2015 Fujitsu Ltd.
-#    Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= mkfs01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
deleted file mode 100755
index cf7ccb6cb..000000000
--- a/testcases/commands/mkfs/mkfs01.sh
+++ /dev/null
@@ -1,197 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2015 Fujitsu Ltd.
-# Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
-# Test mkfs command with some basic options.
-#
-
-TST_CNT=5
-TST_SETUP=setup
-TST_TESTFUNC=test
-TST_OPTS="f:"
-TST_USAGE=usage
-TST_PARSE_ARGS=parse_args
-TST_NEEDS_ROOT=1
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_DEVICE=1
-TST_NEEDS_CMDS="blkid df"
-. tst_test.sh
-
-usage()
-{
-	cat << EOF
-usage: $0 [-f <ext2|ext3|ext4|vfat|...>]
-
-OPTIONS
--f	Specify the type of filesystem to be built.  If not
-	specified, the default filesystem type (currently ext2)
-	is used.
-EOF
-}
-
-parse_args()
-{
-	FS_TYPE="$2"
-}
-
-setup()
-{
-	if [ -n "$FS_TYPE" ]; then
-		tst_check_cmds mkfs.${FS_TYPE}
-	fi
-
-	ROD_SILENT mkdir -p mntpoint
-}
-
-mkfs_mount()
-{
-	mount ${TST_DEVICE} mntpoint
-	local ret=$?
-	if [ $ret -eq 32 ]; then
-		tst_brk TCONF "Cannot mount ${FS_TYPE}, missing driver?"
-	fi
-
-	if [ $ret -ne 0 ]; then
-		tst_brk TBROK "Failed to mount device: mount exit = $ret"
-	fi
-}
-
-mkfs_verify_type()
-{
-	if [ -z "$1" ]; then
-		blkid $2 -t TYPE="ext2" >/dev/null
-	else
-		if [ "$1" = "msdos" ]; then
-			blkid $2 -t TYPE="vfat" >/dev/null
-		else
-			blkid $2 -t TYPE="$1" >/dev/null
-		fi
-	fi
-}
-
-mkfs_verify_size()
-{
-	mkfs_mount
-	local blocknum=`df -P -B 1k mntpoint | tail -n1 | awk '{print $2}'`
-	tst_umount "$TST_DEVICE"
-
-	if [ $blocknum -gt "$2" ]; then
-		return 1
-	fi
-
-	# Size argument in mkfs.ntfs denotes number-of-sectors which is 512bytes,
-	# 1k-block size should be devided by this argument for ntfs verification.
-	if [ "$1" = "ntfs" ]; then
-		local rate=1024/512
-		if [ $blocknum -lt "$(($2/$rate*9/10))" ]; then
-			return 1
-		fi
-	else
-		if [ $blocknum -lt "$(($2*9/10))" ]; then
-			return 1
-		fi
-	fi
-
-	return 0
-}
-
-mkfs_test()
-{
-	local mkfs_op=$1
-	local fs_type=$2
-	local fs_op=$3
-	local device=$4
-	local size=$5
-
-	if [ -n "$fs_type" ]; then
-		mkfs_op="-t $fs_type"
-	fi
-
-	if [ "$fs_type" = "xfs" ] || [ "$fs_type" = "btrfs" ]; then
-		fs_op="$fs_op -f"
-	fi
-
-	local mkfs_cmd="mkfs $mkfs_op $fs_op $device $size"
-
-	echo ${fs_op} | grep -q "\-c"
-	if [ $? -eq 0 ] && [ "$fs_type" = "ntfs" ]; then
-		tst_res TCONF "'${mkfs_cmd}' not supported."
-		return
-	fi
-
-	if [ -n "$size" ]; then
-		if [ "$fs_type" = "xfs" ] || [ "$fs_type" = "btrfs" ]; then
-			tst_res TCONF "'${mkfs_cmd}' not supported."
-			return
-		fi
-	fi
-
-	${mkfs_cmd} >temp 2>&1
-	if [ $? -ne 0 ]; then
-		grep -q -E "unknown option | invalid option" temp
-		if [ $? -eq 0 ]; then
-			tst_res TCONF "'${mkfs_cmd}' not supported."
-			return
-		else
-			tst_res TFAIL "'${mkfs_cmd}' failed."
-			cat temp
-			return
-		fi
-	fi
-
-	if [ -n "$device" ]; then
-		mkfs_verify_type "$fs_type" "$device"
-		if [ $? -ne 0 ]; then
-			tst_res TFAIL "'${mkfs_cmd}' failed, not expected."
-			return
-		fi
-	fi
-
-	if [ -n "$size" ]; then
-		mkfs_verify_size "$fs_type" "$size"
-		if [ $? -ne 0 ]; then
-			tst_res TFAIL "'${mkfs_cmd}' failed, not expected."
-			return
-		fi
-	fi
-
-	tst_res TPASS "'${mkfs_cmd}' passed."
-}
-
-test1()
-{
-	mkfs_test "" "$FS_TYPE" "" "$TST_DEVICE"
-}
-
-test2()
-{
-	mkfs_test "" "$FS_TYPE" "" "$TST_DEVICE" "16000"
-}
-
-test3()
-{
-	mkfs_test "" "$FS_TYPE" "-c" "$TST_DEVICE"
-}
-
-test4()
-{
-	mkfs_test "-V"
-}
-
-test5()
-{
-	mkfs_test "-h"
-}
-
-tst_run
diff --git a/testcases/commands/mkswap/Makefile b/testcases/commands/mkswap/Makefile
deleted file mode 100644
index 5c8bd9bba..000000000
--- a/testcases/commands/mkswap/Makefile
+++ /dev/null
@@ -1,22 +0,0 @@
-#
-#    Copyright (c) 2015 Fujitsu Ltd.
-#    Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= mkswap01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
deleted file mode 100755
index 1c01c86b2..000000000
--- a/testcases/commands/mkswap/mkswap01.sh
+++ /dev/null
@@ -1,176 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2015 Fujitsu Ltd.
-# Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-# GNU General Public License for more details.
-#
-# Test mkswap command with some basic options.
-#
-
-TST_CNT=10
-TST_SETUP=setup
-TST_TESTFUNC=do_test
-TST_NEEDS_ROOT=1
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_DEVICE=1
-TST_NEEDS_CMDS="uuidgen blkid blockdev mkswap"
-. tst_test.sh
-
-setup()
-{
-	UUID=`uuidgen`
-
-	PAGE_SIZE=`getconf PAGE_SIZE`
-
-	# Here get the size of the device and align it down to be the
-	# multiple of $PAGE_SIZE and use that as the size for testing.
-	real_size=`blockdev --getsize64 $TST_DEVICE`
-	DEVICE_SIZE=$((($real_size/$PAGE_SIZE * $PAGE_SIZE)/1024))
-}
-
-wait_for_file()
-{
-	local path="$1"
-	local retries=10
-
-	if [ -z "$path" ]; then
-		return
-	fi
-
-	while [ $retries -gt 0 ]; do
-		if [ -e "$path" ]; then
-			return
-		fi
-		tst_res TINFO "Waiting for $path to appear"
-		retries=$((retries - 1))
-		tst_sleep 10ms
-	done
-
-	tst_res TINFO "The file $path haven't appeared"
-}
-
-mkswap_verify()
-{
-	local mkswap_op="$1"
-	local op_arg="$2"
-	local swapfile="$3"
-	local dev_file="$5"
-
-	local before=`awk '/SwapTotal/ {print $2}' /proc/meminfo`
-
-	local swapsize=${4:-$DEVICE_SIZE}
-
-	if [ "$mkswap_op" = "-p" ]; then
-		local pagesize=$op_arg
-	else
-		local pagesize=$PAGE_SIZE
-	fi
-
-	wait_for_file "$dev_file"
-
-	swapon $swapfile 2>/dev/null
-
-	if [ $? -ne 0 ]; then
-		tst_res TINFO "Can not do swapon on $swapfile."
-		if [ $pagesize -ne $PAGE_SIZE ]; then
-			tst_res TINFO "Page size specified by 'mkswap -p' \
-is not equal to system's page size."
-			tst_res TINFO "Swapon failed expectedly."
-			return 0
-		fi
-
-		if [ $swapsize -gt $DEVICE_SIZE ]; then
-			tst_res TINFO "Device size specified by 'mkswap' \
-greater than real size."
-			tst_res TINFO "Swapon failed expectedly."
-			return 0
-		fi
-
-		tst_res TINFO "Swapon failed unexpectedly."
-		return 1
-	fi
-
-	local after=`awk '/SwapTotal/ {print $2}' /proc/meminfo`
-
-	local diff=$((after-before))
-	local filesize=$((swapsize-pagesize/1024))
-
-	local ret=0
-
-	# In general, the swap increment by doing swapon should be equal to
-	# the device size minus a page size, however for some kernels, the
-	# increment we get is not exactly equal to that value, but is equal
-	# to the value minus an extra page size, e.g. on RHEL5.11GA.
-	if [ $diff -ne $filesize ] && \
-		[ $diff -ne $((filesize-pagesize/1024)) ]; then
-		ret=1
-	fi
-
-	swapoff $swapfile 2>/dev/null
-	if [ $? -ne 0 ]; then
-		tst_res TWARN "Can not do swapoff on $swapfile."
-	fi
-
-	return $ret
-}
-
-mkswap_test()
-{
-	local mkswap_op="$1"
-	local op_arg="$2"
-	local device="$3"
-	local size="$4"
-	local dev_file="$5"
-
-	local mkswap_cmd="mkswap $mkswap_op $op_arg $TST_DEVICE $size"
-
-	${mkswap_cmd} >temp 2>&1
-	if [ $? -ne 0 ]; then
-		grep -q -E "unknown option|invalid option|Usage" temp
-		if [ $? -eq 0 ]; then
-			tst_res TCONF "'${mkswap_cmd}' not supported."
-			return
-		fi
-
-		tst_res TFAIL "'${mkswap_cmd}' failed."
-		cat temp
-		return
-	fi
-
-	if [ -n "$device" ]; then
-		mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size" "$dev_file"
-		if [ $? -ne 0 ]; then
-			tst_res TFAIL "'${mkswap_cmd}' failed, not expected."
-			return
-		fi
-	fi
-
-	tst_res TPASS "'${mkswap_cmd}' passed."
-}
-
-do_test()
-{
-	case $1 in
-	1) mkswap_test "" "" "$TST_DEVICE";;
-	2) mkswap_test "" "" "$TST_DEVICE" "$((DEVICE_SIZE-PAGE_SIZE/1024))";;
-	3) mkswap_test "-f" "" "$TST_DEVICE" "$((DEVICE_SIZE+PAGE_SIZE/1024))";;
-	4) mkswap_test "-c" "" "$TST_DEVICE";;
-	5) mkswap_test "-p" "2048" "$TST_DEVICE";;
-	6) mkswap_test "-L" "ltp_testswap" "-L ltp_testswap" "" "/dev/disk/by-label/ltp_testswap";;
-	7) mkswap_test "-v1" "" "$TST_DEVICE";;
-	8) mkswap_test "-U" "$UUID" "-U $UUID" "" "/dev/disk/by-uuid/$UUID";;
-	9) mkswap_test "-V";;
-	10) mkswap_test "-h";;
-	esac
-}
-
-tst_run
diff --git a/testcases/commands/mv/Makefile b/testcases/commands/mv/Makefile
deleted file mode 100644
index ca594a50a..000000000
--- a/testcases/commands/mv/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/fileutils/mv testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= mv_tests.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/mv/mv_tests.sh b/testcases/commands/mv/mv_tests.sh
deleted file mode 100755
index ed5506616..000000000
--- a/testcases/commands/mv/mv_tests.sh
+++ /dev/null
@@ -1,170 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-## Author:       Manoj Iyer, manjo@mail.utexas.edu                            ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
-#
-# Description:  Test basic functionality of mv command
-#		- Test #1:  mv <dir1> <dir2>
-#		  move dir1 to dir2 and all its contents.
-#		- Test #2:  mv -b <file1> <file2>
-#		  move file1 to file2 and backup the file2.
-#
-
-TST_CNT=2
-TST_SETUP=setup
-TST_TESTFUNC=test
-TST_NEEDS_TMPDIR=1
-. tst_test.sh
-
-setup()
-{
-	ROD_SILENT mkdir -p tst_mv.old
-}
-
-creat_dirnfiles()
-{
-	local numdirs=$2
-	local numfiles=$3
-	local dirname=$4
-	local dircnt=0
-	local fcnt=0
-
-	tst_res TINFO "Test #$1: Creating $numdirs directories."
-	tst_res TINFO "Test #$1: filling each dir with $numfiles files."
-	while [ $dircnt -lt $numdirs ]
-	do
-		dirname=$dirname/d.$dircnt
-		ROD_SILENT mkdir -p $dirname
-
-		fcnt=0
-		while [ $fcnt -lt $numfiles ]
-		do
-			ROD_SILENT touch $dirname/f.$fcnt
-			fcnt=$(($fcnt+1))
-		done
-		dircnt=$(($dircnt+1))
-	done
-}
-
-creat_expout()
-{
-	local numdir=$1
-	local numfile=$2
-	local dirname=$3
-	local dircnt=0
-	local fcnt=0
-
-	echo "$dirname:"  1>>tst_mv.exp
-	echo "d.$dircnt"  1>>tst_mv.exp
-	while [ $dircnt -lt $numdirs ]
-	do
-		dirname=$dirname/d.$dircnt
-		dircnt=$(($dircnt+1))
-		echo "$dirname:"  1>>tst_mv.exp
-		if [ $dircnt -lt $numdirs ]; then
-			echo "d.$dircnt" 1>>tst_mv.exp
-		fi
-
-		fcnt=0
-		while [ $fcnt -lt $numfiles ]
-		do
-			echo "f.$fcnt " 1>>tst_mv.exp
-			fcnt=$(($fcnt+1))
-		done
-		printf "\n\n" 1>>tst_mv.exp
-	done
-}
-
-test1()
-{
-	numdirs=10
-	numfiles=10
-	dircnt=0
-	fcnt=0
-
-	tst_res TINFO "Test #1: mv <dir1> <dir2> will move dir1 to dir2 and" \
-		       "all its contents"
-
-	creat_dirnfiles 1 $numdirs $numfiles tst_mv.old
-
-	mv tst_mv.old tst_mv.new > tst_mv.err 2>&1
-	if [ $? -ne 0 ]; then
-		cat tst_mv.err
-		tst_brk TFAIL "Test #1: 'mv tst_mv.old tst_mv.new' failed"
-	fi
-
-	tst_res TINFO "Test #1: creating output file"
-	ls -R tst_mv.new > tst_mv.out 2>&1
-
-	tst_res TINFO "Test #1: creating expected output file"
-	creat_expout $numdirs $numfiles tst_mv.new
-
-	tst_res TINFO "Test #1: comparing expected out and actual output file"
-	diff -w -B -q tst_mv.out tst_mv.exp > tst_mv.err 2>&1
-	if [ $? -ne 0 ]; then
-		cat tst_mv.err
-		tst_res TFAIL "Test #1: mv failed."
-	else
-		tst_res TINFO "Test #1: expected same as actual"
-		if [ -f tst_mv.old ]; then
-			tst_res TFAIL "Test #1: mv did not delete old" \
-				       "directory"
-		else
-			tst_res TPASS "Test #1: mv success"
-		fi
-	fi
-}
-
-test2()
-{
-	tst_res TINFO "Test #2: mv -b <file1> <file2> will move dir1 to dir2"
-
-	ROD_SILENT touch tmpfile1 tmpfile2
-
-	MD5_old=$(md5sum tmpfile2 | awk '{print $1}')
-	if [ $? -ne 0 ]; then
-		tst_brk TBROK "Test #2: can't get the MD5 message of file2."
-	fi
-
-	if [ -f "tmpfile2~" ]; then
-		tst_brk TBROK "Test #2: file tmpfile2~ should not exists."
-	fi
-
-	mv -b tmpfile1 tmpfile2
-	if [ $? -ne 0 ]; then
-		tst_brk TBROK "Test #2: 'mv -b tmpfile1 tmpfile2' failed."
-	fi
-
-	# if 'mv -b file1 file2' succeed, there will be "tmpfile2~" file.
-
-	MD5_backup=$(md5sum tmpfile2 | awk '{print $1}')
-	if [ $? -ne 0 ]; then
-		tst_brk TBROK "Test #2: can not get the MD5 message of" \
-			       "backup file2."
-	fi
-
-	if [ "$MD5_old" = "$MD5_backup" -a -f "tmpfile2~" ]; then
-		tst_res TPASS "Test #2: mv -b success"
-	else
-		tst_res TFAIL "Test #2: mv -b failed"
-	fi
-}
-
-tst_run
diff --git a/testcases/commands/nm/Makefile b/testcases/commands/nm/Makefile
deleted file mode 100644
index 37a9d7872..000000000
--- a/testcases/commands/nm/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    commands/ade/nm testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= nm01
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/nm/datafiles/.gitignore b/testcases/commands/nm/datafiles/.gitignore
deleted file mode 100644
index efff51ae0..000000000
--- a/testcases/commands/nm/datafiles/.gitignore
+++ /dev/null
@@ -1,3 +0,0 @@
-/f1
-/f2
-/f3
diff --git a/testcases/commands/nm/datafiles/Makefile b/testcases/commands/nm/datafiles/Makefile
deleted file mode 100644
index 371490e1c..000000000
--- a/testcases/commands/nm/datafiles/Makefile
+++ /dev/null
@@ -1,24 +0,0 @@
-#
-#    Copyright (C) 2016, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-INSTALL_DIR		:= testcases/data/nm01
-INSTALL_TARGETS		:= f1 f2 f3 lib.a
-MAKE_TARGETS		+= f1 f2 f3 lib.a
-
-lib.a: f1.o f2.o f3.o
-	$(AR) rcs $@ $?
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/nm/datafiles/f1.c b/testcases/commands/nm/datafiles/f1.c
deleted file mode 100644
index 46fafb7c1..000000000
--- a/testcases/commands/nm/datafiles/f1.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include <stdio.h>
-
-int main(void)
-{
-	printf("Hello World\n");
-	return (0);
-}
diff --git a/testcases/commands/nm/datafiles/f2.c b/testcases/commands/nm/datafiles/f2.c
deleted file mode 100644
index 46fafb7c1..000000000
--- a/testcases/commands/nm/datafiles/f2.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include <stdio.h>
-
-int main(void)
-{
-	printf("Hello World\n");
-	return (0);
-}
diff --git a/testcases/commands/nm/datafiles/f3.c b/testcases/commands/nm/datafiles/f3.c
deleted file mode 100644
index 46fafb7c1..000000000
--- a/testcases/commands/nm/datafiles/f3.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include <stdio.h>
-
-int main(void)
-{
-	printf("Hello World\n");
-	return (0);
-}
diff --git a/testcases/commands/nm/nm01 b/testcases/commands/nm/nm01
deleted file mode 100755
index 39d5c9a21..000000000
--- a/testcases/commands/nm/nm01
+++ /dev/null
@@ -1,137 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2000
-#  06/01 Robbie Williamson (robbiew@us.ibm.com)
-# Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
-#
-# This program is free software;  you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY;  without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-# the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#---------------------------------------------------------------------------
-#
-# Tests the basic functionality of the `nm` command.
-#
-NM=${NM:=nm}
-
-TST_CNT=7
-TST_TESTFUNC=test
-TST_SETUP=setup
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="$NM"
-. tst_test.sh
-
-setup()
-{
-	ROD cp "$TST_DATAROOT/lib.a" "."
-	ROD mkdir "dir"
-	ROD cp "$TST_DATAROOT/lib.a" "dir/"
-}
-
-test1()
-{
-	EXPECT_PASS $NM -f posix -A "lib.a" \> nm.out
-
-	if grep -q "lib.a\[f2.o\]\:" nm.out; then
-		tst_res TPASS "Got correct listing"
-	else
-		tst_res TFAIL "Got incorrect listing"
-		cat nm.out
-	fi
-
-	EXPECT_PASS $NM -f posix -A "dir/lib.a" \> nm.out
-
-	if grep -q "dir/lib.a\[f2.o\]\:" nm.out; then
-		tst_res TPASS "Got correct listing"
-	else
-		tst_res TFAIL "Got incorrect listing"
-		cat nm.out
-	fi
-}
-
-test2()
-{
-	EXPECT_PASS $NM -f posix -g $TST_DATAROOT/f1 \> nm.out
-
-	if grep -q "\w [a,b,d,f,t]" nm.out; then
-		tst_res TFAIL "Got internal symbols with -g"
-		cat nm.out
-	else
-		tst_res TPASS "Got only external symbols with -g"
-	fi
-}
-
-test3()
-{
-	EXPECT_PASS $NM -f posix -t o $TST_DATAROOT/f1 \> nm.out
-
-	if awk '{print $3}' nm.out | grep -q "[8-9a-f]"; then
-		tst_res TFAIL "Got non-octal symbol values with -f"
-		cat nm.out
-	else
-		tst_res TPASS "Got an octal symbol values with -f"
-	fi
-}
-
-test4()
-{
-	EXPECT_PASS $NM -f sysv $TST_DATAROOT/f1 \> nm.out
-
-	if grep -q "Name" nm.out; then
-		tst_res TPASS "Got SysV format with -f sysv"
-	else
-		tst_res TFAIL "Got wrong format with -f sysv"
-		cat nm.out
-	fi
-}
-
-test5()
-{
-	EXPECT_PASS $NM -f bsd $TST_DATAROOT/f1 \> nm_bsd.out
-	EXPECT_PASS $NM -f posix $TST_DATAROOT/f1 \> nm_posix.out
-
-	ROD awk '{print $3 $2 $1}' nm_bsd.out \> nm1.out
-	ROD awk '{print $1 $2 $3}' nm_posix.out \> nm2.out
-
-	if diff nm1.out nm2.out > /dev/null; then
-		tst_res TPASS "Got BSD format with -f bsd"
-	else
-		tst_res TFAIL "Got wrong format with -f bsd"
-		cat nm_bsd.out
-	fi
-}
-
-test6()
-{
-	EXPECT_PASS $NM -f sysv -u $TST_DATAROOT/f1 \> nm.out
-
-	if grep -q "Undefined symbols from" nm.out; then
-		tst_res TPASS "Got undefined symbols with -u"
-	else
-		tst_res TFAIL "Haven't got undefined symbols with -u"
-		cat nm.out
-	fi
-}
-
-test7()
-{
-	EXPECT_PASS $NM -s $TST_DATAROOT/lib.a \> nm.out
-
-	if grep -q "index" nm.out; then
-		tst_res TPASS "Got index with -s"
-	else
-		tst_res TFAIL "Haven't got index with -s"
-	fi
-}
-
-tst_run
diff --git a/testcases/commands/su/Makefile b/testcases/commands/su/Makefile
deleted file mode 100644
index da2ff036f..000000000
--- a/testcases/commands/su/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/su testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= su01 su01_s1 su_set_passwd
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/su/su01 b/testcases/commands/su/su01
deleted file mode 100755
index 34386d937..000000000
--- a/testcases/commands/su/su01
+++ /dev/null
@@ -1,181 +0,0 @@
-#!/bin/bash
-#*********************************************************************
-#   Copyright (c) International Business Machines  Corp., 2003, 2004
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#  FILE   : su
-#
-#  PURPOSE: Tests the basic functionality of `su`.
-#
-#  SETUP: The program `/usr/bin/expect' MUST be installed.
-#
-#  HISTORY:
-#    03/03    Dustin Kirkland (dkirklan@us.ibm.com)
-#    03/03    Jerone Young    (jeroney@us.ibm.com)
-#    10/01/04 Kris Wilson     Port to Red Hat
-#
-#*********************************************************************
-
-echo "This script contains bashism that needs to be fixed!"
-
-if [ -z ${TCbin} ]
-then
-   export TCbin=$PWD
-fi
-
-export TEST_USER1="su_usr1"
-
-tvar=${MACHTYPE%-*}
-tvar=${tvar#*-}
-
-# need to export tvar for su01_s1
-export tvar
-printf "Machine type is: $tvar\n\n"
-
-if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ]
-# Need to also set group for TEST_USER2
-then
-export TEST_USER1_GROUP="wheel"
-export TEST_USER2_GROUP="wheel"
-else
-export TEST_USER1_GROUP="trusted"
-export TEST_USER2_GROUP="trusted"
-fi
-export TEST_USER1_PASSWD="eal"
-export TEST_USER1_ENCRYPTED_PASSWD="42VmxaOByKwlA"
-export TEST_USER1_NEW_PASSWD="a_very_good_and_long_password"
-export TEST_USER1_HOMEDIR="/home/$TEST_USER1"
-
-export TEST_USER2="su_usr2"
-# Group needs to be trusted for Red Hat.
-#export TEST_USER2_GROUP="trusted"
-export TEST_USER2_PASSWD="eal"
-export TEST_USER2_ENCRYPTED_PASSWD="42VmxaOByKwlA"
-export TEST_USER2_HOMEDIR="/home/$TEST_USER2"
-
-#This is for enviroment test
-export TEST_LINE="YOU_HAVE_THE_VARIABLE"
-export TEST_ENV_FILE="/tmp/TEST_ENV_FILE_ROOT"
-export TEST_ENV_FILE_USER="/tmp/TEST_ENV_FILE_USER"
-export TEST_ENV_FILE2="/tmp/TEST_ENV_FILE_ROOT2"
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup(){
-
-#REMOVE ANY TEMPOARY FILES THAT MAY STILL BE AROUND
-rm -f $TEST_ENV_FILE_USER > /dev/null 2>&1
-rm -f $TEST_ENV_FILE2 > /dev/null 2>&1
-rm -f $TEST_ENV_FILE > /dev/null 2>&1
-
-
-#Create 1st test user
-    #erase user if he may exist , so we can have a clean en
-        rm -rf /home/$TEST_USER1
-        getent passwd $TEST_USER1 > /dev/null 2>&1 && userdel $TEST_USER1
-	sleep 1
-
-        useradd -m -g users $TEST_USER1
-        if [ $? != 0 ]
-        then {
-                echo "Could not add test user $TEST_USER1."
-                exit 1
-        }
-        fi
-
-		usermod -G users,$TEST_USER1_GROUP $TEST_USER1
-
-	#create users home directory (SLES 8 does not do this, even when specified in adduser)
-# Only do this if not RH; RH creates the directory.
-	if [ "$tvar" != "redhat" -a "$tvar" != "redhat-linux" ]
-	then {
-          USER_UID=`id -u $TEST_USER1`
-          USER_GID=`id -g $TEST_USER1`
-          mkdir -p $TEST_USER1_HOMEDIR
-          chown -R $USER_UID.$USER_GID $TEST_USER1_HOMEDIR
-	}
-	fi
-
-        usermod -p $TEST_USER1_ENCRYPTED_PASSWD $TEST_USER1 > /dev/null 2>&1
-        if [ $? != 0 ]
-        then {
-                echo "Could not set password for test user $TEST_USER1"
-                exit 1
-        }
-        fi
-
-#Create 2nd test user
-	#erase user if he may exist , so we can have a clean en
-        rm -rf /home/$TEST_USER2
-        getent passwd $TEST_USER2 > /dev/null 2>&1 && userdel $TEST_USER2
-	sleep 1
-
-        useradd -m -g users $TEST_USER2
-
-        if [ $? != 0 ]
-        then {
-                echo "Could not add test user $TEST_USER2."
-                exit 1
-        }
-        fi
-
-		usermod -G users,$TEST_USER2_GROUP $TEST_USER2
-
-	#create users home diretory (SLES 8 does not do this, even when specified in adduser)
-# Only do this if not RH; RH creates the directory.
-        if [ "$tvar" != "redhat" -a "$tvar" != "redhat-linux" ]
-        then {
-          USER_UID=`id -u $TEST_USER2`
-          USER_GID=`id -g $TEST_USER2`
-          mkdir -p $TEST_USER2_HOMEDIR
-          chown -R $USER_UID.$USER_GID $TEST_USER2_HOMEDIR
-	}
-	fi
-
-        usermod -p $TEST_USER2_ENCRYPTED_PASSWD $TEST_USER2 > /dev/null 2>&1
-        if [ $? != 0 ]
-        then {
-                echo "Could not set password for test user $TEST_USER2"
-                exit 1
-        }
-        fi
-}
-
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
-
-do_cleanup() {
-        rm -rf /home/$TEST_USER1
-        rm -rf /home/$TEST_USER2
-	userdel $TEST_USER1
-	userdel $TEST_USER2
-	#REMOVE ANY TEMPOARY FILES THAT MAY STILL BE AROUND
-	rm -f $TEST_ENV_FILE_USER > /dev/null 2>&1
-	rm -f $TEST_ENV_FILE2 > /dev/null 2>&1
-	rm -f $TEST_ENV_FILE > /dev/null 2>&1
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  MAIN
-#-----------------------------------------------------------------------
-do_setup
-/bin/su $TEST_USER1 -c ${TCbin}/su01_s1
-EXIT_CODE=$?
-do_cleanup
-exit $EXIT_CODE
diff --git a/testcases/commands/su/su01_s1 b/testcases/commands/su/su01_s1
deleted file mode 100755
index 313207b64..000000000
--- a/testcases/commands/su/su01_s1
+++ /dev/null
@@ -1,486 +0,0 @@
-#! /usr/bin/expect -f
-#*********************************************************************
-#   Copyright (c) International Business Machines  Corp., 2003, 2004, 2007
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#  FILE   : su
-#
-#  PURPOSE: Tests the basic functionality of `su`.
-#
-#  SETUP: The program `/usr/bin/expect' MUST be installed.
-#         The user invoking this test script must NOT be "root".
-#     	  The PASSWD variable should be set prior to execution
-#
-#  HISTORY:
-#     03/03     Dustin Kirkland (dkirklan@us.ibm.com)
-#     03/03     Jerone Young    (jeroney@us.ibm.com)
-#     10/01/04  Kris Wilson     Skip test 7 if RedHat; no -e option.
-#     05/23/07  Kris Wilson     Make test 7 work for SLES.
-########################################################################
-
-# The root user cannot succesfully execute su test because the root user
-# is able to become anyone without entering passwords
-set whoami [ exec whoami ]
-if { $whoami=="root" } {
-  send_user "ERROR: You must execute the 'su' tests as a non-root user\n"
-  exit 1
-}
-
-#Grab input from enviroment
-if [info exists env(PASSWD)] {
-  	set PASSWD $env(PASSWD)
-} else {
-	send_user "YOU NEED TO SET ENVIROMENT VARIABLE PASSWD. \n"
-	exit 1
-}
-
-if [info exists env(TEST_USER2)] {
-  set USER1 $env(TEST_USER2)
-} else {
-  	send_user "YOU MUST SET ENVIRONMENT VARIABLE TEST_USER2"
-  	exit 1
-}
-
-# Need the release type from su01
-if [info exists env(tvar)] {
-  set distro $env(tvar)
-} else {
-        send_user "YOU MUST SET ENVIORMENT VARIABLE tvar"
-        exit 1
-}
-
-if [info exists env(TEST_USER2_PASSWD)] {
-  set USER1_PASSWORD $env(TEST_USER2_PASSWD)
-} else {
-  send_user "YOU MUST SET ENVIROMENT VARIABLE TEST_USER2_PASSWD"
-  exit 1
-}
-
-if [info exists env(TEST_LINE)] {
-  set TEST_LINE_ENV $env(TEST_LINE)
-} else {
-  send_user "YOU MUST SET ENVIROMENT VARIABLE TEST_LINE"
-  exit 1
-}
-
-
-if [info exists env(TEST_ENV_FILE)] {
-  set TEST_ENV_FILE $env(TEST_ENV_FILE)
-} else {
-  send_user "YOU MUST SET ENVIROMENT VARIABLE TEST_ENV_FILE_USER"
-  exit 1
-}
-
-if [info exists env(TEST_ENV_FILE2)] {
-  set TEST_ENV_FILE2 $env(TEST_ENV_FILE2)
-} else {
-  send_user "YOU MUST SET ENVIROMENT VARIABLE TEST_ENV_FILE2"
-  exit 1
-}
-
-
-if [info exists env(TEST_ENV_FILE_USER)] {
-  set TEST_ENV_FILE_USER1 $env(TEST_ENV_FILE_USER)
-} else {
-  send_user "YOU MUST SET ENVIROMENT VARIABLE TEST_ENV_FILE_USER"
-  exit 1
-}
-
-if [info exists env(TEST_USER1_NEW_PASSWD)] {
-  set USER1_NEW_PASSWORD $env(TEST_USER1_NEW_PASSWD)
-} else {
-  send_user "YOU MUST SET ENVIROMENT VARIABLE TEST_USER1_NEW_PASSWD"
-  exit 1
-}
-
-
-set script_exit_code 0
-set i_can_root 0
-
-send_user "Starting 'su' Testing\n"
-
-# 1) su with no parameters and correct password.
-#    - The su command should return a result code of 0
-#    - The user ID should be root
-#    - The user environment should be that of the invoking process
-#    - The command should create a new shell with a new process ID
-
-send_user "\nTEST: su with no parameters and correct password\n"
-
-set i_am_root 0
-# run "whoami" to test user ID inside su shell
-spawn /bin/su -c whoami
-set i_am_root 0
-expect {
-  "Password:" {
-  	send "$PASSWD\r"
-    expect {
-      "root" { set i_am_root 1
-		set i_can_root 1
-	 }
-    }
-  }
-}
-
-# capture result code
-set codes [wait]
-set pid [lindex $codes 0]
-set exit_code [lindex $codes 3]
-
-#Check that su user has same enviroment as current user
-set i_have_env 0
-set test_env_var " "
-if { $i_am_root==1 } {
-	spawn su -c "/bin/su root -c \"echo \\\$TEST_LINE > $TEST_ENV_FILE\""
-	expect {
-		 "Password:" {
-			send "$PASSWD\r"
-		}
-	}
-	expect eof
-	wait
-
-	set test_env_var [exec cat $TEST_ENV_FILE]
-
-	if  { $test_env_var==$TEST_LINE_ENV } {
-		set i_have_env 1
-	} else {
-		send_user "/bin/su with correct password (FAILED), the enviroment was not kept after su.\n"
-	}
-}
-
-
-#this variable is for any test, it can't run correctly if this test fails
-set test_one_passed 0
-
-if { ($i_am_root==1) && ($exit_code==0) && ($pid>0) && ($i_have_env==1) } {
-	send_user "/bin/su with correct password & enviroment check ( PASSED )\n"
-	set test_one_passed 1
-} else {
-  	send_user "/bin/su with correct password ( FAILED )\n"
-    set script_exit_code 1
-}
-
-
-# 2) su with no parameters and incorrect password.
-# 	  - The su command should return a result code of non-0
-#     - The user should be returned to the invoking shell
-#     - An appropriate failure message should be displayed
-
-send_user "\nTEST: su with no parameters and incorrect password \n"
-
-set displayed_error 0
-# run "whoami" to test user ID inside su shell
-spawn /bin/su -c whoami
-set displayed_error 0
-expect {
-  "Password:" {
-    send "wrong_$PASSWD\r"
-    expect {
-				"su: incorrect password" { set displayed_error 1 }
-				"su: Authentication failure" { set displayed_error 1 }
-    }
-  }
-}
-
-# capture result code
-set codes [wait]
-set pid [lindex $codes 0]
-set exit_code [lindex $codes 3]
-
-#Added for arm architecture
-
-send_user "\ndisplayed_error=$displayed_error"
-send_user "\nexit_code=$exit_code"
-send_user "\npid=$pid\n"
-
-if { ($displayed_error==1) && ($exit_code!=0) && ($pid>0) } {
-  send_user "/bin/su with incorrect password ( PASSED )\n"
-} else {
-  send_user "/bin/su with incorrect password ( FAILED )\n"
-  set script_exit_code 1
-}
-
-# 3) su to root using name parameter and correct password.
-# - The su command should return a result code of 0
-# - The user ID should be root
-# - The user environment should be that of the invoking process
-# - The command should create a new shell with a new process ID
-
-send_user "\nTEST: su to root using name parameter and correct password. \n"
-
-set i_am_root 0
-# run "whoami" to test user ID inside su shell
-spawn /bin/su -l root -c whoami
-expect {
-  "Password:" {
-    send "$PASSWD\r"
-    expect {
-				"root" { set i_am_root 1 }
-    }
-  }
-}
-
-# capture result code
-set codes [wait]
-set pid [lindex $codes 0]
-set exit_code [lindex $codes 3]
-
-
-#Check that su user does not have the same enviroment as current user
-set i_have_env 0
-set test_env " "
-if { $i_am_root==1 } {
-     	spawn /bin/sh -c "/bin/su -l root -c \"echo \"\\\$TEST_LINE > $TEST_ENV_FILE2\"\""
-        expect {
-                 "Password:" {
-			send "$PASSWD\r"
-                }
-        }
-
-	set test_env [exec cat $TEST_ENV_FILE2]
-
-	if  { $test_env==$TEST_LINE_ENV } {
-        	set i_have_env 1
- 		send_user "/bin/su -l root with correct password (FAILED), because it did not change enviroment\n"
-	}
-}
-
-
-if { ($i_am_root==1) && ($exit_code==0) && ($pid>0) && ($i_have_env==0) } {
-  send_user "/bin/su -l root with correct password & enviroment check ( PASSED )\n"
-} else {
-  send_user "/bin/su -l root with correct password ( FAILED )\n"
-  set script_exit_code 1
-}
-
-
-# 4) su to root with name parameter and incorrect password.
-#    - The su command should return a result code of non-0
-#    - The user should be returned to the invoking shell
-#    - An appropriate failure message should be displayed
-
-send_user "\nTEST: su to root with name parameter and incorrect password. \n"
-
-set displayed_error 0
-# run "whoami" to test user ID inside su shell
-spawn /bin/su -l root -c whoami
-expect {
-  "Password:" {
-    send "wrong_$PASSWD\r"
-    expect {
-				"su: incorrect password" { set displayed_error 1 }
-				"su: Authentication failure" { set displayed_error 1 }
-    }
-  }
-}
-
-# capture result code
-set codes [wait]
-set pid [lindex $codes 0]
-set exit_code [lindex $codes 3]
-if { ($displayed_error==1) && ($exit_code!=0) && ($pid>0) } {
-  send_user "/bin/su -l root with incorrect password ( PASSED )\n"
-} else {
-  send_user "/bin/su -l root with incorrect password ( FAILED )\n"
-  set script_exit_code 1
-}
-
-
-# 5) su to user1 with name parameter and correct password.
-#    - The su command should return a result code of 0
-#    - The user ID should be user1
-#    - The user environment should be that of the invoking process, in this case,that of user1
-#    - The command should create a new shell with a new process ID
-#    - Run "whoami" to test user ID inside su shell
-
-send_user "TEST: su to user1 with name parameter and correct password.\n"
-
-set i_am_correct 0
-spawn /bin/su -l $USER1 -c whoami
-expect {
-  "Password:" {
-    send "$USER1_PASSWORD\r"
-    expect {
-				"$USER1\r" { set i_am_correct 1 }
-    }
-  }
-}
-
-# capture result code
-set codes [wait]
-set pid [lindex $codes 0]
-set exit_code [lindex $codes 3]
-
-set i_have_env 0
-set test_env_var 0
-#Check to see that su user does not have the same enviroment
-if { $i_am_correct==1 } {
-        spawn /bin/sh -c "/bin/su -l $USER1 -c \"echo \"\\\$TEST_LINE > $TEST_ENV_FILE_USER1\"\""
-        expect {
-                 "Password:" {
-                                send "$USER1_PASSWORD\r"
-                }
-        }
-
-}
-
-set test_env_var [exec cat $TEST_ENV_FILE_USER1]
-
-set i_have_env 0
-if  { $test_env_var==$TEST_LINE_ENV } {
-        set i_have_env 1
-        send_user "/bin/su -l $USER1 with correct password (FAILED), because it did not change enviroment\n"
-	set i_have_env 0
-	if  { $test_env_var==$TEST_LINE_ENV } {
-        	set i_have_env 1
-        	send_user "su -l $USER1 with correct password (FAILED), because it did not change enviroment\n"
-	}
-}
-
-if { ($i_am_correct==1) && ($exit_code==0) && ($pid>0) && ($i_have_env==0) } {
-  send_user "/bin/su -l $USER1 with correct password & enviroment check ( PASSED )\n"
-} else {
-  send_user "/bin/su -l $USER1 with correct password ( FAILED )\n"
-  set script_exit_code 1
-}
-
-
-
-# 6)su to user1 with name parameter and incorrect password.
-#    - The su command should return a result code of non-0
-#    - The user should be returned to the invoking shell
-#    - An appropriate failure message should be displayed.
-
-send_user "TEST: su to user1 with name parameter and incorrect password.\n"
-spawn /bin/su -l $USER1 -c whoami
-set displayed_error 0
-expect {
-  "Password:" {
-    send "wrong_$USER1_PASSWORD\r"
-    expect {
-				"su: incorrect password" { set displayed_error 1 }
-				"su: Authentication failure" { set displayed_error 1 }
-    }
-  }
-}
-
-# capture result code
-set codes [wait]
-set pid [lindex $codes 0]
-set exit_code [lindex $codes 3]
-if { ($displayed_error==1) && ($exit_code!=0) && ($pid>0) } {
-  	send_user "/bin/su -l $USER1 with incorrect password ( PASSED )\n"
-} else {
-  	send_user "/bin/su -l $USER1 with incorrect password ( FAILED )\n"
-	set script_exit_code 1
-}
-
-
-# 7) su to user1 with the user1 password expired
-#    - user1 should not be allowed to log in
-#    - The su command should return a result code of non-0
-#    - The user should be returned to the invoking shell
-#    - An appropriate failure message should be displayed.
-
-# Become root and expire $USER1 password
-
-#  Skip this if Red Hat; -e option not supported.
-if { $distro != "redhat" && $distro != "redhat-linux" } {
-
-if { $test_one_passed==1} {
-send_user "TEST:  su to user1 with the user1 password expired.\n"
-
-spawn /bin/su -l root -c "passwd -e $USER1"
-expect {
-  "Password:" {
-    send "$PASSWD\r"
-    expect {
-				"Password expiry information changed."
-    }
-  }
-}
-
-set i_am_correct 0
-spawn /bin/su -l $USER1 -c whoami
-expect {
-  "Password:" {
-    send "$USER1_PASSWORD\r"
-    expect {
-        -re "current.*password|Old Password" {
-        send "wrong_$USER1_PASSWORD\r"
-        expect {
-       	  -re "current.*password|Old Password" {
-          send "wrong_$USER1_PASSWORD\r"
-            expect {
-								"su: incorrect password" { set i_am_correct 1 }
-								"su: Authentication failure" { set i_am_correct 1 }
-								"su: Authentication token manipulation error" { set i_am_correct 1 }
-            }
-          }
-					"su: incorrect password" { set i_am_correct 1 }
-					"su: Authentication failure" { set i_am_correct 1 }
-					"su: Authentication token manipulation error" { set i_am_correct 1 }
-        }
-      }
-    }
-  }
-}
-
-# capture result code
-set codes [wait]
-set pid [lindex $codes 0]
-set exit_code [lindex $codes 3]
-if { ($i_am_correct==1) && ($exit_code!=0) && ($pid>0) } {
-  	send_user "/bin/su -l $USER1 with expired correct password ( PASSED )\n"
-} else {
-  	send_user "/bin/su -l $USER1 with expired correct password ( FAILED )\n"
-	set script_exit_code 1
-}
-
-
-#Become root and set $USER1 password back to previous value
-spawn /bin/su -l root -c "passwd $USER1"
-expect {
-  "Password: " {
-    send "$PASSWD\r"
-    expect {
-     "Enter new password: " {
-        send "$USER1_NEW_PASSWORD\r"
-        expect {
-          "Re-type new password: " {
-            send "$USER1_NEW_PASSWORD\r"
-            expect {
-              "Password changed" {}
-            }
-          }
-        }
-      }
-    }
-  }
-}
-
-} else {
-
-	send_user "TEST:  su to user1 with the user1 password expired. (FAILED),see more next line.\n"
-	send_user "This test cannot be run because the first test to su as root failed\n"
-
-}
-# If RH let the tester know why only 6 tests were run.
-} else {
-  send_user "TEST 7 skipped if running on Red Hat; -e not supported \n"
-}
-exit  $script_exit_code
diff --git a/testcases/commands/su/su_set_passwd b/testcases/commands/su/su_set_passwd
deleted file mode 100755
index e8f0d2f50..000000000
--- a/testcases/commands/su/su_set_passwd
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/sh
-#
-# Set Password for a specific new user
-# This script should be run as 'root'
-#
-# Example:
-#		./su_set_passwd USER ENCRYPTED_PASSWD
-#
-
-USER=$1
-ENCRYPTED_PASSWD=$2
-
-usermod -p $ENCRYPTED_PASSWD $USER
-exit $?
diff --git a/testcases/commands/sysctl/Makefile b/testcases/commands/sysctl/Makefile
deleted file mode 100644
index 61ff70518..000000000
--- a/testcases/commands/sysctl/Makefile
+++ /dev/null
@@ -1,25 +0,0 @@
-#
-# Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
-# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, see <http://www.gnu.org/licenses/>.
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/sysctl/sysctl01.sh b/testcases/commands/sysctl/sysctl01.sh
deleted file mode 100755
index 7522da53d..000000000
--- a/testcases/commands/sysctl/sysctl01.sh
+++ /dev/null
@@ -1,55 +0,0 @@
-#!/bin/sh
-
-# Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
-# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
-# Description:
-# This is a regression test for invalid value of sysctl_sched_time_avg.
-# System will hang if user set sysctl_sched_time_avg to 0 on buggy kernel.
-#
-# The kernel bug has been fixed in kernel:
-# '5ccba44ba118("sched/sysctl: Check user input value of sysctl_sched_time_avg")'
-
-TST_TESTFUNC=sysctl_test
-TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="sysctl"
-
-. tst_test.sh
-
-sysctl_test()
-{
-	# With commit d00535d, sched_time_avg was renamed as sched_time_avg_ms
-	local dir="/proc/sys/kernel/"
-	[ -e "$dir""sched_time_avg_ms" ] && local name="sched_time_avg_ms"
-	[ -e "$dir""sched_time_avg" ] && local name="sched_time_avg"
-	[ -z "$name" ] && tst_brk TCONF \
-		"sched_time_avg(_ms) was not supported"
-
-	local orig_value=$(cat "$dir""$name")
-
-	sysctl -w "kernel.""$name"=0 >/dev/null 2>&1
-
-	local test_value=$(cat "$dir""$name")
-
-	if [ ${test_value} -eq ${orig_value} ]; then
-		tst_res TPASS "Setting $name failed"
-	else
-		tst_res TFAIL "Setting $name succeeded"
-		sysctl -w "kernel.""$name"=${orig_value} >/dev/null 2>&1
-	fi
-}
-
-tst_run
diff --git a/testcases/commands/tar/Makefile b/testcases/commands/tar/Makefile
deleted file mode 100644
index 7406b1f11..000000000
--- a/testcases/commands/tar/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/tar testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= tar_tests.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/tar/tar_tests.sh b/testcases/commands/tar/tar_tests.sh
deleted file mode 100755
index 7ac18a4e5..000000000
--- a/testcases/commands/tar/tar_tests.sh
+++ /dev/null
@@ -1,152 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author: Manoj Iyer, manjo@mail.utexas.edu                                 ##
-## Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>                          ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
-#
-# Creates, lists and extracts an plain, gzip and bzip tar archive.
-#
-
-TST_CNT=6
-TST_TESTFUNC=do_test
-TST_NEEDS_TMPDIR=1
-. tst_test.sh
-
-TAR_FILES="file1 file2 file3"
-
-check_listing()
-{
-	local i
-	local verbose=$1
-	shift
-
-	if [ -z "$verbose" ]; then
-		if [ -s tar.out ]; then
-			tst_res TFAIL "Tar produced unexpected output"
-			cat tar.out
-		else
-			tst_res TPASS "Tar produced no output"
-		fi
-
-		return
-	fi
-
-	if [ $(wc -l < tar.out) != $# ]; then
-		tst_res TFAIL "Unexpected number of lines in tar.out"
-		cat tar.out
-		return
-	fi
-
-	for i in $@; do
-		if ! grep -q $i tar.out; then
-			tst_res TFAIL "File $i missing in listing"
-			return
-		fi
-	done
-
-	tst_res TPASS "Listing in tar.out is correct"
-}
-
-check_content()
-{
-	local fname="$1"
-	local verbose="$2"
-	shift 2
-
-	EXPECT_PASS tar t${verbose}f "$fname" \> tar.out
-	check_listing v $@
-}
-
-check_files()
-{
-	for i in $@; do
-		if ! [ -f $i ]; then
-			tst_res TFAIL "Missing file $i in extracted archive"
-			cat tar.out
-			return
-		fi
-	done
-
-	tst_res TPASS "Files were uncompressed correctly"
-}
-
-check_extraction()
-{
-	local fname="$1"
-	local verbose="$2"
-	shift 2
-
-	EXPECT_PASS tar x${verbose}f $fname \> tar.out
-	check_listing "${verbose}" $@
-	check_files $@
-	ROD rm $@
-}
-
-test_tar()
-{
-	local comp="$1"
-	local verbose="$2"
-	local fname="$3"
-	local i
-
-	# Create archive
-	ROD touch $TAR_FILES
-	EXPECT_PASS tar c${verbose}f$comp $fname $TAR_FILES \> tar.out
-	check_listing "$verbose" $TAR_FILES
-
-	# Diff filesystem against the archive, should be the same at this point
-	EXPECT_PASS tar d${verbose}f $fname \> tar.out
-	check_listing "$verbose" $TAR_FILES
-
-	ROD rm $TAR_FILES
-
-	# Check content listing
-	check_content $fname "$verbose" $TAR_FILES
-
-	# Check decompression
-	check_extraction $fname "$verbose" $TAR_FILES
-
-	# Append to an archive, only possible for uncompressed archive
-	if [ -z "$comp" ]; then
-		ROD touch file4
-		EXPECT_PASS tar r${verbose}f $fname file4 \> tar.out
-		check_listing "$verbose" file4
-		check_content $fname "$verbose" $TAR_FILES file4
-		ROD rm file4
-
-		check_extraction $fname "$verbose" $TAR_FILES file4
-	fi
-
-	ROD rm $fname
-}
-
-do_test()
-{
-	case $1 in
-	1) test_tar ""  "v" "test.tar";;
-	2) test_tar "z" "v" "test.tar.gz";;
-	3) test_tar "j" "v" "test.tar.bz2";;
-	4) test_tar ""  ""  "test.tar";;
-	5) test_tar "z" ""  "test.tar.gz";;
-	6) test_tar "j" ""  "test.tar.bz2";;
-	esac
-}
-
-tst_run
diff --git a/testcases/commands/tpm-tools/Makefile b/testcases/commands/tpm-tools/Makefile
deleted file mode 100644
index 8b5b205da..000000000
--- a/testcases/commands/tpm-tools/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-#
-#    commands/tpm_tools testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/tpm-tools/tpm/Makefile b/testcases/commands/tpm-tools/tpm/Makefile
deleted file mode 100644
index f62cc14d1..000000000
--- a/testcases/commands/tpm-tools/tpm/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-#
-#    commands/tpm-tools/tpm test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/tpm-tools/tpm/tpm_changeauth/00_Descriptions.txt b/testcases/commands/tpm-tools/tpm/tpm_changeauth/00_Descriptions.txt
deleted file mode 100644
index 17a7b7430..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_changeauth/00_Descriptions.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-test01
-	tpm_changeownerauth changes the current owner password
-test02
-	tpm_changeownerauth changes the current SRK password
-test03
-	tpm_changeownerauth resets the owner and SRK password
diff --git a/testcases/commands/tpm-tools/tpm/tpm_changeauth/Makefile b/testcases/commands/tpm-tools/tpm/tpm_changeauth/Makefile
deleted file mode 100644
index a52e38691..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_changeauth/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/tpm-tools/tpm/tpm_changeauth testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests.sh b/testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests.sh
deleted file mode 100755
index 1ef9ce294..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests.sh
+++ /dev/null
@@ -1,146 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-setup()
-{
-	RC=0				# Return code from commands.
-
-	if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-	then
-		LTPTMP="/tmp"
-	else
-		LTPTMP="$TMPBASE"
-	fi
-
-	export TPM_TMPFILE="$LTPTMP/tst_tpm.err"
-	rm -f $TPM_TMPFILE 2>&1
-
-	# Set known password values
-	if [ -z "$OWN_PWD" ]
-	then
-		export OWN_PWD="OWN PWD"
-	fi
-	if [ -z "$SRK_PWD" ]
-	then
-		export SRK_PWD="SRK PWD"
-	fi
-	if [ -z "$NEW_OWN_PWD" ]
-	then
-		export NEW_OWN_PWD="NEW OWN PWD"
-	fi
-	if [ -z "$NEW_SRK_PWD" ]
-	then
-		export NEW_SRK_PWD="NEW SRK PWD"
-	fi
-
-	tst_resm TINFO "INIT: Inititalizing tests."
-
-	which tpm_changeownerauth 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: tpm_changeownerauth command does not exist. Reason:"
-		return $RC
-	fi
-
-	return $RC
-}
-
-test01()
-{
-	RC=0				# Return value from commands
-	export TCID=tpm_changeauth01	# Test ID
-	export TST_COUNT=1		# Test number
-
-	tpm_changeauth_tests_exp01.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpm_changeauth -o' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpm_changeauth -o' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test02()
-{
-	RC=0				# Return value from commands
-	export TCID=tpm_changeauth02	# Test ID
-	export TST_COUNT=2		# Test number
-
-	tpm_changeauth_tests_exp02.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpm_changeauth -s' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpm_changeauth -s' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test03()
-{
-	RC=0				# Return value from commands
-	export TCID=tpm_changeauth03	# Test ID
-	export TST_COUNT=3		# Test number
-
-	tpm_changeauth_tests_exp03.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpm_changeauth -s -o' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpm_changeauth -s -o' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-cleanup()
-{
-	rm -f $TPM_TMPFILE 2>&1
-}
-
-# Function:	main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:		- zero on success
-# 		- non-zero on failure.
-
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
-RC=0				# Return code from tests.
-
-export TCID=tpm_changeauth	# Test ID
-export TST_TOTAL=3		# Total numner of tests in this file.
-export TST_COUNT=0		# Initialize identifier
-
-setup || exit $RC		# Exit if initializing testcases fails.
-
-test01 || TFAILCNT=$(($TFAILCNT+1))
-test02 || TFAILCNT=$(($TFAILCNT+1))
-test03 || TFAILCNT=$(($TFAILCNT+1))
-
-cleanup
-
-exit $TFAILCNT
diff --git a/testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests_exp01.sh b/testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests_exp01.sh
deleted file mode 100755
index b1570317b..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests_exp01.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set OWN_PWD $env(OWN_PWD)
-set NEW_OWN_PWD $env(NEW_OWN_PWD)
-set SRK_PWD $env(SRK_PWD)
-set NEW_SRK_PWD $env(NEW_SRK_PWD)
-set timeout 30
-
-# Initiate the tpm_changeownerauth command to change the owner password
-spawn tpm_changeownerauth -o
-expect -re "Enter owner password: "
-send "$OWN_PWD\n"
-expect -re "Enter new owner password: "
-send "$NEW_OWN_PWD\n"
-expect -re "Confirm password: "
-send "$NEW_OWN_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests_exp02.sh b/testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests_exp02.sh
deleted file mode 100755
index d60af90b8..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests_exp02.sh
+++ /dev/null
@@ -1,40 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set OWN_PWD $env(OWN_PWD)
-set NEW_OWN_PWD $env(NEW_OWN_PWD)
-set SRK_PWD $env(SRK_PWD)
-set NEW_SRK_PWD $env(NEW_SRK_PWD)
-set timeout 30
-
-# Initiate the tpm_changeownerauth command to change the SRK password
-#   owner password was previously changed to NEW_OWN_PWD!
-spawn tpm_changeownerauth -s
-expect -re "Enter owner password: "
-send "$NEW_OWN_PWD\n"
-expect -re "Enter new SRK password: "
-send "$NEW_SRK_PWD\n"
-expect -re "Confirm password: "
-send "$NEW_SRK_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests_exp03.sh b/testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests_exp03.sh
deleted file mode 100755
index 9ed71143d..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_changeauth/tpm_changeauth_tests_exp03.sh
+++ /dev/null
@@ -1,44 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set OWN_PWD $env(OWN_PWD)
-set NEW_OWN_PWD $env(NEW_OWN_PWD)
-set SRK_PWD $env(SRK_PWD)
-set NEW_SRK_PWD $env(NEW_SRK_PWD)
-set timeout 30
-
-# Initiate the tpm_changeownerauth command to reset the owner and SRK password
-#   owner and SRK password was previously changed to NEW_OWN_PWD and NEW_SRK_PWD!
-spawn tpm_changeownerauth -s -o
-expect -re "Enter owner password: "
-send "$NEW_OWN_PWD\n"
-expect -re "Enter new SRK password: "
-send "$SRK_PWD\n"
-expect -re "Confirm password: "
-send "$SRK_PWD\n"
-expect -re "Enter new owner password: "
-send "$OWN_PWD\n"
-expect -re "Confirm password: "
-send "$OWN_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpm/tpm_clear/00_Descriptions.txt b/testcases/commands/tpm-tools/tpm/tpm_clear/00_Descriptions.txt
deleted file mode 100644
index 3ffc4e3c5..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_clear/00_Descriptions.txt
+++ /dev/null
@@ -1,2 +0,0 @@
-test01
-	tpm_clear clears the TPM
diff --git a/testcases/commands/tpm-tools/tpm/tpm_clear/Makefile b/testcases/commands/tpm-tools/tpm/tpm_clear/Makefile
deleted file mode 100644
index 96ed9d847..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_clear/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/tpm-tools/tpm/tpm_clear testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/tpm-tools/tpm/tpm_clear/tpm_clear_tests.sh b/testcases/commands/tpm-tools/tpm/tpm_clear/tpm_clear_tests.sh
deleted file mode 100755
index 8478e3f12..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_clear/tpm_clear_tests.sh
+++ /dev/null
@@ -1,100 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-setup()
-{
-	RC=0				# Return code from commands.
-
-	if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-	then
-		LTPTMP="/tmp"
-	else
-		LTPTMP="$TMPBASE"
-	fi
-
-	export TPM_TMPFILE="$LTPTMP/tst_tpm.err"
-	rm -f $TPM_TMPFILE 2>&1
-
-	# Set known password values
-	if [ -z "$OWN_PWD" ]
-	then
-		export OWN_PWD="OWN PWD"
-	fi
-	if [ -z "$SRK_PWD" ]
-	then
-		export SRK_PWD="SRK PWD"
-	fi
-
-	tst_resm TINFO "INIT: Inititalizing tests."
-
-	which tpm_clear 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: tpm_clear command does not exist. Reason:"
-		return $RC
-	fi
-
-	return $RC
-}
-
-test01()
-{
-	RC=0				# Return value from commands
-	export TCID=tpm_clear01		# Test ID
-	export TST_COUNT=1		# Test number
-
-	tpm_clear_tests_exp01.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpm_clear' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpm_clear' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-cleanup()
-{
-	rm -f $TPM_TMPFILE 2>&1
-}
-
-# Function:	main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:		- zero on success
-# 		- non-zero on failure.
-
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
-RC=0				# Return code from tests.
-
-export TCID=tpm_clear		# Test ID
-export TST_TOTAL=1		# Total numner of tests in this file.
-export TST_COUNT=0		# Initialize identifier
-
-setup || exit $RC		# Exit if initializing testcases fails.
-
-test01 || TFAILCNT=$(($TFAILCNT+1))
-
-cleanup
-
-exit $TFAILCNT
diff --git a/testcases/commands/tpm-tools/tpm/tpm_clear/tpm_clear_tests_exp01.sh b/testcases/commands/tpm-tools/tpm/tpm_clear/tpm_clear_tests_exp01.sh
deleted file mode 100755
index 093537f2f..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_clear/tpm_clear_tests_exp01.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set OWN_PWD $env(OWN_PWD)
-set SRK_PWD $env(SRK_PWD)
-set timeout 30
-
-# Initiate the tpm_clear command
-spawn tpm_clear
-expect -re "Enter owner password: "
-send "$OWN_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpm/tpm_getpubek/00_Descriptions.txt b/testcases/commands/tpm-tools/tpm/tpm_getpubek/00_Descriptions.txt
deleted file mode 100644
index 72e445ac8..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_getpubek/00_Descriptions.txt
+++ /dev/null
@@ -1,2 +0,0 @@
-test01
-	tpm_getpubek returns the public endorsement key
diff --git a/testcases/commands/tpm-tools/tpm/tpm_getpubek/Makefile b/testcases/commands/tpm-tools/tpm/tpm_getpubek/Makefile
deleted file mode 100644
index a42b51d49..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_getpubek/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/tpm-tools/tpm/tpm_getpubek testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/tpm-tools/tpm/tpm_getpubek/tpm_getpubek_tests.sh b/testcases/commands/tpm-tools/tpm/tpm_getpubek/tpm_getpubek_tests.sh
deleted file mode 100755
index 29c0a14e7..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_getpubek/tpm_getpubek_tests.sh
+++ /dev/null
@@ -1,100 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-setup()
-{
-	RC=0				# Return code from commands.
-
-	if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-	then
-		LTPTMP="/tmp"
-	else
-		LTPTMP="$TMPBASE"
-	fi
-
-	export TPM_TMPFILE="$LTPTMP/tst_tpm.err"
-	rm -f $TPM_TMPFILE 2>&1
-
-	# Set known password values
-	if [ -z "$OWN_PWD" ]
-	then
-		export OWN_PWD="OWN PWD"
-	fi
-	if [ -z "$SRK_PWD" ]
-	then
-		export SRK_PWD="SRK PWD"
-	fi
-
-	tst_resm TINFO "INIT: Inititalizing tests."
-
-	which tpm_getpubek 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: tpm_getpubek command does not exist. Reason:"
-		return $RC
-	fi
-
-	return $RC
-}
-
-test01()
-{
-	RC=0				# Return value from commands
-	export TCID=tpm_getpubek01	# Test ID
-	export TST_COUNT=1		# Test number
-
-	tpm_getpubek_tests_exp01.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpm_getpubek' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpm_getpubek' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-cleanup()
-{
-	rm -f $TPM_TMPFILE 2>&1
-}
-
-# Function:	main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:		- zero on success
-# 		- non-zero on failure.
-
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
-RC=0				# Return code from tests.
-
-export TCID=tpm_getpubek	# Test ID
-export TST_TOTAL=1		# Total numner of tests in this file.
-export TST_COUNT=0		# Initialize identifier
-
-setup || exit $RC		# Exit if initializing testcases fails.
-
-test01 || TFAILCNT=$(($TFAILCNT+1))
-
-cleanup
-
-exit $TFAILCNT
diff --git a/testcases/commands/tpm-tools/tpm/tpm_getpubek/tpm_getpubek_tests_exp01.sh b/testcases/commands/tpm-tools/tpm/tpm_getpubek/tpm_getpubek_tests_exp01.sh
deleted file mode 100755
index 062226bad..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_getpubek/tpm_getpubek_tests_exp01.sh
+++ /dev/null
@@ -1,42 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set OWN_PWD $env(OWN_PWD)
-set SRK_PWD $env(SRK_PWD)
-set timeout 30
-
-# Initiate the tpm_getpubek command
-#   we should not be prompted for an owner password at this stage
-#   if we are, it is an error
-spawn tpm_getpubek
-expect {
-	-re "Public Endorsement Key" { set pwd_prompt 0 }
-	-re "Enter owner password: " {
-		set pwd_prompt 1
-		send "$OWN_PWD\n"
-	}
-}
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-if {$pwd_prompt == 1} { set rc 1 }
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/00_Descriptions.txt b/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/00_Descriptions.txt
deleted file mode 100644
index 944780f1b..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/00_Descriptions.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-test01
-	tpm_restrictpubek restricts the reading of the pubek
-test02
-	tpm_restrictpubek checks the current setting
-test03
-	tpm_getpubek requires owner authorization to read the pubek
diff --git a/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/Makefile b/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/Makefile
deleted file mode 100644
index 4a646a0a6..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/tpm-tools/tpm/tpm_restrictpubek testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests.sh b/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests.sh
deleted file mode 100755
index 165c6931a..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests.sh
+++ /dev/null
@@ -1,146 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-setup()
-{
-	RC=0				# Return code from commands.
-
-	if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-	then
-		LTPTMP="/tmp"
-	else
-		LTPTMP="$TMPBASE"
-	fi
-
-	export TPM_TMPFILE="$LTPTMP/tst_tpm.err"
-	rm -f $TPM_TMPFILE 2>&1
-
-	# Set known password values
-	if [ -z "$OWN_PWD" ]
-	then
-		export OWN_PWD="OWN PWD"
-	fi
-	if [ -z "$SRK_PWD" ]
-	then
-		export SRK_PWD="SRK PWD"
-	fi
-
-	tst_resm TINFO "INIT: Inititalizing tests."
-
-	which tpm_restrictpubek 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: tpm_restrictpubek command does not exist. Reason:"
-		return $RC
-	fi
-
-	which tpm_getpubek 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: tpm_getpubek command does not exist. Reason:"
-		return $RC
-	fi
-
-	return $RC
-}
-
-test01()
-{
-	RC=0				# Return value from commands
-	export TCID=tpm_restrictpubek01	# Test ID
-	export TST_COUNT=1		# Test number
-
-	tpm_restrictpubek_tests_exp01.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpm_restrictpubek -r' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpm_restrictpubek -r' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test02()
-{
-	RC=0				# Return value from commands
-	export TCID=tpm_restrictpubek02	# Test ID
-	export TST_COUNT=2		# Test number
-
-	tpm_restrictpubek_tests_exp02.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpm_restrictpubek -s' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpm_restrictpubek -s' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test03()
-{
-	RC=0				# Return value from commands
-	export TCID=tpm_restrictpubek03	# Test ID
-	export TST_COUNT=3		# Test number
-
-	tpm_restrictpubek_tests_exp03.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpm_getpubek' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpm_getpubek' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-cleanup()
-{
-	rm -f $TPM_TMPFILE 2>&1
-}
-
-# Function:	main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:		- zero on success
-# 		- non-zero on failure.
-
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
-RC=0				# Return code from tests.
-
-export TCID=tpm_restrictpubek	# Test ID
-export TST_TOTAL=3		# Total numner of tests in this file.
-export TST_COUNT=0		# Initialize identifier
-
-setup || exit $RC		# Exit if initializing testcases fails.
-
-test01 || TFAILCNT=$(($TFAILCNT+1))
-test02 || TFAILCNT=$(($TFAILCNT+1))
-test03 || TFAILCNT=$(($TFAILCNT+1))
-
-cleanup
-
-exit $TFAILCNT
diff --git a/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests_exp01.sh b/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests_exp01.sh
deleted file mode 100755
index b8c8437fa..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests_exp01.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set OWN_PWD $env(OWN_PWD)
-set SRK_PWD $env(SRK_PWD)
-set timeout 30
-
-# Initiate the tpm_restrictpubek command
-spawn tpm_restrictpubek -r
-expect -re "Enter owner password: "
-send "$OWN_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests_exp02.sh b/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests_exp02.sh
deleted file mode 100755
index a084ae5ca..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests_exp02.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set OWN_PWD $env(OWN_PWD)
-set SRK_PWD $env(SRK_PWD)
-set timeout 30
-
-# Initiate the tpm_restrictpubek command
-spawn tpm_restrictpubek -s
-expect -re "Enter owner password: "
-send "$OWN_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests_exp03.sh b/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests_exp03.sh
deleted file mode 100755
index d252bcc8e..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/tpm_restrictpubek_tests_exp03.sh
+++ /dev/null
@@ -1,42 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set OWN_PWD $env(OWN_PWD)
-set SRK_PWD $env(SRK_PWD)
-set timeout 30
-
-# Initiate the tpm_getpubek command
-#   we should be prompted for an owner password at this stage
-#   if we are not, it is an error
-spawn tpm_getpubek
-expect {
-	-re "Public Endorsement Key" { set pwd_prompt 0 }
-	-re "Enter owner password: " {
-		set pwd_prompt 1
-		send "$OWN_PWD\n"
-	}
-}
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-if {$pwd_prompt == 0} { set rc 1 }
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpm/tpm_selftest/00_Descriptions.txt b/testcases/commands/tpm-tools/tpm/tpm_selftest/00_Descriptions.txt
deleted file mode 100644
index 50d7c2d82..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_selftest/00_Descriptions.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-test01
-	tpm_selftest executes selftest and reports result
-test02
-	tpm_selftest -r reports result of last selftest
diff --git a/testcases/commands/tpm-tools/tpm/tpm_selftest/Makefile b/testcases/commands/tpm-tools/tpm/tpm_selftest/Makefile
deleted file mode 100644
index 589ae8e14..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_selftest/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/tpm-tools/tpm/tpm_selftest testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/tpm-tools/tpm/tpm_selftest/tpm_selftest_tests.sh b/testcases/commands/tpm-tools/tpm/tpm_selftest/tpm_selftest_tests.sh
deleted file mode 100755
index 8ce092167..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_selftest/tpm_selftest_tests.sh
+++ /dev/null
@@ -1,109 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-setup()
-{
-	RC=0				# Return code from commands.
-
-	if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-	then
-		LTPTMP="/tmp"
-	else
-		LTPTMP="$TMPBASE"
-	fi
-
-	export TPM_TMPFILE="$LTPTMP/tst_tpm.err"
-	rm -f $TPM_TMPFILE 2>&1
-
-	tst_resm TINFO "INIT: Inititalizing tests."
-
-	which tpm_selftest 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: tpm_selftest command does not exist. Reason:"
-		return $RC
-	fi
-
-	return $RC
-}
-
-test01()
-{
-	RC=0				# Return value from commands
-	export TCID=tpm_selftest01	# Test ID
-	export TST_COUNT=1		# Test number
-
-	tpm_selftest 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpm_selftest' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpm_selftest' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test02()
-{
-	RC=0				# Return value from commands
-	export TCID=tpm_selftest02	# Test ID
-	export TST_COUNT=2		# Test number
-
-	tpm_selftest -r 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpm_selftest -r' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpm_selftest -r' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-cleanup()
-{
-	rm -f $TPM_TMPFILE 2>&1
-}
-
-# Function:	main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:		- zero on success
-# 		- non-zero on failure.
-
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
-RC=0				# Return code from tests.
-
-export TCID=tpm_selftest	# Test ID
-export TST_TOTAL=2		# Total numner of tests in this file.
-export TST_COUNT=0		# Initialize identifier
-
-setup || exit $RC		# Exit if initializing testcases fails.
-
-test01 || TFAILCNT=$(($TFAILCNT+1))
-test02 || TFAILCNT=$(($TFAILCNT+1))
-
-cleanup
-
-exit $TFAILCNT
diff --git a/testcases/commands/tpm-tools/tpm/tpm_takeownership/00_Descriptions.txt b/testcases/commands/tpm-tools/tpm/tpm_takeownership/00_Descriptions.txt
deleted file mode 100644
index 939b8c5cb..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_takeownership/00_Descriptions.txt
+++ /dev/null
@@ -1,2 +0,0 @@
-test01
-	tpm_takeownership takes ownership of the TPM
diff --git a/testcases/commands/tpm-tools/tpm/tpm_takeownership/Makefile b/testcases/commands/tpm-tools/tpm/tpm_takeownership/Makefile
deleted file mode 100644
index 9803f04ec..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_takeownership/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/tpm-tools/tpm/tpm_takeownership testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/tpm-tools/tpm/tpm_takeownership/tpm_takeownership_tests.sh b/testcases/commands/tpm-tools/tpm/tpm_takeownership/tpm_takeownership_tests.sh
deleted file mode 100755
index 502ee34fe..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_takeownership/tpm_takeownership_tests.sh
+++ /dev/null
@@ -1,100 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-setup()
-{
-	RC=0				# Return code from commands.
-
-	if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-	then
-		LTPTMP="/tmp"
-	else
-		LTPTMP="$TMPBASE"
-	fi
-
-	export TPM_TMPFILE="$LTPTMP/tst_tpm.err"
-	rm -f $TPM_TMPFILE 2>&1
-
-	# Set known password values
-	if [ -z "$OWN_PWD" ]
-	then
-		export OWN_PWD="OWN PWD"
-	fi
-	if [ -z "$SRK_PWD" ]
-	then
-		export SRK_PWD="SRK PWD"
-	fi
-
-	tst_resm TINFO "INIT: Inititalizing tests."
-
-	which tpm_takeownership 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: tpm_takeownership command does not exist. Reason:"
-		return $RC
-	fi
-
-	return $RC
-}
-
-test01()
-{
-	RC=0				# Return value from commands
-	export TCID=tpm_takeownership01	# Test ID
-	export TST_COUNT=1		# Test number
-
-	tpm_takeownership_tests_exp01.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpm_takeownership' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpm_takeownership' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-cleanup()
-{
-	rm -f $TPM_TMPFILE 2>&1
-}
-
-# Function:	main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:		- zero on success
-# 		- non-zero on failure.
-
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
-RC=0				# Return code from tests.
-
-export TCID=tpm_takeownership	# Test ID
-export TST_TOTAL=1		# Total numner of tests in this file.
-export TST_COUNT=0		# Initialize identifier
-
-setup || exit $RC		# Exit if initializing testcases fails.
-
-test01 || TFAILCNT=$(($TFAILCNT+1))
-
-cleanup
-
-exit $TFAILCNT
diff --git a/testcases/commands/tpm-tools/tpm/tpm_takeownership/tpm_takeownership_tests_exp01.sh b/testcases/commands/tpm-tools/tpm/tpm_takeownership/tpm_takeownership_tests_exp01.sh
deleted file mode 100755
index 1e74a37e2..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_takeownership/tpm_takeownership_tests_exp01.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set OWN_PWD $env(OWN_PWD)
-set SRK_PWD $env(SRK_PWD)
-set timeout 30
-
-# Initiate the tpm_takeownership command
-spawn tpm_takeownership
-expect -re "Enter owner password: "
-send "$OWN_PWD\n"
-expect -re "Confirm password: "
-send "$OWN_PWD\n"
-expect -re "Enter SRK password: "
-send "$SRK_PWD\n"
-expect -re "Confirm password: "
-send "$SRK_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpm/tpm_version/00_Descriptions.txt b/testcases/commands/tpm-tools/tpm/tpm_version/00_Descriptions.txt
deleted file mode 100644
index 0d2d3c102..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_version/00_Descriptions.txt
+++ /dev/null
@@ -1,2 +0,0 @@
-test01
-	tpm_version reports the version information
diff --git a/testcases/commands/tpm-tools/tpm/tpm_version/Makefile b/testcases/commands/tpm-tools/tpm/tpm_version/Makefile
deleted file mode 100644
index 26e64f25d..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_version/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/tpm-tools/tpm/tpm_version testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/tpm-tools/tpm/tpm_version/tpm_version_tests.sh b/testcases/commands/tpm-tools/tpm/tpm_version/tpm_version_tests.sh
deleted file mode 100755
index 347ee61a7..000000000
--- a/testcases/commands/tpm-tools/tpm/tpm_version/tpm_version_tests.sh
+++ /dev/null
@@ -1,94 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-export TCID=tpm_version
-export TST_TOTAL=1
-export TST_COUNT=1
-
-setup()
-{
-	RC=0				# Return code from commands.
-
-	if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-	then
-		LTPTMP="/tmp"
-	else
-		LTPTMP="$TMPBASE"
-	fi
-
-	export TPM_TMPFILE="$LTPTMP/tst_tpm.err"
-	rm -f $TPM_TMPFILE 2>&1
-
-	tst_resm TINFO "INIT: Inititalizing tests."
-
-	which tpm_version 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Test: tpm_version command does not exist. Reason:"
-		return $RC
-	fi
-
-	return $RC
-}
-
-test01()
-{
-	RC=0				# Return value from commands
-	export TCID=tpm_version01	# Test ID
-	export TST_COUNT=1		# Test number
-
-	tpm_version 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpm_version' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpm_version' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-cleanup()
-{
-	rm -f $TPM_TMPFILE 2>&1
-}
-
-# Function:	main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:		- zero on success
-# 		- non-zero on failure.
-
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
-RC=0				# Return code from tests.
-
-setup || exit $RC		# Exit if initializing testcases fails.
-
-export TCID=tpm_version		# Test ID
-export TST_TOTAL=1		# Total numner of tests in this file.
-export TST_COUNT=0		# Initialize identifier
-
-test01 || TFAILCNT=$(($TFAILCNT+1))
-
-cleanup
-
-exit $TFAILCNT
diff --git a/testcases/commands/tpm-tools/tpmtoken/Makefile b/testcases/commands/tpm-tools/tpmtoken/Makefile
deleted file mode 100644
index f9c6fde69..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-#
-#    commands/tpm-tools/tpmtoken test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/00_Descriptions.txt b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/00_Descriptions.txt
deleted file mode 100644
index 6389ae444..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/00_Descriptions.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-test01
-	tpmtoken_import import a certificate and key
-test02
-	tpmtoken_import import a certificate and key
-test03
-	tpmtoken_import import a certificate and key with -y option
-test04
-	tpmtoken_import import a public certificate and key
-test05
-	tpmtoken_import import a public certificate and key
-test06
-	tpmtoken_import import a public certificate and key with -y option
-test07
-	tpmtoken_import import a certificate
-test08
-	tpmtoken_import import a key
-test09
-	tpmtoken_import attempt to import a certificate from a key file
-test10
-	tpmtoken_import attempt to import a key from a certificate file
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/Makefile b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/Makefile
deleted file mode 100644
index 130d83939..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/tpm-tools/tpmtoken/tpmtoken_import testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_openssl.cnf b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_openssl.cnf
deleted file mode 100644
index 2e7abd937..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_openssl.cnf
+++ /dev/null
@@ -1,258 +0,0 @@
-#
-# OpenSSL example configuration file.
-# This is mostly being used for generation of certificate requests.
-#
-
-# This definition stops the following lines choking if HOME isn't
-# defined.
-HOME			= .
-RANDFILE		= $ENV::HOME/.rnd
-
-# Extra OBJECT IDENTIFIER info:
-#oid_file		= $ENV::HOME/.oid
-oid_section		= new_oids
-
-# To use this configuration file with the "-extfile" option of the
-# "openssl x509" utility, name here the section containing the
-# X.509v3 extensions to use:
-# extensions		=
-# (Alternatively, use a configuration file that has only
-# X.509v3 extensions in its main [= default] section.)
-
-[ new_oids ]
-
-# We can add new OIDs in here for use by 'ca' and 'req'.
-# Add a simple OID like this:
-# testoid1=1.2.3.4
-# Or use config file substitution like this:
-# testoid2=${testoid1}.5.6
-
-####################################################################
-[ ca ]
-default_ca	= CA_default		# The default ca section
-
-####################################################################
-[ CA_default ]
-
-dir		= /usr/share/ssl/CA	# Where everything is kept
-certs		= $dir/certs		# Where the issued certs are kept
-crl_dir		= $dir/crl		# Where the issued crl are kept
-database	= $dir/index.txt	# database index file.
-new_certs_dir	= $dir/newcerts		# default place for new certs.
-
-certificate	= $dir/cacert.pem 	# The CA certificate
-serial		= $dir/serial 		# The current serial number
-crl		= $dir/crl.pem 		# The current CRL
-private_key	= $dir/private/cakey.pem# The private key
-RANDFILE	= $dir/private/.rand	# private random number file
-
-x509_extensions	= usr_cert		# The extentions to add to the cert
-
-# Comment out the following two lines for the "traditional"
-# (and highly broken) format.
-name_opt 	= ca_default		# Subject Name options
-cert_opt 	= ca_default		# Certificate field options
-
-# Extension copying option: use with caution.
-# copy_extensions = copy
-
-# Extensions to add to a CRL. Note: Netscape communicator chokes on V2 CRLs
-# so this is commented out by default to leave a V1 CRL.
-# crl_extensions	= crl_ext
-
-default_days	= 365			# how long to certify for
-default_crl_days= 30			# how long before next CRL
-default_md	= md5			# which md to use.
-preserve	= no			# keep passed DN ordering
-
-# A few difference way of specifying how similar the request should look
-# For type CA, the listed attributes must be the same, and the optional
-# and supplied fields are just that :-)
-policy		= policy_match
-
-# For the CA policy
-[ policy_match ]
-countryName		= match
-stateOrProvinceName	= match
-organizationName	= match
-organizationalUnitName	= optional
-commonName		= supplied
-emailAddress		= optional
-
-# For the 'anything' policy
-# At this point in time, you must list all acceptable 'object'
-# types.
-[ policy_anything ]
-countryName		= optional
-stateOrProvinceName	= optional
-localityName		= optional
-organizationName	= optional
-organizationalUnitName	= optional
-commonName		= supplied
-emailAddress		= optional
-
-####################################################################
-[ req ]
-default_bits		= 1024
-default_keyfile 	= privkey.pem
-distinguished_name	= req_distinguished_name
-attributes		= req_attributes
-x509_extensions	= v3_ca	# The extentions to add to the self signed cert
-
-# Passwords for private keys
-#   These passwords need to correspond the passwords
-#   set in the testcase script file
-input_password = "SSL PWD"
-output_password = "SSL PWD"
-
-# This sets a mask for permitted string types. There are several options.
-# default: PrintableString, T61String, BMPString.
-# pkix	 : PrintableString, BMPString.
-# utf8only: only UTF8Strings.
-# nombstr : PrintableString, T61String (no BMPStrings or UTF8Strings).
-# MASK:XXXX a literal mask value.
-# WARNING: current versions of Netscape crash on BMPStrings or UTF8Strings
-# so use this option with caution!
-string_mask = nombstr
-
-# req_extensions = v3_req # The extensions to add to a certificate request
-
-[ req_distinguished_name ]
-countryName			= Country Name (2 letter code)
-countryName_default		= US
-countryName_min			= 2
-countryName_max			= 2
-
-stateOrProvinceName		= State or Province Name (full name)
-stateOrProvinceName_default	= Texas
-
-localityName			= Locality Name (eg, city)
-localityName_default		= Austin
-
-0.organizationName		= Organization Name (eg, company)
-0.organizationName_default	= LTP Tests
-
-# we can do this but it is not needed normally :-)
-#1.organizationName		= Second Organization Name (eg, company)
-#1.organizationName_default	= World Wide Web Pty Ltd
-
-organizationalUnitName		= Organizational Unit Name (eg, section)
-#organizationalUnitName_default	=
-
-commonName			= Common Name (eg, your name or your server\'s hostname)
-commonName_max			= 64
-
-emailAddress			= Email Address
-emailAddress_max		= 64
-
-# SET-ex3			= SET extension number 3
-
-[ req_attributes ]
-challengePassword		= A challenge password
-challengePassword_min		= 4
-challengePassword_max		= 20
-
-unstructuredName		= An optional company name
-
-[ usr_cert ]
-
-# These extensions are added when 'ca' signs a request.
-
-# This goes against PKIX guidelines but some CAs do it and some software
-# requires this to avoid interpreting an end user certificate as a CA.
-
-basicConstraints=CA:FALSE
-
-# Here are some examples of the usage of nsCertType. If it is omitted
-# the certificate can be used for anything *except* object signing.
-
-# This is OK for an SSL server.
-# nsCertType			= server
-
-# For an object signing certificate this would be used.
-# nsCertType = objsign
-
-# For normal client use this is typical
-# nsCertType = client, email
-
-# and for everything including object signing:
-# nsCertType = client, email, objsign
-
-# This is typical in keyUsage for a client certificate.
-# keyUsage = nonRepudiation, digitalSignature, keyEncipherment
-
-# This will be displayed in Netscape's comment listbox.
-nsComment			= "OpenSSL Generated Certificate"
-
-# PKIX recommendations harmless if included in all certificates.
-subjectKeyIdentifier=hash
-authorityKeyIdentifier=keyid,issuer:always
-
-# This stuff is for subjectAltName and issuerAltname.
-# Import the email address.
-# subjectAltName=email:copy
-# An alternative to produce certificates that aren't
-# deprecated according to PKIX.
-# subjectAltName=email:move
-
-# Copy subject details
-# issuerAltName=issuer:copy
-
-#nsCaRevocationUrl		= http://www.domain.dom/ca-crl.pem
-#nsBaseUrl
-#nsRevocationUrl
-#nsRenewalUrl
-#nsCaPolicyUrl
-#nsSslServerName
-
-[ v3_req ]
-
-# Extensions to add to a certificate request
-
-basicConstraints = CA:FALSE
-keyUsage = nonRepudiation, digitalSignature, keyEncipherment
-
-[ v3_ca ]
-
-
-# Extensions for a typical CA
-
-
-# PKIX recommendation.
-
-subjectKeyIdentifier=hash
-
-authorityKeyIdentifier=keyid:always,issuer:always
-
-# This is what PKIX recommends but some broken software chokes on critical
-# extensions.
-#basicConstraints = critical,CA:true
-# So we do this instead.
-basicConstraints = CA:true
-
-# Key usage: this is typical for a CA certificate. However since it will
-# prevent it being used as an test self-signed certificate it is best
-# left out by default.
-# keyUsage = cRLSign, keyCertSign
-
-# Some might want this also
-# nsCertType = sslCA, emailCA
-
-# Include email address in subject alt name: another PKIX recommendation
-# subjectAltName=email:copy
-# Copy issuer details
-# issuerAltName=issuer:copy
-
-# DER hex encoding of an extension: beware experts only!
-# obj=DER:02:03
-# Where 'obj' is a standard or added object
-# You can even override a supported extension:
-# basicConstraints= critical, DER:30:03:01:01:FF
-
-[ crl_ext ]
-
-# CRL extensions.
-# Only issuerAltName and authorityKeyIdentifier make any sense in a CRL.
-
-# issuerAltName=issuer:copy
-authorityKeyIdentifier=keyid:always,issuer:always
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests.sh
deleted file mode 100755
index 1ea16556b..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests.sh
+++ /dev/null
@@ -1,323 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-setup()
-{
-	RC=0				# Return code from commands.
-
-	if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-	then
-		LTPTMP="/tmp"
-	else
-		LTPTMP="$TMPBASE"
-	fi
-
-	export TPM_TMPFILE="$LTPTMP/tst_tpm.err"
-	rm -f $TPM_TMPFILE 2>&1
-
-	# Set the cert, key and combined cert and key filenames
-	export TPM_CERTFILE="$LTPTMP/tst_tpm.cert"
-	rm -f $TPM_CERTFILE 2>&1
-	export TPM_KEYFILE="$LTPTMP/tst_tpm.key"
-	rm -f $TPM_KEYFILE 2>&1
-	export TPM_COMBFILE="$LTPTMP/tst_tpm.comb"
-	rm -f $TPM_COMBFILE 2>&1
-
-	# Set the OpenSSL configuration file
-	export TPM_SSLCONF="$LTPBIN/tpmtoken_import_openssl.cnf"
-
-	# Set known password values
-	if [ -z "$P11_SO_PWD" ]
-	then
-		export P11_SO_PWD="P11 SO PWD"
-	fi
-	if [ -z "$P11_USER_PWD" ]
-	then
-		export P11_USER_PWD="P11 USER PWD"
-	fi
-	# This password needs to correspond to the passwords
-	#   in the supplied OpenSSL configuration file
-	if [ -z "$SSL_PWD" ]
-	then
-		export SSL_PWD="SSL PWD"
-	fi
-
-	tst_resm TINFO "INIT: Inititalizing tests."
-
-	which tpmtoken_import 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Test: tpmtoken_import command does not exist. Reason:"
-		return $RC
-	fi
-
-	which openssl 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: openssl command does not exist. Reason:"
-		return $RC
-	fi
-	openssl req -x509 -new -out $TPM_CERTFILE	\
-		-newkey rsa:2048 -keyout $TPM_KEYFILE	\
-		-sha1 -batch -config $TPM_SSLCONF
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: unable to create certificate and/or key file. Reason:"
-		return $RC
-	fi
-	cat $TPM_CERTFILE $TPM_KEYFILE 1>$TPM_COMBFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_COMBFILE NULL \
-			"Setup: unable to create combined certficate and key file. Reason:"
-		return $RC
-	fi
-
-	return $RC
-}
-
-test01()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_import01	# Test ID
-	export TST_COUNT=1		# Test number
-
-	tpmtoken_import_tests_exp01.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_import -n $TCID $TPM_COMBFILE' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_import -n $TCID $TPM_COMBFILE' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test02()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_import02	# Test ID
-	export TST_COUNT=2		# Test number
-
-	tpmtoken_import_tests_exp02.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_import -n $TCID $TPM_COMBFILE' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_import -n $TCID $TPM_COMBFILE' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test03()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_import03	# Test ID
-	export TST_COUNT=3		# Test number
-
-	tpmtoken_import_tests_exp03.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_import -y -n $TCID $TPM_COMBFILE' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_import -y -n $TCID $TPM_COMBFILE' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test04()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_import04	# Test ID
-	export TST_COUNT=4		# Test number
-
-	tpmtoken_import_tests_exp04.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_import -p -n $TCID $TPM_COMBFILE' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_import -p -n $TCID $TPM_COMBFILE' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test05()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_import05	# Test ID
-	export TST_COUNT=5		# Test number
-
-	tpmtoken_import_tests_exp05.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_import -p -n $TCID $TPM_COMBFILE' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_import -p -n $TCID $TPM_COMBFILE' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test06()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_import06	# Test ID
-	export TST_COUNT=6		# Test number
-
-	tpmtoken_import_tests_exp06.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_import -y -p -n $TCID $TPM_COMBFILE' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_import -y -p -n $TCID $TPM_COMBFILE' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test07()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_import07	# Test ID
-	export TST_COUNT=7		# Test number
-
-	tpmtoken_import_tests_exp07.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_import -n $TCID $TPM_CERTFILE' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_import -n $TCID $TPM_CERTFILE' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test08()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_import08	# Test ID
-	export TST_COUNT=8		# Test number
-
-	tpmtoken_import_tests_exp08.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_import -n $TCID $TPM_KEYFILE' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_import -n $TCID $TPM_KEYFILE' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test09()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_import09	# Test ID
-	export TST_COUNT=9		# Test number
-
-	#  The command should fail in this test case!
-	tpmtoken_import -t key -n $TCID $TPM_CERTFILE 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_import -t key -n $TCID $TPM_CERTFILE' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_import -t key -n $TCID $TPM_CERTFILE' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test10()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_import10	# Test ID
-	export TST_COUNT=10		# Test number
-
-	#  The command should fail in this test case!
-	tpmtoken_import -t cert -n $TCID $TPM_KEYFILE 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_import -t cert -n $TCID $TPM_KEYFILE' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_import -t cert -n $TCID $TPM_KEYFILE' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-cleanup()
-{
-	rm -f $TPM_TMPFILE 2>&1
-	rm -f $TPM_CERTFILE 2>&1
-	rm -f $TPM_KEYFILE 2>&1
-	rm -f $TPM_COMBFILE 2>&1
-}
-
-# Function:	main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:		- zero on success
-# 		- non-zero on failure.
-
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
-RC=0				# Return code from tests.
-
-export TCID=tpmtoken_import	# Test ID
-export TST_TOTAL=10		# Total numner of tests in this file.
-export TST_COUNT=0		# Initialize identifier
-
-if [ -n "$TPM_NOPKCS11" ]
-then
-	tst_resm TINFO "'tpmtoken_import' skipped."
-	exit $TFAILCNT
-fi
-
-setup || exit $RC		# Exit if initializing testcases fails.
-
-test01 || TFAILCNT=$(($TFAILCNT+1))
-test02 || TFAILCNT=$(($TFAILCNT+1))
-test03 || TFAILCNT=$(($TFAILCNT+1))
-test04 || TFAILCNT=$(($TFAILCNT+1))
-test05 || TFAILCNT=$(($TFAILCNT+1))
-test06 || TFAILCNT=$(($TFAILCNT+1))
-test07 || TFAILCNT=$(($TFAILCNT+1))
-test08 || TFAILCNT=$(($TFAILCNT+1))
-test09 || TFAILCNT=$(($TFAILCNT+1))
-test10 || TFAILCNT=$(($TFAILCNT+1))
-
-cleanup
-
-exit $TFAILCNT
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp01.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp01.sh
deleted file mode 100755
index 73781aafc..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp01.sh
+++ /dev/null
@@ -1,40 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set TPM_CERTFILE $env(TPM_CERTFILE)
-set TPM_KEYFILE $env(TPM_KEYFILE)
-set TPM_COMBFILE $env(TPM_COMBFILE)
-set SSL_PWD $env(SSL_PWD)
-set TCID $env(TCID)
-set timeout 30
-
-# Import the combined certificate and key
-spawn tpmtoken_import -n "$TCID" $TPM_COMBFILE
-expect -re "Enter PEM pass phrase:"
-send "$SSL_PWD\n"
-expect -re "Enter your TPM user password: "
-send "$P11_USER_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp02.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp02.sh
deleted file mode 100755
index a945aecdd..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp02.sh
+++ /dev/null
@@ -1,47 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set TPM_CERTFILE $env(TPM_CERTFILE)
-set TPM_KEYFILE $env(TPM_KEYFILE)
-set TPM_COMBFILE $env(TPM_COMBFILE)
-set SSL_PWD $env(SSL_PWD)
-set TCID $env(TCID)
-set timeout 30
-
-# Import the combined certificate and key as public objects
-#   there should already be a cert and key objects
-spawn tpmtoken_import -n "$TCID" $TPM_COMBFILE
-expect -re "Enter PEM pass phrase:"
-send "$SSL_PWD\n"
-expect -re "Enter your TPM user password: "
-send "$P11_USER_PWD\n"
-# Replace the cert object
-expect -re "Import the object?"
-send "y\n"
-# Replace the key objects
-expect -re "Import the object?"
-send "y\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp03.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp03.sh
deleted file mode 100755
index 2e1469cc7..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp03.sh
+++ /dev/null
@@ -1,42 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set TPM_CERTFILE $env(TPM_CERTFILE)
-set TPM_KEYFILE $env(TPM_KEYFILE)
-set TPM_COMBFILE $env(TPM_COMBFILE)
-set SSL_PWD $env(SSL_PWD)
-set TCID $env(TCID)
-set timeout 30
-
-# Import the combined certificate and key
-#   there should already be a cert and key objects,
-#   but the -y option takes care of that
-spawn tpmtoken_import -y -n "$TCID" $TPM_COMBFILE
-expect -re "Enter PEM pass phrase:"
-send "$SSL_PWD\n"
-expect -re "Enter your TPM user password: "
-send "$P11_USER_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp04.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp04.sh
deleted file mode 100755
index 1f59ba4da..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp04.sh
+++ /dev/null
@@ -1,38 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set TPM_CERTFILE $env(TPM_CERTFILE)
-set TPM_KEYFILE $env(TPM_KEYFILE)
-set TPM_COMBFILE $env(TPM_COMBFILE)
-set SSL_PWD $env(SSL_PWD)
-set TCID $env(TCID)
-set timeout 30
-
-# Import the combined certificate and key
-spawn tpmtoken_import -p -n "$TCID" $TPM_COMBFILE
-expect -re "Enter PEM pass phrase:"
-send "$SSL_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp05.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp05.sh
deleted file mode 100755
index c463496f5..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp05.sh
+++ /dev/null
@@ -1,45 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set TPM_CERTFILE $env(TPM_CERTFILE)
-set TPM_KEYFILE $env(TPM_KEYFILE)
-set TPM_COMBFILE $env(TPM_COMBFILE)
-set SSL_PWD $env(SSL_PWD)
-set TCID $env(TCID)
-set timeout 30
-
-# Import the combined certificate and key as public objects
-#   there should already be a cert and key objects
-spawn tpmtoken_import -p -n "$TCID" $TPM_COMBFILE
-expect -re "Enter PEM pass phrase:"
-send "$SSL_PWD\n"
-# Replace the cert object
-expect -re "Import the object?"
-send "y\n"
-# Replace the key objects
-expect -re "Import the object?"
-send "y\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp06.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp06.sh
deleted file mode 100755
index 8abcd29f7..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp06.sh
+++ /dev/null
@@ -1,40 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set TPM_CERTFILE $env(TPM_CERTFILE)
-set TPM_KEYFILE $env(TPM_KEYFILE)
-set TPM_COMBFILE $env(TPM_COMBFILE)
-set SSL_PWD $env(SSL_PWD)
-set TCID $env(TCID)
-set timeout 30
-
-# Import the combined certificate and key
-#   there should already be a cert and key objects,
-#   but the -y option takes care of that
-spawn tpmtoken_import -y -p -n "$TCID" $TPM_COMBFILE
-expect -re "Enter PEM pass phrase:"
-send "$SSL_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp07.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp07.sh
deleted file mode 100755
index cf0a082a0..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp07.sh
+++ /dev/null
@@ -1,45 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set TPM_CERTFILE $env(TPM_CERTFILE)
-set TPM_KEYFILE $env(TPM_KEYFILE)
-set TPM_COMBFILE $env(TPM_COMBFILE)
-set SSL_PWD $env(SSL_PWD)
-set TCID $env(TCID)
-set timeout 30
-
-# Import the certificate
-#   there should already be a cert and key objects
-spawn tpmtoken_import -n "$TCID" $TPM_CERTFILE
-expect -re "Enter your TPM user password: "
-send "$P11_USER_PWD\n"
-# Replace the cert object
-expect -re "Import the object?"
-send "y\n"
-# Replace the key object (a cert has a public key)
-expect -re "Import the object?"
-send "y\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp08.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp08.sh
deleted file mode 100755
index 11ca85535..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/tpmtoken_import_tests_exp08.sh
+++ /dev/null
@@ -1,44 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set TPM_CERTFILE $env(TPM_CERTFILE)
-set TPM_KEYFILE $env(TPM_KEYFILE)
-set TPM_COMBFILE $env(TPM_COMBFILE)
-set SSL_PWD $env(SSL_PWD)
-set TCID $env(TCID)
-set timeout 30
-
-# Import the key
-#   there should already be a cert and key objects
-spawn tpmtoken_import -n "$TCID" $TPM_KEYFILE
-expect -re "Enter PEM pass phrase:"
-send "$SSL_PWD\n"
-expect -re "Enter your TPM user password: "
-send "$P11_USER_PWD\n"
-# Replace the key object
-expect -re "Import the object?"
-send "y\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/00_Descriptions.txt b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/00_Descriptions.txt
deleted file mode 100644
index 55ea2b77e..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/00_Descriptions.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-test01
-	tpmtoken_init initializes the PKCS#11 store
-test02
-	tpmtoken_init re-initializes the PKCS#11 store
-test03
-	tpmtoken_init re-initializes the PKCS#11 store with -y flag
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/Makefile b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/Makefile
deleted file mode 100644
index 81e84dd6d..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/tpm-tools/tpmtoken/tpmtoken_init testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests.sh
deleted file mode 100755
index 27317e55b..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests.sh
+++ /dev/null
@@ -1,160 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-setup()
-{
-	RC=0				# Return code from commands.
-
-	if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-	then
-		LTPTMP="/tmp"
-	else
-		LTPTMP="$TMPBASE"
-	fi
-
-	export TPM_TMPFILE="$LTPTMP/tst_tpm.err"
-	rm -f $TPM_TMPFILE 2>&1
-
-	# Set known password values
-	if [ -z "$OWN_PWD" ]
-	then
-		export OWN_PWD="OWN PWD"
-	fi
-	if [ -z "$SRK_PWD" ]
-	then
-		export SRK_PWD="SRK PWD"
-	fi
-	if [ -z "$P11_SO_PWD" ]
-	then
-		export P11_SO_PWD="P11 SO PWD"
-	fi
-	if [ -z "$P11_USER_PWD" ]
-	then
-		export P11_USER_PWD="P11 USER PWD"
-	fi
-
-	tst_resm TINFO "INIT: Inititalizing tests."
-
-	which tpmtoken_init 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: tpmtoken_init command does not exist. Reason:"
-		return $RC
-	fi
-
-	tpmtoken_init_tests_exp00.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: cannot set SRK password. Reason:"
-		return $RC
-	fi
-
-	return $RC
-}
-
-test01()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_init01	# Test ID
-	export TST_COUNT=1		# Test number
-
-	tpmtoken_init_tests_exp01.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_init' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_init' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test02()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_init02	# Test ID
-	export TST_COUNT=2		# Test number
-
-	tpmtoken_init_tests_exp02.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_init' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_init' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test03()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_init03	# Test ID
-	export TST_COUNT=3		# Test number
-
-	tpmtoken_init_tests_exp03.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_init -y' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_init -y' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-cleanup()
-{
-	rm -f $TPM_TMPFILE 2>&1
-}
-
-# Function:	main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:		- zero on success
-# 		- non-zero on failure.
-
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
-RC=0				# Return code from tests.
-
-export TCID=tpmtoken_init	# Test ID
-export TST_TOTAL=3		# Total numner of tests in this file.
-export TST_COUNT=0		# Initialize identifier
-
-if [ -n "$TPM_NOPKCS11" ]
-then
-	tst_resm TINFO "'tpmtoken_init' skipped."
-	exit $TFAILCNT
-fi
-
-setup || exit $RC		# Exit if initializing testcases fails.
-
-test01 || TFAILCNT=$(($TFAILCNT+1))
-test02 || TFAILCNT=$(($TFAILCNT+1))
-test03 || TFAILCNT=$(($TFAILCNT+1))
-
-cleanup
-
-exit $TFAILCNT
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp00.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp00.sh
deleted file mode 100755
index cf39e2e5d..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp00.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set OWN_PWD $env(OWN_PWD)
-set SRK_PWD $env(SRK_PWD)
-set timeout 30
-
-# Initiate the tpmtoken_init command
-#   this sets the SRK to a null password for use by the
-#   PKCS#11 TPM token
-spawn tpm_changeownerauth -s
-expect -re "Enter owner password: "
-send "$OWN_PWD\n"
-expect -re "Enter new SRK password: "
-send "\n"
-expect -re "Confirm password: "
-send "\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp01.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp01.sh
deleted file mode 100755
index 55fcd72a9..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp01.sh
+++ /dev/null
@@ -1,57 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set timeout 30
-
-# Initiate the tpmtoken_init command
-#   it should not have been initialized at this point
-#   if it has, it is an error
-spawn tpmtoken_init
-expect {
-	-re "Clear the TPM token data?" {
-		set reinit 1
-		send "n\n"
-	}
-	-re "A new TPM security officer password is needed." {
-		set reinit 0
-	}
-}
-
-if {$reinit == 0} {
-	expect -re "Enter new password: "
-	send "$P11_SO_PWD\n"
-	expect -re "Confirm password: "
-	send "$P11_SO_PWD\n"
-	expect -re "A new TPM user password is needed."
-	expect -re "Enter new password: "
-	send "$P11_USER_PWD\n"
-	expect -re "Confirm password: "
-	send "$P11_USER_PWD\n"
-}
-
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-if {$reinit == 1} { set rc 1 }
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp02.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp02.sh
deleted file mode 100755
index efe621ca0..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp02.sh
+++ /dev/null
@@ -1,60 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set timeout 30
-
-# Initiate the tpmtoken_init command
-#   it should have been initialized at this point
-#   if it has not, it is an error
-spawn tpmtoken_init
-expect {
-	-re "Clear the TPM token data?" {
-		set reinit 1
-		send "y\n"
-	}
-	-re "A new TPM security officer password is needed." {
-		set reinit 0
-		send "$P11_SO_PWD\n"
-	}
-}
-
-if {$reinit == 1} {
-	expect -re "Enter the TPM security officer password: "
-	send "$P11_SO_PWD\n"
-}
-expect -re "Enter new password: "
-send "$P11_SO_PWD\n"
-expect -re "Confirm password: "
-send "$P11_SO_PWD\n"
-expect -re "A new TPM user password is needed."
-expect -re "Enter new password: "
-send "$P11_USER_PWD\n"
-expect -re "Confirm password: "
-send "$P11_USER_PWD\n"
-
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-if {$reinit == 0} { set rc 1 }
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp03.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp03.sh
deleted file mode 100755
index 2a10e145f..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/tpmtoken_init_tests_exp03.sh
+++ /dev/null
@@ -1,55 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set timeout 30
-
-# Initiate the tpmtoken_init command
-#   it should have been initialized at this point
-#   if it has not, it is an error
-spawn tpmtoken_init -y
-expect {
-	-re "Enter the TPM security officer password: " {
-		set reinit 1
-		send "$P11_SO_PWD\n"
-	}
-	-re "A new TPM security officer password is needed." {
-		set reinit 0
-	}
-}
-
-expect -re "Enter new password: "
-send "$P11_SO_PWD\n"
-expect -re "Confirm password: "
-send "$P11_SO_PWD\n"
-expect -re "A new TPM user password is needed."
-expect -re "Enter new password: "
-send "$P11_USER_PWD\n"
-expect -re "Confirm password: "
-send "$P11_USER_PWD\n"
-
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-if {$reinit == 0} { set rc 1 }
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/00_Descriptions.txt b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/00_Descriptions.txt
deleted file mode 100644
index 432f3f9ca..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/00_Descriptions.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-test01
-	tpmtoken_objects display public and private objects
-test02
-	tpmtoken_objects display only public objects
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/Makefile b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/Makefile
deleted file mode 100644
index 9ebaf6be7..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/tpm-tools/tpmtoken/tpmtoken_objects testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/tpmtoken_objects_tests.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/tpmtoken_objects_tests.sh
deleted file mode 100755
index a856f3f56..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/tpmtoken_objects_tests.sh
+++ /dev/null
@@ -1,125 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-setup()
-{
-	RC=0				# Return code from commands.
-
-	if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-	then
-		LTPTMP="/tmp"
-	else
-		LTPTMP="$TMPBASE"
-	fi
-
-	export TPM_TMPFILE="$LTPTMP/tst_tpm.err"
-	rm -f $TPM_TMPFILE 2>&1
-
-	# Set known password values
-	if [ -z "$P11_SO_PWD" ]
-	then
-		export P11_SO_PWD="P11 SO PWD"
-	fi
-	if [ -z "$P11_USER_PWD" ]
-	then
-		export P11_USER_PWD="P11 USER PWD"
-	fi
-
-	tst_resm TINFO "INIT: Inititalizing tests."
-
-	which tpmtoken_objects 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: tpmtoken_objects command does not exist. Reason:"
-		return $RC
-	fi
-
-	return $RC
-}
-
-test01()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_objects01	# Test ID
-	export TST_COUNT=1		# Test number
-
-	tpmtoken_objects_tests_exp01.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_objects' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_objects' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test02()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_objects02	# Test ID
-	export TST_COUNT=2		# Test number
-
-	tpmtoken_objects -p 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_objects -p' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_objects -p' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-cleanup()
-{
-	rm -f $TPM_TMPFILE 2>&1
-}
-
-# Function:	main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:		- zero on success
-# 		- non-zero on failure.
-
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
-RC=0				# Return code from tests.
-
-export TCID=tpmtoken_objects	# Test ID
-export TST_TOTAL=2		# Total numner of tests in this file.
-export TST_COUNT=0		# Initialize identifier
-
-if [ -n "$TPM_NOPKCS11" ]
-then
-	tst_resm TINFO "'tpmtoken_objects' skipped."
-	exit $TFAILCNT
-fi
-
-setup || exit $RC		# Exit if initializing testcases fails.
-
-test01 || TFAILCNT=$(($TFAILCNT+1))
-test02 || TFAILCNT=$(($TFAILCNT+1))
-
-cleanup
-
-exit $TFAILCNT
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/tpmtoken_objects_tests_exp01.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/tpmtoken_objects_tests_exp01.sh
deleted file mode 100755
index 097071d7e..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/tpmtoken_objects_tests_exp01.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set timeout 30
-
-# Initiate the tpmtoken_objects command
-spawn tpmtoken_objects
-expect -re "Enter your TPM user password: "
-send "$P11_USER_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/00_Descriptions.txt b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/00_Descriptions.txt
deleted file mode 100644
index 08e7be614..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/00_Descriptions.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-test01
-	tpmtoken_protect encrypt a file
-test02
-	tpmtoken_protect decrypt a file
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/Makefile b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/Makefile
deleted file mode 100644
index 8d1ffae72..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/tpm-tools/tpmtoken/tpmtoken_protect testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_data.txt b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_data.txt
deleted file mode 100644
index 3d1c2856b..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_data.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_tests.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_tests.sh
deleted file mode 100755
index 9c413a678..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_tests.sh
+++ /dev/null
@@ -1,153 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-setup()
-{
-	RC=0				# Return code from commands.
-
-	if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-	then
-		LTPTMP="/tmp"
-	else
-		LTPTMP="$TMPBASE"
-	fi
-
-	export TPM_TMPFILE="$LTPTMP/tst_tpm.err"
-	rm -f $TPM_TMPFILE 2>&1
-
-	# Set the file to be protected and the related output files
-	export TPM_DATAFILE="$LTPBIN/tpmtoken_protect_data.txt"
-	export TPM_ENCDATA="$LTPTMP/tst_tpm_data.enc"
-	rm -f $TPM_ENCDATA 2>&1
-	export TPM_DECDATA="$LTPTMP/tst_tpm_data.dec"
-	rm -f $TPM_DECDATA 2>&1
-
-	# Set known password values
-	if [ -z "$P11_SO_PWD" ]
-	then
-		export P11_SO_PWD="P11 SO PWD"
-	fi
-	if [ -z "$P11_USER_PWD" ]
-	then
-		export P11_USER_PWD="P11 USER PWD"
-	fi
-
-	tst_resm TINFO "INIT: Inititalizing tests."
-
-	which tpmtoken_protect 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: tpmtoken_protect command does not exist. Reason:"
-		return $RC
-	fi
-
-	return $RC
-}
-
-test01()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_protect01	# Test ID
-	export TST_COUNT=1		# Test number
-
-	tpmtoken_protect_tests_exp01.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_protect -e -i $TPM_DATAFILE -o $TPM_ENCDATA' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_protect -e -i $TPM_DATAFILE -o $TPM_ENCDATA' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test02()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_protect02	# Test ID
-	export TST_COUNT=2		# Test number
-
-	tpmtoken_protect_tests_exp02.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_protect -d -i $TPM_ENCDATA -o $TPM_DECDATA' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_protect -d -i $TPM_ENCDATA -o $TPM_DECDATA' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test03()
-{
-	RC=0				# Return value from commands
-	export TCID=tpmtoken_protect03	# Test ID
-	export TST_COUNT=3		# Test number
-
-	diff $TPM_DATAFILE $TPM_DECDATA 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'diff $TPM_DATAFILE $TPM_DECDATA' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'diff $TPM_DATAFILE $TPM_DECDATA' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-cleanup()
-{
-	rm -f $TPM_TMPFILE 2>&1
-	rm -f $TPM_ENCDATA 2>&1
-	rm -f $TPM_DECDATA 2>&1
-}
-
-# Function:	main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:		- zero on success
-# 		- non-zero on failure.
-
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
-RC=0				# Return code from tests.
-
-export TCID=tpmtoken_protect	# Test ID
-export TST_TOTAL=3		# Total numner of tests in this file.
-export TST_COUNT=0		# Initialize identifier
-
-if [ -n "$TPM_NOPKCS11" ]
-then
-	tst_resm TINFO "'tpmtoken_protect' skipped."
-	exit $TFAILCNT
-fi
-
-setup || exit $RC		# Exit if initializing testcases fails.
-
-test01 || TFAILCNT=$(($TFAILCNT+1))
-test02 || TFAILCNT=$(($TFAILCNT+1))
-test03 || TFAILCNT=$(($TFAILCNT+1))
-
-cleanup
-
-exit $TFAILCNT
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_tests_exp01.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_tests_exp01.sh
deleted file mode 100755
index 03d456b99..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_tests_exp01.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set TPM_DATAFILE $env(TPM_DATAFILE)
-set TPM_ENCDATA $env(TPM_ENCDATA)
-set TPM_DECDATA $env(TPM_DECDATA)
-set timeout 30
-
-# Initiate the tpmtoken_protect command to encrypt the data
-spawn tpmtoken_protect -e -i $TPM_DATAFILE -o $TPM_ENCDATA
-expect -re "Enter your TPM user password: "
-send "$P11_USER_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_tests_exp02.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_tests_exp02.sh
deleted file mode 100755
index da205b6a0..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/tpmtoken_protect_tests_exp02.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set TPM_DATAFILE $env(TPM_DATAFILE)
-set TPM_ENCDATA $env(TPM_ENCDATA)
-set TPM_DECDATA $env(TPM_DECDATA)
-set timeout 30
-
-# Initiate the tpmtoken_protect command to decrypt the data
-spawn tpmtoken_protect -d -i $TPM_ENCDATA -o $TPM_DECDATA
-expect -re "Enter your TPM user password: "
-send "$P11_USER_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/00_Descriptions.txt b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/00_Descriptions.txt
deleted file mode 100644
index f834f4e01..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/00_Descriptions.txt
+++ /dev/null
@@ -1,8 +0,0 @@
-test01
-	tpmtoken_setpasswd change user password
-test02
-	tpmtoken_setpasswd change security officer password
-test03
-	tpmtoken_setpasswd reset user password
-test04
-	tpmtoken_setpasswd reset security officer password
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/Makefile b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/Makefile
deleted file mode 100644
index 1c85dc0d3..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/tpm-tools/tpmtoken/tpmtoken_setpasswd testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests.sh
deleted file mode 100755
index a2a59ec88..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests.sh
+++ /dev/null
@@ -1,171 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-setup()
-{
-	RC=0				# Return code from commands.
-
-	if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-	then
-		LTPTMP="/tmp"
-	else
-		LTPTMP="$TMPBASE"
-	fi
-
-	export TPM_TMPFILE="$LTPTMP/tst_tpm.err"
-	rm -f $TPM_TMPFILE 2>&1
-
-	# Set known password values
-	if [ -z "$P11_SO_PWD" ]
-	then
-		export P11_SO_PWD="P11 SO PWD"
-	fi
-	if [ -z "$NEW_P11_SO_PWD" ]
-	then
-		export NEW_P11_SO_PWD="NEW P11 SO PWD"
-	fi
-	if [ -z "$P11_USER_PWD" ]
-	then
-		export P11_USER_PWD="P11 USER PWD"
-	fi
-	if [ -z "$NEW_P11_USER_PWD" ]
-	then
-		export NEW_P11_USER_PWD="NEW P11 USER PWD"
-	fi
-
-	tst_resm TINFO "INIT: Inititalizing tests."
-
-	which tpmtoken_setpasswd 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $TPM_TMPFILE NULL \
-			"Setup: tpmtoken_setpasswd command does not exist. Reason:"
-		return $RC
-	fi
-
-	return $RC
-}
-
-test01()
-{
-	RC=0					# Return value from commands
-	export TCID=tpmtoken_setpasswd01	# Test ID
-	export TST_COUNT=1			# Test number
-
-	tpmtoken_setpasswd_tests_exp01.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_setpasswd' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_setpasswd' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test02()
-{
-	RC=0					# Return value from commands
-	export TCID=tpmtoken_setpasswd02	# Test ID
-	export TST_COUNT=2			# Test number
-
-	tpmtoken_setpasswd_tests_exp02.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_setpasswd --security-officer' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_setpasswd --security-officer' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test03()
-{
-	RC=0					# Return value from commands
-	export TCID=tpmtoken_setpasswd03	# Test ID
-	export TST_COUNT=3			# Test number
-
-	tpmtoken_setpasswd_tests_exp03.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_setpasswd' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_setpasswd' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-test04()
-{
-	RC=0					# Return value from commands
-	export TCID=tpmtoken_setpasswd04	# Test ID
-	export TST_COUNT=4			# Test number
-
-	tpmtoken_setpasswd_tests_exp04.sh 1>$TPM_TMPFILE 2>&1 || RC=$?
-	if [ $RC -eq 0 ]
-	then
-		tst_resm TPASS "'tpmtoken_setpasswd --security-officer' passed."
-		RC=0
-	else
-		tst_res TFAIL $TPM_TMPFILE "'tpmtoken_setpasswd --security-officer' failed."
-		RC=1
-	fi
-	return $RC
-}
-
-cleanup()
-{
-	rm -f $TPM_TMPFILE 2>&1
-}
-
-# Function:	main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:		- zero on success
-# 		- non-zero on failure.
-
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
-RC=0				# Return code from tests.
-
-export TCID=tpmtoken_setpasswd	# Test ID
-export TST_TOTAL=4		# Total numner of tests in this file.
-export TST_COUNT=0		# Initialize identifier
-
-if [ -n "$TPM_NOPKCS11" ]
-then
-	tst_resm TINFO "'tpmtoken_setpasswd' skipped."
-	exit $TFAILCNT
-fi
-
-setup || exit $RC		# Exit if initializing testcases fails.
-
-test01 || TFAILCNT=$(($TFAILCNT+1))
-test02 || TFAILCNT=$(($TFAILCNT+1))
-test03 || TFAILCNT=$(($TFAILCNT+1))
-test04 || TFAILCNT=$(($TFAILCNT+1))
-
-cleanup
-
-exit $TFAILCNT
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp01.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp01.sh
deleted file mode 100755
index 3d10e2fb2..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp01.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set NEW_P11_SO_PWD $env(NEW_P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set NEW_P11_USER_PWD $env(NEW_P11_USER_PWD)
-set timeout 30
-
-# Initiate the tpmtoken_setpasswd command
-spawn tpmtoken_setpasswd
-expect -re "Enter your TPM user password: "
-send "$P11_USER_PWD\n"
-expect -re "Enter new password: "
-send "$NEW_P11_USER_PWD\n"
-expect -re "Confirm password: "
-send "$NEW_P11_USER_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp02.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp02.sh
deleted file mode 100755
index 7ce31928f..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp02.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set NEW_P11_SO_PWD $env(NEW_P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set NEW_P11_USER_PWD $env(NEW_P11_USER_PWD)
-set timeout 30
-
-# Initiate the tpmtoken_setpasswd --security-officer command
-spawn tpmtoken_setpasswd --security-officer
-expect -re "Enter the TPM security officer password: "
-send "$P11_SO_PWD\n"
-expect -re "Enter new password: "
-send "$NEW_P11_SO_PWD\n"
-expect -re "Confirm password: "
-send "$NEW_P11_SO_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp03.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp03.sh
deleted file mode 100755
index e0122388c..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp03.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set NEW_P11_SO_PWD $env(NEW_P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set NEW_P11_USER_PWD $env(NEW_P11_USER_PWD)
-set timeout 30
-
-# Initiate the tpmtoken_setpasswd command
-spawn tpmtoken_setpasswd
-expect -re "Enter your TPM user password: "
-send "$NEW_P11_USER_PWD\n"
-expect -re "Enter new password: "
-send "$P11_USER_PWD\n"
-expect -re "Confirm password: "
-send "$P11_USER_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp04.sh b/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp04.sh
deleted file mode 100755
index 8dd829b42..000000000
--- a/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/tpmtoken_setpasswd_tests_exp04.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#! /usr/bin/expect -f
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-set P11_SO_PWD $env(P11_SO_PWD)
-set NEW_P11_SO_PWD $env(NEW_P11_SO_PWD)
-set P11_USER_PWD $env(P11_USER_PWD)
-set NEW_P11_USER_PWD $env(NEW_P11_USER_PWD)
-set timeout 30
-
-# Initiate the tpmtoken_setpasswd --security-officer command
-spawn tpmtoken_setpasswd --security-officer
-expect -re "Enter the TPM security officer password: "
-send "$NEW_P11_SO_PWD\n"
-expect -re "Enter new password: "
-send "$P11_SO_PWD\n"
-expect -re "Confirm password: "
-send "$P11_SO_PWD\n"
-expect timeout
-
-set rc_list [wait -i $spawn_id]
-set rc [lindex $rc_list {3}]
-
-exit $rc
diff --git a/testcases/commands/unshare/Makefile b/testcases/commands/unshare/Makefile
deleted file mode 100644
index a17529145..000000000
--- a/testcases/commands/unshare/Makefile
+++ /dev/null
@@ -1,22 +0,0 @@
-#
-# Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
-# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= unshare01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/unshare/unshare01.sh b/testcases/commands/unshare/unshare01.sh
deleted file mode 100755
index 71b50ba3a..000000000
--- a/testcases/commands/unshare/unshare01.sh
+++ /dev/null
@@ -1,171 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
-# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
-# Test unshare command with some basic options.
-# 1) If we run unshare with "--user", UID in the newly created user namespace
-#    is set to 65534.
-# 2) If we run unshare with "--user", GID in the newly created user namespace
-#    is set to 65534.
-# 3) If we run with "--user --map-root-user", UID in the newly created user
-#    namespace is set to 0.
-# 4) If we run with "--user --map-root-user", GID in the newly created user
-#    is set to 0.
-# 5) If we run with "--mount", mount and unmount events do not propagate to
-#    its parent mount namespace.
-# 6) If we run with "--mount --propagation shared", mount and unmount events
-#    propagate to its parent mount namespace.
-# 7) If we run with "--user --map-root-user --mount", mount and unmount events
-#    do not propagate to its parent mount namespace.
-# 8) Even if we run with "--user --map-root-user --mount --propagation shared",
-#    mount and unmount events do not propagate to its parent mount namespace
-#    because the shared mount is reduced to a slave mount.
-#
-#    Please see the following URL for detailed information:
-#    http://man7.org/linux/man-pages/man7/user_namespaces.7.html
-#    http://man7.org/linux/man-pages/man7/mount_namespaces.7.html
-#
-
-TST_CNT=8
-TST_SETUP=setup
-TST_CLEANUP=cleanup
-TST_TESTFUNC=do_test
-TST_NEEDS_ROOT=1
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="unshare id mount umount"
-. tst_test.sh
-
-max_userns_path="/proc/sys/user/max_user_namespaces"
-max_mntns_path="/proc/sys/user/max_mnt_namespaces"
-default_max_userns=-1
-default_max_mntns=-1
-
-setup()
-{
-	# On some distributions(e.g RHEL7.4), the default value of
-	# max_user_namespaces or max_mnt_namespaces is set to 0.
-	# We need to change the default value to run unshare command.
-	if [ -f "${max_userns_path}" ]; then
-		default_max_userns=$(cat "${max_userns_path}")
-		echo 1024 > "${max_userns_path}"
-	fi
-
-	if [ -f "${max_mntns_path}" ]; then
-		default_max_mntns=$(cat "${max_mntns_path}")
-		echo 1024 > "${max_mntns_path}"
-	fi
-
-	mkdir -p dir_A dir_B
-	touch dir_A/A dir_B/B
-}
-
-cleanup()
-{
-	# Restore the default value to 0.
-	[ ${default_max_userns} -ne -1 ] && \
-		echo ${default_max_userns} > "${max_userns_path}"
-	[ ${default_max_mntns} -ne -1 ] && \
-		echo ${default_max_mntns} > "${max_mntns_path}"
-}
-
-check_id()
-{
-	local act_id=$1
-	local exp_id=$2
-	local cmd=$3
-
-	if [ ${act_id} -ne ${exp_id} ]; then
-		tst_res TFAIL "$cmd got wrong uid/gid"
-	else
-		tst_res TPASS "$cmd got correct uid/gid"
-	fi
-}
-
-check_mount()
-{
-	local tst_dir=$1
-	local exp_stat=$2
-	local cmd=$3
-
-	case ${exp_stat} in
-	unmounted)
-		if ls "${tst_dir}" | grep -qw 'A'; then
-			tst_res TFAIL "$cmd got bind info"
-			umount ${tst_dir}
-			return
-		fi
-		;;
-	mounted)
-		if ! ls "${tst_dir}" | grep -qw 'A'; then
-			tst_res TFAIL "$cmd did not get bind info"
-			return
-		fi
-		umount ${tst_dir}
-		;;
-	esac
-
-	tst_res TPASS "$cmd got bind info as expected"
-}
-
-unshare_test()
-{
-	local unshare_opts=$1
-	local verify_cmd=$2
-	local exp_result=$3
-
-	local unshare_cmd="unshare ${unshare_opts} ${verify_cmd}"
-
-	eval ${unshare_cmd} > temp 2>&1
-	if [ $? -ne 0 ]; then
-		# unrecognized option or invalid option is returned if the
-		# option is not supported by unshare command(e.g. RHEL6).
-		# Invalid argument or Operation not permitted is returned
-		# if the feature is not supported by kernel(e.g. RHEL7).
-		grep -q -E "unrecognized option|invalid option|Invalid argument|Operation not permitted" temp
-		if [ $? -eq 0 ]; then
-			tst_res TCONF "${unshare_cmd} not supported."
-		else
-			tst_res TFAIL "${unshare_cmd} failed."
-		fi
-		return
-	fi
-
-	case ${verify_cmd} in
-	id*)
-		check_id "$(cat temp)" "${exp_result}" "${unshare_cmd}"
-		;;
-	mount*)
-		check_mount "dir_B" "${exp_result}" "${unshare_cmd}"
-		;;
-	esac
-}
-
-do_test()
-{
-	case $1 in
-	1) unshare_test "--user" "id -u" "65534";;
-	2) unshare_test "--user" "id -g" "65534";;
-	3) unshare_test "--user --map-root-user" "id -u" "0";;
-	4) unshare_test "--user --map-root-user" "id -g" "0";;
-	5) unshare_test "--mount" "mount --bind dir_A dir_B" "unmounted";;
-	6) unshare_test "--mount --propagation shared" \
-			"mount --bind dir_A dir_B" "mounted";;
-	7) unshare_test "--user --map-root-user --mount" \
-			"mount --bind dir_A dir_B" "unmounted";;
-	8) unshare_test "--user --map-root-user --mount --propagation shared" \
-			"mount --bind dir_A dir_B" "unmounted";;
-	esac
-}
-
-tst_run
diff --git a/testcases/commands/unzip/Makefile b/testcases/commands/unzip/Makefile
deleted file mode 100644
index 72ac803c1..000000000
--- a/testcases/commands/unzip/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    commands/unzip testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= unzip01.sh
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/unzip/datafiles/Makefile b/testcases/commands/unzip/datafiles/Makefile
deleted file mode 100644
index 1b993f61a..000000000
--- a/testcases/commands/unzip/datafiles/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-#    Copyright (C) 2016, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-INSTALL_DIR		:= testcases/data/unzip01
-INSTALL_TARGETS		:= test.zip dir.out
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/unzip/datafiles/dir.out b/testcases/commands/unzip/datafiles/dir.out
deleted file mode 100644
index 64f27d404..000000000
--- a/testcases/commands/unzip/datafiles/dir.out
+++ /dev/null
@@ -1,16 +0,0 @@
-dir/d1
-dir/d1/f1
-dir/d1/f2
-dir/d1/f3
-dir/d2
-dir/d2/d1
-dir/d2/d2
-dir/d2/d3
-dir/d2/f1
-dir/d2/f2
-dir/d2/f3
-dir/d3
-dir/d3/d1
-dir/d3/d2
-dir/d3/d3
-dir/d4
diff --git a/testcases/commands/unzip/datafiles/test.zip b/testcases/commands/unzip/datafiles/test.zip
deleted file mode 100644
index 835331a0d5dd80dadd40603c1c4c9f1450dcee90..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 2544
zcmbuByGjE=6ozNrjUg*&QYb1SMnq7Mkd3#-fOZm#6cGY~)hcMI5$wd)!iNxRpTVa{
zp)a6C1TU?Zb9QETPG)9z6O(Y3ZO+G;|DW?G^_uOt3_nw?gWcdoJRCN|{FAfNej~^1
z_s>G}73$)0gjvpu%~<fLN8R&EcUE-!We)g-=1vk|B@W<mz{FRf`IZFOiUU+QU_A|>
z3J@J(Rce4b#A;B437$8K?Hnk`iz^5k9G3$bzo8vVLF_f^bFHKEmMis4VtE1U2RK;i
zEc7OBu1df{cd*h~ONz>F=(AS}tsVuTu@sm*+j0U!xIG5_SpQ-O!}HLO70XzN)5Qz@
zvY{PIK^XkP>ub~)Slq91;9w2L;(p;WV5PIvt%&@pM1HLS2up!UzmgcjuYnk3L2*g7
zIjo^sJ1(OpMOx)qXB%I6Vr6(@C6M&IqNJ)I1y>qihTW*w<XC!kQP@=oL#+U2Fpk1h
zwX=-E9zz(42CzN_>xNkt7tF_mOV>=#Bt98X*!}fR2;*r7I78CWgC^r{2@VzraE7p>
zI6dX)bWa2aI|R5CPxYXqHY^Sa<wWcO&lq{~j_9FBd8dRYu8A@JdgVP3p13K-D3m-s
z45@q{l7~NKa9l$yQaAKGq_`^lfxu1mc{&2lkc_?KZU~N>+vkqCT|3qeaUvsOJYzme
l@zkB|=1n`|w7?VQ4#YboyrdY&48vlw0(>_!jNL&OV}DgjzNi2I

diff --git a/testcases/commands/unzip/unzip01.sh b/testcases/commands/unzip/unzip01.sh
deleted file mode 100755
index 532afc0ce..000000000
--- a/testcases/commands/unzip/unzip01.sh
+++ /dev/null
@@ -1,98 +0,0 @@
-#! /bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author:        Manoj Iyer, manjo@mail.utexas.edu                          ##
-## Copyright (c) Cyril Hrubis <chrubis@suse.cz>                               ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
-#
-# Tests basic functionality of unzip command.
-#
-
-TST_SETUP=setup
-TST_TESTFUNC=do_test
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="unzip"
-. tst_test.sh
-
-setup()
-{
-	cat > unzip_exp.out <<EOF
-Archive:  $TST_DATAROOT/test.zip
-   creating: dir/
-   creating: dir/d1/
-   creating: dir/d2/
-   creating: dir/d3/
-   creating: dir/d4/
- extracting: dir/d1/f1
- extracting: dir/d1/f2
- extracting: dir/d1/f3
-   creating: dir/d2/d1/
-   creating: dir/d2/d2/
-   creating: dir/d2/d3/
- extracting: dir/d2/f1
- extracting: dir/d2/f2
- extracting: dir/d2/f3
-   creating: dir/d3/d1/
-   creating: dir/d3/d2/
-   creating: dir/d3/d3/
-EOF
-}
-
-stable_ls()
-{
-	local i
-
-	for i in $(echo "$1/*" | sort); do
-
-		if ! [ -e "$i" ]; then
-			return
-		fi
-
-		echo "$i"
-
-		if [ -d "$i" ]; then
-			stable_ls "$i"
-		fi
-	done
-}
-
-do_test()
-{
-	EXPECT_PASS unzip "$TST_DATAROOT/test.zip" \> unzip.out
-
-	if diff -w unzip_exp.out unzip.out; then
-		tst_res TPASS "Unzip output is correct"
-	else
-		tst_res TFAIL "Unzip output is incorrect"
-		cat unzip.out
-	fi
-
-	stable_ls "dir" > dir.out
-
-	if diff "$TST_DATAROOT/dir.out" dir.out; then
-		tst_res TPASS "Files unzipped correctly"
-	else
-		tst_res TFAIL "Files unzipped incorrectly"
-		cat dir.out
-	fi
-
-	ROD rm -rf "dir/"
-}
-
-tst_run
diff --git a/testcases/commands/wc/Makefile b/testcases/commands/wc/Makefile
deleted file mode 100644
index 6571074a9..000000000
--- a/testcases/commands/wc/Makefile
+++ /dev/null
@@ -1,22 +0,0 @@
-#
-#    Copyright (c) 2016 Fujitsu Ltd.
-#    Author:Xiao Yang <yangx.jy@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= wc01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/wc/wc01.sh b/testcases/commands/wc/wc01.sh
deleted file mode 100755
index e72819c51..000000000
--- a/testcases/commands/wc/wc01.sh
+++ /dev/null
@@ -1,81 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2016 Fujitsu Ltd.
-# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
-# Test wc command with some basic options.
-#
-
-TST_CNT=12
-TST_SETUP=setup
-TST_TESTFUNC=do_test
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="wc"
-. tst_test.sh
-
-setup()
-{
-	echo "hello world" > ltp_wc
-
-	echo "This is a test" >> ltp_wc
-}
-
-wc_test()
-{
-	local wc_opt=$1
-	local wc_file=$2
-	local std_out=$3
-
-	local wc_cmd="wc $wc_opt $wc_file"
-
-	eval $wc_cmd > temp 2>&1
-	if [ $? -ne 0 ]; then
-		grep -q -E "unknown option|invalid option" temp
-		if [ $? -eq 0 ]; then
-			tst_res TCONF "$wc_cmd not supported."
-		else
-			tst_res TFAIL "$wc_cmd failed."
-		fi
-		return
-	fi
-
-	if [ $# -gt 1 ]; then
-		local act_out=`cat temp | awk '{printf $1}'`
-		if [ $act_out -ne $std_out ]; then
-			tst_res TFAIL "$wc_cmd got mismatched data."
-			return
-		fi
-	fi
-
-	tst_res TPASS "wc passed with $wc_opt option."
-}
-
-do_test()
-{
-	case $1 in
-	1) wc_test "-c" ltp_wc 27;;
-	2) wc_test "--bytes" ltp_wc 27;;
-	3) wc_test "-l" ltp_wc 2;;
-	4) wc_test "--lines" ltp_wc 2;;
-	5) wc_test "-L" ltp_wc 14;;
-	6) wc_test "--max-line-length" ltp_wc 14;;
-	7) wc_test "-w" ltp_wc 6;;
-	8) wc_test "--words" ltp_wc 6;;
-	9) wc_test "-m" ltp_wc 27;;
-	10) wc_test "--chars" ltp_wc 27;;
-	11) wc_test "--help";;
-	12) wc_test "--version";;
-	esac
-}
-
-tst_run
diff --git a/testcases/commands/which/Makefile b/testcases/commands/which/Makefile
deleted file mode 100644
index d9b4d1299..000000000
--- a/testcases/commands/which/Makefile
+++ /dev/null
@@ -1,22 +0,0 @@
-#
-#    Copyright (c) 2015 Fujitsu Ltd.
-#    Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= which01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/which/which01.sh b/testcases/commands/which/which01.sh
deleted file mode 100755
index 0bd698ed9..000000000
--- a/testcases/commands/which/which01.sh
+++ /dev/null
@@ -1,118 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2015 Fujitsu Ltd.
-# Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
-# Test which command with some basic options.
-#
-
-TST_CNT=10
-TST_SETUP=setup
-TST_TESTFUNC=do_test
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="which"
-. tst_test.sh
-
-setup()
-{
-	touch pname
-	chmod +x pname
-	PATH=$PATH:.
-
-	mkdir bin
-	touch bin/pname
-	chmod +x bin/pname
-	PATH=$PATH:./bin
-
-	alias pname='pname -i'
-}
-
-which_verify()
-{
-	local IFS i j
-	IFS="$IFS_FIRST_LEVEL"
-	for i in $1; do
-		found="no"
-		IFS="$IFS_SECOND_LEVEL"
-		for j in $i; do
-			if grep -F -q "$j" temp; then
-				found="yes"
-			fi
-		done
-		if [ "$found" != "yes" ]; then
-			echo "'$i' not found in:"
-			cat temp
-			echo
-			return 1
-		fi
-	done
-}
-
-which_test()
-{
-	local which_op=$1
-	local prog_name=$2
-
-	local which_cmd="which $which_op $prog_name"
-
-	if [ "$which_op" = "--read-alias" ] || [ "$which_op" = "-i" ] || \
-		[ "$which_op" = "--skip-alias" ]; then
-		which_cmd="alias | $which_cmd"
-	fi
-
-	eval ${which_cmd} >temp 2>&1
-	if [ $? -ne 0 ]; then
-		grep -q -E "unknown option|invalid option|Usage" temp
-		if [ $? -eq 0 ]; then
-			tst_res TCONF "'${which_cmd}' not supported."
-			return
-		fi
-
-		tst_res TFAIL "'${which_cmd}' failed."
-		cat temp
-		return
-	fi
-
-	if [ $# -gt 2 ]; then
-		shift 2
-		which_verify "$@"
-		if [ $? -ne 0 ]; then
-			tst_res TFAIL "'${which_cmd}' failed, not expected."
-			return
-		fi
-	fi
-
-	tst_res TPASS "'${which_cmd}' passed."
-}
-
-IFS_FIRST_LEVEL='^'
-IFS_SECOND_LEVEL='|'
-do_test()
-{
-	case $1 in
-	1) which_test "" "pname" "$PWD/pname|./pname";;
-	2) which_test "-all" "pname" "$PWD/bin/pname|./bin/pname^$PWD/pname|./pname";;
-	3) which_test "-a" "pname" "$PWD/bin/pname|./bin/pname^$PWD/pname|./pname";;
-	4) which_test "--read-alias" "pname" "pname='pname -i'^$PWD/pname";;
-	5) which_test "-i" "pname" "pname='pname -i'^$PWD/pname";;
-	6) alias which='which --read-alias';
-	   which_test "--skip-alias" "pname" "$PWD/pname";
-	   unalias which;;
-	7) which_test "--version";;
-	8) which_test "-v";;
-	9) which_test "-V";;
-	10) which_test "--help";;
-	esac
-}
-
-tst_run
-- 
2.13.6

