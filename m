From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Feb 2019 13:03:34 +0100
Subject: [LTP] [PATCH v3 1/7] lib: Add library functions for sync
 related syscalls
In-Reply-To: <CAFA6WYN2f4iT85y5hJbk3m8zDkfgwi1kEKES59B2ZOOiS22YDA@mail.gmail.com>
References: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
 <1550568500-10871-2-git-send-email-sumit.garg@linaro.org>
 <20190219140627.GC32031@rei.lan>
 <CAFA6WYN2f4iT85y5hJbk3m8zDkfgwi1kEKES59B2ZOOiS22YDA@mail.gmail.com>
Message-ID: <20190220120334.GA32140@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Maybe we just need a tst_dev_bytes_written() function that would return
> > the bytes written since the last call of the function so that we could
> > do:
> >
> >         fd = SAFE_OPEN(...);
> >
> >         tst_dev_blocks_written(tst_device.dev);
> >
> >         tst_fill_fd(fd, 0, TST_MB, size_mb);
> >
> >         TEST(fdsync(fd));
> >
> >         if (TST_RET)
> >                 tst_brk(TFAIL | TTERRNO, "syncfd() failed with %i", TST_RET);
> >
> >         written = tst_dev_blocks_written(tst_device.dev);
> >
> >         SAFE_CLOSE(fd);
> >
> >         if (written >= size_mb * TST_DEV_BLOCKS_IN_MB)
> >                 tst_res(TPASS, ...);
> >         else
> >                 tst_res(TFAIL, ...);
> >
> 
> Seems to be nicer approach. So rather than new file should I add
> tst_dev_bytes_written() function in "lib/tst_device.c" file?

Sounds good to me.

> > The test a bit longer, but the library functions are more reusable, if
> > you do 'git grep -B 1 SAFE_WRITE' you can see that the tst_fill_fd
> > function that loops over SAFE_WRITE could be used in a few places
> > already.
> >
> 
> I am not able to locate tst_fill_fd function. Are you referring to
> tst_fill_file function? If yes, then we could split that function to
> create tst_fill_fd function.

There is none, I was trying to state that there are several places that
use the same pattern and that such function would be generally useful.

And yes, buiding tst_fill_file on the top of tst_fill_fd sounds like a
good approach.

-- 
Cyril Hrubis
chrubis@suse.cz
