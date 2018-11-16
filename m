From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Nov 2018 15:00:35 +0100
Subject: [LTP] [PATCH] lib: Add library function for parsing kernel
	config
In-Reply-To: <20181116035401.z2o67pjhxtutap6x@xpf-desktop>
References: <20181115134441.27359-1-chrubis@suse.cz>
 <20181116035401.z2o67pjhxtutap6x@xpf-desktop>
Message-ID: <20181116140034.GG29013@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> > new file mode 100644
> > +
> > +	snprintf(path_buf, path_buf_len, "/boot/config-%s", un.release);
> > +
> > +	if (!access(path_buf, F_OK))
> > +		return path_buf;
> > +
>   Could add suport for Clear Linux kconfig location:
> 	snprintf(path_buf, path_buf_len, "/lib/kernel/config-%s", un.release);
> 
> 	if (!access(path_buf, F_OK))
> 		return path_buf;

No problem, will add that in v2?

> > +	tst_res(TINFO, "Couldn't locate kernel config!");
> > +
> > +	return NULL;
> > +}
> 
> > +	int abort_test = 0;
> > +
> > +	for (i = 0; i < conf_cnt; i++) {
> > +		if (!conf_match[i]) {
> > +			abort_test = 1;
> > +			tst_res(TINFO, "Kernel is missing %s", kconfigs[i]);
>    Could change TINFO above to TCONF?

What's the point? We do exit with TCONF below anyway.

> > +		}
> > +	}
> > +
> > +	if (abort_test)
> > +		tst_brk(TCONF, "Aborting test due to missing kernel config options!");
> 	Add 'above' in print?
> 		tst_brk(TCONF,
> 			"Aborting test due to missing above kernel config options!");

Sure, np.

-- 
Cyril Hrubis
chrubis@suse.cz
