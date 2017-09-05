From: Sandeep Patil <sspatil@google.com>
Date: Tue, 5 Sep 2017 16:45:37 -0700
Subject: [LTP] [RFC][PATCH 1/2] libltp: add support to mount tmpfs
In-Reply-To: <1690037120.5974631.1504092465031.JavaMail.zimbra@redhat.com>
References: <20170829001126.142076-1-sspatil@google.com>
 <20170829001126.142076-2-sspatil@google.com>
 <20170829101627.GA31839@rei.lan>
 <1690037120.5974631.1504092465031.JavaMail.zimbra@redhat.com>
Message-ID: <20170905234537.GU84377@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Aug 30, 2017 at 07:27:45AM -0400, Jan Stancek wrote:
> 
> ----- Original Message -----
> > Hi!
> > > Some tests go through losetup, create, format and mount
> > > filesystems only to run tests for 'EROFS' return value from
> > > system calls. The tests end up being flaky depending on the tools
> > > available on the platform. e.g. mkfs.<filesystem> tool is required for
> > > mounting a device with filesystem.
> > > 
> > > If the test is only to check for EROFS, this can be achieved by simply
> > > doing a 'tmpfs' read-only mount in $tmpdir.
> > 
> > Using tmpfs for EROFS sounds like a good idea, that should be much
> > faster than loop device as well, but there is a catch. There most likely
> > are embedded Linux devices that do not have tmpfs support compiled in
> > and as it is this would break these testcases on such platforms.
> > 
> > What about we created even more high-level interface for this? For
> > instance we can add .needs_rofs flag to the tst_test structure (reuse
> > the mntpoint to mount it) and let the library handle the details. I.e.
> > go for tmpfs and if that fails fall back to loop mounted device.
> 
> Can we bind mount "/" as read-only somewhere to $tmpdir? That should be
> widely supported (MS_BIND since 2.4).

That sounds like a simpler, more readily available solution than 'tmpfs'.
I'll change this to read-only bind mount //

- ssp
