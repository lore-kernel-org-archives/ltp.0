From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Mar 2017 11:28:07 +0200
Subject: [LTP] [PATCH 2/2] syscalls/read01.c: Cleanup && convert to new
 API.
In-Reply-To: <1490606323-17168-2-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1490606323-17168-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1490606323-17168-2-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20170330092807.GA12095@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	memset(buf, '*', SIZE);
> +	for (i = 0; i < SIZE; i++) {
> +		if (buf[i] != '*') {
> +			tst_brk(TBROK, "buf setup failed: "
> +				"expected * at buf[%d], found %c", i, buf[i]);
>  		}
>  	}

I've removed this dubious check that just checks if memset() does it's
job and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
