From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 26 Apr 2017 11:08:05 +0200
Subject: [LTP] LTP release
In-Reply-To: <CAEemH2fOjPpfHrNy73q69whA8vX7ozN0ea=Hufr7CB-UZos6Lg@mail.gmail.com>
References: <20170424162534.GA13616@rei.lan>
 <CAEemH2fOjPpfHrNy73q69whA8vX7ozN0ea=Hufr7CB-UZos6Lg@mail.gmail.com>
Message-ID: <20170426090805.GA16024@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > It's about a time we should prepare for another release, hence as
> > usuall, lets start with pointing out any patches that should be part of
> > it and I would like to start with pre-release testing at the end of this
> > week. Does that sound OK to everyone?
> 
> ioctl06 always failed on aarch64(others PASS) with upstream
> kernel-4.11-rc[1-7]. Not sure if it is a bug or not, since i'm still
> on debugging way. Just report here to let you know this.
> 
> # uname -rm
> 4.11.0-rc7 aarch64
> 
> # ./ioctl06
> tst_device.c:82: INFO: Found free device '/dev/loop1'
> tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
> ioctl06.c:37: INFO: BLKRAGET original value 256
> ioctl06.c:44: PASS: BLKRASET 0 read back correctly
> ioctl06.c:46: FAIL: BLKRASET 64 read back 0
> ioctl06.c:44: PASS: BLKRASET 128 read back correctly
> ioctl06.c:46: FAIL: BLKRASET 192 read back 128
> ioctl06.c:44: PASS: BLKRASET 256 read back correctly
> ioctl06.c:46: FAIL: BLKRASET 320 read back 256
> ioctl06.c:44: PASS: BLKRASET 384 read back correctly
> ioctl06.c:46: FAIL: BLKRASET 448 read back 384
> ioctl06.c:44: PASS: BLKRASET 512 read back correctly
> ioctl06.c:49: INFO: BLKRASET restoring original value 256

Looks like the value is rounded to be multiple of 128, that may be just
intentional limitation, but we should better check with the kernel
source or ask kernel devs.

-- 
Cyril Hrubis
chrubis@suse.cz
