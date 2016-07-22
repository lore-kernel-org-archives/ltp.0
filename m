From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Jul 2016 09:40:46 -0400 (EDT)
Subject: [LTP] [PATCH] trace_shed: Adapt to glibc 2.24 removal of union
 wait	type
In-Reply-To: <20160721045812.10914-1-raj.khem@gmail.com>
References: <20160721045812.10914-1-raj.khem@gmail.com>
Message-ID: <912075363.7376146.1469194846479.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Khem Raj" <raj.khem@gmail.com>
> To: ltp@lists.linux.it
> Sent: Thursday, 21 July, 2016 6:58:12 AM
> Subject: [LTP] [PATCH] trace_shed: Adapt to glibc 2.24 removal of union wait	type
> 
> This is now needed since glibc commit
> https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=b49ab5f4503f36dcbf43f821f817da66b2931fe6;hp=5f5682b9654101ccaf375c2814cbddbe6033a725
> 
> WEXITSTATUS macro does not do the enum translation anymore and expects
> the applications to pass int type fro status
> 
> fixes below error
> 
> trace_sched.c:425:16: error: invalid operands to binary & (have
> 'thread_sched_t * {aka struct <anonymous> *}' and 'int')
>       thrd_ndx, WEXITSTATUS(status));
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
>  testcases/kernel/sched/tool/trace_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/sched/tool/trace_sched.c
> b/testcases/kernel/sched/tool/trace_sched.c
> index 7815686..30dca5f 100644
> --- a/testcases/kernel/sched/tool/trace_sched.c
> +++ b/testcases/kernel/sched/tool/trace_sched.c
> @@ -422,7 +422,7 @@ int main(int argc,		/* number of input parameters.
> */
>  			if (status == (thread_sched_t *) - 1) {
>  				fprintf(stderr,
>  					"thread [%d] - process exited with errors %d\n",
> -					thrd_ndx, WEXITSTATUS(status));
> +					thrd_ndx, WEXITSTATUS((int)status));


Can we just drop WEXITSTATUS() from this fprintf? It's a pointer
to some struct, and on top of that it's always -1 here. It doesn't
look like this ever provided anything useful.

Regards,
Jan

>  				exit(-1);
>  			} else {
>  				exp_prio[thrd_ndx] = status->exp_prio;
> --
> 2.9.0
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
