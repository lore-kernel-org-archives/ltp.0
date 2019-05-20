From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 May 2019 13:24:51 +0200
Subject: [LTP] [PATCH v2] syscalls/preadv203: Add basic RWF_NOWAIT test
In-Reply-To: <CAOQ4uxgNGK=QcGcmDpjt0jhWC9=E3egSpv5G0-7tXx7bKQD7gw@mail.gmail.com>
References: <20190404141611.15192-1-chrubis@suse.cz>
 <20190520100824.GA25813@rei.lan>
 <CAOQ4uxgNGK=QcGcmDpjt0jhWC9=E3egSpv5G0-7tXx7bKQD7gw@mail.gmail.com>
Message-ID: <20190520112451.GB25813@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Ping, anybody has any comments or can be this be this merged?
> >
> 
> I have no objection to this test, but I have a question. Your claim is:
> "We are attempting to trigger the EAGAIN path for the RWF_NOWAIT flag."
> 
> Seems like you have gone to a great length of effort to achieve this.
> Wouldn't it be sufficient to do a single preadv2 after fsync+drop_caches in
> order to observe EAGAIN?

As far as I can tell the I/O to the device has to be saturated in order
to get EAGAIN at least for a subset of filesystems. If I just drop the
cache once then attempt to read with the NOWAIT flag it strangely works
only for ext2 for me.

So I guess that the manual page is a bit misleading and the NOWAIT flag
actually returns EAGAIN only if the calling thread would end up in a
queue or waiting for a lock, but I haven't looked into the kernel code
to make sure.

> There are several other ways to get EAGAIN, like DIO read/write when
> page cache *is* populated.

That is a good hint, I will have a look at that case as well.

> Question is, how much is the test trying to cover.

Well ideally we should excercise as much kernel code paths as
possible... :-)

-- 
Cyril Hrubis
chrubis@suse.cz
