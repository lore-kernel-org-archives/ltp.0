From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jun 2018 14:12:30 +0200
Subject: [LTP] [RFC PATCH 7/9] syscalls/ipc: Rewrite msgctl12 to new
 library
In-Reply-To: <20180612154631.435-8-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
 <20180612154631.435-8-chrubis@suse.cz>
Message-ID: <20180613121230.4lif4aoaiqkt7dts@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/ipc/msgctl/msgctl12.c | 84 +++++++++----------------


> -static struct test_case_t {
> -	int *queue_id;
> -	int ipc_cmd;

LGTM, I'd use macro for string, but that's only nitpicking.

#define CMD_NAME(x) .cmd = x, .name = #x


> +static struct tcase {
> +	int *msg_id;
> +	int cmd;
>  	char *name;
>  	void *buf;
> -} test_cases[] = {
> +} tc[] = {
>  	{&msg_q, IPC_INFO, "IPC_INFO", &msginfo_buf},
>  	{&msg_q, MSG_INFO, "MSG_INFO", &msginfo_buf},
>  	{&index_q, MSG_STAT, "MSG_STAT", &msgqid_buf},
+ this:
    {&msg_q, CMD_NAME(IPC_INFO), &msginfo_buf},
    {&msg_q, CMD_NAME(MSG_INFO), &msginfo_buf},
    {&index_q, CMD_NAME(MSG_STAT), &msgqid_buf},


Kind regards,
Petr
