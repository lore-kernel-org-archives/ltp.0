From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Feb 2019 13:10:29 +0100
Subject: [LTP] [PATCH] syscalls/preadv203: Add basic RWF_NOWAIT test
In-Reply-To: <20190206080400.GB13396@x230>
References: <20190128134656.27979-1-metan@ucw.cz> <20190206080400.GB13396@x230>
Message-ID: <20190206121028.GC13516@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static void *nowait_reader(void *unused LTP_ATTRIBUTE_UNUSED)
> ...
> > +		TEST(preadv2(fd, rd_iovec, 2, off, RWF_NOWAIT));
> RWF_NOWAIT needs to be declared in lapi for old distros.

Right and we should as well return TCONF on older kernels, I haven't
tested that properly yet but I guess that we should check for EOPNOTSUPP
and EINVAL. I will do that later on, I just didn't want to delay the
initial test patch because it seem that kernel developers wanted to
have it ASAP.

-- 
Cyril Hrubis
chrubis@suse.cz
