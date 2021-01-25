From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jan 2021 16:25:49 +0100
Subject: [LTP] [PATCH RFC 2/2] swapping01: check memory swap usage per
 process
In-Reply-To: <20210125064747.26759-2-liwang@redhat.com>
References: <20210125064747.26759-1-liwang@redhat.com>
 <20210125064747.26759-2-liwang@redhat.com>
Message-ID: <YA7i/eQagkj0Jxsy@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Since previously swapping01 read the system FreeSwap for counting
> usage of swap-size, that's not precise on system especially with
> eating-memory daemon??in the background. Now, we try to check the
> 'VmmSwap' in proc/PID/status??per process, to get rid of??the potential
> influence from??other processes??which easily leads to false positive.

I've been looking for a while at the kernel commit:

commit 50a15981a1fac7e019ff7c3cba87531fb580f065
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Sun Jul 24 10:47:59 2011 +0200

    [S390] reference bit testing for unmapped pages

For which this test seems to be a reproducer and as far as I can tell
this fix is not correct.

If I understand correctly what we are trying to test here is that the
kernel will not attempt to swap out unreferenced pages, so we have to,
by definition, look at the system counters not the process ones.

-- 
Cyril Hrubis
chrubis@suse.cz
