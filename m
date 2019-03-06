From: Mark Salyzyn <salyzyn@android.com>
Date: Wed, 6 Mar 2019 08:42:55 -0800
Subject: [LTP] [RFC PATCH 2/2] syscalls/select04: Test four syscall
	variants
In-Reply-To: <20190306152430.25219-2-chrubis@suse.cz>
References: <20190306152430.25219-1-chrubis@suse.cz>
 <20190306152430.25219-2-chrubis@suse.cz>
Message-ID: <824b83ab-29ec-ebea-6b79-3b84fea504bb@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

_THANKS_ for the set of changes!

On 03/06/2019 07:24 AM, Cyril Hrubis wrote:
> +	case 2: {
> +		struct compat_sel_arg_struct arg = {
> +			._n = (long)nfds,
> +			._inp = (long)readfds,
> +			._outp = (long)writefds,
> +			._exp = (long)exceptfds,
> +			._tvp = (long)timeout,
> +		};
> +
> +		return tst_syscall(__NR_select, &arg);
> +	}

This fragment is correct for 32-bit configurations and 64-bit compat, 
but for 64-bit binaries it is:

#if defined(__LP64__)
return tst_syscall(__NR_select, nfds, readfds, writefds, exceptfds, timeout);
#else
. . .
#endif

-- Mark

