Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1X4UXj-0006r2-Ps
	for ltp-list@lists.sourceforge.net; Tue, 08 Jul 2014 12:30:43 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X4UXi-0007th-8K
	for ltp-list@lists.sourceforge.net; Tue, 08 Jul 2014 12:30:43 +0000
Date: Tue, 8 Jul 2014 08:30:34 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <2026740901.5816308.1404822634671.JavaMail.zimbra@redhat.com>
In-Reply-To: <1015853559.5800703.1404820547657.JavaMail.zimbra@redhat.com>
References: <20140704031641.GA20446@localhost.localdomain>
	<1152474476.5259307.1404735279247.JavaMail.zimbra@redhat.com>
	<20140708072308.GA3111@localhost.localdomain>
	<1472278017.5756231.1404815787899.JavaMail.zimbra@redhat.com>
	<1015853559.5800703.1404820547657.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [RFC PATCH] regression test for 64bit
	sendfile	capped	at	2G
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
To: Han Pingtian <hanpt@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 8 July, 2014 1:55:47 PM
> Subject: Re: [LTP] [RFC PATCH] regression test for 64bit sendfile	capped	at	2G
> 
> 
> 
> 
> 
> ----- Original Message -----
> > From: "Jan Stancek" <jstancek@redhat.com>
> > To: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> > Cc: ltp-list@lists.sourceforge.net
> > Sent: Tuesday, 8 July, 2014 12:36:27 PM
> > Subject: Re: [LTP] [RFC PATCH] regression test for 64bit sendfile capped	at
> > 	2G
> > 
> > 
> > 
> > ----- Original Message -----
> > > From: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> > > To: ltp-list@lists.sourceforge.net
> > > Sent: Tuesday, 8 July, 2014 9:23:08 AM
> > > Subject: Re: [LTP] [RFC PATCH] regression test for 64bit sendfile capped
> > > at
> > > 	2G
> > > 
> > > On Mon, Jul 07, 2014 at 08:14:39AM -0400, Jan Stancek wrote:
> > > > 
> > > > 
> > > Thanks so much. I have changed the patch according to you and
> > > Xiaoguang's suggestions. Please have a look.
> > 
> > Hi,
> > 
> > Below are some small suggestions, mostly to avoid int type related
> > warnings when compiled as 32-bit.
> > 
> > Did you also test this testcase with kernel commit 5d73320a96fcc applied?
> > I tried it with this commit applied on top of RHEL7 GA kernel, but
> > I didn't get the expected result:
> > 
> > sendfile(3, 4, [0], 4294967296)         = 2147418112
> > ...
> > sendfile(3, 4, [2147483648], 2147483648) = 2147418112
> 
> do_sendfile()
>   rw_verify_area()
>     return count > MAX_RW_COUNT ? MAX_RW_COUNT : count;
> 
> #define MAX_RW_COUNT (INT_MAX & PAGE_CACHE_MASK)
> 
> which appears to match return value I get:
>   2147418112 == 0x7FFF0000
> 
> printf("%d %d\n", sizeof(int), getpagesize());
>   4 65536
> 
> Can sendfile work with sizes > 2GB?

I think the problem addressed in commit 5d73320a96fcc was using sendfile on large files,
and not making large (count > 2GB) sendfile() calls.

Taking this into account, I can see the difference with/without commit 5d73320a96fcc.
Second case here fails on unpatched kernel with:

sendfile(3, 4, [3221225472], 1073741824) = -1 EOVERFLOW (Value too large for defined data type)


diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 975c150..b9d49cf 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -750,6 +750,8 @@
 /sendfile/sendfile07_64
 /sendfile/sendfile08
 /sendfile/sendfile08_64
+/sendfile/sendfile09
+/sendfile/sendfile09_64
 /sendmsg/sendmsg01
 /sendmsg/sendmsg02
 /sendto/sendto01
diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
index 1bab702..c33b084 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile09.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
@@ -71,55 +71,51 @@ static int out_fd;
 static void cleanup(void);
 static void setup(void);

-struct test_case_t {
+#define ONE_GB (INT64_C(1) << 30)
+
+static struct test_case_t {
        char *desc;
        OFF_T offset;
+       int64_t count;
        int64_t exp_retval;
        int64_t exp_updated_offset;
 } testcases[] = {
        { "Test sendfile(2) with offset = 0",
-           0, 4294967296, 4294967296},
+           0, ONE_GB, ONE_GB, ONE_GB},
        { "Test sendfile(2) with offset in the middle of file",
-           2147483648, 2147483648, 4294967296}
+           3*ONE_GB, ONE_GB, ONE_GB, 4*ONE_GB}
 };

 int TST_TOTAL = ARRAY_SIZE(testcases);

-#ifdef UCLINUX
-static char *argv0;
-#endif
-
-void do_sendfile(OFF_T offset, int i)
+void do_sendfile(struct test_case_t *t)
 {
-       struct stat sb;
        off_t before_pos, after_pos;

        out_fd = SAFE_OPEN(cleanup, out_file, O_WRONLY);

        in_fd = SAFE_OPEN(cleanup, in_file, O_RDONLY);

-       SAFE_STAT(cleanup, in_file, &sb);
-
        before_pos = SAFE_LSEEK(cleanup, in_fd, 0, SEEK_CUR);

-       TEST(sendfile(out_fd, in_fd, &offset, sb.st_size - offset));
+       TEST(sendfile(out_fd, in_fd, &t->offset, t->count));

        if (TEST_RETURN == -1)
-               tst_brkm(TBROK | TERRNO, cleanup, "sendfile(2) failed");
+               tst_brkm(TBROK | TTERRNO, cleanup, "sendfile(2) failed");

        after_pos = SAFE_LSEEK(cleanup, in_fd, 0, SEEK_CUR);

-       if (TEST_RETURN != testcases[i].exp_retval) {
+       if (TEST_RETURN != t->exp_retval) {
                tst_resm(TFAIL, "sendfile(2) failed to return "
                         "expected value, expected: %" PRId64 ", "
-                        "got: %" PRId64, testcases[i].exp_retval,
+                        "got: %ld", t->exp_retval,
                         TEST_RETURN);
-       } else if (offset != testcases[i].exp_updated_offset) {
+       } else if (t->offset != t->exp_updated_offset) {
                tst_resm(TFAIL, "sendfile(2) failed to update "
                         "OFFSET parameter to expected value, "
                         "expected: %" PRId64 ", got: %" PRId64,
-                        testcases[i].exp_updated_offset,
-                        (int64_t) offset);
+                        t->exp_updated_offset,
+                        (int64_t) t->offset);
        } else if (before_pos != after_pos) {
                tst_resm(TFAIL, "sendfile(2) updated the file position "
                         " of in_fd unexpectedly, expected file position: %"
@@ -149,8 +145,7 @@ void setup(void)
        tst_tmpdir();

        if (!tst_fs_has_free(NULL, ".", 8, TST_GB)) {
-               cleanup();
-               tst_brkm(TCONF, NULL, "sendfile(2) on large file"
+               tst_brkm(TCONF, cleanup, "sendfile(2) on large file"
                        " needs 8G free space.");
        }

@@ -224,7 +219,7 @@ int main(int ac, char **av)
                tst_count = 0;

                for (i = 0; i < TST_TOTAL; ++i)
-                       do_sendfile(testcases[i].offset, i);
+                       do_sendfile(&testcases[i]);
        }

        cleanup();

Regards,
Jan


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
