From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Sep 2021 14:58:17 +0200
Subject: [LTP] [RFC PATCH 1/1] sched: Remove process.c
In-Reply-To: <20210913100022.14501-1-pvorel@suse.cz>
References: <20210913100022.14501-1-pvorel@suse.cz>
Message-ID: <YT9K6Xl9iP8sx2/y@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Test was removed as buggy from the runtest file nearly 20 years ago in:
> 576f1ee56 ("Removed a test that was not correctly running.")
> 
> Test is probably obsolete, not using even legacy API, non-zero exit:
> 
> $ ./process -d 8 -b 2 -t 1; echo $?
> total number of process to be created nodesum (511) is greater
>  than the allowed SEMMSL value (250)
> reseting the value of nodesum to SEMMSL
> Terminated
> 143
> 
> + leaving very high load after being terminated.
> 
> Reported-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

I was looking at the test and while the idea seems to valid and
interesting, the implementation is buggy, it does not take much to make
it segfault and it tends to leave processes unterminated, so it would be
probably easier to implement something from scratch.[

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
