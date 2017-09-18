From: Sandeep Patil <sspatil@google.com>
Date: Mon, 18 Sep 2017 09:51:15 -0700
Subject: [LTP] [PATCH v2 1/2] libltp: add support to mount tmpfs for
 EROFS	testing
In-Reply-To: <1249191462.10698048.1504862521083.JavaMail.zimbra@redhat.com>
References: <20170907221625.13616-1-sspatil@google.com>
 <20170907221625.13616-2-sspatil@google.com>
 <1249191462.10698048.1504862521083.JavaMail.zimbra@redhat.com>
Message-ID: <20170918165115.GA1339@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 08, 2017 at 05:22:01AM -0400, Jan Stancek wrote:
> 
> 
> 
> ----- Original Message -----
> > Some tests go through losetup, create, format and mount filesystems only
> > to test for 'EROFS' return value from system calls. The tests end up
> > being flaky depending on the tools available on the platform. e.g.
> > mkfs.<filesystem> tool is required for mounting a device with
> > filesystem.
> > 
> > If the test is only to check for EROFS, this can be achieved by simply by the
> > read-only mounting 'tmpfs' at 'mntpoint' and fallback to the original way if
> > that fails.
> > 
> > Example of tests that can benefit from this are:
> >   access04, mkdirat02, mknodat02, acct01, fchown04, mknod07 etc.
> > 
> > This also allows for these tests to successfully run on Android.
> > Signed-off-by: Sandeep Patil <sspatil@google.com>
> > ---
> > 
> > v1->v2
> > ------
> > - Changed the interface to be at a higher level, i.e. instead of
> >   making tests specify that they need a read-only tmpfs mount, we
> >   do that automatically in the library as a preference and fallback
> >   to the old way if that doesn't succeed.
> > 
> > - The read-only bind mount of "/" option was tried and it worked just
> >   fine with an Android system, but broke my ubuntu instance badly (I lost
> >   root).
> >   I could never find out why, since hte patch worked fine on Android
> >   and it correctly did the bind mount. However, I figured if there is any
> >   chance of possible breakage, we should simply avoid that path for now.
> 
> I tried this too, with bind mounting only one directory inside TMPDIR:
>   SAFE_MOUNT(source, target, NULL, MS_BIND, NULL);
>   SAFE_MOUNT(NULL, target, NULL, MS_REMOUNT | MS_RDONLY | MS_BIND, NULL);
> and it worked fine, but it turns out it's supported since 2.6.26.

Yes, it worked find for me too. The only place I can imagine something went
wrong was probably some mistake in the code to check for appropriate return
to make sure '/' is indeed bind mounted as read-only. If it is not then there
is a very real chance of the test tear down deleting the bind-mounted '/'
recursively as it clears the $tmpdir (where we bind mounted '/')

I did not use SAFE_MOUNT (I couldn't) because we want to fall back to the
original way of doing things if bind-mount doesn't work. So, I think the
sequence of event as it happened on the broken ubuntu instance in my case may
have been -

1. bind mount '/' to /tmp/foo - success
2. remount /tmp/foo as read-only - fail
3. retry umount(/tmp/foo) 10 times - fail
4. rm -rf /tmp/foo

So, at the end I found things deleted from / :( and wasn't able to diagnose
what went wrong. This was clearly a problem since somehow the test code at
the time must have failed to detect #2 somehow...

.. Anyway, we can do best-effort to do tmpfs, bind mount, create-format-mount
device.


> 
> This patch (which uses tmpfs for EROFS only) looks OK to me, and it allows
> us to add RO bind mount later as fallback if there's need for it (e.g.
> tmpfs not available on some distros).
> 
> I tested it as far back as RHEL5.6 (2.6.18 kernel).

Thanks for the test Jan. I will resend with your tested-by.

> 
> Regards,
> Jan
