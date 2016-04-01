From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Apr 2016 11:09:27 +0800
Subject: [LTP] [PATCH V2] madvice: new case for madvise(WILLNEED)
In-Reply-To: <20160331115547.GA21298@rei.lan>
References: <1459245344-5983-1-git-send-email-liwang@redhat.com>
 <20160331115547.GA21298@rei.lan>
Message-ID: <CAEemH2dyZGngeFBn41a2D_iZObQpYw2xMh94NGgq7YeYTB49_A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Thu, Mar 31, 2016 at 7:55 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> ...
> > +#include <stdio.h>
> > +#include <sys/shm.h>
>
> We don't need this header now, right?
>

right! I forgot to remove that.


>
> > +#include <errno.h>
> > +#include <sys/sysinfo.h>
> > +
> > +#include "test.h"
> > +#include "safe_macros.h"
> > +
> > +char *TCID = "madvise06";
> > +int TST_TOTAL = 3;
> > +
> > +#ifdef __x86_64__
> > +
> > +#define GB_SZ  (1024*1024*1024)
> > +#define PG_SZ  (4*1024)
> > +
> > +static long dst_num;
> > +
> > +static void setup(void);
> > +static int  get_page_fault_num(void);
> > +static void test_advice_willneed(void);
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     int i, lc;
> > +
> > +     tst_parse_opts(argc, argv, NULL, NULL);
> > +
> > +     setup();
> > +
> > +     for (lc = 0; TEST_LOOPING(lc); lc++) {
> > +             tst_count = 0;
> > +
> > +             for(i = 0; i < TST_TOTAL; i++)
> > +                     test_advice_willneed();
>
> So we do three iterations of the test to increase the likehood of
> hitting the bug, right? In that case we should just add -i 3 to the
> runtest file.
>

ok. Even no need to add -i 3 in runtest file, It is easy to reproduce the
issue with un-patched kernel. I will set the TST_TOTAL = 1.


>
> > +     }
> > +
> > +     tst_exit();
> > +}
> > +
> > +static void setup(void)
> > +{
> > +     struct sysinfo sys_buf;
> > +
> > +     sysinfo(&sys_buf);
> > +
> > +     dst_num = sys_buf.totalram / GB_SZ;
> > +     tst_resm(TINFO, "dst_num =  %ld", dst_num);
>
> The variable should be named as dst_max instead of dst_num. Which would
> make the message more understandable...
>

agreed.


>
> > +     tst_sig(NOFORK, DEF_HANDLER, NULL);
> > +     if (tst_kvercmp(3, 9, 0) < 0)
> > +             tst_brkm(TCONF, NULL, "madvise(MADV_WILLNEED) swap file"
> > +                     "prefetch available only since 3.9");
> > +
> > +     if (sys_buf.totalram < 2L * GB_SZ)
> > +             tst_brkm(TCONF, NULL, "Test requires more than 2GB of
> RAM.");
> > +     if (sys_buf.totalram > 100L * GB_SZ)
> > +             tst_brkm(TCONF, NULL, "System RAM is too large, skip this
> test.");
> > +
> > +     TEST_PAUSE;
> > +}
> > +
> > +static int get_page_fault_num(void)
> > +{
> > +     int pg;
> > +
> > +     SAFE_FILE_SCANF(NULL, "/proc/self/stat",
> > +                     "%*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %d",
> > +                     &pg);
> > +
> > +     return pg;
> > +}
> > +
> > +static void test_advice_willneed(void)
> > +{
> > +     int i;
> > +     char *src_1gb;
> > +     char *dst[100];
> > +     int page_fault_num1;
> > +     int page_fault_num2;
> > +
> > +     /* allocate source memory (1GB only) */
> > +     src_1gb = mmap(NULL, 1 * GB_SZ, PROT_READ | PROT_WRITE,
> > +                     MAP_SHARED | MAP_ANONYMOUS,
> > +                     -1, 0);
> > +     if (src_1gb == MAP_FAILED)
> > +             tst_brkm(TFAIL | TERRNO, NULL, "mmap failed");
>
> Use SAFE_MMAP()
>
> > +     /* allocate destination memory (array) */
> > +     for (i = 0; i < dst_num; ++i) {
> > +             dst[i] = mmap(NULL, 1 * GB_SZ, PROT_READ | PROT_WRITE,
> > +                             MAP_SHARED | MAP_ANONYMOUS,
> > +                             -1, 0);
> > +             if (dst[i] == MAP_FAILED)
> > +                     tst_brkm(TFAIL | TERRNO, NULL, "mmap failed");
>
> Here as well.
>
> > +     }
> > +
> > +     /* memmove  source to each destination memories (for SWAP-OUT) */
> > +     for (i = 0; i < dst_num; ++i)
> > +             memmove(dst[i], src_1gb, 1 * GB_SZ);
> > +
> > +     tst_resm(TINFO, "PageFault(before madvice): %d",
> get_page_fault_num());
> > +
> > +     /* Do madvice() to dst[0] */
> > +     TEST(madvise(dst[0], PG_SZ, MADV_WILLNEED));
> > +     if (TEST_RETURN == -1)
> > +             tst_brkm(TBROK | TERRNO, NULL, "madvise failed");
> > +     usleep(1000);  /* wait for read from SWAP */
>
> Again, what exactly do we wait here for?
>
> "wait for read from SWAP" is a bit too vague.
>

okay, will remove the sleep() function.


>
> > +     page_fault_num1 = get_page_fault_num();
> > +     tst_resm(TINFO, "PageFault(after madvice / before Mem Access):
> %d", page_fault_num1);
>
> This line is over 80 chars. Try making the message shorter.
>
> You can use checkpatch.pl (shipped with Linux kernel) to check patches
> before submission.
>
> > +     *dst[0] = 'a';
> > +     page_fault_num2 = get_page_fault_num();
> > +     tst_resm(TINFO, "PageFault(after madvice / after Mem Access): %d",
> page_fault_num2);
>
> Here as well.
>
> > +
> > +     if (page_fault_num1 != page_fault_num2)
> > +             tst_resm(TFAIL, "Bug has been reproduced!");
> > +     else
> > +             tst_resm(TPASS, "Regression test pass!");
>
> No need for the ! in the TPASS message.
>
> > +     if (munmap(src_1gb, 1 * GB_SZ) == -1)
> > +             tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
>
> Use SAFE_MUNMAP()
>
> > +     for (i = 0; i < dst_num; ++i) {
> > +             if (munmap(dst[i], 1 * GB_SZ) == -1)
> > +                     tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
>
> Here as well.
>
>
accepted all the other suggestions, will fix the format isssue in patch V3.

Thank you.

-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160401/bade8ec9/attachment.html>
