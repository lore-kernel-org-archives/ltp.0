From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 9 May 2018 17:27:28 +0200
Subject: [LTP] [PATCH] lib/tst_net.sh: Detect quoted parameters correctly
In-Reply-To: <1525749141-29004-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180507193234.6810-2-pvorel@suse.cz>
 <1525749141-29004-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180509152728.esvxoym3k2gjfe7y@dell5510>
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
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/lib/tst_net.sh | 2 +-
...
>  if [ -n "$TST_USE_LEGACY_API" ]; then
> -	tst_net_read_opts $*
> +	tst_net_read_opts "$@"

Thanks Xiao for  fix, patch applied (with additional explanation and Fixes: in commit
message).

Network tests are no longer blocking the release.

Kind regards,
Petr
