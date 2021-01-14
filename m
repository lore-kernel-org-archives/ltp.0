From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 14 Jan 2021 11:14:18 +0800
Subject: [LTP] [PATCH 1/1] autoconf: Use pkg-config for keyutils
 detection
In-Reply-To: <X/7NxM9EaGiXvjDy@pevik>
References: <20210111123626.28932-1-pvorel@suse.cz>
 <5FFEBDCC.6020102@cn.fujitsu.com> <X/7NxM9EaGiXvjDy@pevik>
Message-ID: <5FFFB70A.9040000@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2021/1/13 18:39, Petr Vorel wrote:
> Hi Yang,
>
>> On 2021/1/11 20:36, Petr Vorel wrote:
>>> Using pkg-config is less error prone during cross compilation.
>> Hi Petr,
>> Is there any detailed example about the above point?
> Sometimes I experienced problems during cross compilation with installed library
> for build architecture but missing library for host architecture build failed
> during linking because library was expected but missing.
>
> But I it turned out to be when using our CROSS_COMPILE implementation (without
> specifying --host). When configuring with just --host libraries are properly
> detected with AC_CHECK_LIB().
Hi Petr,

Does the issue only happened when we use ./configure without --host?
In an other word, AC_CHECK_LIB() can detect proper installed libraries 
for build architecture by './configure --host', right?
> pkg-config has some pros and cons.
> Pros:
> * easily require specific library version
> * getting CFLAGS from *.pc file
> * IMHO it's a standard way nowadays

> Cons:
> * For cross compilation it's reuired to set correctly PKG_CONFIG_LIBDIR.
Current ltp mixes pkg-config and AC_CHECK_LIB() so I want to unify them.
We cannot use pkg-config for all libraries because some packages don't 
provide *.pc files.

Best Regards,
Xiao Yang
> I brought pkg-config as dependency to LTP due checking libtirpc>= 0.2.4.
> But this version is already 7 years old so we might not need this version check now.
> (and one day it'd be best to fix (or rewrite from scratch) rpc/tirpc tests and
> move them to libtirpc upstream as Sun-RPC was removed from glibc in 2.32).
>
> Thus we can safely reconsider if we want pkg-config or not.
>
> Kind regards,
> Petr
>
>
> .
>



