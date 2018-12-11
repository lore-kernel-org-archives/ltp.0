From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 10 Dec 2018 21:40:42 -0800
Subject: [LTP] [PATCH 3/3] crypto/crypto_user01.c: new test for
 information leak bug
In-Reply-To: <87pnudmnpj.fsf@rpws.prws.suse.cz>
References: <20181206181814.85583-1-ebiggers@kernel.org>
 <20181206181814.85583-4-ebiggers@kernel.org>
 <87pnudmnpj.fsf@rpws.prws.suse.cz>
Message-ID: <20181211054041.GB847@sol.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On Fri, Dec 07, 2018 at 03:11:04PM +0100, Richard Palethorpe wrote:
> Hello,
> 
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > From: Eric Biggers <ebiggers@google.com>
> >
> > Test for a bug in the crypto user configuration API (NETLINK_CRYPTO)
> > that leaked uninitialized memory to userspace.  This bug was assigned
> > CVE-2018-19854, and it was also a re-introduction of CVE-2013-2547.
> >
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  runtest/crypto                          |   1 +
> >  runtest/cve                             |   2 +
> >  testcases/kernel/crypto/.gitignore      |   1 +
> >  testcases/kernel/crypto/crypto_user01.c | 208 ++++++++++++++++++++++++
> >  4 files changed, 212 insertions(+)
> >  create mode 100644 testcases/kernel/crypto/crypto_user01.c
> >
> > diff --git a/runtest/crypto b/runtest/crypto
> > index e5ba61e5e..cdbc44cc8 100644
> > --- a/runtest/crypto
> > +++ b/runtest/crypto
> > @@ -1 +1,2 @@
> >  pcrypt_aead01 pcrypt_aead01
> > +crypto_user01 crypto_user01
> > diff --git a/runtest/cve b/runtest/cve
> > index c4ba74186..78a5d8db2 100644
> > --- a/runtest/cve
> > +++ b/runtest/cve
> > @@ -3,6 +3,7 @@ cve-2011-0999 thp01 -I 120
> >  cve-2011-2183 ksm05 -I 10
> >  cve-2011-2496 vma03
> >  cve-2012-0957 uname04
> > +cve-2013-2547 crypto_user01
> >  cve-2014-0196 cve-2014-0196
> >  cve-2015-0235 gethostbyname_r01
> >  cve-2015-7550 keyctl02
> > @@ -36,3 +37,4 @@ cve-2017-17053 cve-2017-17053
> >  cve-2017-18075 pcrypt_aead01
> >  cve-2018-5803 sctp_big_chunk
> >  cve-2018-1000001 realpath01
> > +cve-2018-19854 crypto_user01
> > diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
> > index fafe5c972..759592fbd 100644
> > --- a/testcases/kernel/crypto/.gitignore
> > +++ b/testcases/kernel/crypto/.gitignore
> > @@ -1 +1,2 @@
> >  pcrypt_aead01
> > +crypto_user01
> > diff --git a/testcases/kernel/crypto/crypto_user01.c b/testcases/kernel/crypto/crypto_user01.c
> > new file mode 100644
> > index 000000000..b648fcbdc
> > --- /dev/null
> > +++ b/testcases/kernel/crypto/crypto_user01.c
> > @@ -0,0 +1,208 @@
> > +/*
> > + * Copyright 2018 Google LLC
> > + *
> > + * This program is free software: you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program, if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +/*
> > + * Regression test for commit f43f39958beb ("crypto: user - fix leaking
> > + * uninitialized memory to userspace"), or CVE-2018-19854; it was also a
> > + * re-introduction of CVE-2013-2547.  This bug caused uninitialized kernel stack
> > + * memory to be leaked in some string fields in the replies to CRYPTO_MSG_GETALG
> > + * messages over NETLINK_CRYPTO.  To try to detect the bug, this test dumps all
> > + * algorithms using NLM_F_DUMP mode and checks all string fields for unexpected
> > + * nonzero bytes.
> > + */
> > +
> > +#include <stdlib.h>
> > +#include <linux/rtnetlink.h>
> > +
> > +#include "tst_test.h"
> > +#include "tst_crypto.h"
> > +#include "tst_netlink.h"
> > +
> > +static struct tst_crypto_session ses = TST_CRYPTO_SESSION_INIT;
> > +
> > +static void setup(void)
> > +{
> > +	tst_crypto_open(&ses);
> > +}
> > +
> > +static void __check_for_leaks(const char *name, const char *value,
> > size_t vlen)
> 
> IIRC we don't allow functions beginning with underscores because they
> are reserved by the compiler or C library.
> 
> > +{
> > +	size_t i;
> > +
> > +	for (i = strnlen(value, vlen); i < vlen; i++) {
> > +		if (value[i] != '\0')
> > +			tst_brk(TFAIL, "information leak in field '%s'", name);
> > +	}
> > +}
> > +
> > +#define check_for_leaks(name, field)  \
> > +	__check_for_leaks(name, field, sizeof(field))
> > +
> > +static void validate_one_alg(const struct nlmsghdr *nh)
> > +{
> > +	const struct crypto_user_alg *alg = NLMSG_DATA(nh);
> > +	const struct rtattr *rta = (void *)alg + NLMSG_ALIGN(sizeof(*alg));
> > +	const struct rtattr *tb[CRYPTOCFGA_MAX + 1] = { 0 };
> > +	size_t remaining = NLMSG_PAYLOAD(nh, sizeof(*alg));
> > +
> > +	check_for_leaks("crypto_user_alg::cru_name", alg->cru_name);
> > +	check_for_leaks("crypto_user_alg::cru_driver_name",
> > +			alg->cru_driver_name);
> > +	check_for_leaks("crypto_user_alg::cru_module_name",
> > +			alg->cru_module_name);
> > +
> > +	while (RTA_OK(rta, remaining)) {
> > +		if (rta->rta_type < CRYPTOCFGA_MAX &&
> > !tb[rta->rta_type])
> 
> So does this mean we get multiple instances of the same RTA type and we
> just check the first? If so I wonder if there is any advantage to testing
> all of them?
> 

I don't believe the API returns multiple of any type currently, but we can check
all just as easily, so I'll do it that way instead.  Thanks!

- Eric
