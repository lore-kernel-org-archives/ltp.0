From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Mar 2019 16:40:45 +0100
Subject: [LTP] [PATCH 1/5] rt_sigaction.h: Check for type sighandler_t
 and use if present
In-Reply-To: <20190318032330.3346-2-petr.vorel@gmail.com>
References: <20190318032330.3346-1-petr.vorel@gmail.com>
 <20190318032330.3346-2-petr.vorel@gmail.com>
Message-ID: <20190318154045.GA25922@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> __sighandler_t is libc implementation specific and should not be relied
> upon. Instead, we fall back upon void (*)(int), as specified by POSIX.

Can't we just use the void (* k_sa_handler)(int) in all cases and don't
add more ifdefs to that file?

The __sighandler_t is defined to void (* __sighandler_t)(int) in glibc anyways.

-- 
Cyril Hrubis
chrubis@suse.cz
