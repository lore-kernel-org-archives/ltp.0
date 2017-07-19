From: fixed-term.Islam.Tammam <fixed-term.Islam.Tammam@de.bosch.com>
Date: Wed, 19 Jul 2017 19:44:11 +0200
Subject: [LTP] Build error for LTP project
Message-ID: <c8ced4c0-637a-3b95-d5e8-5c521b866dba@de.bosch.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ltp mailing list,

1. i am trying to build ltp for my ARM target , however i have faced the 
following errors:

2. Also please find the following files attached
i.   include/config.h
ii.  include/mk/config.mk
iii. config.log

tai1hi@HI-Z0EMX:~/Git_Repos/ltp_git$ make -j8
make -C "lib" \
		-f "/home/tai1hi/Git_Repos/ltp_git/lib/Makefile" all
if git describe >/dev/null 2>&1; then \
		git describe > "Version"; \
	else \
		cp /home/tai1hi/Git_Repos/ltp_git/VERSION "Version"; \
	fi
make[1]: Entering directory `/home/tai1hi/Git_Repos/ltp_git/lib'
make[2]: Entering directory 
`/home/tai1hi/Git_Repos/ltp_git/lib/newlib_tests'
arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe 
-Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2 
-I../../include -I../../include -I../../include/old/   -L../../lib 
test01.c   -lltp -o test01
arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe 
-Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2 
-I../../include -I../../include -I../../include/old/   -L../../lib 
test02.c   -lltp -o test02
arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe 
-Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2 
-I../../include -I../../include -I../../include/old/   -L../../lib 
test03.c   -lltp -o test03
arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe 
-Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2 
-I../../include -I../../include -I../../include/old/   -L../../lib 
test04.c   -lltp -o test04
arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe 
-Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2 
-I../../include -I../../include -I../../include/old/   -L../../lib 
test05.c   -lltp -o test05
arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe 
-Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2 
-I../../include -I../../include -I../../include/old/   -L../../lib 
test06.c   -lltp -o test06
arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe 
-Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2 
-I../../include -I../../include -I../../include/old/   -L../../lib 
test07.c   -lltp -o test07
arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe 
-Wall -W -Wold-style-definition -W -Wall -pthread -D_FORTIFY_SOURCE=2 
-I../../include -I../../include -I../../include/old/   -L../../lib 
test08.c   -lltp -o test08
/tmp/cc0cEnWR.o: In function `do_test':
/home/tai1hi/Git_Repos/ltp_git/lib/newlib_tests/test01.c:29: undefined 
reference to `tst_exit'
../../lib/libltp.a(tst_test.o): In function `print_result':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:213: undefined reference 
to `tst_color_enabled'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:214: undefined reference 
to `tst_ttype2color'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:204: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:207: undefined reference 
to `tst_strerrno'
../../lib/libltp.a(tst_test.o): In function `snprintf':
/opt/tooling/codesourcery/MGC-2014.05-74-arm-gcc-4.8.3/Sourcery_CodeBench_for_ARM_Embedded/arm-none-linux-gnueabi/libc/usr/include/bits/stdio2.h:64: 
undefined reference to `TEST_ERRNO'
../../lib/libltp.a(tst_test.o): In function `do_cleanup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:755: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:758: undefined reference 
to `tst_rmdir'
../../lib/libltp.a(tst_test.o): In function `cleanup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:118: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `tst_reinit':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_max_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `check_child_status':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:311: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `setup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:82: undefined reference to 
`tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:83: undefined reference to 
`tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:85: undefined reference to 
`tst_get_tmpdir'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:696: undefined reference 
to `tst_tmpdir_created'
../../lib/libltp.a(tst_test.o): In function `copy_resources':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:617: undefined reference 
to `tst_resource_copy'
../../lib/libltp.a(tst_test.o): In function `tst_run_tcases':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:935: undefined reference 
to `safe_setpgid'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:953: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:697: undefined reference 
to `tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:713: undefined reference 
to `tst_mkfs_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:710: undefined reference 
to `tst_dev_fs_type'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_max_futexes'
../../lib/libltp.a(safe_macros.o): In function `safe_basename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:28: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chdir':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:44: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_close':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:60: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_creat':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:76: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_dirname':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:91: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:106: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_sysconf':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:537: undefined 
reference to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:533: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:555: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:571: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:587: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:603: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:618: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_kill':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mkfifo':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:678: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_rename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:694: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:712: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:729: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:745: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:213: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:257: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:261: undefined reference 
to `tst_fill_file'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:82: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:248: undefined reference 
to `tst_fill_file'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:249: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:98: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:120: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:116: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:221: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o):/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:128: 
more undefined references to `tst_resm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device_':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:286: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:282: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:287: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:295: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_device.o): In function `detach_device':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:195: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:169: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:336: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:343: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvcmp':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:87: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvercmp2':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:161: undefined 
reference to `tst_resm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_check':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:68: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:62: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_start':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:77: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_stop':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:83: undefined reference 
to `tst_resm_'
collect2: error: ld returned 1 exit status
make[2]: *** [test01] Error 1
make[2]: *** Waiting for unfinished jobs....
/tmp/ccN4NuHR.o: In function `do_test':
/home/tai1hi/Git_Repos/ltp_git/lib/newlib_tests/test02.c:40: undefined 
reference to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/newlib_tests/test02.c:36: undefined 
reference to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/newlib_tests/test02.c:37: undefined 
reference to `tst_resm_'
../../lib/libltp.a(tst_test.o): In function `print_result':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:213: undefined reference 
to `tst_color_enabled'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:214: undefined reference 
to `tst_ttype2color'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:204: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:207: undefined reference 
to `tst_strerrno'
../../lib/libltp.a(tst_test.o): In function `snprintf':
/opt/tooling/codesourcery/MGC-2014.05-74-arm-gcc-4.8.3/Sourcery_CodeBench_for_ARM_Embedded/arm-none-linux-gnueabi/libc/usr/include/bits/stdio2.h:64: 
undefined reference to `TEST_ERRNO'
../../lib/libltp.a(tst_test.o): In function `do_cleanup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:755: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:758: undefined reference 
to `tst_rmdir'
../../lib/libltp.a(tst_test.o): In function `cleanup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:118: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `tst_reinit':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_max_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `check_child_status':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:311: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `setup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:82: undefined reference to 
`tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:83: undefined reference to 
`tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:85: undefined reference to 
`tst_get_tmpdir'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:696: undefined reference 
to `tst_tmpdir_created'
../../lib/libltp.a(tst_test.o): In function `copy_resources':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:617: undefined reference 
to `tst_resource_copy'
../../lib/libltp.a(tst_test.o): In function `tst_run_tcases':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:935: undefined reference 
to `safe_setpgid'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:953: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:697: undefined reference 
to `tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:713: undefined reference 
to `tst_mkfs_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:710: undefined reference 
to `tst_dev_fs_type'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_max_futexes'
../../lib/libltp.a(safe_macros.o): In function `safe_basename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:28: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chdir':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:44: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_close':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:60: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_creat':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:76: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_dirname':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:91: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:106: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_sysconf':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:537: undefined 
reference to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:533: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:555: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:571: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:587: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:603: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:618: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_kill':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mkfifo':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:678: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_rename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:694: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:712: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:729: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:745: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:213: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:257: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:261: undefined reference 
to `tst_fill_file'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:82: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:248: undefined reference 
to `tst_fill_file'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:249: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:98: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:120: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:116: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:221: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o):/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:128: 
more undefined references to `tst_resm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device_':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:286: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:282: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:287: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:295: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_device.o): In function `detach_device':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:195: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:169: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:336: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:343: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvcmp':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:87: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvercmp2':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:161: undefined 
reference to `tst_resm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_check':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:68: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:62: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_start':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:77: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_stop':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:83: undefined reference 
to `tst_resm_'
collect2: error: ld returned 1 exit status
make[2]: *** [test02] Error 1
../../lib/libltp.a(safe_macros.o): In function `safe_basename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:28: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chdir':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:44: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_close':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:60: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_creat':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:76: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_dirname':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:91: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:106: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_sysconf':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:537: undefined 
reference to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:533: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:555: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:571: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:587: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:603: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:618: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_kill':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mkfifo':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:678: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_rename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:694: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:712: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:729: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:745: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(tst_test.o): In function `print_result':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:213: undefined reference 
to `tst_color_enabled'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:214: undefined reference 
to `tst_ttype2color'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:204: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:207: undefined reference 
to `tst_strerrno'
../../lib/libltp.a(tst_test.o): In function `snprintf':
/opt/tooling/codesourcery/MGC-2014.05-74-arm-gcc-4.8.3/Sourcery_CodeBench_for_ARM_Embedded/arm-none-linux-gnueabi/libc/usr/include/bits/stdio2.h:64: 
undefined reference to `TEST_ERRNO'
../../lib/libltp.a(tst_test.o): In function `do_cleanup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:755: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:758: undefined reference 
to `tst_rmdir'
../../lib/libltp.a(tst_test.o): In function `cleanup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:118: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `tst_reinit':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_max_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `check_child_status':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:311: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `setup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:82: undefined reference to 
`tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:83: undefined reference to 
`tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:85: undefined reference to 
`tst_get_tmpdir'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:696: undefined reference 
to `tst_tmpdir_created'
../../lib/libltp.a(tst_test.o): In function `copy_resources':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:617: undefined reference 
to `tst_resource_copy'
../../lib/libltp.a(tst_test.o): In function `tst_run_tcases':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:935: undefined reference 
to `safe_setpgid'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:953: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:697: undefined reference 
to `tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:713: undefined reference 
to `tst_mkfs_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:710: undefined reference 
to `tst_dev_fs_type'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_max_futexes'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:213: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:257: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:261: undefined reference 
to `tst_fill_file'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:82: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:248: undefined reference 
to `tst_fill_file'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:249: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:98: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:120: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:116: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:221: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o):/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:128: 
more undefined references to `tst_resm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device_':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:286: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:282: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:287: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:295: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_device.o): In function `detach_device':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:195: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:169: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:336: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:343: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvcmp':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:87: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvercmp2':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:161: undefined 
reference to `tst_resm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_check':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:68: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:62: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_start':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:77: undefined reference 
to `tst_resm_'
....//....//liblib//libltp.alibltp.a((tst_test.o)tst_timer.o:) :In 
Infunction  function` print_result`':tst_timer_stop
'/:home/
tai1hi//homeGit_Repos//tai1hiltp_git//Git_Reposlib//ltp_gittst_test.c/:lib213/: 
tst_timer.cundefined: 83reference:  to undefined` 
tst_color_enabled'reference
  /tohome /`tai1hitst_resm_/'Git_Repos/
ltp_git/lib/tst_test.c:214: undefined reference to `tst_ttype2color'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:204: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/collect2: error: ld returned 1 exit 
status
tst_test.c:207: undefined reference to `tst_strerrno'
../../lib/libltp.a(tst_test.o): In function `snprintf':
/opt/tooling/codesourcery/MGC-2014.05-74-arm-gcc-4.8.3/Sourcery_CodeBench_for_ARM_Embedded/arm-none-linux-gnueabi/libc/usr/include/bits/stdio2.h:64: 
undefined reference to `TEST_ERRNO'
../../lib/libltp.a(tst_test.o): In function `do_cleanup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:755: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:758: undefined reference 
to `tst_rmdir'
../../lib/libltp.a(tst_test.o): In function `cleanup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:118: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `tst_reinit':
/home/tai1hi/Git_Repos/ltp_git/make[2]: lib/tst_test.c*** [test03] Error 
1:135
: undefined reference to `tst_max_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `check_child_status':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:311: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `setup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:82: undefined reference to 
`tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:83: undefined reference to 
`tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:85: undefined reference to 
`tst_get_tmpdir'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:696: undefined reference 
to `tst_tmpdir_created'
../../lib/libltp.a(tst_test.o): In function `copy_resources':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:617: undefined reference 
to `tst_resource_copy'
../../lib/libltp.a(tst_test.o): In function `tst_run_tcases':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:935: undefined reference 
to `safe_setpgid'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:953: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:697: undefined reference 
to `tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:713: undefined reference 
to `tst_mkfs_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:710: undefined reference 
to `tst_dev_fs_type'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_max_futexes'
../../lib/libltp.a(safe_macros.o): In function `safe_basename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:28: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chdir':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:44: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_close':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:60: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_creat':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:76: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_dirname':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:91: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:106: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_sysconf':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:537: undefined 
reference to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:533: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:555: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:571: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:587: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:603: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:618: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_kill':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mkfifo':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:678: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_rename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:694: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:712: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:729: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:745: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:213: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:257: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:261: undefined reference 
to `tst_fill_file'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:82: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:248: undefined reference 
to `tst_fill_file'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:249: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:98: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:120: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:116: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:221: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o):/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:128: 
more undefined references to `tst_resm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device_':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:286: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:282: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:287: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:295: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_device.o): In function `detach_device':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:195: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:169: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:336: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:343: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvcmp':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:87: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvercmp2':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:161: undefined 
reference to `tst_resm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_check':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:68: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:62: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_start':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:77: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_stop':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:83: undefined reference 
to `tst_resm_'
collect2: error: ld returned 1 exit status
../../lib/libltp.a(tst_test.o): In function `print_result':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:213: undefined reference 
to `tst_color_enabled'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:214: undefined reference 
to `tst_ttype2colormake[2]: '
/home*** [test04] Error 1/tai1hi
/Git_Repos/ltp_git/lib/tst_test.c:204: undefined reference to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:207: undefined reference 
to `tst_strerrno'
../../lib/libltp.a(tst_test.o): In function `snprintf':
/opt/tooling/codesourcery/MGC-2014.05-74-arm-gcc-4.8.3/Sourcery_CodeBench_for_ARM_Embedded/arm-none-linux-gnueabi/libc/usr/include/bits/stdio2.h:64: 
undefined reference to `TEST_ERRNO'
../../lib/libltp.a(tst_test.o): In function `do_cleanup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:755: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:758: undefined reference 
to `tst_rmdir'
../../lib/libltp.a(tst_test.o): In function `cleanup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:118: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `tst_reinit':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_max_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `check_child_status':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:311: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `setup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:82: undefined reference to 
`tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:83: undefined reference to 
`tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:85: undefined reference to 
`tst_get_tmpdir'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:696: undefined reference 
to `tst_tmpdir_created'
../../lib/libltp.a(tst_test.o): In function `copy_resources':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:617: undefined reference 
to `tst_resource_copy'
../../lib/libltp.a(tst_test.o): In function `tst_run_tcases':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:935: undefined reference 
to `safe_setpgid'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:953: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:697: undefined reference 
to `tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:713: undefined reference 
to `tst_mkfs_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:710: undefined reference 
to `tst_dev_fs_type'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_max_futexes'
../../lib/libltp.a(safe_macros.o): In function `safe_basename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:28: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chdir':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:44: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_close':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:60: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_creat':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:76: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_dirname':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:91: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:106: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_sysconf':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:537: undefined 
reference to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:533: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:555: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:571: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:587: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:603: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:618: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_kill':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mkfifo':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:678: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_rename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:694: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:712: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:729: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:745: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:213: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:257: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:261: undefined reference 
to `tst_fill_file'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:82: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:248: undefined reference 
to `tst_fill_file'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:249: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:98: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:120: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:116: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:221: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o):/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:128: 
more undefined references to `tst_resm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device_':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:286: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:282: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:287: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:295: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_device.o): In function `detach_device':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:195: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:169: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:336: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:343: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `.tst_kvcmp':.
//.home.//tai1hilib//Git_Reposlibltp.a/(ltp_gittst_test.o/)lib:/ 
tst_kvercmp.cIn: 87function:  `undefinedprint_result 'reference:
to/ home`/tst_resm_tai1hi'/
Git_Repos./.ltp_git//.lib.//tst_test.clib:/213libltp.a:( 
tst_kvercmp.oundefined) :reference  Into  function` 
tst_color_enabled`'tst_kvercmp2
'/:home
//tai1hihome//Git_Repostai1hi//ltp_gitGit_Repos//libltp_git//tst_test.clib:/214tst_kvercmp.c:: 
161undefined:  referenceundefined  toreference  `totst_ttype2color '`
tst_resm_/'home
/.tai1hi.//Git_Repos./.ltp_git//liblib//libltp.atst_test.c(:tst_timer.o204):: 
  undefinedIn  referencefunction  to` tst_timer_check`'tst_strerrno:'

//homehome//tai1hitai1hi//Git_ReposGit_Repos//ltp_gitltp_git//liblib//tst_timer.ctst_test.c::68207:: 
  undefinedundefined  referencereference  toto  ``tst_brkm_tst_strerrno''

/.home.//tai1hi./.Git_Repos//libltp_git//libltp.alib(/tst_test.otst_timer.c)::62 
:In  undefinedfunction  reference` snprintfto' :`
tst_brkm_/'opt
/.tooling.//codesourcery./.MGC/-lib2014.05/-libltp.a74(-tst_timer.oarm)-:gcc 
-In4.8.3 /function 
Sourcery_CodeBench_for_ARM_Embedded`/tst_timer_startarm'-:none
-/linuxhome-/gnueabitai1hi//libcGit_Repos//usrltp_git//includelib//bitstst_timer.c/:stdio2.h77::64 
:undefined  undefinedreference  referenceto  to` tst_resm_`'TEST_ERRNO
'.
../../../.lib//liblibltp.a/(libltp.atst_timer.o():tst_test.o )In: 
functionIn  `functiontst_timer_stop '`:do_cleanup
'/:home
//tai1hihome//Git_Repostai1hi//ltp_gitGit_Repos//libltp_git//tst_timer.clib:/83tst_test.c:: 
755undefined:  referenceundefined  toreference  `totst_resm_ '`
tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:758: undefined reference 
to `tst_rmdir'
../../lib/libltp.a(collect2: error: ld returned 1 exit status
tst_test.o): In function `cleanup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:118: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `tst_reinit':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_max_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `check_child_status':
/home/tai1hi/Git_Repos/ltp_git/libmake[2]: /tst_test.c*** [test06] Error 
1:311
: undefined reference to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `setup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:82: undefined reference to 
`tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:83: undefined reference to 
`tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:85: undefined reference to 
`tst_get_tmpdir'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:696: undefined reference 
to `tst_tmpdir_created'
../../lib/libltp.a(tst_test.o): In function `copy_resources':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:617: undefined reference 
to `tst_resource_copy'
../../lib/libltp.a(tst_test.o): In function `tst_run_tcases':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:935: undefined reference 
to `safe_setpgid'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:953: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:697: undefined reference 
to `tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:713: undefined reference 
to `tst_mkfs_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:710: undefined reference 
to `tst_dev_fs_type'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_max_futexes'
../../lib/libltp.a(safe_macros.o): In function `safe_basename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:28: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chdir':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:44: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_close':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:60: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_creat':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:76: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_dirname':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:91: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:106: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_sysconf':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:537: undefined 
reference to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:533: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:555: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:571: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:587: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:603: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:618: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_kill':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mkfifo':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:678: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_rename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:694: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:712: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:729: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:745: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:213: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:257: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:261: undefined reference 
to `tst_fill_file'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:82: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:248: undefined reference 
to `tst_fill_file'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:249: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:98: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:120: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:116: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:221: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o):/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:128: 
more undefined references to `tst_resm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device_':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:286: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:282: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:287: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:295: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_device.o): In function `detach_device':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:195: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:169: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:336: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:343: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvcmp':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:87: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvercmp2':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:161: undefined 
reference to `tst_resm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_check':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:68: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:62: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_start':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:77: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_stop':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:83: undefined reference 
to `tst_resm_'
collect2: error: ld returned 1 exit status
make[2]: *** [test08] Error 1
../../lib/libltp.a(tst_test.o): In function `print_result':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:213: undefined reference 
to `tst_color_enabled'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:214: undefined reference 
to `tst_ttype2color'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:204: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:207: undefined reference 
to `tst_strerrno'
../../lib/libltp.a(tst_test.o): In function `snprintf':
/opt/tooling/codesourcery/MGC-2014.05-74-arm-gcc-4.8.3/Sourcery_CodeBench_for_ARM_Embedded/arm-none-linux-gnueabi/libc/usr/include/bits/stdio2.h:64: 
undefined reference to `TEST_ERRNO'
../../lib/libltp.a(tst_test.o): In function `do_cleanup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:755: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:758: undefined reference 
to `tst_rmdir'
../../lib/libltp.a(tst_test.o): In function `cleanup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:118: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `tst_reinit':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_max_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `check_child_status':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:311: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `setup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:82: undefined reference to 
`tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:83: undefined reference to 
`tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:85: undefined reference to 
`tst_get_tmpdir'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:696: undefined reference 
to `tst_tmpdir_created'
../../lib/libltp.a(tst_test.o): In function `copy_resources':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:617: undefined reference 
to `tst_resource_copy'
../../lib/libltp.a(tst_test.o): In function `tst_run_tcases':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:935: undefined reference 
to `safe_setpgid'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:953: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:697: undefined reference 
to `tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:713: undefined reference 
to `tst_mkfs_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:710: undefined reference 
to `tst_dev_fs_type'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_max_futexes'
../../lib/libltp.a(safe_macros.o): In function `safe_basename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:28: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chdir':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:44: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_close':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:60: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_creat':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:76: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_dirname':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:91: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:106: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_sysconf':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:537: undefined 
reference to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:533: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:555: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:571: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:587: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:603: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:618: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_kill':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mkfifo':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:678: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_rename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:694: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:712: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:729: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:745: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:213: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:257: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:261: undefined reference 
to `tst_fill_file'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:82: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:248: undefined reference 
to `tst_fill_file'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:249: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:98: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:120: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:116: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:221: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o):/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:128: 
more undefined references to `tst_resm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device_':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:286: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:282: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:287: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:295: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_device.o): In function `detach_device':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:195: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:169: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:336: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:343: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvcmp':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:87: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvercmp2':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:161: undefined 
reference to `tst_resm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_check':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:68: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:62: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_start':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:77: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_stop':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:83: undefined reference 
to `tst_resm_'
collect2: error: ld returned 1 exit status
make[2]: *** [test07] Error 1
../../lib/libltp.a(tst_test.o): In function `print_result':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:213: undefined reference 
to `tst_color_enabled'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:214: undefined reference 
to `tst_ttype2color'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:204: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:207: undefined reference 
to `tst_strerrno'
../../lib/libltp.a(tst_test.o): In function `snprintf':
/opt/tooling/codesourcery/MGC-2014.05-74-arm-gcc-4.8.3/Sourcery_CodeBench_for_ARM_Embedded/arm-none-linux-gnueabi/libc/usr/include/bits/stdio2.h:64: 
undefined reference to `TEST_ERRNO'
../../lib/libltp.a(tst_test.o): In function `do_cleanup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:755: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:758: undefined reference 
to `tst_rmdir'
../../lib/libltp.a(tst_test.o): In function `cleanup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:118: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `tst_reinit':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_max_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:135: undefined reference 
to `tst_futexes'
../../lib/libltp.a(tst_test.o): In function `check_child_status':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:311: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `setup_ipc':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:82: undefined reference to 
`tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:83: undefined reference to 
`tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:85: undefined reference to 
`tst_get_tmpdir'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:696: undefined reference 
to `tst_tmpdir_created'
../../lib/libltp.a(tst_test.o): In function `copy_resources':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:617: undefined reference 
to `tst_resource_copy'
../../lib/libltp.a(tst_test.o): In function `tst_run_tcases':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:935: undefined reference 
to `safe_setpgid'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:953: undefined reference 
to `tst_strsig'
../../lib/libltp.a(tst_test.o): In function `do_setup':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:697: undefined reference 
to `tst_tmpdir'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:713: undefined reference 
to `tst_mkfs_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:710: undefined reference 
to `tst_dev_fs_type'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_futexes'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:703: undefined reference 
to `tst_max_futexes'
../../lib/libltp.a(safe_macros.o): In function `safe_basename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:28: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chdir':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:44: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_close':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:60: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_creat':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:76: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_dirname':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:91: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:106: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_sysconf':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:537: undefined 
reference to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:533: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:555: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchmod':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:571: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_chown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:587: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_fchown':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:603: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:618: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(safe_macros.o): In function `safe_kill':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_strsig'
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:662: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mkfifo':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:678: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_rename':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:694: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_mount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:712: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o): In function `safe_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:729: undefined 
reference to `tst_brkm_'
../../lib/libltp.a(safe_macros.o):/home/tai1hi/Git_Repos/ltp_git/lib/safe_macros.c:745: 
more undefined references to `tst_brkm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:213: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:257: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:261: undefined reference 
to `tst_fill_file'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:82: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:248: undefined reference 
to `tst_fill_file'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:249: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `find_free_loopdev':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:98: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:120: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:116: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device__':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:221: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o):/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:128: 
more undefined references to `tst_resm_' follow
../../lib/libltp.a(tst_device.o): In function `tst_acquire_device_':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:286: undefined reference 
to `tst_tmpdir_created'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:282: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:287: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:295: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_device.o): In function `detach_device':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:195: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:184: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:169: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_device.o): In function `tst_umount':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_strerrno'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:332: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:336: undefined reference 
to `tst_resm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_device.c:343: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvcmp':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:87: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_kvercmp.o): In function `tst_kvercmp2':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_kvercmp.c:161: undefined 
reference to `tst_resm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_check':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:68: undefined reference 
to `tst_brkm_'
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:62: undefined reference 
to `tst_brkm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_start':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:77: undefined reference 
to `tst_resm_'
../../lib/libltp.a(tst_timer.o): In function `tst_timer_stop':
/home/tai1hi/Git_Repos/ltp_git/lib/tst_timer.c:83: undefined reference 
to `tst_resm_'
collect2: error: ld returned 1 exit status
make[2]: *** [test05] Error 1
make[2]: Leaving directory `/home/tai1hi/Git_Repos/ltp_git/lib/newlib_tests'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/tai1hi/Git_Repos/ltp_git/lib'
make: *** [lib-all] Error 2



-- 
Best regards,

*Islam Tammam
Test Architect and Team Leader
CM/ESO3*

Tel.  +49(5121)49-5911

-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.h
Type: text/x-chdr
Size: 12712 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170719/0d18d684/attachment-0001.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.mk
Type: text/x-makefile
Size: 2519 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170719/0d18d684/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.log
Type: text/x-log
Size: 165072 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170719/0d18d684/attachment-0003.bin>
