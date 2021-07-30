From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Jul 2021 11:12:17 +0200
Subject: [LTP] [PATCH v2] crypto/af_alg02: thread termination fixes
In-Reply-To: <20210720101249.10118-1-aleksei.kodanev@bell-sw.com>
References: <20210720101249.10118-1-aleksei.kodanev@bell-sw.com>
Message-ID: <YQPCcew5Are2VrDh@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> On musl, pthread_kill() doesn't return ESRCH if thread id is not found
> (POSIX only recommends to return ESRCH). Use tst_atomic_store/load()
> instead, when waiting for the thread.
> 
> Also, the thread's resources wasn't properly freed after the run(),
> so adding pthread_join() should fix that.

I do not think that we even need atomic operations here as we do not
have competing threads setting the value, it should work fine with
regular assignments as long as the completed variable is marked as
volatile (which will prevent compiler mis-optimizations).

-- 
Cyril Hrubis
chrubis@suse.cz
