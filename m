From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Nov 2018 17:47:55 +0100
Subject: [LTP] [Automated-testing] [PATCH v2] lib: Add library function
 for parsing kernel config
In-Reply-To: <20181127132117.21326-1-chrubis@suse.cz>
References: <20181127132117.21326-1-chrubis@suse.cz>
Message-ID: <20181127164755.GA6668@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> +++ b/lib/newlib_tests/test_kconfig.sh
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +
> +echo "Attempting to parse currently running kernel config"
Could you please add cd into test directory to save people to cd into directory?
cd $(dirname $0)

This might not be needed once I'll finish [1] my "make: Add test target" patch.
(wanted to finish unit testing shell library [2][3] before it).

> +./test_kconfig
> +echo


Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/960363/
[2] https://patchwork.ozlabs.org/patch/964552/
[3] https://github.com/linux-test-project/ltp/issues/312
