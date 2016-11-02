From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Nov 2016 11:37:17 +0100
Subject: [LTP] [PATCH] syscalls/sendto02.c: add new testcase
In-Reply-To: <58195EEA.2080404@cn.fujitsu.com>
References: <1477994467-18497-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20161101162042.GB14966@rei.lan> <58195EEA.2080404@cn.fujitsu.com>
Message-ID: <20161102103717.GA20022@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I find that system would load sctp module when calling scoket(..., 
> IPPROTO_SCTP).
> If sctp module is not supported by system, it returns EPROTONOSUPPORT.
> I will remove loading/unloading code.

I started to wonder about that as I looked at the v2 patch. Sounds
better than loading/unloading the module explicitly.

-- 
Cyril Hrubis
chrubis@suse.cz
