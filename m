From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 May 2016 18:00:27 +0200
Subject: [LTP] [PATCH V2 2/9] tracing/ftrace: add new case for ftrace
 userstacktrace
In-Reply-To: <1460966656-28328-3-git-send-email-chuhu@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-2-git-send-email-chuhu@redhat.com>
 <1460966656-28328-3-git-send-email-chuhu@redhat.com>
Message-ID: <20160504160027.GF12244@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +ftrace_userstacktrace_test()
> +{
> +	if [ ! -e "$TSTACK_TRACE_PATH" ]; then
> +		tst_brkm TCONF ignored "Stack Tracer is not cofigured in This kernel"

The 'ignored' should really be removed here, it's a leftover when the
tst_brkm called the broken-by-design binary.

> +	fi
> +
> +	for i in $(seq $LOOP); do
> +		echo 1 >  $TSTACK_TRACE_PATH
> +		echo userstacktrace > $TRACING_PATH/trace_options
> +		grep -q "^userstacktrace"  $TRACING_PATH/trace_options
> +		if [ $? -ne 0 ]; then
> +			tst_brkm TBROK "Failed to set userstacktrace"
> +		fi
> +
> +		if [ -f "$EXC_PAGE_FAULT_ENABLE" ]; then
> +			exc_page_fault_enable=`cat $EXC_PAGE_FAULT_ENABLE`
> +			echo 1 > $EXC_PAGE_FAULT_ENABLE
> +		else
> +			mm_page_fault_enable=`cat MM_PAGE_FAULT_ENABLE`
> +			echo 1 > $MM_PAGE_FAULT_ENABLE
> +		fi
> +	done
> +
> +	if [ -f "$EXC_PAGE_FAULT_ENABLE" ]; then
> +		echo "$exc_page_fault_enable" > $EXC_PAGE_FAULT_ENABLE
> +	else
> +		echo "$mm_page_fault_enable" > $MM_PAGE_FAULT_ENABLE
> +	fi
> +
> +	tst_resm TPASS "Finished running the test"
> +}

-- 
Cyril Hrubis
chrubis@suse.cz
