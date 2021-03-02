From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 2 Mar 2021 10:56:55 +0100
Subject: [LTP] [PATCH 5.10 000/661] 5.10.20-rc2 review
In-Reply-To: <CA+G9fYsivUPRRQgMXpnA_XdXH8i2wx_DPH70t+6OzHkjOaswrg@mail.gmail.com>
References: <20210301193642.707301430@linuxfoundation.org>
 <CA+G9fYuK0k0FsnSk4egKOO=B0pV80bjp+f5E-0xPOfbPugQPxg@mail.gmail.com>
 <CA+G9fYsivUPRRQgMXpnA_XdXH8i2wx_DPH70t+6OzHkjOaswrg@mail.gmail.com>
Message-ID: <YD4L57LQb8Nh/A85@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 02, 2021 at 03:20:32PM +0530, Naresh Kamboju wrote:
> Hi Greg and Linus,
> 
> On Tue, 2 Mar 2021 at 12:45, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Tue, 2 Mar 2021 at 01:21, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.10.20 release.
> > > There are 661 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed, 03 Mar 2021 19:34:53 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.20-rc2.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> >
> > Results from Linaro?s test farm.
> > Regressions detected on all devices (arm64, arm, x86_64 and i386).
> >
> > hangup01    1  TFAIL  :  hangup01.c:133: unexpected message 3
> >
> > This failure is specific to stable-rc 5.10 and 5.11.
> > Test PASS on mainline and Linux next kernel.
> >
> 
> I have reverted these two patches and the test case got PASS
> on Linux version 5.10.20-rc2.
> 
> hangup01 1 TPASS : child process exited with status 0
> 
>    Linus Torvalds <torvalds@linux-foundation.org>
>        tty: implement read_iter
> 
>    Linus Torvalds <torvalds@linux-foundation.org>
>        tty: convert tty_ldisc_ops 'read()' function to take a kernel pointer

Odd.

Is 5.12-rc1 also failing with this test as well?

thanks,

greg k-h
