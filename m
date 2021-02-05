From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 5 Feb 2021 18:06:08 +0100
Subject: [LTP] [PATCH v2 2/4] Add safe functions for io_uring to LTP
 library
In-Reply-To: <28ce5f25-ee74-adad-ba59-d25e3e72aa1d@suse.cz>
References: <20210204110342.11821-1-mdoucha@suse.cz>
 <20210204110342.11821-2-mdoucha@suse.cz> <YB1qyucNa+aN3p2V@pevik>
 <28ce5f25-ee74-adad-ba59-d25e3e72aa1d@suse.cz>
Message-ID: <YB17ABVa99GD/vLD@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> >> +++ b/lib/tst_safe_io_uring.c
> > ...
> >> +	uring->sqr_base = safe_mmap(file, lineno, NULL, uring->sqr_mapsize,
> >> +		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, uring->fd,
> >> +		IORING_OFF_SQ_RING);
> >> +
> >> +	if (uring->sqr_base == MAP_FAILED)
> >> +		return -1;
> > IMHO this is not needed, safe_mmap() breaks on rval == MAP_FAILED.

> Except when called in cleanup() where it prints a warning and returns as
> usual. That's why safe_io_uring_init() returns int instead of void in
> the first place.

> I don't expect that safe_io_uring_init() will be used in cleanup() very
> often but I've made all the other SAFE_*() functions cleanup()-safe and
> I want to stick with that here as well.

Good point, makes sense. Thanks for an explanation.

Kind regards,
Petr
