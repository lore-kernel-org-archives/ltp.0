Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wkamd-0000kw-8j
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 15:07:51 +0000
Date: Wed, 14 May 2014 17:07:42 +0200
From: chrubis@suse.cz
Message-ID: <20140514150741.GA6175@rei>
References: <1394352758.2346.2.camel@G08JYZSD130126>
	<1394352845.2346.4.camel@G08JYZSD130126>
	<20140311154349.GF10778@rei>
	<1394716096.2087.10.camel@G08JYZSD130126>
	<1394716306.2087.14.camel@G08JYZSD130126>
	<20140401161414.GA13696@rei.suse.cz>
	<1396589471.2098.6.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1396589471.2098.6.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2] open/open12.c: add new tests
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
Pushed with following changes, thanks.

diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index 8b78b83..5b7576b 100644
--- a/testcases/kernel/syscalls/open/open12.c
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -86,7 +86,7 @@ static void setup(void)
 
 static void test_append(void)
 {
-	off_t len;
+	off_t len1, len2;
 
 	TEST(open(TEST_FILE, O_RDWR | O_APPEND, 0777));
 
@@ -95,11 +95,12 @@ static void test_append(void)
 		return;
 	}
 
+	len1 = SAFE_LSEEK(cleanup, TEST_RETURN, 0, SEEK_CUR);
 	SAFE_WRITE(cleanup, 1, TEST_RETURN, TEST_FILE, sizeof(TEST_FILE));
-	len = SAFE_LSEEK(cleanup, TEST_RETURN, 0, SEEK_CUR);
+	len2 = SAFE_LSEEK(cleanup, TEST_RETURN, 0, SEEK_CUR);
 	SAFE_CLOSE(cleanup, TEST_RETURN);
 
-	if (len > (off_t)sizeof(TEST_FILE))
+	if (len2 > len1)
 		tst_resm(TPASS, "test O_APPEND for open success");
 	else
 		tst_resm(TFAIL, "test O_APPEND for open failed");

This makes the test better on -i N (because the len would be greater
than the initial lenght after the first append write no matter what).


@@ -118,10 +119,10 @@ static void test_noatime(void)
 		return;
 	}
 
-	if (tst_path_has_mnt_flags(TEST_FILE, flags)) {
+	if (tst_path_has_mnt_flags(cleanup, NULL, flags)) {
 		tst_resm(TCONF,
 			 "test O_NOATIME flag for open needs filesystems which "
-			 "are mounted without noatime and relatime");
+			 "is mounted without noatime and relatime");
 		return;
 	}

This fixes the tst_path_has_mnt_flags() usage. The path to this function
must be full path (not just filename). I've changed the library to use
tst_tmpdir path if NULL is passed as a path (which simplifies the
usage).

@@ -173,7 +174,7 @@ static void test_cloexec(void)
 
 	if (pid == 0) {
 		if (execlp("open12_cloexec", "open12_cloexec", buf, NULL))
-			exit(1);
+			exit(2);
 	}
 
 	SAFE_CLOSE(cleanup, TEST_RETURN);
@@ -183,13 +184,14 @@ static void test_cloexec(void)
 
 	if (WIFEXITED(status)) {
 		switch ((int8_t)WEXITSTATUS(status)) {
-		case -1:
+		case 0:
 			tst_resm(TPASS, "test O_CLOEXEC for open success");
-			break;
+		break;
 		case 1:
-			tst_brkm(TBROK, cleanup, "execlp() failed");
-		default:
 			tst_resm(TFAIL, "test O_CLOEXEC for open failed");
+		break;
+		default:
+			tst_brkm(TBROK, cleanup, "execlp() failed");
 		}
 	} else {
 		tst_brkm(TBROK, cleanup,
diff --git a/testcases/kernel/syscalls/open/open12_cloexec.c b/testcases/kernel/syscalls/open/open12_cloexec.c
index 5b55a05..a6dabd5 100644
--- a/testcases/kernel/syscalls/open/open12_cloexec.c
+++ b/testcases/kernel/syscalls/open/open12_cloexec.c
@@ -26,12 +26,12 @@ int main(int argc, char **argv)
 	int fd;
 
 	if (argc != 2) {
-		fprintf(stderr, "Only two arguments: %s <fd>", argv[0]);
+		fprintf(stderr, "Only two arguments: %s <fd>\n", argv[0]);
 		exit(1);
 	}
 
 	fd = atoi(argv[1]);
 	ret = write(fd, argv[1], strlen(argv[1]));
 
-	exit(ret);
+	return ret != -1;
 }

This fixes the return values, because as it was return value 1 was
assigned to both failed execlp() and failed testcase (write() succeded
and returned size of the written data which was 1).

Now execlp failure maps to 2, testcase failure to 1 and success to 0 (in
accordance with shell 0 == succes).

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
