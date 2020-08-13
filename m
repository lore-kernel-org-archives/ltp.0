From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Aug 2020 16:11:04 +0200
Subject: [LTP] [PATCH v1 2/3] syscalls/msgrcv07: Add different msgtyp
 test
In-Reply-To: <1595230227-21468-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1595230227-21468-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595230227-21468-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200813141104.GE13292@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> index 39fbdb67a..9b04fd2ac 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> @@ -3,7 +3,8 @@
>   * Copyright (c) 2014-2020 Fujitsu Ltd.
>   * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
>   *
> - * Basic test for msgrcv(2) using MSG_EXCEPT, MSG_NOERROR
> + * Basic test for msgrcv(2) using MSG_EXCEPT, MSG_NOERROR and different
> + * msg_typ(zero,positive,negative).
>   */
>  
>  #define  _GNU_SOURCE
> @@ -22,15 +23,20 @@ static int queue_id = -1;
>  static struct buf {
>  	long type;
>  	char mtext[MSGSIZE];
> -} rcv_buf, snd_buf[2] = {
> +} rcv_buf, snd_buf[3] = {
>  	{MSGTYPE1, MSG1},
> -	{MSGTYPE2, MSG2}
> +	{MSGTYPE2, MSG2},
>  };

This is a bit useless change.

>  static void test_msg_except(void);
>  static void test_msg_noerror(void);
> +static void test_zero_msgtyp(void);
> +static void test_positive_msgtyp(void);
> +static void test_negative_msgtyp(void);
>  static void cleanup(void);
> -static void (*testfunc[])(void) = {test_msg_except, test_msg_noerror};
> +static void (*testfunc[])(void) = {test_msg_except, test_msg_noerror,
> +				   test_zero_msgtyp, test_positive_msgtyp,
> +				   test_negative_msgtyp};
>  
>  static void verify_msgcrv(unsigned int n)
>  {
> @@ -81,6 +87,73 @@ static void test_msg_noerror(void)
>  	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
>  }
>  
> +static void test_zero_msgtyp(void)
> +{
> +	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
> +	SAFE_MSGSND(queue_id, &snd_buf[0], MSGSIZE, 0);
> +	SAFE_MSGSND(queue_id, &snd_buf[1], MSGSIZE, 0);
> +	memset(&rcv_buf, 0, sizeof(rcv_buf));

This init is common for all of these tests, I guess that it would be
easier to put this piece of code into a function called prepare_queue()
so that we do not have to repeat it all over.

-- 
Cyril Hrubis
chrubis@suse.cz
