From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jun 2018 13:24:12 +0200
Subject: [LTP] [RFC PATCH 3/9] syscalls/ipc: Rewrite msgctl01 + merge
 msgctl06
In-Reply-To: <20180612154631.435-4-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
 <20180612154631.435-4-chrubis@suse.cz>
Message-ID: <20180613112412.x3ppu3vpjjlegjlv@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Rewrite msgctl01 to be much more strict, now we assert all fields of the
> buffer we get from IPC_STAT.

> This also removes msgctl06 that was testing the very same IPC_STAT
> command but checked different subset of the msqid_ds buffer.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---

Nice improvement :).
I guess it doesn't make sense to check msqid_ds.__msg_cbytes (and it's also nonstandard).

> +	if (buf.msg_lspid == 0)
> +		tst_res(TPASS, "msg_lspid = 0");
> +	else
> +		tst_res(TFAIL, "msg_lspid = %u", (unsigned)buf.msg_lspid);
checkpatch.pl complains about unsigned instead of unsigned int, but that's nothing we should worry about.


Kind regards,
Petr
