From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 16 Jan 2017 16:53:13 +0100
Subject: [LTP] utimensat EACCES vs. EPERM in 4.8+
In-Reply-To: <18a5b416-ad6a-e679-d993-af7ffa0dcc10@redhat.com>
References: <18a5b416-ad6a-e679-d993-af7ffa0dcc10@redhat.com>
Message-ID: <CAOssrKfb1-C8c=9bAPiairh+Lyf=w28r+RjSXTLQcQZ-=eWMRA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jan 16, 2017 at 4:46 PM, Jan Stancek <jstancek@redhat.com> wrote:
> Hi,
>
> we seem to have a conflict between kernel and man pages.
> From utimensat man page:
>
> EACCES times is NULL, or both tv_nsec values are UTIME_NOW, and either:
>        *  the effective user ID of the caller does not match the owner of the
>           file, the caller does not  have  write  access  to  the file, and the
>           caller is not privileged (Linux: does not have either the CAP_FOWNER
>           or the CAP_DAC_OVERRIDE capability); or,
>        *  the file is marked immutable (see chattr(1)).
>
> But following 2 commits gradually replaced EACCES with EPERM.
>
> commit 337684a1746f93ae107e05d90977b070bb7e39d8
> Author: Eryu Guan <guaneryu@gmail.com>
> Date:   Tue Aug 2 19:58:28 2016 +0800
>     fs: return EPERM on immutable inode

I agree with Eryu that consistently returning EPERM for immutable is
better than sometimes returning EACCESS and sometimes EPERM.

So I think the man page should be fixed.

> commit f2b20f6ee842313a0d681dbbf7f87b70291a6a3b
> Author: Miklos Szeredi <mszeredi@redhat.com>
> Date:   Fri Sep 16 12:44:20 2016 +0200
>     vfs: move permission checking into notify_change() for utimes(NULL)

Actually this later commit didn't change the error value, it just
moved code around.

Thanks,
Miklos
