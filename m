From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 4 May 2021 06:08:36 +0200
Subject: [LTP] [PATCH 0/3] syscalls/aio: Convert libaio wrapper function
 to kernel syscall
In-Reply-To: <YJBJB/S1ThSsNvCk@pevik>
References: <20210429115021.24128-1-xieziyao@huawei.com>
 <YJBJB/S1ThSsNvCk@pevik>
Message-ID: <CAASaF6w3xihoQRakDsBB52jnTimexy3V6eoj2wVbtT43Yq9iCQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 3, 2021 at 9:03 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Ziyao,
>
> > Instead of using the libaio wrapper function, the system call is changed
> to be invoked via syscall(2).
>

I probably missed some discussion. Why are we replacing it with syscall?



> Generally LGTM. Major thing for me is to replace <libaio.h> with
> <linux/aio_abi.h>.
> Do you plan to transform other tests which now still use <libaio.h>
> (testcases/kernel/io/aio/ and testcases/kernel/io/ltp-aiodio/, which are
> BTW
> problematic on mainline kernel)? I guess it'd be good to keep some test
> using <libaio.h>.
>
> FYI if you don't prefer put your copyright, I'll update it with LTP
> copyright.
>
> You also mix more things in single commit: using kernel API instead of
> libaio
> API (that you mentioned) with both code and comments cleanup. But commits
> are
> quite compact thus LGTM.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> For whole patchset.
>
> Kind regards,
> Petr
>
> > Xie Ziyao (3):
> >   syscalls/io_destroy: Convert libaio wrapper function to kernel syscall
> >   syscalls/io_setup: Convert libaio wrapper function to kernel syscall
> >   syscalls/io_submit: Convert libaio wrapper function to kernel syscall
>
> >  .../kernel/syscalls/io_destroy/io_destroy01.c |  49 ++------
> >  .../kernel/syscalls/io_setup/io_setup01.c     |  94 +++++----------
> >  .../kernel/syscalls/io_submit/io_submit01.c   | 110 ++++++++----------
> >  3 files changed, 86 insertions(+), 167 deletions(-)
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210504/4eb588ee/attachment.htm>
