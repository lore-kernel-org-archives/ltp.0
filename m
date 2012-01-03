Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri1pi-0000fL-4D
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 10:43:06 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri1pe-0000Um-8s
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 10:43:06 +0000
Message-ID: <4F02DBAF.5040202@imgtec.com>
Date: Tue, 3 Jan 2012 10:42:55 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060206030401060805020204"
Subject: [LTP] [PATCH 05/21] syscalls: Cast st_nlink variables to proper
	integers
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--------------060206030401060805020204
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------060206030401060805020204
Content-Type: text/plain;
	name="0005-syscalls-Cast-st_nlink-variables-to-proper-integers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0005-syscalls-Cast-st_nlink-variables-to-proper-integers.pat";
	filename*1="ch"

From 5597051818cb71032d6d2dc9eaa16ab417e9c79e Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 11:44:18 +0000
Subject: [PATCH 05/21] syscalls: Cast st_nlink variables to proper integers

st_nlink type is arch specific so it may not be a 32-bit integer everywhere.
Since %d modifier expects an integer, the st_nlink variables need to be casted
to an integer type.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/kernel/syscalls/link/link02.c       |    2 +-
 testcases/kernel/syscalls/link/link03.c       |    4 ++--
 testcases/kernel/syscalls/link/link05.c       |    4 ++--
 testcases/kernel/syscalls/symlink/symlink01.c |    4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link02.c b/testcases/kernel/syscalls/link/link02.c
index 4ddd818..f6cdf9f 100644
--- a/testcases/kernel/syscalls/link/link02.c
+++ b/testcases/kernel/syscalls/link/link02.c
@@ -190,7 +190,7 @@ int main(int ac, char **av)
 					tst_resm(TFAIL,
 						 "link(%s, %s) returned %ld, stat link cnts do not match %d %d",
 						 Fname, Lname, TEST_RETURN,
-						 fbuf.st_nlink, lbuf.st_nlink);
+						 (int)fbuf.st_nlink, (int)lbuf.st_nlink);
 				}
 			}
 			if (unlink(Lname) == -1) {
diff --git a/testcases/kernel/syscalls/link/link03.c b/testcases/kernel/syscalls/link/link03.c
index f2f85b5..b3b4387 100644
--- a/testcases/kernel/syscalls/link/link03.c
+++ b/testcases/kernel/syscalls/link/link03.c
@@ -232,7 +232,7 @@ int main(int ac, char **av)
 						 "link(%s, %s[1-%d]) ret %ld for %d files, stat values do not match %d %d",
 						 Fname, Basename, nlinks,
 						 TEST_RETURN, nlinks,
-						 fbuf.st_nlink, lbuf.st_nlink);
+						 (int)fbuf.st_nlink, (int)lbuf.st_nlink);
 					break;
 				}
 			}
@@ -240,7 +240,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS,
 					 "link(%s, %s[1-%d]) ret %ld for %d files, stat linkcounts match %d",
 					 Fname, Basename, nlinks, TEST_RETURN,
-					 nlinks, fbuf.st_nlink);
+					 nlinks, (int)fbuf.st_nlink);
 			}
 		} else
 			Tst_count++;
diff --git a/testcases/kernel/syscalls/link/link05.c b/testcases/kernel/syscalls/link/link05.c
index 343db1b..f03a149 100644
--- a/testcases/kernel/syscalls/link/link05.c
+++ b/testcases/kernel/syscalls/link/link05.c
@@ -217,7 +217,7 @@ int main(int ac, char **av)
 						 "link(%s, %s[1-%d]) ret %ld for %d files, stat values do not match %d %d",
 						 Fname, Basename, nlinks,
 						 TEST_RETURN, nlinks,
-						 fbuf.st_nlink, lbuf.st_nlink);
+						 (int)fbuf.st_nlink, (int)lbuf.st_nlink);
 					break;
 				}
 			}
@@ -225,7 +225,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS,
 					 "link(%s, %s[1-%d]) ret %ld for %d files, stat linkcounts match %d",
 					 Fname, Basename, nlinks, TEST_RETURN,
-					 nlinks, fbuf.st_nlink);
+					 nlinks, (int)fbuf.st_nlink);
 			}
 		} else
 			Tst_count++;
diff --git a/testcases/kernel/syscalls/symlink/symlink01.c b/testcases/kernel/syscalls/symlink/symlink01.c
index c7be331..94596d0 100644
--- a/testcases/kernel/syscalls/symlink/symlink01.c
+++ b/testcases/kernel/syscalls/symlink/symlink01.c
@@ -1556,8 +1556,8 @@ struct all_test_cases *tc_ptr;
 						tst_resm(TFAIL,
 							 "%slink(%s, %s) failed to adjust link count.\n\
 		count for nick is %d, count for %s is %d, count for %s is %d.",
-							 Buffer, tc_ptr->fn_arg[1], "nick", statter.st_nlink, tc_ptr->fn_arg[1], asymlink.st_nlink, tc_ptr->fn_arg[2],
-							 stbuf.st_nlink);
+							 Buffer, tc_ptr->fn_arg[1], "nick", (int)statter.st_nlink, tc_ptr->fn_arg[1], (int)asymlink.st_nlink, tc_ptr->fn_arg[2],
+							(int) stbuf.st_nlink);
 					}
 				} else {
 					tst_resm(TFAIL, "%sA lstat of %s (ino:%jd) and of\n\t\t\
-- 
1.7.1


--------------060206030401060805020204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------060206030401060805020204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060206030401060805020204--


