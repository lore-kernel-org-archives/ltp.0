From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 11 Jul 2019 08:45:36 -0400 (EDT)
Subject: [LTP] [PATCH v3.1] lib: add tst_no_corefile()
In-Reply-To: <20190711123441.GA8709@rei>
References: <20190705051603.24599-1-liwang@redhat.com>
 <02ade9af1634c4681156dceecfd51721284044e3.1562591065.git.jstancek@redhat.com>
 <20190711123441.GA8709@rei>
Message-ID: <1337100107.32641000.1562849136661.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > +void tst_no_corefile(int verbose)
> > +{
> > +	struct rlimit new_r, old_r;
> > +
> > +	SAFE_GETRLIMIT(RLIMIT_CORE, &old_r);
> > +	if (old_r.rlim_max >= 1 || geteuid() == 0) {
> > +		/*
> > +		 * 1 is a special value, that disables core-to-pipe.
> > +		 * At the same time it is small enough value for
> > +		 * core-to-file, so it skips creating cores as well.
> > +		 */
> > +		new_r.rlim_cur = 1;
> > +		new_r.rlim_max = 1;
> > +		SAFE_SETRLIMIT(RLIMIT_CORE, &new_r);
> > +	}
> > +
> > +	if (verbose)
> > +		tst_res(TINFO, "Avoid dumping corefile for process(pid=%d)", getpid());
> 
> Should we print the message here only
> 
> 	if (old_r.rlim_max <= 1 || geteuid() == 0)
> 
> because otherwise we will print the mesasge even in cases that the
> corefile is not in fact limited.

Depends on setup of core_pattern, if it's core-to-file it's already limited.
If it's core-to-pipe, then it's no limit, so I agree, we can move it above.

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
