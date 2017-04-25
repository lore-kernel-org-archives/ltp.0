From: Li Wang <liwang@redhat.com>
Date: Tue, 25 Apr 2017 10:29:46 +0800
Subject: [LTP] LTP release
In-Reply-To: <20170424162534.GA13616@rei.lan>
References: <20170424162534.GA13616@rei.lan>
Message-ID: <CAEemH2fOjPpfHrNy73q69whA8vX7ozN0ea=Hufr7CB-UZos6Lg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Tue, Apr 25, 2017 at 12:25 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
> It's about a time we should prepare for another release, hence as
> usuall, lets start with pointing out any patches that should be part of
> it and I would like to start with pre-release testing at the end of this
> week. Does that sound OK to everyone?

ioctl06 always failed on aarch64(others PASS) with upstream
kernel-4.11-rc[1-7]. Not sure if it is a bug or not, since i'm still
on debugging way. Just report here to let you know this.

# uname -rm
4.11.0-rc7 aarch64

# ./ioctl06
tst_device.c:82: INFO: Found free device '/dev/loop1'
tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
ioctl06.c:37: INFO: BLKRAGET original value 256
ioctl06.c:44: PASS: BLKRASET 0 read back correctly
ioctl06.c:46: FAIL: BLKRASET 64 read back 0
ioctl06.c:44: PASS: BLKRASET 128 read back correctly
ioctl06.c:46: FAIL: BLKRASET 192 read back 128
ioctl06.c:44: PASS: BLKRASET 256 read back correctly
ioctl06.c:46: FAIL: BLKRASET 320 read back 256
ioctl06.c:44: PASS: BLKRASET 384 read back correctly
ioctl06.c:46: FAIL: BLKRASET 448 read back 384
ioctl06.c:44: PASS: BLKRASET 512 read back correctly
ioctl06.c:49: INFO: BLKRASET restoring original value 256

Summary:
passed   5
failed   4
skipped  0
warnings 0


-- 
Regards,
Li Wang
Email: liwang@redhat.com
