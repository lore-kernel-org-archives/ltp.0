From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Dec 2016 17:17:51 +0100
Subject: [LTP] [PATCH v2 4/5] ipc/msgget02.c: reconstruct && convert to
	new API
In-Reply-To: <1481087800-20639-4-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20161123135513.GI3346@rei.lan>
 <1481087800-20639-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1481087800-20639-4-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161212161751.GH21828@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void cleanup(void)
>  {
> -	/* if it exists, remove the message queue that was created. */
>  	rm_queue(msg_q_1);
>  
> -	tst_rmdir();
> -
> +	msg_q_1 = -1;

Here again, no need to reset the msg_q_1 to -1, otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
