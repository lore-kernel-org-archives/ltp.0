Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYxtY-0001l3-Qf
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 12:50:40 +0000
Date: Wed, 23 Oct 2013 14:50:25 +0200
From: chrubis@suse.cz
Message-ID: <20131023125024.GB23369@rei.Home>
References: <002501cecbfd$3478cee0$9d6a6ca0$@cn.fujitsu.com>
	<20131022174433.GB7753@rei> <526771F7.7070907@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <526771F7.7070907@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] acct/acct01.c: clean up
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
Cc: ltp-list@lists.sourceforge.net

Hi!
Pushed after moving the getpwnam() into setup() (see bellow), thanks.

diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index 8513fdc..ee794cc 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -67,7 +67,7 @@ static struct test_case_t {
 
 char *TCID = "acct01";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
-struct passwd *ltpuser;
+static struct passwd *ltpuser;
 static int exp_enos[] = { EISDIR, EACCES, ENOENT, ENOTDIR, EPERM, 0 };
 
 int main(int argc, char *argv[])
@@ -97,6 +97,8 @@ static void setup(void)
 
        tst_tmpdir();
 
+       ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+
        fd = SAFE_CREAT(cleanup, TEST_FILE5, 0777);
        SAFE_CLOSE(cleanup, fd);
 
@@ -143,7 +145,6 @@ static void acct_verify(int i)
 
 static void setup2(void)
 {
-       ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
        SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
