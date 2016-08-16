From: Yuriy Kolerov <Yuriy.Kolerov@synopsys.com>
Date: Tue, 16 Aug 2016 09:46:13 +0000
Subject: [LTP] [PATCH] syscalls/fcntl34: Use -D_FILE_OFFSET_BITS=64 for
 all cases
In-Reply-To: <20160815120810.GC20680@rei.lan>
References: <1471021912-29886-1-git-send-email-yuriy.kolerov@synopsys.com>
 <20160815120810.GC20680@rei.lan>
Message-ID: <3ABF60118B9B784CA5BF7C841D2F00EC01000AF3@de02wembxa.internal.synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

As far as I know it fails in this case because fcntl always expects flock64 for OFD locks but gets 32-bit flock structure with non-zero l_pid field (OFD expects that this field contains zero otherwise returns EINVAL). The problem is that there are no 32-bit OFD locks in the kernel. So there are 2 options:

1. Set -D_FILE_OFFSET_BITS=64 to use flock64 by default.
2. Use flock64 and fcntl64 everywhere explicitly.

> -----Original Message-----
> From: Cyril Hrubis [mailto:chrubis@suse.cz]
> Sent: Monday, August 15, 2016 3:08 PM
> To: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
> Cc: ltp@lists.linux.it; Vineet.Gupta1@synopsys.com;
> Alexey.Brodkin@synopsys.com
> Subject: Re: [LTP] [PATCH] syscalls/fcntl34: Use -D_FILE_OFFSET_BITS=64 for
> all cases
> 
> Hi!
> > This test uses OFD locks which are supported only by 64-bit ABI.
> > Thus OFD locks must be used with flock64 structure for sure in this
> > test. It is necessary because on some 32-bit targets (e.g. 32-bit
> > uClibc) flock is not mapped to flock64 when _FILE_OFFSET_BITS is not
> > set to 64. Thus fcntl34 and fcntl34_64 must be identical. It is an
> > ugly but the easiest solution.
> 
> Indeed the test fails on 32bit platform without the _FILE_OFFSET_BITS=64.
> But it fails correctly with EINVAL in this case since the ioctl() in question is not
> implemented.
> 
> So better solution would be to try the ioctl() in the test setup and report
> TCONF if we got EINVAL.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
