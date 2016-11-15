From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Nov 2016 16:19:19 +0100
Subject: [LTP] [PATCH 3/4] syscalls/setpriority01: Cleanup && Convert to
 new API
In-Reply-To: <1479116694-23167-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1479116694-23167-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1479116694-23167-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20161115151919.GA24751@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with cosmetic change, thanks.

I've added a curly bracse around this multilne if body:

> +	if (!failflag)
> +		tst_res(TPASS, "setpriority(%d, 0, -20..19) succeeded",
> +			tc->which);


-- 
Cyril Hrubis
chrubis@suse.cz
