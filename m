Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WkbI9-0002Bc-Bi
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 15:40:25 +0000
Date: Wed, 14 May 2014 17:40:12 +0200
From: chrubis@suse.cz
Message-ID: <20140514154011.GA9266@rei>
References: <1396526450-22885-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1397202849-5956-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1397202849-5956-2-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397202849-5956-2-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v4 2/2] openat/openat02.c: add a new case to test
 flags
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
To: "gux.fnst@cn.fujitsu.com" <gux.fnst@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
Pushed with folling chnages (mostly the same as for the open12
testcase), thanks.

diff --git a/testcases/kernel/syscalls/openat/openat02.c b/testcases/kernel/syscalls/openat/openat02.c
index 68e0879..edf71d7 100644
--- a/testcases/kernel/syscalls/openat/openat02.c
+++ b/testcases/kernel/syscalls/openat/openat02.c
@@ -173,7 +173,7 @@ void testfunc_cloexec(void)
 
 	if (pid == 0) {
 		if (execlp(TEST_APP, TEST_APP, buf, NULL))
-			exit(1);
+			exit(2);
 	}
 
 	SAFE_CLOSE(cleanup, TEST_RETURN);
@@ -183,13 +183,14 @@ void testfunc_cloexec(void)
 
 	if (WIFEXITED(status)) {
 		switch ((int8_t)WEXITSTATUS(status)) {
-		case -1:
+		case 0:
 			tst_resm(TPASS, "test O_CLOEXEC for openat success");
-			break;
+		break;
 		case 1:
-			tst_brkm(TBROK, cleanup, "execlp() failed");
-		default:
 			tst_resm(TFAIL, "test O_CLOEXEC for openat failed");
+		break;
+		default:
+			tst_brkm(TBROK, cleanup, "execlp() failed");
 		}
 	} else {
 		tst_brkm(TBROK, cleanup,
@@ -236,7 +237,7 @@ void testfunc_noatime(void)
 		return;
 	}
 
-	ret = tst_path_has_mnt_flags(cleanup, TEST_FILE, flags);
+	ret = tst_path_has_mnt_flags(cleanup, NULL, flags);
 	if (ret > 0) {
 		tst_resm(TCONF, "test O_NOATIME flag for openat needs "
 			"filesystems which are mounted without "
@@ -246,7 +247,7 @@ void testfunc_noatime(void)
 
 	SAFE_STAT(cleanup, TEST_FILE, &file_stat);
 
-	sleep(2);
+	sleep(1);
 
 	TEST(openat(AT_FDCWD, TEST_FILE, O_NOATIME | O_RDONLY, 0777));
 
diff --git a/testcases/kernel/syscalls/openat/openat02_child.c b/testcases/kernel/syscalls/openat/openat02_child.c
index d2af36b..34c4b42 100644
--- a/testcases/kernel/syscalls/openat/openat02_child.c
+++ b/testcases/kernel/syscalls/openat/openat02_child.c
@@ -37,5 +37,5 @@ int main(int argc, char **argv)
 	fd = atoi(argv[1]);
 	ret = write(fd, STR, sizeof(STR) - 1);
 
-	exit(ret);
+	return ret != -1;
 }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
