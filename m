From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Jul 2019 13:36:48 +0200
Subject: [LTP] [PATCH 2/2] syscalls/nanosleep04: Ported into new library
In-Reply-To: <1564363652-3975-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1564363652-3975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1564363652-3975-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190730113648.GB10214@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor change, thanks.

> -	if (TEST_RETURN != -1) {
> -		tst_resm(TFAIL, "nanosleep() succeded unexpectedly");
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "nanosleep() succeded unexpectedly");

I've changed this message to print the value of TST_RET.

-- 
Cyril Hrubis
chrubis@suse.cz
