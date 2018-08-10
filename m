From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 10 Aug 2018 14:57:41 +0200
Subject: [LTP] [PATCH] tracing: ftrace_lib: check if tracing_max_latency
 exists.
In-Reply-To: <20180808234019.241238-1-sspatil@google.com>
References: <20180808234019.241238-1-sspatil@google.com>
Message-ID: <20180810125741.GC32275@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This avoids unnecessary error in ftrace stress test when the
> kernel being tested does not have CONFIG_TRACER_MAX_TRACE defined.
> 
> Signed-off-by: Sandeep Patil <sspatil@google.com>
> ---
>  testcases/kernel/tracing/ftrace_test/ftrace_lib.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
> index 20cf5e760..ec4f7a557 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
> @@ -100,7 +100,9 @@ restore_old_setting()
>  
>  	echo nop > current_tracer
>  	echo 0 > events/enable
> -	echo 0 > tracing_max_latency 2> /dev/null
> +	if [ -e tracing_max_latency ]; then
> +		echo 0 > tracing_max_latency 2> /dev/null
> +	fi

I guess that we can remove the 2> /dev/null that I suppose was supposed
to silence the error. Does it work okay for you without the redirection?

-- 
Cyril Hrubis
chrubis@suse.cz
