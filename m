From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 4 Apr 2017 15:44:38 +0200
Subject: [LTP] [PATCH v2 1/1] syscalls/madvise: Handle zero page
	poisoning
In-Reply-To: <20170403130121.2bbe7cb2@linux-v3j5>
References: <20170403130121.2bbe7cb2@linux-v3j5>
Message-ID: <20170404134438.GA9550@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with cosmetic changes, thanks.

> +	if (maptype == MAP_PRIVATE)
> +		tst_res(TCONF,
> +			"Zero page poisoning is probably not implemented");
> +	else
> +		tst_res(TFAIL,
> +			"Did not receive SIGBUS after accessing %s memory marked with MADV_HWPOISON",
> +			mapname(maptype));

Added braces around these multiline statements as well.

-- 
Cyril Hrubis
chrubis@suse.cz
