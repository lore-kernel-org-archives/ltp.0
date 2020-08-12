From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 Aug 2020 16:40:07 +0200
Subject: [LTP] [PATCH] syscalls/msgget04: Add test for
 /proc/sys/kernel/msg_next_id
In-Reply-To: <1595245614-24814-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1595245614-24814-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200812144007.GA23472@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget04.c b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
> new file mode 100644
> index 000000000..3791f331a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
> + *
> + * It is a basic test about msg_next_id.
> + * msg_next_id specifies desired id for next allocated IPC message. By default
> + * they are equal to -1, which means generic allocation logic. Possible values
> + * to set are in range {0..INT_MAX}.
> + * Toggle with non-default value will be set back to -1 by kernel after
> + * successful IPC object allocation.
> + */
> +
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/msg.h>
> +#include "tst_test.h"
> +#include "tst_safe_sysv_ipc.h"
> +#include "libnewipc.h"
> +
> +#define NEXT_ID_PATH "/proc/sys/kernel/msg_next_id"
> +static int queue_id = 1, pid;
> +static key_t msgkey;
> +
> +static void verify_msgget(void)
> +{
> +	SAFE_FILE_PRINTF(NEXT_ID_PATH, "%d", pid);
> +
> +	TEST(msgget(msgkey, IPC_CREAT | MSG_RW));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "msgget() failed");
> +		return;
> +	}
> +
> +	queue_id = TST_RET;
> +	if (queue_id == pid)
> +		tst_res(TPASS, "msg_next_id succeeded, queue id %d", pid);
> +	else
> +		tst_res(TFAIL, "msg_next_id failed, expected id %d, but got %d", pid, queue_id);
> +
> +	TST_ASSERT_INT(NEXT_ID_PATH, -1);
> +	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
> +	pid++;
> +}
> +
> +static void setup(void)
> +{
> +	msgkey = GETIPCKEY();
> +	pid = getpid();
> +}
> +
> +static void cleanup(void)
> +{
> +	if (queue_id != -1)
> +		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
> +	SAFE_FILE_SCANF(NEXT_ID_PATH, "-1");

Shouldn't this be SAFE_FILE_PRINTF() ?

Otherwise it looks fine, also I can fix this one before pushing.



Also what happens when we write id of existing id to that file? I guess
that we can write another test that tries that...

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_msgget,
> +	.needs_root = 1,
> +};
> -- 
> 2.23.0
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
