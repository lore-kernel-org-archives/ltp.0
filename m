From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 May 2018 09:48:24 +0200
Subject: [LTP] [PATCH 2/3] net/tcp_fastopen_run.sh: Cleanup in
 TST_PARSE_ARGS functions for legacy API
In-Reply-To: <1525663451-32016-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1525663451-32016-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1525663451-32016-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180523074824.xjqen4wq7gullciy@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> 1) Process getopts parameters by TST_OPTS and TST_PARSE_ARGS
> 2) Pass $OPTARG as $2 to TST_PARSE_ARGS functions

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
Pushed, with minor change removing ':' (will be added in tst_net.sh as Alexey suggested).

Kind regards,
Petr

+++ testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -39,7 +39,7 @@ TST_TOTAL=1
 TCID="tcp_fastopen"
 TST_NEEDS_TMPDIR=1
 
-TST_OPTS=":hr:n:R:"
+TST_OPTS="hr:n:R:"
 TST_PARSE_ARGS=tcp_fastopen_parse_args
 
 TST_USE_LEGACY_API=1
