From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 24 Feb 2020 15:20:34 +0100
Subject: [LTP] [PATCH v3 1/2] syscalls/fcntl30: clean up && add more
 range test
In-Reply-To: <8d1a7c73-7122-2c3d-6a73-024bed066966@cn.fujitsu.com>
References: <20200127162016.GD30831@rei.lan>
 <1580969073-27367-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200221160351.GA26393@rei.lan>
 <8d1a7c73-7122-2c3d-6a73-024bed066966@cn.fujitsu.com>
Message-ID: <20200224142034.GA2210@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I was playing with the test and it seems that the kernel allocation may
> > fail even for much smaller sizes for various reasons. I guess that
> > memory framentation on long running systems may be the culprit here
> > because kmalloc() allocates physically continuous memory.
> > 
> > I guess that the safest bet here would be limiting the maximal size we
> > try to resize the pipe and succeed to something as 8MB which would be
> > something as 32 pages to allocate.
> > 
> Agree.
> > At the same time I would just define the size we expect to fail with
> > ENOMEM to 1<<30 and that would save us from this architecture specific
> > trickery that will probably fail on stranger architectures anyway.
> On 64kb page size, it will over 1 <<30 for ENOMEM error .I think we can 
> test MAX_SIZE+pg_size(< 1<<31) for ENOMEM error. If  beyond 1<<31, 
> expect EINVAL error.

Hmm, maybe we can just double the size in a loop until we hit either
ENOMEM or EINVAL then and fail the test if we hit them too soon.

-- 
Cyril Hrubis
chrubis@suse.cz
