From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Wed, 16 Dec 2020 10:16:35 +0200
Subject: [LTP] [PATCH] syscalls/ioctl_loop05.c: skip test on overlay
 filesystem
In-Reply-To: <5FD96C97.6020602@cn.fujitsu.com>
References: <20201215155650.6496-1-radoslav.kolev@suse.com>
 <5FD96C97.6020602@cn.fujitsu.com>
Message-ID: <c6340b4dc96458ddd972beb28059324d44f44a99.camel@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 2020-12-16 at 10:10 +0800, Yang Xu wrote:
> Hi Radoslav
> > The undelrying device can't be properly detected and causes failure
> > when running in an overlay filesystem.
> 
> I guess the best way is to change tst_find_backing_dev api, so it
> can 
> detect the correct underlying device.

Yes, that would be the best solution. If you have and idea of how to do
it that's not too complicated please give me some pointers.

I looked into it briefly, but didn't see a straighforward way.

