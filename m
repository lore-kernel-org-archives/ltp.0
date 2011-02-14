Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1PoxZ3-0003LR-IB
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 12:30:01 +0000
Date: Mon, 14 Feb 2011 13:49:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110214124921.GA29415@saboteur.suse.cz>
References: <4D590650.4090806@nokia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <4D590650.4090806@nokia.com>
Subject: Re: [LTP] [PATCH] Fix the file permissions and other issues in
 "fs_perms" tests
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
To: maxin <john.maxin@nokia.com>
Cc: ltp-list@lists.sourceforge.net


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> On the preliminary analysis of  this failure, I came to know that the reason was due to insufficient file permissions provided in the
> "runtests/fs_perms_simple" . To execute a script file, 'user', 'group', or 'others' should have 'read' and 'execute' permissions.
> Based on that, I have modified the "s_perms_simple"  file as follows:
> 
> -fs_perms01 fs_perms 001 99 99 12 100 x 0
> -fs_perms02 fs_perms 010 99 99 200 99 x 0
> -fs_perms03 fs_perms 100 99 99 99 500 x 0
> +fs_perms01 fs_perms 005 99 99 12 100 x 0
> +fs_perms02 fs_perms 050 99 99 200 99 x 0
> +fs_perms03 fs_perms 500 99 99 99 500 x 0

Actually these are correct, the last number in a row is
'expected result'. So execution of these files must fail in order for
the test to succeed.

> Even after this modification, I have observed some failures in the "fs_perms" test cases. Further analysis using "strace" showed "other"
> issues  present in the test case.
> 
> # strace ./fs_perms 050 99 99 200 99 x 0
> .
> .
> chmod("./test.file2", 062)              = 0
> chown32("./test.file2", 99, 99)         = 0
> .
> We have provided the mode as "050" to the fs_perms binary. However, the test case got executed as though we have provided mode as "062".
> This patch corrects this issue also.

That's a good catch, the original code used strtol(..., 010). Let me
know if attached patch fixed the issue.

-- 
Cyril Hrubis
chrubis@suse.cz

--sm4nu43k4a2Rpi4c
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fs_perms_fix.patch"

diff --git a/testcases/kernel/fs/fs_perms/fs_perms.c b/testcases/kernel/fs/fs_perms/fs_perms.c
index 31cba4a..1e6a8fc 100644
--- a/testcases/kernel/fs/fs_perms/fs_perms.c
+++ b/testcases/kernel/fs/fs_perms/fs_perms.c
@@ -56,7 +56,6 @@ static void cleanup(void)
 	setegid(0);
 
 	tst_rmdir();
-
 }
 
 /*
@@ -163,10 +162,10 @@ static void print_usage(const char *bname)
 	printf("Usage: %s %s\n", bname, usage);
 }
 
-static long str_to_l(const char *str, const char *name)
+static long str_to_l(const char *str, const char *name, int mode)
 {
 	char *end;
-	long i = strtol(str, &end, 10);
+	long i = strtol(str, &end, mode);
 
 	if (*end != '\0')
 		tst_brkm(TBROK, NULL, "Invalid parameter '%s' passed. (%s)",
@@ -196,13 +195,13 @@ int main(int argc, char *argv[])
 		tst_exit();
 	}
 
-	fmode     = str_to_l(argv[1], "file mode");
-	fuser_id  = str_to_l(argv[2], "file uid");
-	fgroup_id = str_to_l(argv[3], "file gid");
-	user_id   = str_to_l(argv[4], "tester uid");
-	group_id  = str_to_l(argv[5], "tester gid");
+	fmode     = str_to_l(argv[1], "file mode", 8);
+	fuser_id  = str_to_l(argv[2], "file uid", 10);
+	fgroup_id = str_to_l(argv[3], "file gid", 10);
+	user_id   = str_to_l(argv[4], "tester uid", 10);
+	group_id  = str_to_l(argv[5], "tester gid", 10);
 	fperm     = argv[6];
-	exp_res   = str_to_l(argv[7], "expected result");
+	exp_res   = str_to_l(argv[7], "expected result", 10);
 
 	tst_tmpdir();
 	testsetup(TEST_FILE_NAME1, 0, fmode, fuser_id, fgroup_id);
@@ -226,4 +225,4 @@ int main(int argc, char *argv[])
 
 	tst_rmdir();
 	tst_exit();
-}
\ No newline at end of file
+}

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--sm4nu43k4a2Rpi4c--

