From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 Aug 2020 17:11:50 +0200
Subject: [LTP] [PATCH 1/4] Integrate tst_taint_check() into main LTP
 library
In-Reply-To: <1124120972.9071386.1597758876284.JavaMail.zimbra@redhat.com>
References: <20200811130502.12010-1-mdoucha@suse.cz>
 <1124120972.9071386.1597758876284.JavaMail.zimbra@redhat.com>
Message-ID: <20200818151150.GE27964@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >  static void do_test_setup(void)
> > @@ -1279,6 +1282,9 @@ static int fork_testrun(void)
> >  	alarm(0);
> >  	SAFE_SIGNAL(SIGINT, SIG_DFL);
> >  
> > +	if (tst_test->taint_check && tst_taint_check())
> > +		tst_brk(TBROK, "Kernel is now tainted.");
> > +
> 
> Shouldn't this be TFAIL?

I would agree, looking at the code tst_res(TFAIL, ) followed by a
return TFAIL should work.

-- 
Cyril Hrubis
chrubis@suse.cz
