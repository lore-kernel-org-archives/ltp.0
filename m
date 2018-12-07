From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 07 Dec 2018 15:30:39 +0100
Subject: [LTP] [PATCH 3/3] crypto/crypto_user01.c: new test for
	information leak bug
In-Reply-To: <20181206181814.85583-4-ebiggers@kernel.org>
References: <20181206181814.85583-1-ebiggers@kernel.org>
 <20181206181814.85583-4-ebiggers@kernel.org>
Message-ID: <87o99xmmsw.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello again,

Eric Biggers <ebiggers@kernel.org> writes:

> From: Eric Biggers <ebiggers@google.com>
>
> Test for a bug in the crypto user configuration API (NETLINK_CRYPTO)
> that leaked uninitialized memory to userspace.  This bug was assigned
> CVE-2018-19854, and it was also a re-introduction of CVE-2013-2547.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  runtest/crypto                          |   1 +
>  runtest/cve                             |   2 +
>  testcases/kernel/crypto/.gitignore      |   1 +
>  testcases/kernel/crypto/crypto_user01.c | 208 ++++++++++++++++++++++++
>  4 files changed, 212 insertions(+)
>  create mode 100644 testcases/kernel/crypto/crypto_user01.c
>
> diff --git a/runtest/crypto b/runtest/crypto
> index e5ba61e5e..cdbc44cc8 100644
> --- a/runtest/crypto
> +++ b/runtest/crypto
> @@ -1 +1,2 @@
>  pcrypt_aead01 pcrypt_aead01
> +crypto_user01 crypto_user01
> diff --git a/runtest/cve b/runtest/cve
> index c4ba74186..78a5d8db2 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -3,6 +3,7 @@ cve-2011-0999 thp01 -I 120
>  cve-2011-2183 ksm05 -I 10
>  cve-2011-2496 vma03
>  cve-2012-0957 uname04
> +cve-2013-2547 crypto_user01
>  cve-2014-0196 cve-2014-0196
>  cve-2015-0235 gethostbyname_r01
>  cve-2015-7550 keyctl02
> @@ -36,3 +37,4 @@ cve-2017-17053 cve-2017-17053
>  cve-2017-18075 pcrypt_aead01
>  cve-2018-5803 sctp_big_chunk
>  cve-2018-1000001 realpath01
> +cve-2018-19854 crypto_user01
> diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
> index fafe5c972..759592fbd 100644
> --- a/testcases/kernel/crypto/.gitignore
> +++ b/testcases/kernel/crypto/.gitignore
> @@ -1 +1,2 @@
>  pcrypt_aead01
> +crypto_user01
> diff --git a/testcases/kernel/crypto/crypto_user01.c b/testcases/kernel/crypto/crypto_user01.c
> new file mode 100644
> index 000000000..b648fcbdc
> --- /dev/null
> +++ b/testcases/kernel/crypto/crypto_user01.c
> @@ -0,0 +1,208 @@
> +/*
> + * Copyright 2018 Google LLC
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program, if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * Regression test for commit f43f39958beb ("crypto: user - fix leaking
> + * uninitialized memory to userspace"), or CVE-2018-19854; it was also a
> + * re-introduction of CVE-2013-2547.  This bug caused uninitialized kernel stack
> + * memory to be leaked in some string fields in the replies to CRYPTO_MSG_GETALG
> + * messages over NETLINK_CRYPTO.  To try to detect the bug, this test dumps all
> + * algorithms using NLM_F_DUMP mode and checks all string fields for unexpected
> + * nonzero bytes.
> + */
> +
> +#include <stdlib.h>
> +#include <linux/rtnetlink.h>
> +
> +#include "tst_test.h"
> +#include "tst_crypto.h"
> +#include "tst_netlink.h"
> +

It seems that on SLE11 there is a bug in the kernel headers which means
compilation fails if you include linux/rtnetlink.h before
linux/netlink.h. If you switch the order then it compiles OK.

-- 
Thank you,
Richard.
