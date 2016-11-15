From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Nov 2016 16:46:37 +0100
Subject: [LTP] [PATCH 4/4] syscalls/setpriority02: Reconstruct &&
 Convert to new API
In-Reply-To: <1479116694-23167-4-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1479116694-23167-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1479116694-23167-4-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20161115154636.GB24751@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

> +	if (TEST_RETURN != -1) {
> +		tst_res(TFAIL,
> +			"setpriority(%d, %d, %d) %ssucceeds unexpectedly",
> +			tc->which, tc->who, tc->prio, desc);

I've changed this tst_res() to include TEST_RETURN in the message and
also fixed .gitignore file.

-- 
Cyril Hrubis
chrubis@suse.cz
