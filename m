From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Mar 2021 16:48:14 +0100
Subject: [LTP] [PATCH v2 6/6] zram: Increase timeout according to used
 devices
In-Reply-To: <YD0LMzlHtms7WYEi@pevik>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-7-pvorel@suse.cz> <YBRroFhaxdqCLv2i@pevik>
 <YD0EuJtWxhis24ZX@yuki.lan> <YD0LMzlHtms7WYEi@pevik>
Message-ID: <YD0MvpaWz7gTjp9V@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I would still prefer if we had a timeout there, -1 is for something that
> > cannot be predicted.
> 
> > Also we do not expect machine to be heavily loaded, in that case half of
> > LTP tests would time out.
> 
> > So I would just measure how long the test takes, then multiply it by 5
> > or something like that and put that in as a timeout.
> Do you mean to use high enough static timeout defined before startup (working
> for maximum possible filesystems)? And create tst_set_timeout() for shell as
> independent effort?

I would do:

* Add tst_set_timeout for shell, so that it mirrors the C API

* Measure runtime of the test divide it by the number of supported
  filesystems, that way we would get mean runtime per filesystem

  now I would multiply this number with arbitrary constantm, e.g. 5 or
  even more, this is now timeout per iteration

  with this number the actuall timeout would be:

  number_of_filesystems * mean_max_per_run


Does this sound sane?

I guess that in the end we will end up with something similar what you
had there, but we would have some data that supports this decision.

-- 
Cyril Hrubis
chrubis@suse.cz
