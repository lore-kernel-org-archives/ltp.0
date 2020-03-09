From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Mar 2020 14:33:02 +0100
Subject: [LTP] [PATCH 4/8] syscalls/sysinfo03: Add time namespace test
In-Reply-To: <87h7yxfylj.fsf@our.domain.is.not.set>
References: <20200305134834.16736-1-chrubis@suse.cz>
 <20200305134834.16736-5-chrubis@suse.cz>
 <87k13tg13f.fsf@our.domain.is.not.set>
 <20200309124844.GB29747@rei.lan>
 <87h7yxfylj.fsf@our.domain.is.not.set>
Message-ID: <20200309133301.GC29747@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> > +static struct tst_test test = {
> >> > +	.tcnt = ARRAY_SIZE(offsets),
> >> > +	.test = verify_sysinfo,
> >> > +	.needs_root = 1,
> >> > +	.forks_child = 1,
> >> > +	.needs_kconfigs = (const char *[]) {
> >> > +		"CONFIG_TIME_NS=y"
> >> > +	}
> >> > +};
> >>
> >> Will you add a git ref when the fix is in mainline/for-next?
> >>
> >> Should be safe to add it as soon as it is in the for-next tree.
> >
> > I'm not sure how usefull that will be because the fix should get in
> > during the RC phase the functionality was introduced, so technically the
> > missing support of sysinfo() in time namespaces should not reach any
> > officially released kernel.
> 
> What is the downside to including it?
> 
> Also, I can imagine some people will try backporting this and may miss
> something not in the original patch set.

Okay, that's a valid reason to include the hash.

-- 
Cyril Hrubis
chrubis@suse.cz
