From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Jan 2017 14:30:24 +0100
Subject: [LTP] LTP release status
In-Reply-To: <1116838376.3405880.1484572780617.JavaMail.zimbra@redhat.com>
References: <20170112142828.GC1208@rei.lan>
 <1124039564.1917107.1484233086635.JavaMail.zimbra@redhat.com>
 <20170112153917.GB5381@rei.lan>
 <1054431302.3375878.1484571069128.JavaMail.zimbra@redhat.com>
 <20170116130237.GA26610@rei.lan>
 <1116838376.3405880.1484572780617.JavaMail.zimbra@redhat.com>
Message-ID: <20170116133023.GB26610@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > So I guess I should tag the git and write the release notes once you
> > push your patches, okay?
> 
> Fine by me. I'm going to look at pushing those 2 patches.

And I've just stumbled over:

commit 8cc1e10d725c9104c0fc2a31527be8b1d9baa252
Author: Artem Savkov <asavkov@redhat.com>
Date:   Thu Sep 1 11:06:13 2016 +0200

    utimensat: fix immutable file retcodes for 4.8.0 and newer.

    Kernel 4.8.0 contains patch "337684a fs: return EPERM on immutable inode" that
    makes operations on immutable files return EPERM instead of EACCESS.

    Adjust utimensat test to check new retcode for kernels 4.8.0 and newer.

    Signed-off-by: Artem Savkov <asavkov@redhat.com>
    Reviewed-by: Jan Stancek <jstancek@redhat.com>


Looking closely at the manual page it explicitly says that immutable file with
NULL times must return EACCESS. So as far as I can tell this either hides a
kernel bug or the manual page is wrong. We may want to revert this for the
release, what do you think?

-- 
Cyril Hrubis
chrubis@suse.cz
