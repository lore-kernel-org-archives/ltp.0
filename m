From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 20:49:44 -0700
Subject: [LTP] [PATCH] trace_shed: Adapt to glibc 2.24 removal of union
	wait type
In-Reply-To: <20160721045812.10914-1-raj.khem@gmail.com>
References: <20160721045812.10914-1-raj.khem@gmail.com>
Message-ID: <CAMKF1spDqxx1jjDaaaX4fiQ7qw2i48S5e75oMstcd+_=XvEMMw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ignore this. I have a better one to follow

On Wed, Jul 20, 2016 at 9:58 PM, Khem Raj <raj.khem@gmail.com> wrote:
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
> diff --git a/testcases/kernel/sched/tool/trace_sched.c b/testcases/kernel/sched/tool/trace_sched.c
> index 7815686..30dca5f 100644
> --- a/testcases/kernel/sched/tool/trace_sched.c
> +++ b/testcases/kernel/sched/tool/trace_sched.c
> @@ -422,7 +422,7 @@ int main(int argc,          /* number of input parameters.                        */
>                         if (status == (thread_sched_t *) - 1) {
>                                 fprintf(stderr,
>                                         "thread [%d] - process exited with errors %d\n",
> -                                       thrd_ndx, WEXITSTATUS(status));
> +                                       thrd_ndx, WEXITSTATUS((int)status));
>                                 exit(-1);
>                         } else {
>                                 exp_prio[thrd_ndx] = status->exp_prio;
> --
> 2.9.0
>
