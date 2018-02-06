From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 6 Feb 2018 16:15:00 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/mmap17.c: Add new regression test
In-Reply-To: <195340110.511328.1517946794955.JavaMail.zimbra@redhat.com>
References: <1517565794-1769-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1069626938.5781132.1517566821086.JavaMail.zimbra@redhat.com>
 <5A7835B2.9030406@cn.fujitsu.com>
 <940714833.169417.1517830921395.JavaMail.zimbra@redhat.com>
 <5A794E19.3000201@cn.fujitsu.com>
 <195340110.511328.1517946794955.JavaMail.zimbra@redhat.com>
Message-ID: <1808841957.523089.1517951700941.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> 
> ----- Original Message -----
> > > The patch you referenced is x86 specific, so we can restrict the test to
> > > x86.
> > > Also please set the minimum kernel version this is expected to fail on.
> > 1) Before commit c64b04f, we couldn't read phys_addr_bits from
> > /proc/cpuinfo in 32-bit kernel on x86.
> > 2) On non-x86 architectures, we couldn't read phys_addr_bits from
> > /proc/cpuinfo as well.
> > 
> > According to above reasons, i perfer to check phys_addr_bits in
> > /proc/cpuinfo rather than the minimum
> > kernel version and x86 architecture.   We can skip this test if
> > phys_addr_bits isn't available.
> 
> I was referring to kernel patch. Does it make sense for this test
> to run on older kernels? Based on description it might crash, so
> presumably yes.

Though you need to be root and write to /dev/mem - which seems
like very rare use-case.

> 
> But do we also want to report FAIL on older kernels if mmap succeeds?
> That does not violate any docs.
> 
> > addr[0] = 'a';
> If mmap works, this has potential of triggering signal,
> which will lead to TBROK.

older kernels with lot of DEBUG options can survive:

# uname -r
3.10.0-810.el7.x86_64.debug

# ./mmap17
tst_test.c:980: INFO: Timeout per run is 0h 05m 00s
a1
tst_test.c:1020: INFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1021: BROK: Test killed! (timeout?)

Summary:
passed   0
failed   0
skipped  0
warnings 0

I'd limit it to 4.14 and later - I'm assuming most people won't care
about this bug and we can ignore all outcomes from older kernels.
What do you think?

Regards,
Jan
