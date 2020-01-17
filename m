From: Theodore Y. Ts'o <tytso@mit.edu>
Date: Fri, 17 Jan 2020 16:33:52 -0500
Subject: [LTP] LTP: statx06: FAIL: Birth time < before time
In-Reply-To: <1555311261.2497849.1579281887353.JavaMail.zimbra@redhat.com>
References: <CA+G9fYuBdcZvE6VPm9i2=F0mK5u3j6Z+RHbFBQ1zh9qbN_4kaw@mail.gmail.com>
 <1555311261.2497849.1579281887353.JavaMail.zimbra@redhat.com>
Message-ID: <20200117213352.GA481935@mit.edu>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jan 17, 2020 at 12:24:47PM -0500, Jan Stancek wrote:
> > LTP syscalls statx06 test case getting failed from linux next 20200115
> > tag onwards on all x86_64, i386, arm and arm64 devices
> > 
> > Test output:
> > statx06.c:152: FAIL: Birth time < before time
> 
> [CC Theo & linux-ext4]
> 
> It's returning '0' in stx_btime for STATX_ALL or STATX_BTIME.
> 
> Looking at changes, I suspect:
>   commit 927353987d503b24e1813245563cde0c6167af6e
>   Author: Theodore Ts'o <tytso@mit.edu>
>   Date:   Thu Nov 28 22:26:51 2019 -0500
>     ext4: avoid fetching btime in ext4_getattr() unless requested
> 
> and that perhaps it should be instead...
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c8355f022e6e..6d76eb6d2e7f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5398,7 +5398,7 @@ int ext4_getattr(const struct path *path, struct kstat *stat,
>         struct ext4_inode_info *ei = EXT4_I(inode);
>         unsigned int flags;
> 
> -       if ((query_flags & STATX_BTIME) &&
> +       if ((request_mask & STATX_BTIME) &&
>             EXT4_FITS_IN_INODE(raw_inode, ei, i_crtime)) {
>                 stat->result_mask |= STATX_BTIME;
>                 stat->btime.tv_sec = ei->i_crtime.tv_sec;

Yep, nice catch!  Unfortunately we don't have a test like this in
xfstests, or I would have caught this sooner.

I've fixed this in the dev branch, so it will hopefully be fixed in
the future linux-next tgs.

							- Ted
