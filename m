Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2J0P-0003Rc-WB
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 12:51:50 +0000
Date: Tue, 9 Jun 2015 14:50:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609125045.GB26692@rei.suse.de>
References: <1433843386-31431-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-4-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-5-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20150609101009.GE24041@rei.suse.de> <5576D352.4040004@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5576D352.4040004@oracle.com>
Subject: Re: [LTP] [RFC PATCH 5/5] acl_test01: Wait until the loop device is
 detached
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> I think it wouldn't. Please, see below.
> 
> ## Problem 1 ##
> Rapid execution of 'losetup /dev/loop0' file + 'losetup -d /dev/loop0' 
> may fail.
> 
> Reproducer:
> for i in `seq 20`; do
>      echo "attach"
>      losetup /dev/loop0 file1.img
>      echo "detach"
>      losetup -d /dev/loop0
> done
> 
> 1. Kernel versions without the above kernel patch should fail on the 
> "detach" phase, i.e. on
>         if (lo->lo_refcnt > 1)  /* we needed one fd for the ioctl */
>                 return -EBUSY;
> in loop_clr_fd().
> 
> However, I've not tested it by myself.
> 
> And Jan's commit:
> 
> commit 554b1793a1aa34f8918e8b1c04d8c6835f4a5710
> Author: Jan Stancek <jstancek@redhat.com>
> Date:   Tue Jan 20 14:35:49 2015 +0100
> 
>      tst_device: sleep/retry if LOOP_CLR_FD fails with EBUSY
> 
>      Rapid succession of device attach/detach may lead to EBUSY
>      from ioctl(LOOP_CLR_FD), because udev rules might still be
>      running.
> 
>      Sleep/retry for a short period if LOOP_CLR_FD fails with EBUSY.
> 
>      Signed-off-by: Jan Stancek <jstancek@redhat.com>
>      Acked-by: Cyril Hrubis <chrubis@suse.cz>
> 
> is to fix this scenario.

This has been added due to udev holding reference to the device and
preventing the detach. Looks like they "fixed" this in kernel with lazy
detach meanwhile...

> 2. However, newer kernels (i.e. with the above kernel patch) will fail 
> with EBUSY at the "attach" phase, because loop_clr_fd() will always 
> return 0 and mark the loop device for auto clearing, but loop_set_fd() 
> will go this path:
> 
>         error = -EBUSY;
>         if (lo->lo_state != Lo_unbound)
>                 goto out_putf;
> 
>         /* ... */
> 
> out_putf:
>         fput(file);
> out:
>         /* This is safe: open() is still holding a reference. */
>         module_put(THIS_MODULE);
>         return error;

Hmm, that shouldn't be needed, because the we do losetup -f to get free
loop device before the attach operation. If that returns a device that
hasn't been detached yet because of lazy detaching it's a kernel bug.

> ## Problem 2 - NFS specific ##
> 
> If we have the above kernel patch, even if 'losetup -d' executed without 
> problems, it doesn't mean that the backend file is not in use.
> 
> So we need to wait some undetermined time until udev finishes its 
> playing with the loop device, and only after that we can safely remove 
> the file without a risk to be affected by "NFS silly rename".
> 
> ##
> 
> I think that to nail down both the problems at once, we may need to do 
> something like this:
> 
> attach_device(const char *dev)
> {
>    /* a cycle to verify that dev is not in use.
>     * If it's in use after the cycle, call tst_brkm()
>     */
>    ioctl(dev_fd, LOOP_SET_FD);
>    /* handle ioctl errors */
> }
> 
> detach_device(const char *dev)
> {
>    ioctl(dev_fd, LOOP_CLR_FD);
>    /* ignore the return code */
> 
>    /* a cycle to verify that dev is not in use.
>     * If it's still in use after the cycle, call tst_brkm()
>     */
> }
> 
> ioctl(LOOP_GET_STATUS64) looks like a good way to check whether the loop 
> device is in use.
> 
> What do you think?


I think that we should do:

detach_device(..)
{
	while EBUSY:
		ioctl(fd, LOOP_CLR_FD);

	while not error:
		ioclt(LOOP_GET_STATUS);
		usleep();
}

Because if we ignore the return value from LOOP_CLR_FD we will break on
older kernels where we may get EBUSSY instead of lazy detach. And the
LOOP_GET_STATUS* ioctls should return error when device is not attached,
at least if I'm reading kernel code right.


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
