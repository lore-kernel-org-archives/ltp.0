From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Aug 2016 13:13:49 +0200
Subject: [LTP] [PATCH] syscalls/splice02: Reduce size of the input
 sequence
In-Reply-To: <1471440457-26985-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1471440457-26985-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <20160818111349.GC24254@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This test may take a lot of time on slow FPGA-based targets. Size of
> the generated sequence may be reduced from 1-10000000 to seq 1-20000
> and in bytes it is still more than SPLICE_SIZE constant from splice02.c:
> 
>     #define SPLICE_SIZE (64*1024)

Good catch. It's quite useless to feed the test with more than 64KB and
the seq 1-20000 produces about 100KB.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
