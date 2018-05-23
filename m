From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 May 2018 10:12:43 +0200
Subject: [LTP] [PATCH 3/3] net/nfs_lib.sh: Cleanup for legacy API
In-Reply-To: <1525663451-32016-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1525663451-32016-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1525663451-32016-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180523081243.myzhjvwsbq5m77lu@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> 1) Move common tst_net.sh to nfs_lib.sh itself
> 2) Pass $OPTARG as $2 to TST_PARSE_ARGS functions

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
Pushed, with minor change removing ':'
I'll add it into tst_net.sh for old API + send a patch for tst_net.sh as Alexey suggested.

Kind regards,
Petr
