From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Mar 2016 18:10:30 +0100
Subject: [LTP] [PATCH] rt_sigaction.h: ARC: Provide default sa_restorer
In-Reply-To: <1457351513-8310-1-git-send-email-vgupta@synopsys.com>
References: <1457351513-8310-1-git-send-email-vgupta@synopsys.com>
Message-ID: <20160307171030.GC6055@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#if defined __x86_64__ || defined __arc__
>  #ifdef __x86_64__
>  	sig_initial(signum);
> +#endif
>  	kact.sa_flags |= SA_RESTORER;
>  	kact.sa_restorer = restore_rt;
>  #endif

I've changed this so that there are no nested #ifdefs here and pushed,
thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
