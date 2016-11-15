From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Nov 2016 15:57:37 +0100
Subject: [LTP] [PATCH 2/4] syscalls/getpriority02: Cleanup && Convert to
 new API
In-Reply-To: <1479116694-23167-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1479116694-23167-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1479116694-23167-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20161115145736.GF13947@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (TEST_RETURN != -1) {
> +		tst_res(TFAIL, "getpriority(%d, %d) succeeds unexpectedly",
> +			tc->which, tc->who);

I've changed this tst_res() to include the TEST_RETURN in the message as
well and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
