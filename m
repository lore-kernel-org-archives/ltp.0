From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jan 2021 11:39:00 +0100
Subject: [LTP] [PATCH 1/1] autoconf: Use pkg-config for keyutils
 detection
In-Reply-To: <5FFEBDCC.6020102@cn.fujitsu.com>
References: <20210111123626.28932-1-pvorel@suse.cz>
 <5FFEBDCC.6020102@cn.fujitsu.com>
Message-ID: <X/7NxM9EaGiXvjDy@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> On 2021/1/11 20:36, Petr Vorel wrote:
> > Using pkg-config is less error prone during cross compilation.
> Hi Petr,

> Is there any detailed example about the above point?
Sometimes I experienced problems during cross compilation with installed library
for build architecture but missing library for host architecture build failed
during linking because library was expected but missing.

But I it turned out to be when using our CROSS_COMPILE implementation (without
specifying --host). When configuring with just --host libraries are properly
detected with AC_CHECK_LIB().

pkg-config has some pros and cons.
Pros:
* easily require specific library version
* getting CFLAGS from *.pc file
* IMHO it's a standard way nowadays

Cons:
* For cross compilation it's reuired to set correctly PKG_CONFIG_LIBDIR.

I brought pkg-config as dependency to LTP due checking libtirpc >= 0.2.4.
But this version is already 7 years old so we might not need this version check now.
(and one day it'd be best to fix (or rewrite from scratch) rpc/tirpc tests and
move them to libtirpc upstream as Sun-RPC was removed from glibc in 2.32).

Thus we can safely reconsider if we want pkg-config or not.

Kind regards,
Petr
