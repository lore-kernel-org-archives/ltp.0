From: zhaogongyi <zhaogongyi@huawei.com>
Date: Sun, 25 Apr 2021 03:28:08 +0000
Subject: [LTP] [PATCH] syscalls/getdents01: Add close() and open() at
 the end of run()
Message-ID: <808aa8a561fa469b9eedda4f29196c6a@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I have re-submitted the patch according you review, please see: https://patchwork.ozlabs.org/project/ltp/patch/20210425012240.6328-1-zhaogongyi@huawei.com/

Thanks so much!

Best Regards,
Gongyi

> 
> Hi!
> >  testcases/kernel/syscalls/getdents/getdents01.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/getdents/getdents01.c
> > b/testcases/kernel/syscalls/getdents/getdents01.c
> > index ef8f4e864..7982691a6 100644
> > --- a/testcases/kernel/syscalls/getdents/getdents01.c
> > +++ b/testcases/kernel/syscalls/getdents/getdents01.c
> > @@ -92,6 +92,9 @@ static void run(void)
> >  	} while (rval > 0);
> >
> >  	check_flags();
> > +
> > +	SAFE_CLOSE(fd);
> > +	fd = SAFE_OPEN(".", O_RDONLY|O_DIRECTORY);
> >  }
> 
> Good catch but I guess that it would be a bit cleaner if we opened the fd at
> the start of the run() and closed it at the end instead of opening it in setup()
> and reopening it for each iteration.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
