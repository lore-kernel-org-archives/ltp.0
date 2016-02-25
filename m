From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Feb 2016 14:52:45 +0100
Subject: [LTP] [PATCH v2 3/3] llistxattr/llistxattr03.c: add new testcase
In-Reply-To: <1455706286-4090-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <56AEECEC.8090305@cn.fujitsu.com>
 <1455706286-4090-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1455706286-4090-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160225135245.GA3750@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	ev_rdonly = SAFE_MMAP(NULL, NULL, page_size, PROT_READ | PROT_WRITE,
> +		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +

...

> +	if (mprotect(ev_rdonly, page_size, PROT_READ)) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			"failed to set memory area read-only");
> +	}

I've removed the PROT_WRITE from the mmap() flags and the mprotect() and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
