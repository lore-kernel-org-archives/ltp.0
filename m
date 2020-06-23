From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 23 Jun 2020 11:53:43 +0530
Subject: [LTP] LTP: crypto: af_alg02 regression on linux-next 20200621
 tag
In-Reply-To: <20200622224920.GA4332@42.do-not-panic.com>
References: <CA+G9fYvHFs5Yx8TnT6VavtfjMN8QLPuXg6us-dXVJqUUt68adA@mail.gmail.com>
 <20200622224920.GA4332@42.do-not-panic.com>
Message-ID: <CA+G9fYsXDZUspc5OyfqrGZn=k=2uRiGzWY_aPePK2C_kZ+dYGQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 23 Jun 2020 at 04:19, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Jun 23, 2020 at 12:04:06AM +0530, Naresh Kamboju wrote:
> > LTP crypto regressions noticed on linux next 20200621.
> >
> > The common case for all tests is timeout after 15 minutes which
> > means tests got hung and LTP timers killed those test runs after
> > timeout.
> > The root cause of the failure is under investigation.
> >
> >   ltp-crypto-tests:
> >     * af_alg02 - failed
> >     * af_alg05 - failed
> >   ltp-syscalls-tests:
> >     * keyctl07 - failed
> >     * request_key03 - failed
<trim>
>
> Can you try reverting:
>
> d13ef8e10756873b0a8b7cc8f230a2d1026710ea
>
> The patch is titled "umh: fix processed error when UMH_WAIT_PROC is used"

Thanks for the investigation.
After reverting, two test cases got PASS out of four reported failure cases.
 ltp-crypto-tests:
     * af_alg02 - still failing - Hung and time out
     * af_alg05 - still failing - Hung and time out
  ltp-syscalls-tests:
     * keyctl07 - PASS
     * request_key03 - PASS

Please suggest the way to debug / fix the af_alg02 and af_alg05 failures.

- Naresh
