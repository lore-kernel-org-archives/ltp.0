From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 6 Feb 2018 14:53:14 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/mmap17.c: Add new regression test
In-Reply-To: <5A794E19.3000201@cn.fujitsu.com>
References: <1517565794-1769-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1069626938.5781132.1517566821086.JavaMail.zimbra@redhat.com>
 <5A7835B2.9030406@cn.fujitsu.com>
 <940714833.169417.1517830921395.JavaMail.zimbra@redhat.com>
 <5A794E19.3000201@cn.fujitsu.com>
Message-ID: <195340110.511328.1517946794955.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> > The patch you referenced is x86 specific, so we can restrict the test to
> > x86.
> > Also please set the minimum kernel version this is expected to fail on.
> 1) Before commit c64b04f, we couldn't read phys_addr_bits from
> /proc/cpuinfo in 32-bit kernel on x86.
> 2) On non-x86 architectures, we couldn't read phys_addr_bits from
> /proc/cpuinfo as well.
> 
> According to above reasons, i perfer to check phys_addr_bits in
> /proc/cpuinfo rather than the minimum
> kernel version and x86 architecture.   We can skip this test if
> phys_addr_bits isn't available.

I was referring to kernel patch. Does it make sense for this test
to run on older kernels? Based on description it might crash, so
presumably yes.

But do we also want to report FAIL on older kernels if mmap succeeds?
That does not violate any docs.

> addr[0] = 'a';
If mmap works, this has potential of triggering signal,
which will lead to TBROK.

Regards,
Jan
