From: Li Wang <liwang@redhat.com>
Date: Fri, 31 May 2019 20:46:16 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02.c: Compatible with new
 and old kernels
In-Reply-To: <20190531122630.GA12608@rei.lan>
References: <1559292243-2882-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <5CF0FEB5.4030700@cn.fujitsu.com>
 <CAEemH2erJkdcKU_qg8RsjWUf7A37wj1QgMv=UZ21xUy=vXq9rg@mail.gmail.com>
 <20190531122630.GA12608@rei.lan>
Message-ID: <CAEemH2cFvnOxhk3v8FEZyEX9rH_9nSL1fuVXk0oQGtTJkwOkYw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 31, 2019 at 8:26 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > I have no objection on this. But, is there really make sense to test some
> > more non regular files which not being mentioned by Linux Manual Page?
> >
> > The copy_file_range02 test errors are all extract from manual page, I
> > commented that in Christian's first patch version. And I don't think it's
> > necessary to test undefined behavior in syscall using, because how do we
> > know what error return is the expected?
>
> That's not undefined that's undocummented at best. The kernel code for
> vfs_copy_file_range does:
>
>         if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
>                 return -EISDIR;
>         if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
>                 return -EINVAL;
>
> Which means that directories are treated as special here and all other file
> descriptors that are not regular files are supposed to fail with EINVAL.
>

Yeah, Indeed true.


> So as far as I can tell it makes sense to pass a pipe fd for example and
> check
> for EINVAL. And we should do that both for in_fd and out_fd as well.
>

Sounds reasonable. Thanks for the explanation.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190531/9c601a43/attachment.html>
