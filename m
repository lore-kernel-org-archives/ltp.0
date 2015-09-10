Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1ZZuuJ-0000kF-KW
	for ltp-list@lists.sourceforge.net; Thu, 10 Sep 2015 06:00:27 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZZuuG-0000TQ-MM
	for ltp-list@lists.sourceforge.net; Thu, 10 Sep 2015 06:00:27 +0000
Message-ID: <1441864845.29760.5.camel@G08FNSTD140232>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 10 Sep 2015 14:00:45 +0800
In-Reply-To: <1441846935-44787-1-git-send-email-cuibixuan@huawei.com>
References: <1441846935-44787-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH]  [PATCH] rmdir/rmdir05: Delete unnecessary if
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: zhuyanpeng@huawei.com, ltp-list@lists.sourceforge.net, ltp@lists.linux.it, zhanyongming@huawei.com

Hello,

CC: ltp@lists.linux.it

On Thu, 2015-09-10 at 01:02 +0000, Cui Bixuan wrote:
> Delete unnecessary if in testcase
> 
> Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
> ---
>  testcases/kernel/syscalls/rmdir/rmdir05.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/rmdir/rmdir05.c b/testcases/kernel/syscalls/rmdir/rmdir05.c
> index 10037c7..2f0f102 100644
> --- a/testcases/kernel/syscalls/rmdir/rmdir05.c
> +++ b/testcases/kernel/syscalls/rmdir/rmdir05.c
> @@ -81,9 +81,6 @@ int main(int argc, char **argv)
>  		TEST(rmdir("."));
>  
>  		if (TEST_RETURN == -1) {
> -		}
> -
> -		if (TEST_RETURN == -1) {
>  			if (TEST_ERRNO & (EBUSY | ENOTEMPTY)) {
>  				/* For functionality tests, verify that the
>  				 * directory wasn't removed.

Good catch.
And more cleanup:
----------------------------------------------------------------------------------------
diff --git a/testcases/kernel/syscalls/bind/bind01.c b/testcases/kernel/syscalls/bind/bind01.c
index 6a3bc50..54c54c7 100644
--- a/testcases/kernel/syscalls/bind/bind01.c
+++ b/testcases/kernel/syscalls/bind/bind01.c
@@ -119,10 +119,8 @@ int main(int argc, char *argv[])
 
 			TEST(bind
 			     (s, tdat[testno].sockaddr, tdat[testno].salen));
-			if (TEST_RETURN > 0) {
+			if (TEST_RETURN > 0)
 				TEST_RETURN = 0;
-			} else {
-			}
 			if (TEST_RETURN != tdat[testno].retval ||
 			    (TEST_RETURN < 0 &&
 			     TEST_ERRNO != tdat[testno].experrno)) {
diff --git a/testcases/kernel/syscalls/mkdir/mkdir01.c b/testcases/kernel/syscalls/mkdir/mkdir01.c
index 9839a09..9488dbe 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir01.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir01.c
@@ -141,8 +141,6 @@ int main(int ac, char **av)
 		TEST(mkdir(bad_addr, 0777));
 
 		/* check return code */
-		if (TEST_RETURN == -1) {
-		}
 
 		if (TEST_RETURN == -1) {
 			if (TEST_ERRNO == EFAULT) {
@@ -171,8 +169,6 @@ int main(int ac, char **av)
 		TEST(mkdir(get_high_address(), 0777));
 
 		/* check return code */
-		if (TEST_RETURN == -1) {
-		}
 
 		if (TEST_RETURN == -1) {
 			if (TEST_ERRNO == EFAULT) {
diff --git a/testcases/kernel/syscalls/rmdir/rmdir03.c b/testcases/kernel/syscalls/rmdir/rmdir03.c
index 8a42058..acdb4e7 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir03.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir03.c
@@ -246,9 +246,6 @@ void dochild1(void)
 	/* rmdir tstdir2 */
 	TEST(rmdir(tstdir2));
 
-	if (TEST_ERRNO) {
-	}
-
 	if (TEST_RETURN != -1) {
 		retval = 1;
 		tst_resm(TFAIL, "call succeeded unexpectedly");
@@ -284,9 +281,6 @@ void dochild2(void)
 	/* rmdir tstdir4 */
 	TEST(rmdir(tstdir4));
 
-	if (TEST_ERRNO) {
-	}
-
 	if (TEST_RETURN != -1) {
 		retval = 1;
 		tst_resm(TFAIL, "call succeeded unexpectedly");
diff --git a/testcases/kernel/syscalls/rmdir/rmdir05.c b/testcases/kernel/syscalls/rmdir/rmdir05.c
index 10037c7..cdfca1b 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir05.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir05.c
@@ -81,9 +81,6 @@ int main(int argc, char **argv)
 		TEST(rmdir("."));
 
 		if (TEST_RETURN == -1) {
-		}
-
-		if (TEST_RETURN == -1) {
 			if (TEST_ERRNO & (EBUSY | ENOTEMPTY)) {
 				/* For functionality tests, verify that the
 				 * directory wasn't removed.
@@ -125,9 +122,6 @@ int main(int argc, char **argv)
 		TEST(rmdir(bad_addr));
 
 		if (TEST_RETURN == -1) {
-		}
-
-		if (TEST_RETURN == -1) {
 			if (TEST_ERRNO == EFAULT) {
 				tst_resm(TPASS,
 					 "rmdir() - path argument points below the minimum allocated address space failed as expected with errno %d : %s",
@@ -151,8 +145,6 @@ int main(int argc, char **argv)
 
 		TEST(rmdir(get_high_address()));
 
-		if (TEST_RETURN == -1) {
-		}
 
 		if (TEST_RETURN == -1) {
 			if (TEST_ERRNO == EFAULT) {
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
index ba0e894..764cb7f 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
@@ -94,9 +94,6 @@ int main(int ac, char **av)
 
 			TEST(sched_setscheduler(pid, SCHED_FIFO, &param));
 
-			if (TEST_ERRNO) {
-			}
-
 			if (TEST_RETURN != -1) {
 				tst_resm(TFAIL, "sched_setscheduler(2) passed "
 					 "with non root priveledges");
diff --git a/testcases/kernel/syscalls/setregid/setregid03.c b/testcases/kernel/syscalls/setregid/setregid03.c
index 2a13c72..ea2c0a5 100644
--- a/testcases/kernel/syscalls/setregid/setregid03.c
+++ b/testcases/kernel/syscalls/setregid/setregid03.c
@@ -154,8 +154,6 @@ int main(int ac, char **av)
 						 *test_data[i].eff_gid);
 					flag = -1;
 				}
-				if (test_ret == -1) {
-				}
 
 				gid_verify(test_data[i].exp_real_usr,
 					   test_data[i].exp_eff_usr,
diff --git a/testcases/kernel/syscalls/setreuid/setreuid03.c b/testcases/kernel/syscalls/setreuid/setreuid03.c
index b62098e..2f5bf03 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid03.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid03.c
@@ -136,8 +136,6 @@ int main(int ac, char **av)
 					 *test_data[i].eff_uid);
 			}
 
-			if (TEST_RETURN == -1) {
-			}
 			uid_verify(test_data[i].exp_real_usr,
 				   test_data[i].exp_eff_usr,
 				   test_data[i].test_msg);
diff --git a/testcases/kernel/syscalls/setreuid/setreuid05.c b/testcases/kernel/syscalls/setreuid/setreuid05.c
index 39b30f9..073d0ad 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid05.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid05.c
@@ -137,8 +137,6 @@ int main(int argc, char **argv)
 						 *test_data[i].eff_uid);
 				}
 
-				if (TEST_RETURN == -1) {
-				}
 				uid_verify(test_data[i].exp_real_usr,
 					   test_data[i].exp_eff_usr,
 					   test_data[i].test_msg);
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt01.c b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
index f25694a..f7b9e57 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt01.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
@@ -145,9 +145,6 @@ int main(int argc, char *argv[])
 					tdat[testno].optval,
 					tdat[testno].optlen));
 
-			if (TEST_RETURN == -1) {
-			}
-
 			if (TEST_RETURN != tdat[testno].retval ||
 			    (TEST_RETURN < 0 &&
 			     TEST_ERRNO != tdat[testno].experrno)) {
diff --git a/testcases/kernel/syscalls/socket/socket01.c b/testcases/kernel/syscalls/socket/socket01.c
index f471d8b..eaa7796 100644
--- a/testcases/kernel/syscalls/socket/socket01.c
+++ b/testcases/kernel/syscalls/socket/socket01.c
@@ -94,10 +94,8 @@ int main(int argc, char *argv[])
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			TEST((s = socket(tdat[testno].domain, tdat[testno].type,
 					 tdat[testno].proto)));
-			if (TEST_RETURN >= 0) {
+			if (TEST_RETURN >= 0)
 				TEST_RETURN = 0;	/* > 0 equivalent */
-			} else {
-			}
 			if (TEST_RETURN != tdat[testno].retval || (TEST_RETURN < 0 && (TEST_ERRNO != tdat[testno].experrno && TEST_ERRNO != EPROTONOSUPPORT))) {	/* Change for defect 21065 for kernel change */
 				tst_resm(TFAIL, "%s ; returned"	/* of return code for this test but don't want */
 					 " %d (expected %d), errno %d (expected"	/* to break on older kernels */
diff --git a/testcases/kernel/syscalls/socketpair/socketpair01.c b/testcases/kernel/syscalls/socketpair/socketpair01.c
index 3a045b7..ca07a5e 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair01.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair01.c
@@ -106,10 +106,8 @@ int main(int argc, char *argv[])
 					     tdat[testno].type,
 					     tdat[testno].proto,
 					     tdat[testno].sv)));
-			if (TEST_RETURN >= 0) {
+			if (TEST_RETURN >= 0)
 				TEST_RETURN = 0;	/* > 0 equivalent */
-			} else {
-			}
 			if (TEST_RETURN != tdat[testno].retval ||
 			    (TEST_RETURN &&
 			     (TEST_ERRNO != tdat[testno].experrno
----------------------------------------------------------------------------------------

Thanks,
Zeng


------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
