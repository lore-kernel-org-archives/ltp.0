From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 8 Oct 2018 14:09:40 +0200
Subject: [LTP] [PATCH 1/1] syscalls/statx04: TCONF on BTRFS for kernel <
	4.13
In-Reply-To: <20181008115411.GA13162@rei.lan>
References: <20181008093322.8624-1-pvorel@suse.cz>
 <20181008115411.GA13162@rei.lan>
Message-ID: <20181008120939.GA31388@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Why not just:

> 	if (!strcmp(tst_device->fs_type, "btrfs") && tst_kvercmp(4, 13, 0) < 0)
> 		tst_brk(TCONF, "Btrfs statx() supported since 4.13");


> There is no point in parsing a statically defined string that will never
> change with tst_parse_kver().

Sure, make sense.
Thanks for pointing out silly code.
Pushed with your reviewed-by tag.

Kind regards,
Petr
