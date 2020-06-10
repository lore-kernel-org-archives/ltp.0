From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Jun 2020 12:48:16 +0200
Subject: [LTP] [PATCH v2] LIB: Use INTERNAL_LIB for ltp lib
In-Reply-To: <5EE09E11.102@cn.fujitsu.com>
References: <57a1c19e-d8e5-4389-8565-20e49f144657@G08CNEXMBPEKD05.g08.fujitsu.local>
 <78176e41-03c4-e75b-594b-20731b2d4dfd@cn.fujitsu.com>
 <20200610080529.GA19781@dell5510> <5EE09E11.102@cn.fujitsu.com>
Message-ID: <20200610104816.GA12808@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang, Xu,

> Agreed, This patch should focus on replacing LIB with INTERNAL_LIB.
+1 merged (with adjusted commit message, added realtime and keeping libdir
changes for now).

Xu, thank you!

> My question about the issue is not important, we can just keep libdir for
> now as you want because someone may add dynamic library linking in future.
Yep, let's leave it now. I guess for adding LTP into traditional linux
distribution (not just have it in QA teams repositories or in embedded distros)
LTP libraries would have to be dynamically linked.

Also traditional distros would probably install most of LTP binaries outside of
/usr/bin, into LTP library path (e.g. /usr/lib64/ltp). Thus I'm for keeping that
old comment in include/mk/generic_leaf_target.inc.

Kind regards,
Petr
