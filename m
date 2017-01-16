From: Eryu Guan <eguan@redhat.com>
Date: Mon, 16 Jan 2017 23:25:32 +0800
Subject: [LTP] LTP release status
In-Reply-To: <329006128.105238.1484575796946.JavaMail.zimbra@redhat.com>
References: <20170112142828.GC1208@rei.lan>
 <1124039564.1917107.1484233086635.JavaMail.zimbra@redhat.com>
 <20170112153917.GB5381@rei.lan>
 <1054431302.3375878.1484571069128.JavaMail.zimbra@redhat.com>
 <20170116130237.GA26610@rei.lan>
 <1116838376.3405880.1484572780617.JavaMail.zimbra@redhat.com>
 <20170116133023.GB26610@rei.lan>
 <329006128.105238.1484575796946.JavaMail.zimbra@redhat.com>
Message-ID: <20170116152532.GJ1859@eguan.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jan 16, 2017 at 09:09:56AM -0500, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
> > From: "Cyril Hrubis" <chrubis@suse.cz>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: ltp@lists.linux.it
> > Sent: Monday, 16 January, 2017 2:30:24 PM
> > Subject: Re: [LTP] LTP release status
> > 
> > Hi!
> > > > So I guess I should tag the git and write the release notes once you
> > > > push your patches, okay?
> > > 
> > > Fine by me. I'm going to look at pushing those 2 patches.
> > 
> > And I've just stumbled over:
> > 
> > commit 8cc1e10d725c9104c0fc2a31527be8b1d9baa252
> > Author: Artem Savkov <asavkov@redhat.com>
> > Date:   Thu Sep 1 11:06:13 2016 +0200
> > 
> >     utimensat: fix immutable file retcodes for 4.8.0 and newer.
> > 
> >     Kernel 4.8.0 contains patch "337684a fs: return EPERM on immutable inode"
> >     that
> >     makes operations on immutable files return EPERM instead of EACCESS.
> > 
> >     Adjust utimensat test to check new retcode for kernels 4.8.0 and newer.
> > 
> >     Signed-off-by: Artem Savkov <asavkov@redhat.com>
> >     Reviewed-by: Jan Stancek <jstancek@redhat.com>
> > 
> > 
> > Looking closely at the manual page it explicitly says that immutable file
> > with
> > NULL times must return EACCESS. So as far as I can tell this either hides a
> > kernel bug or the manual page is wrong. We may want to revert this for the
> > release, what do you think?
> 
> I'm thinking revert until we figure out which one is correct. I checked man-pages
> mailing list, but I don't see any patches for utimensat.
> 
> @Eryu: kernel commit 337684a mentions setxattr03, do you recall if it changed
> also utimensat errno code on purpose? We seem to have a conflict with man
> page at the moment.

Yes, I changed all errno to EPERM on immutable inode so that we return
the consistent errno. But I failed to reference a explicit standard to
say what we really should return on immutable inode, just that in most
places EPERM are returned on immutable or append-only inode, and
fcntl(2) manpage says (it doesn't mention immutable inode):

EPERM  Attempted to clear the O_APPEND flag on a file that has the
append-only attribute set.

I think immutable inode should be treated the same as append-only inode,
they're both file attribute.

OTOH, utimensat(2) manpage seems inconsistent/vague on immutable inode,
it says:

EACCES ...
...
	*  the file is marked immutable (see chattr(1)).

then

EPERM ...
...
	*  the file is marked append-only or immutable (see chattr(1)).

Perhaps the manpage should be updated.

Thanks,
Eryu
