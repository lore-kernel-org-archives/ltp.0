From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Jul 2019 12:15:03 +0200
Subject: [LTP] [PATCH v2] syscalls/ioprio: Add test cases for I/O
 priority
In-Reply-To: <20190718100848.GA24931@rei.lan>
References: <20190718073941.13153-1-linus.walleij@linaro.org>
 <20190718100848.GA24931@rei.lan>
Message-ID: <20190718101503.GA25712@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +	/* Bump to best effort scheduling, all 8 priorities */
> > +	class = IOPRIO_CLASS_BE;
> > +
> > +	fail_in_loop = 0;
> > +	for (prio = 0; prio < 8; prio++) {
> > +		TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
> > +				IOPRIO_PRIO_VALUE(class, prio)));
> > +		if (TST_RET == -1) {
> > +			tst_res(TFAIL | TTERRNO, "ioprio_set IOPRIO_CLASS_BE prio %d failed", prio);
> > +			fail_in_loop = 1;
> > +		}
> > +	}
> > +	if (!fail_in_loop)
> > +		tst_res(TPASS, "tested all 8 prios in class %s",
> > +			 to_class_str[class]);
> 
> Just btw, we don't have to have the fail_in_loop variable here
> (fail_in_loop) == (prio < 8)

And that only works when we have a break; on failure, which we don't
have here...

-- 
Cyril Hrubis
chrubis@suse.cz
