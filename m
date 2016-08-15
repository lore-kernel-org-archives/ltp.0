From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Aug 2016 14:08:10 +0200
Subject: [LTP] [PATCH] syscalls/fcntl34: Use -D_FILE_OFFSET_BITS=64 for
 all cases
In-Reply-To: <1471021912-29886-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1471021912-29886-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <20160815120810.GC20680@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This test uses OFD locks which are supported only by 64-bit ABI.
> Thus OFD locks must be used with flock64 structure for sure in this
> test. It is necessary because on some 32-bit targets (e.g. 32-bit
> uClibc) flock is not mapped to flock64 when _FILE_OFFSET_BITS is not
> set to 64. Thus fcntl34 and fcntl34_64 must be identical. It is an
> ugly but the easiest solution.

Indeed the test fails on 32bit platform without the
_FILE_OFFSET_BITS=64. But it fails correctly with EINVAL in this case
since the ioctl() in question is not implemented.

So better solution would be to try the ioctl() in the test setup and
report TCONF if we got EINVAL.

-- 
Cyril Hrubis
chrubis@suse.cz
