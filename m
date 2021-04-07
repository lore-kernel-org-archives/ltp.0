From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Apr 2021 14:28:05 +0200
Subject: [LTP] [PATCH 1/3] tst_test.sh: Run cleanup also after test
 timeout
In-Reply-To: <20210312173201.27708-2-pvorel@suse.cz>
References: <20210312173201.27708-1-pvorel@suse.cz>
 <20210312173201.27708-2-pvorel@suse.cz>
Message-ID: <YG2lVae3qLH8ZHRV@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  _tst_cleanup_timer()
>  {
> @@ -442,6 +442,26 @@ _tst_multiply_timeout()
>  	return 0
>  }
>  
> +_tst_kill_test()
> +{
> +	local i=10
> +
> +	tst_res TBROK "Test timeouted, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
                                                   ^
						   SIGINT?
> +	kill -INT -$pid
> +	tst_sleep 100ms

Other than that it looks good,

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
