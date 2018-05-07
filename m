From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 7 May 2018 21:35:27 +0200
Subject: [LTP] [PATCH 3/3] net/nfs_lib.sh: Cleanup for legacy API
In-Reply-To: <1525663451-32016-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1525663451-32016-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1525663451-32016-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180507193526.hkb2obpkdoi677k7@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> 1) Move common tst_net.sh to nfs_lib.sh itself
> 2) Pass $OPTARG as $2 to TST_PARSE_ARGS functions
Second part suffers the same problem I introduced with
commit 89a83d8a0, see:
https://lists.linux.it/pipermail/ltp/2018-May/008035.html

So we must hold this patch until ve solve it.


Kind regards,
Petr
