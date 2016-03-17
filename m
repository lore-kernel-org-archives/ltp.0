From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Mar 2016 17:49:14 +0100
Subject: [LTP] [PATCH RFC 4/9] ftrace_regression: add new case to
 ftrace_regression/ dir
In-Reply-To: <1457079898-9449-5-git-send-email-liwang@redhat.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
Message-ID: <20160317164914.GE31815@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +LOOP=10
> +
> +TSTACK_TRACE_PATH=/proc/sys/kernel/stack_tracer_enabled
> +
> +cd $TRACING_PATH

Why cant we setup a few variables to use in the code below instead of
changing the test directory?

EXC_PAGE_FAULT_ENABLE="$TRACING_PATH/events/exceptions/page_fault_kernel/enable"
MM_PAGE_FAULT_ENABLE="$TRACING_PATH/events/kmem/mm_kernel_pagefault/enable"

> +grep -q CONFIG_STACK_TRACER=y /boot/config-`uname -r`

This is not portable. Some distributions store the config in different
places while others don't have it at all.

Can't we do [ -e "$TSTACK_TRACE_PATH" ] or similar instead?

> +if [ $? -ne 0 ];then
> +	echo "Stack Tracer is not cofigured in This kernel. Skip the test"

You must correctly report the TCONF here. If you have used the test.sh
library you could have simply done tst_resm TCONF "..." and there would
ne no need for the else branch as well.

> +else
> +	for ((i = 0; i < $LOOP; i++))
> +	{

This is bashism. You should do 'for i in $(seq $LOOP); do' instead.

> +		echo 1 >  $TSTACK_TRACE_PATH
> +		echo userstacktrace > trace_options
> +		grep -q "^userstacktrace"  trace_options
> +
> +		if [ -f "events/exceptions/page_fault_kernel/enable" ]; then
> +			PAGE_FAULT_KERNEL_ENABLE=`cat events/exceptions/page_fault_kernel/enable`
> +			echo 1 > events/exceptions/page_fault_kernel/enable
> +		else
> +			MM_KERNEL_PAGEFAULT_ENABLE=`cat events/kmem/mm_kernel_pagefault/enable`
> +			echo 1 > events/kmem/mm_kernel_pagefault/enable
> +		fi
> +	}
> +
> +	if [ -f "events/exceptions/page_fault_kernel/enable" ]; then
> +		echo "$PAGE_FAULT_KERNEL_ENABLE" > events/exceptions/page_fault_kernel/enable
> +	else
> +		echo "$MM_KERNEL_PAGEFAULT_ENABLE" > events/kmem/mm_kernel_pagefault/enable
> +	fi
> +	# echo "No panic, Still alive."

No unused code in test please.

> +fi
> +
> +cd - > /dev/null
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: http://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
