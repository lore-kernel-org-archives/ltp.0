From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Nov 2016 15:07:20 +0100
Subject: [LTP] [PATCH 1/3] sched_xxx: TCONF instead of TFAIL if user is
 not root
In-Reply-To: <1478087824-31577-2-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478087824-31577-1-git-send-email-dejan.jovicevic@rt-rk.com>
 <1478087824-31577-2-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161102140719.GA28344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  void setup(void)
>  {
> +	tst_require_root();
> +
>  	struct sched_param p = { 1 };

I've changed this part so that the call to tst_require_root() goes after
the struct sched_param declaration and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
