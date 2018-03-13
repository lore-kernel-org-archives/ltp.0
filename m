From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Mar 2018 13:26:30 +0100
Subject: [LTP] [PATCH v6 1/3] Add library support for
 /proc/sys/kernel/tainted
In-Reply-To: <20180309124418.30271-2-mmoese@suse.de>
References: <20180309124418.30271-1-mmoese@suse.de>
 <20180309124418.30271-2-mmoese@suse.de>
Message-ID: <20180313122630.GA19715@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static unsigned int tst_taint_read(void)
> +{
> +	unsigned int val;
> +
> +	if (taint_mask == (unsigned int) -1)
> +		tst_brk(TBROK, "need to call tst_taint_init() first");

I've removed this check, since all the entry points that could call
this function either set the taint_mask or checks that it has been set.

And finally pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
