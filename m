From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Nov 2020 13:53:16 +0100
Subject: [LTP] [PATCH 06/19] Unify error handling in lib/safe_net.c
In-Reply-To: <20201026164756.30556-7-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-7-mdoucha@suse.cz>
Message-ID: <20201111125316.GB5870@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
> +			"Invalid getsockopt(%d, %d, %d, %p, %p) return "
> +			"value %d", sockfd, level, optname, optval, optlen,

Here as well, please do not split strings even if they end up over 80
chars.

Otherwise the chages looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
