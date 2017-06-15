From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Jun 2017 14:46:39 +0200
Subject: [LTP] [PATCH v2] syscalls/splice05: check if splice supports
 stream af_unix sockets
In-Reply-To: <1497399788-3331-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1496904074-25394-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <1497399788-3331-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170615124639.GC2832@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +			if (errno == EINVAL) {
> +				tst_res(TCONF, "splice doesn't support "
> +					"stream af_unix sockets as input");

Maybe just shorter:

	tst_res(TCONF, "splice() does not support af_unix sockets");

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
