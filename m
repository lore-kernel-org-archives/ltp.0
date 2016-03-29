From: Li Wang <liwang@redhat.com>
Date: Tue, 29 Mar 2016 16:44:50 +0800
Subject: [LTP] [PATCH] madvice: new case for madvise(WILLNEED)
In-Reply-To: <20160322141517.GD10905@rei.suse.cz>
References: <1458282662-21666-1-git-send-email-liwang@redhat.com>
 <20160322141517.GD10905@rei.suse.cz>
Message-ID: <CAEemH2dbhLDybwNQqqB+biuMzDp=8A3JfVZ+ywJjF9VTE22AoA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Tue, Mar 22, 2016 at 10:15 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > +/*
> > + * DESCRIPTION
> > + *
> > + *   Page fault occurs in spite that madvise(WILLNEED) system call is
> called
> > + *   to prefetch the page. This issue is reproduced by running a program
> > + *   which sequentially accesses to a shared memory and calls
> madvise(WILLNEED)
> > + *   to the next page on a page fault.
> > + *
> > + *   This bug is present in all RHEL7 versions. It looks like this was
> fixed in
> > + *   mainline kernel > v3.15 by the following patch:
> > + *
> > + *   commit 55231e5c898c5c03c14194001e349f40f59bd300
> > + *   Author: Johannes Weiner <hannes@cmpxchg.org>
> > + *   Date:   Thu May 22 11:54:17 2014 -0700
> > + *
> > + *       mm: madvise: fix MADV_WILLNEED on shmem swapouts
> > + */
> > +
> > +#include <stdio.h>
> > +#include <sys/shm.h>
> > +#include <errno.h>
> > +#include <sys/sysinfo.h>
> > +
> > +#include "test.h"
> > +#include "safe_macros.h"
> > +
> > +char *TCID = "madvise06";
> > +int TST_TOTAL = 1;
> > +
> > +#if __x86_64__
>     ^
> #ifdef
>
> > +#define GB_SZ  (1024*1024*1024)
> > +#define PG_SZ  (4*1024)
> > +
> > +#define INV_PTR ((char *)-1)
> > +
> > +static int id_src_1gb;
> > +static char *src_1gb;
> > +
> > +static int *id_dst;
> > +static char **dst;
> > +static long dst_num;
> > +
> > +static struct sysinfo *sys_buf;
> > +static long mem_total;
> > +
> > +static int page_fault_num1;
> > +static int page_fault_num2;
> > +
> > +static void setup(void);
> > +static void cleanup(void);
> > +static void free_shm(void);
> > +static int  get_page_fault_num(void);
> > +static void test_advice_willneed(void);
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     int lc;
> > +
> > +     tst_parse_opts(argc, argv, NULL, NULL);
> > +
> > +     sys_buf = malloc(sizeof(struct sysinfo));
> > +     sysinfo(sys_buf);
> > +     mem_total = sys_buf->totalram;
>
> Just why do you use malloc to allocate small structure? Why can't you
> just create it on the stack instead?
>
> Also why do you have global pointer to it when it's not used outside of
> the main() function?
>
> And also getting the amount of system memory is something that should be
> done in the setup() function instead.
>

ok, I will make them be created on the stack in setup().


>
> > +     setup();
> > +
> > +     for (lc = 0; TEST_LOOPING(lc); lc++) {
> > +             test_advice_willneed();
> > +
> > +             if (page_fault_num1 != page_fault_num2)
> > +                     tst_resm(TFAIL, "Bug has been reproduced!");
> > +             else
> > +                     tst_resm(TPASS, "Regression test pass!");
>
> The TPASS/TFAIL should be printed in the test_advice_willneed()
> function and the page_fault* variables shouldn't be global.


> > +             free_shm();
> > +     }
> > +
> > +     free(sys_buf);
> > +     tst_exit();
> > +}
> > +
> > +static void setup(void)
> > +{
> > +     tst_sig(NOFORK, DEF_HANDLER, cleanup);
> > +     if (tst_kvercmp(3, 9, 0) < 0)
> > +             tst_brkm(TCONF, NULL, "madvise(MADV_WILLNEED) swap file"
> > +                     "prefetch available only since 3.9");
> > +
> > +     if (mem_total < 2L * GB_SZ) {
> > +             tst_resm(TCONF, "Test requires more than 2GB of RAM");
> > +             tst_exit();
>
> tst_brkm(TCONF, NULL, "...");
>
> > +     } else if (mem_total > 100L * GB_SZ) {
>
> Why is the else branch here if you call tst_exit() in the body of the if
> above?
>
> > +             tst_resm(TCONF, "System RAM is too large, skip this
> test.");
> > +             tst_exit();
>
> tst_brkm(TCONF, NULL, ...);
>
> Also why do we skip the test on systems with large RAM?
>
> Does it take too long?
>

Yes, the memmove() takes too long on larger RAM, so I limit the test on
less than 100G system.


>
> > +     }
> > +
> > +     TEST_PAUSE;
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +     free_shm();
> > +}
> > +
> > +static void free_shm(void)
> > +{
> > +     int i;
> > +
> > +     if (id_src_1gb != -1) {
> > +             if (shmctl(id_src_1gb, IPC_RMID, NULL) == -1)
> > +                     tst_brkm(TBROK | TERRNO, NULL,
> "shmctl(id_src_1gb)");
> > +     }
> > +
> > +     for (i = 0; i < dst_num; ++i) {
> > +             if (id_dst[i] != -1) {
> > +                     if (shmctl(id_dst[i], IPC_RMID, NULL) == -1)
> > +                             tst_brkm(TBROK | TERRNO, NULL,
> "shmctl(id_dst[i])");
> > +             }
> > +     }
>
> You can shmctl(..., IPC_RMID) the memory right after you did shmat() and
> you don't have to remember the ids that way, the memory will be
> accesible till you detach it with shmdt(). In other words this will not
> free the memory at all. Does the test runs with -i 100?
>

run with -i 100, it  triggers the oom-killer.


>
> > +}
> > +
> > +static int get_page_fault_num(void)
> > +{
> > +     FILE *fp;
> > +     char s[11][256];
> > +     int pg, ret;
> > +
> > +     fp = fopen("/proc/self/stat", "r");
> > +     if (fp == NULL)
> > +             tst_brkm(TBROK | TERRNO, cleanup, "Failed to open
> /proc/self/stat.");
> > +
> > +     ret = fscanf(fp, "%s %s %s %s %s %s %s %s %s %s %s %d",
> > +                     s[0], s[1], s[2], s[3], s[4], s[5], s[6], s[7],
> s[8], s[9], s[10], &pg);
>
> fscanf has assigment-supression operator '*' so you can just do:
>
> SAFE_FILE_SCANF("/proc/self/stat",
>                 "%*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %d",
>                 &pg);
>

pretty good! it makes the code much less but clearer.


>
> > +     if (ret != 12) {
> > +             tst_resm(TFAIL, "Failed to get page fault num.");
> > +             pg = -1;
> > +     }
> > +
> > +     fclose(fp);
> > +     return pg;
> > +}
> > +
> > +static void test_advice_willneed(void)
> > +{
> > +     int i;
> > +
> > +     dst_num = mem_total / GB_SZ;
> > +     tst_resm(TINFO, "dst_num =  %ld", dst_num);
> > +
> > +     if ((id_dst = malloc(dst_num * sizeof(int))) == NULL)
> > +             tst_brkm(TBROK | TERRNO, NULL, "malloc failed.");
> > +
> > +     if ((dst = malloc(dst_num * sizeof(char *))) == NULL)
> > +             tst_brkm(TBROK | TERRNO, NULL, "malloc failed.");
>
> Make use of SAFE_MALLOC().
>
> > +     id_src_1gb = -1;
> > +     src_1gb = INV_PTR;
> > +     for (i = 0; i < dst_num; ++i) {
> > +             id_dst[i] = -1;
> > +             dst[i] = INV_PTR;
> > +     }
> > +
> > +     /* allocate source memory (1GB only) */
> > +     id_src_1gb = shmget(IPC_PRIVATE, 1 * GB_SZ, IPC_CREAT);
> > +     if (id_src_1gb == -1)
> > +             tst_brkm(TBROK | TERRNO, cleanup, "shmget failed");
> > +     src_1gb = shmat(id_src_1gb, 0, 0);
> > +     if (src_1gb == INV_PTR)
> > +             tst_brkm(TBROK | TERRNO, cleanup, "shmat failed");
> > +
> > +     /* allocate destination memory (array) */
> > +     for (i = 0; i < dst_num; ++i) {
> > +             id_dst[i] = shmget(IPC_PRIVATE, 1 * GB_SZ, IPC_CREAT);
> > +             if (id_dst[i] == -1)
> > +                     tst_brkm(TBROK | TERRNO, cleanup, "shmget failed");
> > +
> > +             dst[i] = shmat(id_dst[i], 0, 0);
> > +             if (dst[i] == INV_PTR)
> > +                     tst_brkm(TBROK | TERRNO, cleanup, "shmat failed");
>
> Why can't we just use mmap() with MAP_ANONYMOUS instead? Do we really
> need to use the System V shm?
>

Just tried mmap() with flag 'MAP_SHARED | MAP_ANONYMOUS', it reproduced the
bug as we expected. Now, I decide to use mmap(). thanks!


>
> > +     }
> > +
> > +     /* memmove  source to each destination memories (for SWAP-OUT) */
> > +     for (i = 0; i < dst_num; ++i) {
> > +             memmove(dst[i], src_1gb, 1 * GB_SZ);
> > +             fflush(stdout);
>
> Why do we fflush(stdout) here? We do not write to it at all.
>
> > +     }
> > +
> > +     /* Do madvice() to dst[0] */
> > +     tst_resm(TINFO, "PageFault(before madvice): %d",
> get_page_fault_num());
> > +
> > +     TEST(madvise(dst[0], PG_SZ, MADV_WILLNEED));
> > +     if (TEST_RETURN == -1)
> > +             tst_brkm(TBROK | TERRNO, cleanup, "madvise failed");
> > +     sleep(3);  /* wait for read from SWAP */
>
> Can't we just loop here with a usleep(1000) waiting for the page_fault
> count to increase?
>
> Doing blind sleep(3) does not guarantee that the event we are wating
> for really happened and will slown down the testing.
>
> > +     /* Read dst[0] data */
>
> Eh? You are writing to dst[0] here.
>
> > +     page_fault_num1 = get_page_fault_num();
> > +     tst_resm(TINFO, "PageFault(after madvice / before Mem Access):
> %d", page_fault_num1);
> > +
> > +     *dst[0] = 10;
> > +     page_fault_num2 = get_page_fault_num();
> > +     tst_resm(TINFO, "PageFault(after madvice / after Mem Access): %d",
> page_fault_num2);
>
> You are allocating the dst arrays on each test iteration but they are
> not freed. You should rather allocate them once in the setup and free
> then in the cleanup.
>
> Also the test would not run if you have more than 100GB so we can easily
> setup static global array for 100 pointers and be done with it.
>

sure, I tend to declare the global arrays as id_des[100], dst[100].

And, I accepted all the other comments in above. Thanks for reviewing,
PATCH V2 will be sent out soon.


-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160329/c0b3a0f6/attachment-0001.html>
