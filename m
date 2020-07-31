From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 31 Jul 2020 19:15:47 +0200
Subject: [LTP] [PATCH 5.4 00/19] 5.4.55-rc1 review
In-Reply-To: <CA+G9fYvCPwwmF-k=Z9Z6P2KYrOMHurcORwa3RW2H1j6pq1QEDg@mail.gmail.com>
References: <20200730074420.502923740@linuxfoundation.org>
 <CA+G9fYvCPwwmF-k=Z9Z6P2KYrOMHurcORwa3RW2H1j6pq1QEDg@mail.gmail.com>
Message-ID: <20200731171547.GC2012979@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 31, 2020 at 04:02:16PM +0530, Naresh Kamboju wrote:
> On Thu, 30 Jul 2020 at 13:36, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.4.55 release.
> > There are 19 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 01 Aug 2020 07:44:05 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.55-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro?s test farm.
> Regressions on arm64 Juno-r2 device running LTP controllers-tests
> 
> CONFIG_ARM64_64K_PAGES=y
> 
> Unable to handle kernel paging request at virtual address dead000000000108
> [dead000000000108] address between user and kernel address ranges
> Internal error: Oops: 96000044 [#1] PREEMPT SMP
> 
> pc : get_page_from_freelist+0xa64/0x1030
> lr : get_page_from_freelist+0x9c4/0x1030
> 
> We are trying to reproduce this kernel panic and trying to narrow down to
> specific test cases.

If you come up with something that needs to be reverted, please let me
know.

Otherwise, thanks for testing all of these.

greg k-h
