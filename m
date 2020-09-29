From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 29 Sep 2020 10:51:37 +0200
Subject: [LTP] [PATCH 1/1] io_destroy01: TCONF when unsupported
In-Reply-To: <20200929084809.GB7482@dell5510>
References: <20200929073501.4598-1-pvorel@suse.cz>
 <20200929083846.GA2717@yuki.lan> <20200929084809.GB7482@dell5510>
Message-ID: <20200929085137.GB2717@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > to fix test on kernel built without CONFIG_AIO=y.
> 
> > > Cleanup: use return instead of else, join string.
> 
> > This is both obviously ok, but the cleanup should be in a separate
> > patch.
> +1, I'll do.
> I suggested to use tst_syscall(), but we probably want here to use libc wrapper

These are from libaio library, which is why they return negative errors
instead of setting errno.

-- 
Cyril Hrubis
chrubis@suse.cz
