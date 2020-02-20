From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Feb 2020 11:18:11 +0100
Subject: [LTP] [PATCH] syscalls/fgetxattr02: Use loop instead of RAM disk
In-Reply-To: <c2168ced-4634-a7d4-7112-ac8e2ceba830@cn.fujitsu.com>
References: <20200220095908.14980-1-chrubis@suse.cz>
 <c2168ced-4634-a7d4-7112-ac8e2ceba830@cn.fujitsu.com>
Message-ID: <20200220101811.GA11142@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > which makes this test fail with ENXIO when we attempt to open the block
> > device in the test setup.
> > 
> > LTP depends on heavily on loop device driver already so it makes sense
> > to switch over to a loop device backed block device instead.
> > 
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > ---
> >   testcases/kernel/syscalls/fgetxattr/fgetxattr02.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
> > index 02e81810a..82fb676be 100644
> > --- a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
> > +++ b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
> > @@ -210,7 +210,8 @@ static void setup(void)
> >   	size_t i = 0;
> >   	struct sockaddr_un sun;
> >   
> > -	dev_t dev = makedev(1, 3);
> > +	dev_t chr_dev = makedev(1, 3);
> > +	dev_t blk_dev = makedev(7, 3);
>   Can we use tst_find_free_loopdev to avoid a fixed loop dev like 
> copy_file_range02.c?

I do not think that it matters here, we are not actually touching the
block device here, we just need to be able to open the block device so
that we can add an attribute to the file we have created. I does not
matter if it's used or not.

-- 
Cyril Hrubis
chrubis@suse.cz
