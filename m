From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 20 Jun 2016 06:43:18 -0400 (EDT)
Subject: [LTP] [PATCH] mem/lib: keep allocating memory until get an
 error in single process
In-Reply-To: <1466416385-20603-1-git-send-email-liwang@redhat.com>
References: <1466416385-20603-1-git-send-email-liwang@redhat.com>
Message-ID: <1007336481.302642.1466419398150.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: jstancek@redhat.com
> Cc: ltp@lists.linux.it
> Sent: Monday, 20 June, 2016 11:53:05 AM
> Subject: [PATCH] mem/lib: keep allocating memory until get an error in single process
> 
> We occasionally catch errors like:
> oom03       0  TINFO  :  start OOM testing for KSM pages.
> oom03       0  TINFO  :  expected victim is 3490.
> oom03       6  TFAIL  :  mem.c:163: victim unexpectedly ended with retcode:
> 0, expected: 12
> oom03       0  TINFO  :  set overcommit_memory to 0
> 
> It cames from the caller testoom(0, 1, ENOMEM, 1). The full reason is that
> function child_alloc() go into single process mode, then successfully finish
> the memory allocation and return 0.

Description above doesn't explain why you get 0, when oom03 is set to run
in cgroup with memory.memsw.limit_in_bytes == TESTMEM, and then allocates
TESTMEM + MB.

My guess is a KSM scan merged some pages before you have hit the limit.
Do yo get these failures always during KSM test?

Regards,
Jan

> 
> In this patch, let's make it (in single mode) keep allocating memory with
> an incresed length in order to avoid 0 returned.


