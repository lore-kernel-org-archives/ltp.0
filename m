From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 18:09:50 +0100
Subject: [LTP] [PATCH V2 25/32] mc_gethost: include sys/types.h
In-Reply-To: <1452302060-103643-25-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-25-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202170950.GO19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Fix build on musl
> error: unknown type name 'u_char'

Just fix the test to use unsigned char instead.

And ideally please do the same for tcp_cmds/perf_lan/pingpong.c and
tcp_cmds/perf_lan/pingpong6.c.

-- 
Cyril Hrubis
chrubis@suse.cz
