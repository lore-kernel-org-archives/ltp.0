From: Murphy Zhou <xzhou@redhat.com>
Date: Sat, 11 May 2019 12:20:14 +0800
Subject: [LTP] [PATCH v4] syscalls/swap{on,
 off}: fail softly if FIBMAP ioctl trial fails
In-Reply-To: <CAOQ4uxjAzTL+aN4SdvD7xEUhuOht0nc70JDUOqAHGoyChOyPbA@mail.gmail.com>
References: <CAOQ4uxjDyx7JFBSmkDe-rHNe=NriT710Ldsva=s+HasaDL0CTw@mail.gmail.com>
 <20190510044217.5215-1-xzhou@redhat.com>
 <CAOQ4uxi1=Xj59GvyrJf9HiMgGvRYTC8HGG8UOZKz3B8zgGh52g@mail.gmail.com>
 <20190510081535.ax7th47uyjjkayk6@XZHOUW.usersys.redhat.com>
 <CAOQ4uxjAzTL+aN4SdvD7xEUhuOht0nc70JDUOqAHGoyChOyPbA@mail.gmail.com>
Message-ID: <20190511042014.xlonuwqpg6owg6a3@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 10, 2019 at 11:48:42AM +0300, Amir Goldstein wrote:
> On Fri, May 10, 2019 at 11:15 AM Murphy Zhou <xzhou@redhat.com> wrote:
> >
> > On Fri, May 10, 2019 at 08:27:35AM +0300, Amir Goldstein wrote:
> > > On Fri, May 10, 2019 at 7:42 AM Murphy Zhou <xzhou@redhat.com> wrote:
> > > >
> > > > Add a test helper to do a FIBMAP ioctl test. Remove old fs type whitelist code.
> > >
> > > If you wouldn't have just done that it would have been good.
> > > But your patch also changes a lot of the logic and output messages,
> > > which is less good.
> >
> > First of all, don't be mad if you think I'm changing too much. :)
> 
> Not mad. Sorry if came off this way..
> Just trying to explain why too much changes can be counter productive.
> And I am writing my opinion, you are not obliged to agree with it ;-)

Start your developer engine. Actually _think_ about what your're writing.
Your opinion varies every single post in this thread.

> 
> > I should have written more info here in commit message like in the changelog.
> >
> > If FIBMAP trial fails, don't bail out immediately, go on to the rest
> > of tests. Than don't report fail if swap* syscall fails, just record
> > the failure info, acting like a sanity check test.
> 
> In retrospect, I think the best approach is to do all the feature support
> testing in setup(). As someone else wrote, testing mkswap/swapon in setup()
> and keeping logic simpler in tests would be better.
> Testing FIBMAP and then mkwap/swpaon/swapoff will make sure that
> test will detect regression in swpaon with filesystems that support
> FIBMAP. It will not guaranty that for BTRFS/NFS, but that is the tradeoff
> of not whitelisting.
> 
> >
> > If FIBMAP trial pass, follow the original logic.
> >
> > The whitelist code removal is kinda independent. But combining with the
> > fibmap code it looks like a lot of logic changing.
> >
> > > For BTRFS, with a kernel that does not support swapon/off, test logic
> > > should have stayed the same and produce more or less the same output.
> > > This would have made review much easier and less chance of breaking things.
> >
> > I can understand the test logic part, but why the same output matters?
> > Since we are not using golden output like fstests :)
> 
> Same output doesn't matter, but output was good and you have not
> made it better you have made it worse - I will explain below.
> 
> >
> > Back to the logic, checking specific return value is precise, but it i
> >  hard to maintain them IMO. If kernel logic changes, it's easy to forget
> > updating testing logic. That's why I am fan of your whitelist avoiding
> > idea. Now if I understand correctly, you want to keep the filesystems
> > whitelist, fibmap test is just for the info. Am I right?
> 
> I meant you stopped checking errno == EINVAL, which is the only
> expected return value for fs that do not support swapon.
> If for some reason btrfs has a regression and swapon returns ENOSPC
> test MUST fail.

Ah, this is new to me.

> 
> >
> > For better communication, I'd like to remove whitelist code. Can we have
> > an alter opinion here?
> >
> > >
> > > > Leave swapoff02 alone because it's permission checking only in it.
> > > >
> > > > Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> > > > ---
> > > > v2:
> > > >   Test FIBMAP instead of fstype whitelist.
> > > > v3:
> > > >   Fix fs_type undeclared in swapoff01.c.
> > > > v4:
> > > >   Fail softly if FIBMAP nit supported, instead of skip entire testcase.
> > > >
> > > >  include/tst_fs.h                              |  5 ++
> > > >  lib/tst_ioctl.c                               | 39 ++++++++++++++
> > > >  testcases/kernel/syscalls/swapoff/swapoff01.c | 46 +++++++++-------
> > > >  testcases/kernel/syscalls/swapoff/swapoff02.c | 10 ----
> > > >  testcases/kernel/syscalls/swapon/swapon01.c   | 23 ++++----
> > > >  testcases/kernel/syscalls/swapon/swapon02.c   | 31 ++++++-----
> > > >  testcases/kernel/syscalls/swapon/swapon03.c   | 52 +++++++++----------
> > > >  7 files changed, 121 insertions(+), 85 deletions(-)
> > > >  create mode 100644 lib/tst_ioctl.c
> > > >
> > > > diff --git a/include/tst_fs.h b/include/tst_fs.h
> > > > index b2b19ada6..423ca82ec 100644
> > > > --- a/include/tst_fs.h
> > > > +++ b/include/tst_fs.h
> > > > @@ -172,6 +172,11 @@ const char **tst_get_supported_fs_types(void);
> > > >   */
> > > >  void tst_fill_fs(const char *path, int verbose);
> > > >
> > > > +/*
> > > > + * test if FIBMAP ioctl is supported
> > > > + */
> > > > +int tst_fibmap(const char *filename, const char *fstype);
> > > > +
> > > >  #ifdef TST_TEST_H__
> > > >  static inline long tst_fs_type(const char *path)
> > > >  {
> > > > diff --git a/lib/tst_ioctl.c b/lib/tst_ioctl.c
> > > > new file mode 100644
> > > > index 000000000..f63eb5565
> > > > --- /dev/null
> > > > +++ b/lib/tst_ioctl.c
> > > > @@ -0,0 +1,39 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +
> > > > +#include <errno.h>
> > > > +#include <stdio.h>
> > > > +#include <stdlib.h>
> > > > +#include <sys/ioctl.h>
> > > > +#include <linux/fs.h>
> > > > +
> > > > +#define TST_NO_DEFAULT_MAIN
> > > > +
> > > > +#include "tst_test.h"
> > > > +
> > > > +int tst_fibmap(const char *filename, const char *fstype)
> > > > +{
> > > > +       /* test if FIBMAP ioctl is supported */
> > > > +       int fd, block = 0;
> > > > +
> > > > +       tst_res(TINFO, "Testing if FIBMAP ioctl is supported on %s", fstype);
> > >
> > > passing the fstype into this helper seems quite irrelevant to me.
> > > the TINFO print doesn't justify it IMO
> > > Its not even an important info IMO, so as long as you have the print
> > > when FIBMAP not supported
> >
> > That's for ensure the test taking place in the right dir. We can remove this.
> >
> > >
> > > > +
> > > > +       fd = open(filename, O_RDWR | O_CREAT, 0666);
> > > > +       if (fd < 0) {
> > > > +               tst_res(TWARN | TERRNO,
> > > > +                        "open(%s, O_RDWR | O_CREAT, 0666) failed", filename);
> > > > +               return 1;
> > > > +       }
> > > > +
> > > > +       if (ioctl(fd, FIBMAP, &block)) {
> > > > +               tst_res(TINFO, "FIBMAP ioctl is NOT supported");
> > > > +               close(fd);
> > > > +               return 1;
> > > > +       }
> > > > +       tst_res(TINFO, "FIBMAP ioctl is supported");
> > > > +
> > > > +       if (close(fd)) {
> > > > +               tst_res(TWARN | TERRNO, "close(fd) failed");
> > > > +               return 1;
> > > > +       }
> > > > +       return 0;
> > > > +}
> > > > diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
> > > > index a63e661a5..fbce66fc8 100644
> > > > --- a/testcases/kernel/syscalls/swapoff/swapoff01.c
> > > > +++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
> > > > @@ -32,6 +32,7 @@ static void verify_swapoff(void);
> > > >
> > > >  char *TCID = "swapoff01";
> > > >  int TST_TOTAL = 1;
> > > > +int fibmap = 1;
> > > >
> > > >  static long fs_type;
> > > >
> > > > @@ -55,22 +56,26 @@ int main(int ac, char **av)
> > > >  static void verify_swapoff(void)
> > > >  {
> > > >         if (ltp_syscall(__NR_swapon, "./swapfile01", 0) != 0) {
> > > > -               if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
> > > > -                       tst_brkm(TCONF, cleanup,
> > > > -                                "Swapfiles on BTRFS are not implemented");
> > > > +               if (fibmap == 1) {
> > >
> > > This changes both logic and output message.
> > > I don't see a good reason for you to do that.
> > > Please keep the errno == EINVAL check and the message format for TCONF case
> > > Same comment for all the other places it applies
> >
> > Explained at the beginning.
> >
> > >
> > > > +                       tst_resm(TBROK, "Failed to turn on the swap file"
> > > > +                                ", skipping test iteration");
> > > > +                       return;
> > > > +               } else {
> > > > +                       tst_resm(TCONF, "Failed to turn on the swap file"
> > > > +                                ", keep going for sanity check");
> > > >                 }
> > > > -
> > > > -               tst_resm(TBROK, "Failed to turn on the swap file"
> > > > -                        ", skipping test iteration");
> > > > -               return;
> > > >         }
> > > >
> > > >         TEST(ltp_syscall(__NR_swapoff, "./swapfile01"));
> > > >
> > > >         if (TEST_RETURN == -1) {
> > > > -               tst_resm(TFAIL | TTERRNO, "Failed to turn off swapfile,"
> > > > -                        " system reboot after execution of LTP "
> > > > -                        "test suite is recommended.");
> > > > +               if (fibmap == 1) {
> > >
> > > No reason to do that.
> > > If filesystem was already proven to support swpaon(), swapoff() must succeed.
> > > If fs doesn't support swapon(), test should bail out and not try swapoff()
> >
> > If swapon() fails an fibmap == 0, we could be here for a sanity check. Big
> > chance it will fail, but hey, don't panic.
> 
> Of course swapoff will fail if swpaon failed.
> Should abort when swapon fails.
> 
> >
> > >
> > > > +                       tst_resm(TFAIL | TTERRNO, "Failed to turn off swapfile,"
> > > > +                                " system reboot after execution of LTP "
> > > > +                                "test suite is recommended.");
> > > > +               } else {
> > > > +                       tst_resm(TCONF, "Failed to turn off swapfile");
> > > > +               }
> > > >         } else {
> > > >                 tst_resm(TPASS, "Succeeded to turn off swapfile");
> > > >         }
> > > > @@ -86,13 +91,11 @@ static void setup(void)
> > > >
> > > >         tst_tmpdir();
> > > >
> > > > -       switch ((fs_type = tst_fs_type(cleanup, "."))) {
> > > > -       case TST_NFS_MAGIC:
> > > > -       case TST_TMPFS_MAGIC:
> > > > -               tst_brkm(TCONF, cleanup,
> > > > -                        "Cannot do swapoff on a file on %s filesystem",
> > > > -                        tst_fs_type_name(fs_type));
> > > > -       break;
> > > > +       fs_type = tst_fs_type(cleanup, ".");
> > > > +       if (tst_fibmap("./tst_fibmap", tst_fs_type_name(fs_type))) {
> > > > +               tst_resm(TCONF,
> > > > +                        "Will not report FAIL as FIBMAP ioctl not supported");
> > >
> > > Here printing fs name would be useful IMO
> >
> > Ya, I did it here firstly.
> >
> > >
> > > > +               fibmap = 0;
> > > >         }
> > > >
> > > >         if (!tst_fs_has_free(NULL, ".", 64, TST_MB)) {
> > > > @@ -103,8 +106,13 @@ static void setup(void)
> > > >         if (tst_fill_file("swapfile01", 0x00, 1024, 65536))
> > > >                 tst_brkm(TBROK, cleanup, "Failed to create file for swap");
> > > >
> > > > -       if (system("mkswap swapfile01 > tmpfile 2>&1") != 0)
> > > > -               tst_brkm(TBROK, cleanup, "Failed to make swapfile");
> > > > +       if (system("mkswap swapfile01 > tmpfile 2>&1") != 0) {
> > > > +               if (fibmap == 1) {
> > > > +                       tst_brkm(TBROK, cleanup, "Failed to make swapfile");
> > > > +               } else {
> > > > +                       tst_resm(TCONF, "Failed to make swapfile");
> > >
> > > You see, this message does not align with the outcome (skip).
> >
> > Sorry, you lost me here.
> >
> 
> Put your tester hat on. Imagine you do not know what swapfile is nor
> that filesystems may support it or not.
> Which is the following messages convey the test result better:
> 
> TCONF: Failed to make swapfile
> 
> OR
> 
> TCONF: mkswap not supported on btrfs filesystem

You are ranting at wrong guy. It was not me writing this message.

> 
> If test setup arrives to a conclusion that filesystem doesn't support test
> and test should be skipped, that is what should be communicated to user.
> 
> The BTRFS_MAGIC code that your patch removes does that correctly.
> Your patch does not.
> 
> Even the message:
> TCONF: "Will not report FAIL as FIBMAP ioctl not supported"
> is "too much information" IMO.
> Users without proper background won't know what it means.
> This would have been better IMO:
> TCONF: "FIBMAP ioctl not supported on XXX filesystem"

I guess LTP is not a desktop app :), but yes these messages need improvement.

Thanks,
M

> 
> Thanks,
> Amir.
