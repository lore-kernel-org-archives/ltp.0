From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Mar 2020 12:22:10 +0100
Subject: [LTP] LTP configure Error in ARM64 Platform
In-Reply-To: <20200304111718.ikysbdor72e4innh@vireshk-i7>
References: <fb581273-449f-5b24-0ad3-0fe224a2ab36@arm.com>
 <20200304111718.ikysbdor72e4innh@vireshk-i7>
Message-ID: <20200304112210.GB16978@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> You should have sent this mail to ltp@lists.linux.it instead. Owner
> list has a different purpose.
Yes, please don't use ltp-owner@lists.linux.it :)

> Broken by this commit, reset HEAD before it and apply your patches.

> commit c7d2a7458ee571fc89910602fdd84d85e8a6c008
> Author: Petr Vorel <pvorel@suse.cz>
> Date:   Tue Jan 7 14:20:32 2020 +0100

>     rpc-tirpc: Detect libtirpc with pkg-config

>     Using pkg-config is more reliable way than detecting presence of
>     libtirpc shared library with headers. As it does not require use $SYSROOT,
>     which is not defined everywhere (at least SDKs built in YOCTO as they
>     use nonstandard $SDKTARGETSYSROOT, see [1]).
>     Also use CFLAGS instead of CPPFLAGS in build system (we have C sources).
>     Fixes: a86d71fe5 ("Implemented autoconf check for libtirpc")

>     Use only <rpc/*.h> includes, <tirpc/rpc/*.h> removed as not needed
>     (pkg-config detects -I/usr/include/tirpc when needed). Therefore rpc.h
>     moved out of lapi.
>     Fixes: 7fe1a8bf8 ("rpc: Use libtirpc for all RPC tests + detect headers location")

>     Also removed <netconfig.h> (resp. <tirpc/netconfig.h>) as it's not needed.
>     Fixes: c0caf8f23 (initial commit of TI-RPC tests)

>     Implementation expects that RPC headers (<rpc/rpc.h> etc) are available,
>     because AC_CHECK_HEADERS() doesn't support passing header location and
>     libtirpc has them anyway.

>     [1] https://github.com/linux-test-project/ltp/pull/628

>     Closes: #628

>     Acked-by: Cyril Hrubis <chrubis@suse.cz>
>     Signed-off-by: Petr Vorel <pvorel@suse.cz>
As I noted in my private reply, you need pkg-config package. I'll document
travis/*.sh scripts as a source of required packages.
Commit c7d2a7458 ("rpc-tirpc: Detect libtirpc with pkg-config") changed quite a
lot files, that's probably why people (you're not alone) didn't notice added
dependencies in travis scripts.

Kind regards,
Petr
