From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Apr 2016 16:22:57 +0200
Subject: [LTP] [PATCH 2/3] syscalls/pwritev01: convert to new test API
In-Reply-To: <1460436789-11969-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1460436789-11969-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1460436789-11969-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160420142257.GA4004@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	TEST(pwritev(fd, wr_iovec, tc->count, tc->offset));
>  	if (TEST_RETURN < 0) {
> -		tst_resm(TFAIL | TTERRNO, "Pwritev(2) failed");
> +		tst_res(TFAIL | TERRNO, "pwritev() failed");
                                 ^
				 I've changed this back to TTERRNO
				 since we use the TEST() macro here.

And also merged this patch with the next one to avoid failures when the
fallback from pwritev.h is used with the new macro in the old library
and pushed. Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
