From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Jul 2021 13:47:54 +0200
Subject: [LTP] [PATCH v3] squashfs: Add regression test for sanity check
 bug
In-Reply-To: <f2fd323e-a5da-2959-d130-2d3c0aa59e89@jv-coder.de>
References: <20210715050812.1950884-1-lkml@jv-coder.de>
 <60EFF034.6070800@fujitsu.com>
 <4aaba9d9-e013-3c12-500a-647ff2c0b82d@jv-coder.de>
 <YO//gakCvqaDZl9f@yuki>
 <f2fd323e-a5da-2959-d130-2d3c0aa59e89@jv-coder.de>
Message-ID: <YPgJan6PMGu+Pb/J@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also the dev_min_size = 1 does not have any efect here, since it can be
> > used only to request bigger-than-default size and gets ignored here. I
> > guess that we can merge this as it is and I will add needs_loopdev to
> > the tst_test structure later which will just allocate loop device and
> > pass it down to the test.
> This is true, but the test should also specify what it needs. If for 
> whatever reason DEV_SIZE_MB is redefined to a smaller value, the test 
> would still work.
> To be honest, for "1" it doesn't matter. But it it was bigger, it makes 
> total sense to specify the size if the test knows it...

I was thinking about it and we can easily allow the test to request
smaller than the default size with a pretty minimal change:

diff --git a/lib/tst_device.c b/lib/tst_device.c
index c91c6cd55..4ef802c41 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -300,7 +300,7 @@ const char *tst_acquire_device__(unsigned int size)
        unsigned int acq_dev_size;
        uint64_t ltp_dev_size;

-       acq_dev_size = MAX(size, DEV_SIZE_MB);
+       acq_dev_size = size ? size : DEV_SIZE_MB;

        dev = getenv("LTP_DEV");


This shouldn't break anything while it allows better controll for the
test over the device size.

-- 
Cyril Hrubis
chrubis@suse.cz
