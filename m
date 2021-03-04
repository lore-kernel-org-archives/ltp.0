From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 4 Mar 2021 12:23:15 +0100
Subject: [LTP] [PATCH 5.11 000/773] 5.11.3-rc3 review
In-Reply-To: <CA+G9fYvkW+84U9e0Cjft_pq9bGnBBqCXST7Hg+gx4pKNyuGPFQ@mail.gmail.com>
References: <20210302192719.741064351@linuxfoundation.org>
 <CA+G9fYvkW+84U9e0Cjft_pq9bGnBBqCXST7Hg+gx4pKNyuGPFQ@mail.gmail.com>
Message-ID: <YEDDIzz32JqSvi1S@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 03, 2021 at 02:02:20PM +0530, Naresh Kamboju wrote:
> On Wed, 3 Mar 2021 at 00:59, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.11.3 release.
> > There are 773 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 04 Mar 2021 19:25:07 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.11.3-rc3.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.11.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Results from Linaro?s test farm.
> All our builds are getting PASS now.
> But,
> Regressions detected on all devices (arm64, arm, x86_64 and i386).
> LTP pty test case hangup01 failed on all devices
> 
> hangup01    1  TFAIL  :  hangup01.c:133: unexpected message 3
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> This failure is specific to stable-rc v5.10.20-rc4 and v5.11.3-rc3
> Test PASS on the v5.12-rc1 mainline and Linux next kernel.
> 
> Following two commits caused this test failure,
> 
>    Linus Torvalds <torvalds@linux-foundation.org>
>        tty: implement read_iter
> 
>    Linus Torvalds <torvalds@linux-foundation.org>
>        tty: convert tty_ldisc_ops 'read()' function to take a kernel pointer
> 
> Test case failed link,
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.11.y/build/v5.11.2-774-g6ca52dbc58df/testrun/4070143/suite/ltp-pty-tests/test/hangup01/log
> 

Thanks for testing them all, I'll try to debug this later today...

greg k-h
