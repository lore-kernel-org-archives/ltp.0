From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Mar 2020 14:49:30 +0100
Subject: [LTP] [PATCH 6/8] syscalls/clock_gettime03: Add basic time
 namespace test
In-Reply-To: <87imjdfyr2.fsf@our.domain.is.not.set>
References: <20200305134834.16736-1-chrubis@suse.cz>
 <20200305134834.16736-7-chrubis@suse.cz>
 <87imjdfyr2.fsf@our.domain.is.not.set>
Message-ID: <20200309134930.GD29747@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static void child(struct tcase *tc)
> > +{
> > +	struct timespec then;
> > +	struct timespec parent_then;
> > +	long long diff;
> > +
> > +	SAFE_CLOCK_GETTIME(tc->clk_id, &then);
> > +
> > +	setns(parent_ns, CLONE_NEWTIME);
> 
> Maybe check the error code?

Indeed, I guess that I should add SAFE_SETNS() and then make use of that
in the tests.

-- 
Cyril Hrubis
chrubis@suse.cz
