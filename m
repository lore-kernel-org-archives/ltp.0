From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Jun 2017 17:01:18 +0200
Subject: [LTP] [PATCH v2 1/2] clone08: convert to new LTP API
In-Reply-To: <1496915851-5222-1-git-send-email-alexey.kodanev@oracle.com>
References: <1496915851-5222-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20170622150117.GB28231@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  
> -	stopped_flag = 0;
> -	child = clone_child(&test_cases[t], 1);
> +	child = clone_child(&test_cases[t]);
>  
>  	/* give the kernel scheduler chance to run the CLONE_STOPPED thread*/
>  	for (i = 0; i < 100; i++) {
> @@ -246,23 +178,22 @@ static void test_clone_stopped(int t)
>  		usleep(1000);
>  	}

Can't we check the /proc/$pid/state here to assert that the child is in
'T' state here? We do have PROCESS_STATE_WAIT() for that.

Otherwise this looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
