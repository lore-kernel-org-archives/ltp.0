From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 Jul 2017 15:27:20 +0200
Subject: [LTP] [PATCH v2 3/3] commands/keyctl01: Check keyctl support
 instead of kernel version
In-Reply-To: <20170718063144.18856-3-fenggw-fnst@cn.fujitsu.com>
References: <20170717114235.GB11059@rei.lan>
 <20170718063144.18856-1-fenggw-fnst@cn.fujitsu.com>
 <20170718063144.18856-3-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170718132719.GA22620@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've pushed the first two patches, thanks.

>  setup()
>  {
> -	if tst_kvcmp -le 2.6.33; then
> -		tst_brk TCONF "Kernel newer than 2.6.33 is needed"
> +	keyctl 2>&1 | tr '\n' ' ' | grep "request2" | grep "negate" | \
> +		grep "show" | grep "unlink" >/dev/null

Uh, what are we grepping here for exactly? Can't we do that with a
single regular expression?

> +	if [ $? -ne 0 ]; then
> +		tst_brk TCONF "keyctl operations not supported"
>  	fi
>  
>  	PATH_KEYSTAT="/proc/key-users"
> -- 
> 2.9.4
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
