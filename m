From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Aug 2017 17:52:29 +0200
Subject: [LTP] [PATCH] cve/cve-2017-2671.c: check if socket() supports
 IPPROTO_ICMP
In-Reply-To: <1501751564-8002-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1501751564-8002-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170803155229.GD15519@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> socket() does not support IPPROTO_ICMP, and the ping_group_range file
> does not exist in older kernels(e.g. RHEL5.11GA).  these supports are
> introduced by:
> 'c319b4d("net: ipv4: add IPPROTO_ICMP socket kind")'

Hm, the question is if there is a system that supports IPPROTO_ICMP
and where the ping_group_range file is missing. Does that even happen?

If not we should simplify this by exitting (tst_brk()) with TCONF if the
ping_group_range is missing instead of doing that later on
EPROTONOSUPPORT.

-- 
Cyril Hrubis
chrubis@suse.cz
