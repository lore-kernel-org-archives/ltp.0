From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Jun 2021 14:12:24 +0200
Subject: [LTP] [PATCH 2/3] syscalls/sendfile: Convert sendfile06 to the
 new API
In-Reply-To: <YMxTQliOqBJsYZcu@yuki>
References: <20210603033611.15619-1-xieziyao@huawei.com>
 <20210603033611.15619-3-xieziyao@huawei.com>
 <YMurRVXwyvKXnkjj@pevik> <YMxTQliOqBJsYZcu@yuki>
Message-ID: <YNCCKN3W5RsO28pq@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> Hi!
> > > 1. Convert sendfile06 to the new API with file descriptors instead
> > > of socket descriptors.
> > I wonder if this is ok, suppose yes, but better if other check.

> In kernels before 2.6.33 out_fd had to be a socket. Kernel 2.6.33 went
> out somewhere in 2010 which should be more than old enough.
Yes, Ziyao also explained that. Thus merged.
I forgot to mention the reason at commit message, fortunately unlike me other
people aren't lazy to search in man page :).

Thanks!

Kind regards,
Petr
