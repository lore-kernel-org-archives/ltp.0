From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Dec 2015 15:40:44 +0100
Subject: [LTP] [PATCH v2 1/2] preadv/preadv01.c: add new testcase
In-Reply-To: <1449142273-10679-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20151103144613.GE5795@rei>
 <1449142273-10679-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20151215144044.GD26217@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (i < tc->size) {
> +		tst_resm(TFAIL, "Buffer wrong at %i have %c expected a",
> +			 i, vec[i]);

I've changed the %c to %x since more than half of the char values are
non-printable ones and will probably mess up terminal.

> +	ret = tst_fill_file("file", 0x61, CHUNK, 2);
> +	if (ret)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Failed to fill test file");

Change to single tst_fill_file() is not a good one. Since that way we
cannot say that the offset parameter for the syscall is working as
expected. So I changed this part to go with memset() and SAFE_WRITE()
and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
