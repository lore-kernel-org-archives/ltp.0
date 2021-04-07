From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 7 Apr 2021 14:37:30 +0200
Subject: [LTP] [PATCH 1/3] tst_test.sh: Run cleanup also after test
 timeout
In-Reply-To: <YG2lVae3qLH8ZHRV@yuki>
References: <20210312173201.27708-1-pvorel@suse.cz>
 <20210312173201.27708-2-pvorel@suse.cz> <YG2lVae3qLH8ZHRV@yuki>
Message-ID: <YG2nigNt+dPZfMC5@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> >  _tst_cleanup_timer()
> >  {
> > @@ -442,6 +442,26 @@ _tst_multiply_timeout()
> >  	return 0
> >  }

> > +_tst_kill_test()
> > +{
> > +	local i=10
> > +
> > +	tst_res TBROK "Test timeouted, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
>                                                    ^
> 						   SIGINT?

Oops, thanks for noticing this.

Kind regards,
Petr

> > +	kill -INT -$pid
> > +	tst_sleep 100ms

> Other than that it looks good,

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
