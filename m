From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Jan 2021 17:40:04 +0100
Subject: [LTP] [PATCH v4 1/3] lib: Fix kernel module detection on BusyBox
In-Reply-To: <YAmq/L8u+vh9JL2w@yuki.lan>
References: <20210121133233.29007-1-pvorel@suse.cz>
 <20210121133233.29007-2-pvorel@suse.cz> <YAmq/L8u+vh9JL2w@yuki.lan>
Message-ID: <YAmuZAu60JoqZYd7@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Hi!
> > +int tst_check_driver(const char *driver)
> > +{
> > +#ifdef __ANDROID__
> > +	/*
> > +	 * Android may not have properly installed modules.* files. We could
> > +	 * search modules in /system/lib/modules, but to to determine built-in
> > +	 * drivers we need modules.builtin. Therefore assume all drivers are
> > +	 * available.
> >  	 */
> >  	return 0;
> >  #endif
> > +
> > +	if (!tst_check_driver_(driver))
> > +		return 0;
> > +
> > +	int ret = 1;

> One last nit, shouldn't this be -1?

> Since the tst_check_driver_() returns either 0 or -1.

> Or should we change tst_check_driver_() to return 0 or 1 instead?

Oops, yes the value should be the same.
I prefer -1 as that's error in syscalls, but no strong opinion about it.

> Other than that this version looks good,

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks a lot for your patient review!

Kind regards,
Petr
