From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 4 Jul 2019 14:15:10 +0300
Subject: [LTP] [PATCH] syscalls/copy_file_range02.c: Compatible with new
 and old kernels
In-Reply-To: <5D1DD658.8050303@cn.fujitsu.com>
References: <1559292243-2882-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <5CF0FEB5.4030700@cn.fujitsu.com>
 <CAEemH2erJkdcKU_qg8RsjWUf7A37wj1QgMv=UZ21xUy=vXq9rg@mail.gmail.com>
 <CAOQ4uxjE6RC_60SR0KZk7dJvU12pxPXEq56-tz840rDCQth1Xg@mail.gmail.com>
 <5D147856.5040709@cn.fujitsu.com>
 <CAOQ4uxjxOWCOBV1OQVg9B5D2eT4jUdQfOAaxTSJgFkqQDUVapg@mail.gmail.com>
 <5D1DD658.8050303@cn.fujitsu.com>
Message-ID: <CAOQ4uxjq110UMEvT6xhp+-T-D0u9SX6ty9E6wBn67Z8aYphjcA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 4, 2019 at 1:35 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:
>
> on 2019/06/27 16:39, Amir Goldstein wrote:
> > On Thu, Jun 27, 2019 at 11:03 AM Yang Xu<xuyang2018.jy@cn.fujitsu.com>  wrote:
> >> on 2019/05/31 21:02, Amir Goldstein wrote:
> >>
> >>> On Fri, May 31, 2019 at 3:03 PM Li Wang<liwang@redhat.com>   wrote:
> >>>>
> >>>> On Fri, May 31, 2019 at 6:15 PM Xiao Yang<yangx.jy@cn.fujitsu.com>   wrote:
> >>>>> On 2019/05/31 16:44, Jinhui huang wrote:
> >>>>>> On new kernels, copy_file_range() returned EISDIR when copyed contents
> >>>>>> to directory, but on old kernels, it returned EBADF, we should accept
> >>>>>> EBADF to be compatible with new and old kernels.
> >>>>>>
> >>>>>> The patch as follows:
> >>>>>> commit 11cbfb10775a ("vfs: deny copy_file_range() for non regular files")
> >>>>> Hi,
> >>>>>
> >>>>>   From description of commit, I wonder if we can add more tests for some
> >>>>> non regular files(e.g. block, pipe)?
> >>>> I have no objection on this. But, is there really make sense to test some more non regular files which not being mentioned by Linux Manual Page?
> >>>>
> >>> FYI, more changes to copy_file_range checks are in the works:
> >>> https://lore.kernel.org/linux-fsdevel/20190526061100.21761-1-amir73il@gmail.com/T/#me34d4363449118bd3b2ec8421d282a77e9a7d2d1
> >> Hi Amir
> >>
> >>       Meet again.  We can increase ltp copy_file_range02 coverage include( swapfile ->ETXTBUSY,  immutable file->EPERM) as same as xfstests generic/553[4].
> >> Also the two other checks(overlaping and offset wrap).  I am glad to do it.
> > That would be great!
>
> Hi Amir
>
> I have tried it.  swapfile and immutable file has no problem, but when I try to reproduce EINVAL(same file overlaping) without xfs_io, I got EFAULT error.
> It look likes we must depend on the new xfs_io feature patch.  Right?
>
> ps: If it must xfs_io command, I think we can not check this situation because we should only check by copy_file_range syscall.
> what do you think about it?
>


I don't understand how xfs_io is related.
LTP should use only copy_file_range() syscall.
Do you have patches I can look at?

> another question:
> I have seen copy_file_range manpage,  it says fd_out data can be overwriting, but I got EFAULT when I use the following code.
>
> open(src_path, O_RDWR|O_CREAT, 0644) = fd_copy
> open(copy_path, O_RDWR|O_CREAT, 0644) = fd_src
> SAFE_WRITE(1, fd_src,  CONTENT,  CONTSIZE);
> SAFE_WRITE(1, fd_copy,  CONTENT,  CONTSIZE);
> copy_file_range(fd_src,0, fd_copy, CONTSIZE/4, CONTSIZE/2, 0) = -1 EFAULT
>
> fs/read_write.c copy_file_range function copy_from_user reports this error. If off_out or off_in isn't equal to 0, the error occurs.
>
> ---------------------
> ret= -EFAULT;
> ....
> if (off_out) {
>                 copy_from_user(&pos_out, off_out, sizeof(loff_t));
>
>                          goto out;
>               }
> ----------------------
>
> Is it a bug or I miss something?
>

You know off_out/off_out are either NULL or pointer to loff_t offset variable?

If you have a sample code you may post it for review.

Thanks,
Amir.
