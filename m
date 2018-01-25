From: Michael Moese <mmoese@suse.de>
Date: Thu, 25 Jan 2018 13:26:40 +0100
Subject: [LTP] [PATCH v2] Add library support for
	/proc/sys/kernel/tainted
In-Reply-To: <20180125121641.26795-1-mmoese@suse.de>
References: <20180125121641.26795-1-mmoese@suse.de>
Message-ID: <20180125122640.ekdiy3pxyxpvbis7@linux.suse>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
I'm sorry I sent the wrong patch file. 
I will wait if you have other remarks, then re-send this.

> +void tst_taint_init(unsigned int mask)
> +{
> +	unsigned int taint = -1;
> +
> +	if (mask == 0)
> +		tst_brk(TBROK, "mask is not allowed to be 0");
> +
> +	if (tst_taint_check_kver(mask) < 0)
> +		tst_res(TCONF, "Kernel is too old for requested mask");
> +
> +	taint = tst_taint_read();
> +	if ((taint & mask) != 0)
> +		tst_res(TCONF, "Kernel is already tainted: %u", taint);
> +
> +	taint_mask = mask;

This line above should go before the call to tst_taint_read()

Thx,
Michael
-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
