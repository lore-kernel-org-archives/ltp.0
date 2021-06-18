From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 Jun 2021 10:14:54 +0200
Subject: [LTP] [PATCH 2/3] syscalls/sendfile: Convert sendfile06 to the
 new API
In-Reply-To: <81961ede-0a43-36d5-ce50-996e81daf867@huawei.com>
References: <20210603033611.15619-1-xieziyao@huawei.com>
 <20210603033611.15619-3-xieziyao@huawei.com>
 <YMurRVXwyvKXnkjj@pevik>
 <81961ede-0a43-36d5-ce50-996e81daf867@huawei.com>
Message-ID: <YMxV/hsYgmegkg5Y@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

> Hi, Petr,

> > > 1. Convert sendfile06 to the new API with file descriptors instead
> > > of socket descriptors.
> > I wonder if this is ok, suppose yes, but better if other check.
> I noticed that it is described in `man 2 sendfile` as follows:

> In Linux kernels before 2.6.33, out_fd must refer to a socket.  Since Linux
> 2.6.33 it can be any file.
+1

> And if we need to cover the case where out_fd is a socket, I suggest adding
> it to sendfile02.c, which tests the basic functionality of the sendfile(),
> just like sendfile07.c:

> in_fd = SAFE_OPEN("in_file", O_RDONLY);

> SAFE_SOCKETPAIR(PF_UNIX, SOCK_DGRAM | SOCK_NONBLOCK, 0, p);
> out_fd = p[1];

Sounds reasonable, but given we test for compilation with 3.10 [1], we can
forget on 2.6.33. We haven't decided the minimal version, maybe we should state
that anything < 3.0 can be removed (it's probably to early to declare 3.10 as
minimal supported version).


> > > 2. Remove the support for UCLINUX.

> > LGTM.
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > ...
> > > +	TEST(sendfile(out_fd, in_fd, NULL, sb.st_size));
> > > +	after_pos = SAFE_LSEEK(in_fd, 0, SEEK_CUR);
> > > +
> > > +	if (TST_RET != sb.st_size)
> > nit: checkpatch.pl complains, it should be if (sb.st_size != TST_RET)
> > (can be fixed during merge)
> Oh yes, sometimes forgot to use checkpatch.pl to check my code files. Thanks
> for your tips, Petr.
np, it's really a detail.

Kind regards,
Petr

> Kind Regards,
> Ziyao

[1] https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions
