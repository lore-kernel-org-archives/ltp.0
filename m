From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Nov 2016 17:49:56 +0100
Subject: [LTP] [PATCH] lsmod01: keep the output in variables
In-Reply-To: <1478702093-15080-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <20161011161557.GD17083@rei.suse.cz>
 <1478702093-15080-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20161109164956.GB9168@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>  lsmod_test()
>  {
> -	lsmod >temp 2>&1
> -	if [ $? -ne 0 ]; then
> -		tst_resm TFAIL "'lsmod' failed."
> -		cat temp
> +	lsmod_output=$(lsmod | awk '!/Module/{print $1, $2, $3}' | sort)
> +	if [ -z "$lsmod_output" ]; then
> +		tst_resm TFAIL "Failed to parse the output from lsmod"
>  		return
>  	fi
>  
> -	awk '!/Module/{print $1, $2, $3}' temp |sort >temp1
> -
> -	awk '{print $1, $2, $3}' /proc/modules |sort >temp2
> +	modules_output=$(awk '{print $1, $2, $3}' /proc/modules | sort)
> +	if [ -z "$modules_output" ]; then
> +		tst_resm TFAIL "Failed to parse /proc/modules"
> +		return
> +	fi
>  
> -	diff temp1 temp2 >temp3
> -	if [ $? -ne 0 ]; then
> +	if [ "$lsmod_output" != "$modules_output" ]; then
>  		tst_resm TFAIL "lsmod output different from /proc/modules."
> -		cat temp3
> +
> +		echo "$lsmod_output" > temp1
> +		echo "$modules_output" > temp2
> +		diff temp1 temp2

Hmm since the foo=$() flattened the text into single line this diff
would be pretty much useless.

So we can either just print these two lines, or split them again
so that exactly three words/numbers are on each line before we do the
diff.

>  		return
>  	fi
>  
> -- 
> 1.7.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
