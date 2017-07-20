From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Jul 2017 14:17:17 +0200
Subject: [LTP] [PATCH] syscalls/clone09.c: skip this test if net ns is
 not supported
In-Reply-To: <1500542704-4889-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1500542704-4889-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170720121717.GG32092@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If net namespace is supported and disable, clone(CLONE_NEWNET) fails
> and sets errno to EINVAL as expected.  However, If net namespace is
> not supported(e.g. RHEL5.11GA), clone(CLONE_NEWNET) succeeds abnormally.

This sounds like a kernel bug. The usuall course of action for unknown
flag is to return EINVAL.

-- 
Cyril Hrubis
chrubis@suse.cz
