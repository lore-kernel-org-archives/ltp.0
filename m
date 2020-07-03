From: Luis Chamberlain <mcgrof@kernel.org>
Date: Fri, 3 Jul 2020 13:35:58 +0000
Subject: [LTP] [v2 PATCH] crypto: af_alg - Fix regression on empty
 requests
In-Reply-To: <20200702033221.GA19367@gondor.apana.org.au>
References: <CA+G9fYvHFs5Yx8TnT6VavtfjMN8QLPuXg6us-dXVJqUUt68adA@mail.gmail.com>
 <20200622224920.GA4332@42.do-not-panic.com>
 <CA+G9fYsXDZUspc5OyfqrGZn=k=2uRiGzWY_aPePK2C_kZ+dYGQ@mail.gmail.com>
 <20200623064056.GA8121@gondor.apana.org.au>
 <20200623170217.GB150582@gmail.com>
 <20200626062948.GA25285@gondor.apana.org.au>
 <CA+G9fYutuU55iL_6Qrk3oG3iq-37PaxvtA4KnEQHuLH9YpH-QA@mail.gmail.com>
 <20200702033221.GA19367@gondor.apana.org.au>
Message-ID: <20200703133558.GX4332@42.do-not-panic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 02, 2020 at 01:32:21PM +1000, Herbert Xu wrote:
> On Tue, Jun 30, 2020 at 02:18:11PM +0530, Naresh Kamboju wrote:
> > 
> > Since we are on this subject,
> > LTP af_alg02  test case fails on stable 4.9 and stable 4.4
> > This is not a regression because the test case has been failing from
> > the beginning.
> > 
> > Is this test case expected to fail on stable 4.9 and 4.4 ?
> > or any chance to fix this on these older branches ?
> > 
> > Test output:
> > af_alg02.c:52: BROK: Timed out while reading from request socket.
> > 
> > ref:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.228-191-g082e807235d7/testrun/2884917/suite/ltp-crypto-tests/test/af_alg02/history/
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.228-191-g082e807235d7/testrun/2884606/suite/ltp-crypto-tests/test/af_alg02/log
> 
> Actually this test really is broken.

FWIW the patch "umh: fix processed error when UMH_WAIT_PROC is used" was
dropped from linux-next for now as it was missing checking for signals.
I'll be open coding iall checks for each UMH_WAIT_PROC callers next. Its
not clear if this was the issue with this test case, but figured I'd let
you know.

  Luis
