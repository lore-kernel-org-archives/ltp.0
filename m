From: Li Wang <liwang@redhat.com>
Date: Tue, 5 Apr 2016 12:34:23 +0800
Subject: [LTP] [PATCH V3] madvice: new case for madvise(WILLNEED)
In-Reply-To: <20160404173038.GB16610@rei.lan>
References: <1459488281-23882-1-git-send-email-liwang@redhat.com>
 <20160404173038.GB16610@rei.lan>
Message-ID: <CAEemH2f0S7S3O7kd6jo0p89SGk8JdNgtDqgQgPpSvH=QL7NJyA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Cyril,

On Tue, Apr 5, 2016 at 1:30 AM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > +#ifdef __x86_64__
>
> Last question, why do we limit the test to x86_64?
>
> Since apart from hardcoded page size, there does not seem to be anything
> x86_64 specific at all.
>

Thanks for reminding me, limit the test program to x86_64 because the bug
was detected on that platform, I did not noticed the portable issue.

If the following changes test good(bug reproduced) on other platform, I
will post V4.

v3 ---> v4
------------
$ git diff
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c
b/testcases/kernel/syscalls/madvise/madvise06.c
index 44a40ba..41e51f9 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -43,10 +43,7 @@
 char *TCID = "madvise06";
 int TST_TOTAL = 1;

-#ifdef __x86_64__
-
 #define GB_SZ  (1024*1024*1024)
-#define PG_SZ  (4*1024)

 static long dst_max;

@@ -100,7 +97,7 @@ static int get_page_fault_num(void)

 static void test_advice_willneed(void)
 {
-       int i;
+       int i, pg_sz;
        char *src;
        char *dst[100];
        int page_fault_num_1;
@@ -124,8 +121,9 @@ static void test_advice_willneed(void)

        tst_resm(TINFO, "PageFault(no madvice): %d", get_page_fault_num());

+       pg_sz = getpagesize();
        /* Do madvice() to dst[0] */
-       TEST(madvise(dst[0], PG_SZ, MADV_WILLNEED));
+       TEST(madvise(dst[0], pg_sz, MADV_WILLNEED));
        if (TEST_RETURN == -1)
                tst_brkm(TBROK | TERRNO, NULL, "madvise failed");

@@ -147,11 +145,3 @@ static void test_advice_willneed(void)
        for (i = 0; i < dst_max; ++i)
                SAFE_MUNMAP(NULL, dst[i], 1 * GB_SZ);
 }
-
-
-#else
-int main(void)
-{
-       tst_brkm(TCONF, NULL, "Only test on x86_64.");
-}
-#endif



>
> Otherwise the test looks fine.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160405/149c46b8/attachment.html>
