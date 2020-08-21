From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Aug 2020 08:51:05 +0200
Subject: [LTP] [PATCH 5.8 000/232] 5.8.3-rc1 review
In-Reply-To: <20200820182516.GA49496@sol.localdomain>
References: <20200820091612.692383444@linuxfoundation.org>
 <CA+G9fYtebf78TH-XpqArunHc1L6s9mHdLEbpY1EY9tSyDjp=sg@mail.gmail.com>
 <20200820182516.GA49496@sol.localdomain>
Message-ID: <20200821065105.GB11908@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> On Thu, Aug 20, 2020 at 08:57:57PM +0530, Naresh Kamboju wrote:
> > On Thu, 20 Aug 2020 at 14:55, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:

> > > This is the start of the stable review cycle for the 5.8.3 release.
> > > There are 232 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.

> > > Responses should be made by Sat, 22 Aug 2020 09:15:09 +0000.
> > > Anything received after that time might be too late.

> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.3-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.8.y
> > > and the diffstat can be found below.

> > > thanks,

> > > greg k-h

> > > Herbert Xu <herbert@gondor.apana.org.au>
> > >     crypto: af_alg - Fix regression on empty requests

> > Results from Linaro?s test farm.
> > Regressions detected.

> >   ltp-crypto-tests:
> >     * af_alg02
> >   ltp-cve-tests:
> >     * cve-2017-17805

> > af_alg02.c:52: BROK: Timed out while reading from request socket.
> > We are running the LTP 20200515 tag released test suite.
> >  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/crypto/af_alg02.c

> > Summary
> > ------------------------------------------------------------------------

> > kernel: 5.8.3-rc1
> > git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > git branch: linux-5.8.y
> > git commit: 201fff807310ce10485bcff294d47be95f3769eb
> > git describe: v5.8.2-233-g201fff807310
> > Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.8-oe/build/v5.8.2-233-g201fff807310

> > Regressions (compared to build v5.8.2)
> > ------------------------------------------------------------------------

> > x15:
> >   ltp-crypto-tests:
> >     * af_alg02

> >   ltp-cve-tests:
> >     * cve-2017-17805


> Looks like this test is still "broken" because it assumes behavior that isn't
> clearly specified, as previously discussed at
> https://lkml.kernel.org/r/20200702033221.GA19367@gondor.apana.org.au.

> I sent out LTP patches to fix it:
> https://lkml.kernel.org/linux-crypto/20200820181918.404758-1-ebiggers@kernel.org/T/#u

FYI fix for LTP merged.

Kind regards,
Petr

> - Eric
