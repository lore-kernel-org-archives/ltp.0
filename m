From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 21 Aug 2020 13:15:35 +0200
Subject: [LTP] [PATCH 5.8 000/232] 5.8.3-rc1 review
In-Reply-To: <CA+G9fYtebf78TH-XpqArunHc1L6s9mHdLEbpY1EY9tSyDjp=sg@mail.gmail.com>
References: <20200820091612.692383444@linuxfoundation.org>
 <CA+G9fYtebf78TH-XpqArunHc1L6s9mHdLEbpY1EY9tSyDjp=sg@mail.gmail.com>
Message-ID: <20200821111535.GC2222852@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Aug 20, 2020 at 08:57:57PM +0530, Naresh Kamboju wrote:
> On Thu, 20 Aug 2020 at 14:55, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.8.3 release.
> > There are 232 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 22 Aug 2020 09:15:09 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.3-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.8.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> > Herbert Xu <herbert@gondor.apana.org.au>
> >     crypto: af_alg - Fix regression on empty requests
> 
> Results from Linaro?s test farm.
> Regressions detected.
> 
>   ltp-crypto-tests:
>     * af_alg02
>   ltp-cve-tests:
>     * cve-2017-17805
> 
> af_alg02.c:52: BROK: Timed out while reading from request socket.
> We are running the LTP 20200515 tag released test suite.
>  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/crypto/af_alg02.c

Looks like the crypto tests are now fixed :)

Anyway, thanks for testing all of these and letting me know.

greg k-h
