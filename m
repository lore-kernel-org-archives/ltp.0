From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Apr 2018 13:42:32 +0200
Subject: [LTP] [RFC PATCH v3 10/10] ima/ima_mmap: Rewrite to new library
In-Reply-To: <20180419195503.7194-11-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180419195503.7194-11-pvorel@suse.cz>
Message-ID: <20180420114232.GD19090@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	ima_mmap $FILE &
> +	ima_mmap -f $FILE &
>  	# wait for violations appear in logs
>  	tst_sleep 1s

Whenever we wait for logs we should poll for them.

But same as the sleep in previous case, let's get these tests fixed
first, then we can improve on the performance and robustness.

-- 
Cyril Hrubis
chrubis@suse.cz
