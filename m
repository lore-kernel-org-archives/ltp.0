From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 14 Aug 2020 16:15:46 +0800
Subject: [LTP] [PATCH] syscalls/msgrcv07: Add functional test for
 MSG_COPY flag
In-Reply-To: <1597392640-26678-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1597392640-26678-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <138b18cf-3a3c-c3e6-b20e-ca7f35072d1a@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril

> When specifying MSG_COPY flag, we can read the msg but don't destory
> it in msg queue and mtype is interpreted as number of the message to
> copy. We check the read data whether correctly and use msgctl to
> check whether we still have 2 msg in msg queue after msgrcv(MSG_COPY).
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
> Hi Cyril
> This patch is based on new msgrcv07.c(test different msgtyp) and also
> based on MSG_COPY error test(introduced MSG_COPY flag in lapi/msg.h).
>   .../kernel/syscalls/ipc/msgrcv/msgrcv07.c     | 63 +++++++++++++++++--
>   1 file changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> index f6139ba57..51dbc8951 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> @@ -3,12 +3,13 @@
>    * Copyright (c) 2014-2020 Fujitsu Ltd.
>    * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
>    *
> - * Basic test for msgrcv(2) using MSG_EXCEPT, MSG_NOERROR and different
> - * msg_typ(zero,positive,negative).
> + * Basic test for msgrcv(2) using MSG_EXCEPT, MSG_NOERROR, MSG_COPY
> + * and different msg_typ(zero,positive,negative).
>    */
>   
>   #define  _GNU_SOURCE
>   #include <sys/wait.h>
> +#include "lapi/msg.h"
>   #include "tst_test.h"
>   #include "tst_safe_sysv_ipc.h"
>   #include "libnewipc.h"
> @@ -19,7 +20,7 @@
>   #define MSG2	"messagetype2"
>   
>   static key_t msgkey;
> -static int queue_id = -1;
> +static int queue_id = -1, msg_copy_sup;
>   static struct buf {
>   	long type;
>   	char mtext[MSGSIZE];
> @@ -141,15 +142,69 @@ static void test_negative_msgtyp(void)
>   	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
>   }
>   
> +static void test_msg_copy(void)
> +{
> +	struct msqid_ds buf = {0};
> +
> +	if (!msg_copy_sup)
> +		tst_res(TCONF, "kernel doesn't support MSG_COPY flag, skip it");
Sorry, here missed a return;
> +	prepare_queue();
> +
> +	/*
> +	 * If MSG_COPY flag was specified, then mtype is interpreted as number
> +	 * of the message to copy.
> +	 */
> +	SAFE_MSGRCV(queue_id, &rcv_buf, MSGSIZE, 0, MSG_COPY | IPC_NOWAIT);
> +	if (strcmp(rcv_buf.mtext, MSG1) == 0 && rcv_buf.type == MSGTYPE1)
> +		tst_res(TPASS, "msgrcv(MSG_COPY) got MSGTYPE1 msg data"
> +			" correctly");
> +	else
> +		tst_res(TFAIL, "msgrcv(MSG_COPY) got MSGTYPE1 msg data"
> +			" incorrectly");
> +
> +	SAFE_MSGRCV(queue_id, &rcv_buf, MSGSIZE, 1, MSG_COPY | IPC_NOWAIT);
> +	if (strcmp(rcv_buf.mtext, MSG2) == 0 && rcv_buf.type == MSGTYPE2)
> +		tst_res(TPASS, "msgrcv(MSG_COPY) got MSGTYPE2 msg data"
> +			" correctly");
> +	else
> +		tst_res(TFAIL, "msgrcv(MSG_COPY) got MSGTYPE2 msg data"
> +			" incorrectly");
> +
> +	SAFE_MSGCTL(queue_id, IPC_STAT, &buf);
> +	if (buf.msg_qnum == 2)
> +		tst_res(TPASS, "msgrcv(MSG_COPY) succeeded, msg queue "
> +			"still has 2 msg");
> +	else
> +		tst_res(TFAIL, "msgrcv(MSG_COPY) msg queue expected 2 msg num,"
> +			" but only got %d", (int)buf.msg_qnum);
> +	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
> +}
>   
>   static void setup(void)
>   {
>   	msgkey = GETIPCKEY();
> +	prepare_queue();
> +	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, MSGTYPE1, MSG_COPY));
> +	if (TST_RET != -1)
> +		tst_res(TINFO, "msgrcv succeeded unexpectedly, kernel doesn't"
> +			" support MSG_COPY flag");
> +
> +	if (TST_ERR == EINVAL) {
> +		tst_res(TINFO, "msgrcv failed as expected when not using"
> +			" MSG_COPY and IPC_NOWAIT concurrently");
> +		msg_copy_sup = 1;
> +	} else if (TST_ERR == ENOSYS) {
> +		tst_res(TINFO, "kernel doesn't enable CONFIG_CHECKPOINT_RESTORE");
> +	} else {
> +		tst_res(TINFO | TTERRNO, "msgrcv failed when not using MSG_COPY"
> +			"and IPC_NOWAIT concurrently, expected EINVAL but got");
> +	}
> +	cleanup();
>   }
>   
>   static void (*testfunc[])(void) = {test_msg_except, test_msg_noerror,
>   				   test_zero_msgtyp, test_positive_msgtyp,
> -				   test_negative_msgtyp};
> +				   test_negative_msgtyp, test_msg_copy};
>   
>   static void verify_msgcrv(unsigned int n)
>   {
> 


