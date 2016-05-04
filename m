From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 May 2016 18:57:35 +0200
Subject: [LTP] [PATCH V2 7/9] ftrace_stress: update the trace_options
	test
In-Reply-To: <1460966656-28328-8-git-send-email-chuhu@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-2-git-send-email-chuhu@redhat.com>
 <1460966656-28328-3-git-send-email-chuhu@redhat.com>
 <1460966656-28328-4-git-send-email-chuhu@redhat.com>
 <1460966656-28328-5-git-send-email-chuhu@redhat.com>
 <1460966656-28328-6-git-send-email-chuhu@redhat.com>
 <1460966656-28328-7-git-send-email-chuhu@redhat.com>
 <1460966656-28328-8-git-send-email-chuhu@redhat.com>
Message-ID: <20160504165735.GD22563@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +			if [ $ret_val -ne 0 ]; then
> +				tst_resm TFAIL "$0: $operation trace option $option failed"
> +			fi
> +			i=$((i + 1))
> +		done
> +		j=$((j + 1))
> +	done
> +	# sleep is not needed if ftrace can surrive.
> +	# tst_sleep 1s

Just remove these lines if they are not needed.

-- 
Cyril Hrubis
chrubis@suse.cz
