From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Fri, 25 Jun 2021 09:23:05 +0000
Subject: [LTP] [PATCH] ipc/msgget03: Make sure we get ENOSPC error after
 creating MSGMNI message queues
In-Reply-To: <CAEemH2eJLd5cSHZLUyXCYBhr643noDPT4RrMb8YBxrE_M3d1gA@mail.gmail.com>
References: <1624515373-3899-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2eJLd5cSHZLUyXCYBhr643noDPT4RrMb8YBxrE_M3d1gA@mail.gmail.com>
Message-ID: <60D5A0A0.7060801@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li
>
>
> On Thu, Jun 24, 2021 at 2:16 PM Yang Xu <xuyang2018.jy@fujitsu.com
> <mailto:xuyang2018.jy@fujitsu.com>> wrote:
>
>     Even msgget() failed, this for loop still continues. So we can't
>     know whether
>     system creates actual MSGMNI message queues and then fail with
>     ENOSPC. Fix this by
>     reporting fail if msgget failed in setup.
>
>     Also make use of TST_EXP_FAIL2 macro.
>
>
> Do we have TST_EXP_FAIL2 macro? or do you mean TST_EXP_FAIL?
> And the remaining part looks good.
Sorry. I should have added this macro implementation url(In review).
https://patchwork.ozlabs.org/project/ltp/patch/1624512827-3256-2-git-send-email-xuyang2018.jy@fujitsu.com/

Best Regards
Yang Xu

>
>
>     Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com
>     <mailto:xuyang2018.jy@fujitsu.com>>
>     ---
>     .../kernel/syscalls/ipc/msgget/msgget03.c | 21 +++++++------------
>     1 file changed, 7 insertions(+), 14 deletions(-)
>
>     diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
>     b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
>     index 8fa620855..da3753a19 100644
>     --- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
>     +++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
>     @@ -20,22 +20,14 @@
>     #include "tst_safe_sysv_ipc.h"
>     #include "libnewipc.h"
>
>     -static int maxmsgs;
>     +static int maxmsgs, queue_cnt;
>     static int *queues;
>     static key_t msgkey;
>
>     static void verify_msgget(void)
>     {
>     - TEST(msgget(msgkey + maxmsgs, IPC_CREAT | IPC_EXCL));
>     - if (TST_RET != -1)
>     - tst_res(TFAIL, "msgget() succeeded unexpectedly");
>     -
>     - if (TST_ERR == ENOSPC) {
>     - tst_res(TPASS | TTERRNO, "msgget() failed as expected");
>     - } else {
>     - tst_res(TFAIL | TTERRNO, "msgget() failed unexpectedly,"
>     - " expected ENOSPC");
>     - }
>     + TST_EXP_FAIL2(msgget(msgkey + maxmsgs, IPC_CREAT | IPC_EXCL), ENOSPC,
>     + "msgget(%i, %i)", msgkey + maxmsgs, IPC_CREAT | IPC_EXCL);
>     }
>
>     static void setup(void)
>     @@ -52,8 +44,9 @@ static void setup(void)
>     queues[num] = -1;
>
>     res = msgget(msgkey + num, IPC_CREAT | IPC_EXCL);
>     - if (res != -1)
>     - queues[num] = res;
>     + if (res == -1)
>     + tst_brk(TBROK | TERRNO, "msgget failed unexpectedly");
>     + queues[queue_cnt++] = res;
>     }
>
>     tst_res(TINFO, "The maximum number of message queues (%d) reached",
>     @@ -67,7 +60,7 @@ static void cleanup(void)
>     if (!queues)
>     return;
>
>     - for (num = 0; num < maxmsgs; num++) {
>     + for (num = 0; num < queue_cnt; num++) {
>     if (queues[num] != -1)
>     SAFE_MSGCTL(queues[num], IPC_RMID, NULL);
>     }
>     --
>     2.23.0
>
>
>     --
>     Mailing list info: https://lists.linux.it/listinfo/ltp
>
>
>
> --
> Regards,
> Li Wang
