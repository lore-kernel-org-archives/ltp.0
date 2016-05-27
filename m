From: Dong ZHu <bluezhudong@gmail.com>
Date: Fri, 27 May 2016 22:08:49 +0800
Subject: [LTP] cgroup_regression_test failed in CentOS 7.2
In-Reply-To: <2095793802.2123498.1464345325799.JavaMail.zimbra@redhat.com>
References: <CAAUgArA3oBMmf4YJebREKXYyE_XfQnsw3_eO1gV-K_b8FaKnFg@mail.gmail.com>
 <2095793802.2123498.1464345325799.JavaMail.zimbra@redhat.com>
Message-ID: <CAAUgArA4ON_uT+nTEPqret4o51CaaXehopnoh+HdmMUdN_RKQw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

Thanks for your info, Is there any effective way (any options or
workaround) for making the test passing on systemd distros ?

On Fri, May 27, 2016 at 6:35 PM, Jan Stancek <jstancek@redhat.com> wrote:

>
>
>
>
> ----- Original Message -----
> > From: "Dong ZHu" <bluezhudong@gmail.com>
> > To: ltp@lists.linux.it
> > Sent: Friday, 27 May, 2016 4:25:41 AM
> > Subject: [LTP] cgroup_regression_test failed in CentOS 7.2
> >
> > Hi All,
> >
> > I ran LTP test suite in CentOS 7.2 with kernel 3.10.0-327, test named
> > "cgroup_regression_test" Test 3 and Test 5 always failed as below:
> > http://pastebin.ubuntu.com/16703246/
> >
> > Test 3 failed when execute "mount -t cgroup -o cpu xxx cgroup/"
> > Test 5 failed when execute "mount -t cgroup -o $subsys1,$subsys2 xxx
> cgroup/"
> >
> > cpu, hugetlb and perf_event has already been mounted in sys as below:
> > http://pastebin.ubuntu.com/16703384/
> >
> > So the mount operation will definitely fail in the test.
> >
> > I just want to know whether it is the test program issue, and whether it
> can
> > be waived ?
>
> This is known to happen on systemd distros, where systemd mounts specific
> subsystems together and LTP test wants to mount just one.
>
> In those cases you should get -EBUSY as described in
> Documentation/cgroup-v1/cgroups.txt:
> "If an active hierarchy with exactly the same set of subsystems already
> exists, it will be reused for the new mount. If no existing hierarchy
> matches, and any of the requested subsystems are in use in an existing
> hierarchy, the mount will fail with -EBUSY. Otherwise, a new hierarchy
> is activated, associated with the requested subsystems."
>
> Regards,
> Jan
>



-- 
Best Regards,
Dong Zhu

My Site: http://bluezd.info
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160527/8db8d357/attachment-0001.html>
