Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yicheng.wang@huawei.com>) id 1T56tW-0000wb-J8
	for ltp-list@lists.sourceforge.net; Sat, 25 Aug 2012 03:18:42 +0000
Received: from szxga01-in.huawei.com ([119.145.14.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T56tR-0005ql-UA
	for ltp-list@lists.sourceforge.net; Sat, 25 Aug 2012 03:18:42 +0000
From: Wangyicheng <yicheng.wang@huawei.com>
Date: Sat, 25 Aug 2012 03:05:10 +0000
Message-ID: <9D7565DAE340BD42B8D00446E021992C28AC935C@SZXEML506-MBS.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Subject: [LTP] [PATCH] testcases/kernel/syscalls/mount test cases of mount2
 and mount3 faild in JUNE 2012 STABLE :ltp-full-20120614
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi:
  When I run ltp testcases (the latest version, JU= NE 2012 STABLE :ltp-full-20120614),I find tow testcases are broken( mount2 and mount3 in " testcases/kernel/syscalls/mount" = directory):
  # ./mount02 -D /dev/loop2 -T ext3
mount02     1  TPASS  :&n= bsp; mount got expected failure: errno=3DENODEV(19): No such device
mount02     2  TPASS  :&n= bsp; mount got expected failure: errno=3DENOTBLK(15): Block device required= 
mount02     3  TPASS  :&n= bsp; mount got expected failure: errno=3DEBUSY(16): Device or resource busy= 
mount02     4  TBROK  :&n= bsp; umount of mnt_18620 failed: errno=3DEBUSY(16): Device or resource busy= 
mount02     5  TBROK  :&n= bsp; Remaining cases broken
mount02     0  TWARN  :&n= bsp; tst_rmdir: rmobj(/tmp/mouSyPao1) failed: remove(/tmp/mouSyPao1/mnt_186= 20) failed; errno=3D16: Device or resource busy 
 
# ./mount03 -D /dev/loop2 -T ext3
mount03     1  TBROK  :&n= bsp; stat for setuid_test failed
mount03     2  TBROK  :&n= bsp; Remaining cases broken
  
In mount02.c, the global array variable exp_enos is def= ined as :
   static int exp_enos[] =3D { ENODEV, ENOTBL= K, EBUSY, EINVAL, EFAULT, ENAMETOOLONG, ENOENT, ENOTDIR, 0};
There are egiht items in the exp_enos, but the value of= TST_TOTAL is 13, it means there are 13 checkpoints int the testcase.  As a result ,in the setup_test function , there are 13= switch-cases ( case 0=A1=A2case1 ... case 12)
But the number of the expect result in the exp_enos arr= ay is mismatch with the number of checkpoint, so the TBROK  happend. 
 In mount03.c, there are three issues:
In setup function, the setuid_test file is in the testhome_path instead of the temporary directory Path_name. It results "stat for setuid_test failed"
In setup function, snprintf(Path_name, PATH_MAX, "%s/%s/", Path_name, mntpoint),it can not implement appending the mntpoint string to the Path_name string;
In test_rwflag function, in the part of "case 2"(at line 280 in mount03.c), if the "execlp(file, basename(file), NULL)" will return (actually it will return),the return value of test_rwfla= g is always 1 (1 means fail),so the testcase is always failed; Another hand, if it will not return (if kernel bug exists), the process will terminate unexpectedly.
 I fix them , and both of the tow testcase can get pass. 

diff -uNr ltp-full-20120614/testcases/kernel/syscalls/mount/mount02.c ltp-full-20120614.bugfix/testcases/kernel/syscalls/mount/mount02.c
--- ltp-full-20120614/testcases/kernel/syscalls/mount/mount02.c        2012-07-12 10:59:29.000000000 +0800
+++ ltp-full-20120614.bugfix/testcases/kernel/syscalls/mount/mount02.c  2012-07-12 11:01:37.000000000 +0800
@@ -123,8 +123,8 @@
static int Tflag = 0;
static int Dflag = 0;

-static int exp_enos[] = { ENODEV, ENOTBLK, EBUSY, EINVAL, EFAULT, ENAMETOOLONG,
-        ENOENT, ENOTDIR, 0
+static int exp_enos[] = { ENODEV, ENOTBLK, EBUSY, EBUSY, EINVAL, EINVAL, EINVAL,EFAULT, EFAULT, ENAMETOOLONG,
+        ENOENT, ENOENT, ENOTDIR, 0
};

 int TST_TOTAL = (sizeof(exp_enos) / sizeof(exp_enos[0])) - 1;
@@ -427,4 +427,4 @@
       printf("-T type   : specifies the type of filesystem to be mounted."
              " Default ext2. \n");
       printf("-D device : device used for mounting \n");
-}
\ No newline at end of file
+}
diff -uNr ltp-full-20120614/testcases/kernel/syscalls/mount/mount03.c ltp-full-20120614.bugfix/testcases/kernel/syscalls/mount/mount03.c
--- ltp-full-20120614/testcases/kernel/syscalls/mount/mount03.c        2012-07-12 10:59:29.000000000 +0800
+++ ltp-full-20120614.bugfix/testcases/kernel/syscalls/mount/mount03.c  2012-07-12 11:09:57.000000000 +0800
@@ -277,7 +277,9 @@
                          tst_resm(TWARN|TERRNO, "opening %s failed", file);
                } else {
                          close(fd);
-                           execlp(file, basename(file), NULL);
+                          if(system(file)) {
+                                   return 0;
+                          }
                }
                return 1;
       case 3:
@@ -460,11 +462,18 @@
       if (getcwd(Path_name, sizeof(Path_name)) == NULL) {
                tst_brkm(TBROK, cleanup, "getcwd failed");
       }
+       /*
+       * under temporary directory
+       */
+       snprintf(Path_name + strlen(Path_name), PATH_MAX, "/%s/", mntpoint);
       if (chmod(Path_name, DIR_MODE) != 0) {
                tst_brkm(TBROK, cleanup, "chmod(%s, %#o) failed",
                    Path_name, DIR_MODE);
       }
-        snprintf(file, PATH_MAX, "%ssetuid_test", Path_name);
+
+       snprintf(testhome_path, PATH_MAX, "%s/setuid_test", test_home);
+                
+       snprintf(file, PATH_MAX, "%s", testhome_path);
       if (stat(file, &setuid_test_stat) < 0) {
                tst_brkm(TBROK, cleanup, "stat for setuid_test failed");
       } else {
@@ -480,14 +489,6 @@
                }
       }

-        /*
-        * under temporary directory
-        */
-        snprintf(Path_name, PATH_MAX, "%s/%s/", Path_name, mntpoint);
-
-        strcpy(testhome_path, test_home);
-        strcat(testhome_path, "/setuid_test");
-
       TEST_PAUSE;

 }
@@ -517,4 +518,4 @@
       printf("-T type   : specifies the type of filesystem to be mounted."
              " Default ext2. \n");
       printf("-D device : device used for mounting \n");
-}
\ No newline at end of file
+}

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
