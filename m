From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Mar 2016 18:19:00 +0100
Subject: [LTP] [PATCH RFC 8/9] ftrace_stress: update the trace_options
 test
In-Reply-To: <1457079898-9449-9-git-send-email-liwang@redhat.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
 <1457079898-9449-7-git-send-email-liwang@redhat.com>
 <1457079898-9449-8-git-send-email-liwang@redhat.com>
 <1457079898-9449-9-git-send-email-liwang@redhat.com>
Message-ID: <20160317171859.GH31815@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +# enable the nop_test_refuse can cause an
> +# 'write error: Invalid argument'. So don't
> +# test it.
> +option_files=${option_files/test_nop_refuse/}
> +trace_options=( $option_files )
> +
> +NR_TRACE_OPTIONS=${#trace_options[*]}

This does not work even in bash because the trace_options is never
casted to array so it just returns 0.

The portable way is plain old wc:

NR=$(echo $trace_options |wc -w)

>  for ((; ; ))
>  {

Please fix these bash style loops as well.

> @@ -25,7 +31,6 @@ for ((; ; ))
>  	{
>  		num=`date +%N`
>  		num=`printf 1%s $num`
> -
>  		for ((i = 0; i < $NR_TRACE_OPTIONS; i++))
>  		{

And here.

>  			n=$(( ( $num >> $i ) % 2 ))
> @@ -34,9 +39,9 @@ for ((; ; ))
>  			else
>  				echo 1 > "$TRACING_PATH"/options/${trace_options[$i]}
>  			fi
> +			[ $? -ne 0 ] && echo "setup trace option ${trace_options[$i]} failed"

Shouldn't this check be just after the echo rather than here?

>  		}
>  	}
>  
>  	sleep 1
>  }
> -
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: http://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
