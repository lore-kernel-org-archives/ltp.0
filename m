From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 8 May 2018 10:05:48 +0200
Subject: [LTP] [PATCH] lib/tst_net.sh: Detect quoted parameters correctly
In-Reply-To: <1525749141-29004-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180507193234.6810-2-pvorel@suse.cz>
 <1525749141-29004-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180508080548.2x337zth56liebqe@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> If we pass $* to tst_net_read_opts, we cannot detect quoted parameters
> correctly, which process only first number from quoted parameters.
> For example, running sctp_ipsec.sh -s "100 1000 65535":
...
>  if [ -n "$TST_USE_LEGACY_API" ]; then
> -	tst_net_read_opts $*
> +	tst_net_read_opts "$@"
>  	ipver=${TST_IPV6:-4}
>  fi

Acked-by: Petr Vorel <pvorel@suse.cz>

Expect to merge it on Wednesday (if nobody objects), instead of my fix with a note of
missing quotes as a root cause [1].


Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/2018-May/008042.html
