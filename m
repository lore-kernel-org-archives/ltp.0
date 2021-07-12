From: Li Wang <liwang@redhat.com>
Date: Mon, 12 Jul 2021 16:42:55 +0800
Subject: [LTP] [PATCH v2 1/2] shmget03: don't depend on existed shared
 resources
In-Reply-To: <af9eb653-4c75-938e-71b1-2e4050b39d26@bell-sw.com>
References: <20210712075223.10682-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2ehOzddTbDqZBcbyZcnUy3899u_U81XGtckf1Gs_LJGMA@mail.gmail.com>
 <af9eb653-4c75-938e-71b1-2e4050b39d26@bell-sw.com>
Message-ID: <CAEemH2d9gYfTE28m9bzXstSLWes36bbBo3EuoVvJa2AQpC2DXQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jul 12, 2021 at 4:37 PM Alexey Kodanev <aleksei.kodanev@bell-sw.com>
wrote:

> On 12.07.2021 11:28, Li Wang wrote:
> >
> >
> > On Mon, Jul 12, 2021 at 3:54 PM Alexey Kodanev <
> aleksei.kodanev@bell-sw.com <mailto:aleksei.kodanev@bell-sw.com>> wrote:
> >
> >     It's unlikely, but still possible that some of them could be
> >     created/released during the test as well, so the patch only
> >     checks errno.
> >
> >     Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com <mailto:
> aleksei.kodanev@bell-sw.com>>
> >     ---
> >     v2: * Move the loop to the test run function and try to get
> >           ENOSPC errno there.
> >
> >
> > I'm fine to go with this but move the loop to test run without any
> > limit will bring new fail if running with parameter '-i 2'.
> >
> > We have to handle that situation (maybe add a judgment to skip
> > test for run more times) in case someone uses it like:
>
> Or just release them asap after tpass?


Sure, but looks a bit redundant.

Or we can just adding a global varible for saving num:

--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -22,7 +22,7 @@
 #include "libnewipc.h"

 static int *segments;
-static int maxshms, segments_cnt;
+static int number = 0, maxshms, segments_cnt;
 static key_t shmkey;

 static void verify_shmget(void)
@@ -30,7 +30,7 @@ static void verify_shmget(void)
        int res = 0, num;

        errno = 0;
-       for (num = 0; num <= maxshms; ++num) {
+       for (num = number; num <= maxshms; ++num) {
                res = shmget(shmkey + num, SHM_SIZE, IPC_CREAT | IPC_EXCL |
SHM_RW);
                if (res == -1)
                        break;
@@ -42,6 +42,8 @@ static void verify_shmget(void)

        tst_res(TPASS, "Maximum number of segments reached (%d), used by
test %d",
                maxshms, segments_cnt);
+
+       number = num;
 }

 static void setup(void)


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210712/22e4fe29/attachment.htm>
