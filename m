From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Dec 2017 15:25:26 +0100
Subject: [LTP] [RFC PATCH 2/2] travis: Add 2x cross-compile ARM build
In-Reply-To: <20171213135808.GE11493@rei>
References: <20171212174544.12310-1-pvorel@suse.cz>
 <20171212174544.12310-3-pvorel@suse.cz>
 <20171213135808.GE11493@rei>
Message-ID: <20171213142526.tozen4rtmaerbkma@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> So the cross compilers are gcc-4.x and gcc-6.x? I ask since we just ask
> for arm cross compilers without a version in the script below.
Versions are 4.8.4 for both. It's actually visible in the log:

https://travis-ci.org/pevik-travis/ltp/jobs/315469429
$ arm-linux-gnueabihf-gcc --version
arm-linux-gnueabihf-gcc (Ubuntu/Linaro 4.8.4-2ubuntu1~14.04.1) 4.8.4
Copyright (C) 2013 Free Software Foundation, Inc.

https://travis-ci.org/pevik-travis/ltp/jobs/315469430
$ aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (Ubuntu/Linaro 4.8.4-2ubuntu1~14.04.1) 4.8.4

> I that is true I suppose that the cross compiler versions may change
> without us noticing, which is not that big deal but it may be better to
> select specific version instead if possible.
The reason why it's not fixed is that it's possible only with special repository
ubuntu-toolchain-r-test, which is used for other jobs. AFAIK they don't provide arm
toolchain, that's why I used standard trusty repository for ARM.

So is that ok as it is?


Kind regards,
Petr
