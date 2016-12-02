From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 2 Dec 2016 21:33:57 +0100
Subject: [LTP] [PATCH v4 1/1] syscalls/mq_unlink: convert to use new
 test library API
In-Reply-To: <20161202141251.26121-1-pvorel@suse.cz>
References: <20161202141251.26121-1-pvorel@suse.cz>
Message-ID: <20161202203356.wgdckanthjsulvxr@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
<snip>
> +	/* cleanup */
> +	if (tc->user != NULL && seteuid(euid) == -1)
> +		tst_res(TWARN | TTERRNO, "seteuid back to %d failed", euid);
> +
> +	if (fd > 0 && close(fd))
> +		tst_res(TWARN | TERRNO, "close(fd) failed");
TTERRNO :-(.

Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161202/dac765df/attachment.sig>
