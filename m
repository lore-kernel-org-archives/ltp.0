From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 Oct 2018 14:49:23 +0200
Subject: [LTP] [PATCH 1/6] lapi: Add TEMP_FAILURE_RETRY definition
In-Reply-To: <20181018112433.9554-1-pvorel@suse.cz>
References: <20181018112433.9554-1-pvorel@suse.cz>
Message-ID: <20181019124923.GA477@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> and use it in realtime to fix pi-tests.
> This fixes build failure on libc missing it (e.g. musl, bionic):
> 
> test-skeleton.c:112:12: warning: implicit declaration of function ???TEMP_FAILURE_RETRY??? [-Wimplicit-function-declaration]
>   termpid = TEMP_FAILURE_RETRY(waitpid(pid, &status, 0));
>             ^~~~~~~~~~~~~~~~~~
> make[5]: *** [<builtin>: testpi-6] Error 1

I had no idea glibc has macro like this. I do wonder if it worth a
fallback definition if we have exactly one use in the source code tree.
Maybe we should just replace the macro with the while loop instead.

-- 
Cyril Hrubis
chrubis@suse.cz
