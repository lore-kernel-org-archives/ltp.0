From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Nov 2017 16:49:10 +0100
Subject: [LTP] [RFC PATCH 0/4] Add headers in lapi
In-Reply-To: <20171109145443.GA30136@rei>
References: <20171109113947.24609-1-pvorel@suse.cz>
 <20171109145443.GA30136@rei>
Message-ID: <20171109154910.64skbi3ztuqjtozt@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

thanks for info!

> I think that it's a bit cleaner to include the system header before we
> define the fallback definitions, since that way we are sure to pick the
> system ones even if test writer forgets to include the system header in
> the test.
OK. And so it's proposed to include system headers even when using lapi headers.
This looks to me as a duplicity, but probably good practise.

> But be wary of combining the linux and glibc headers, sometimes that
> causes collisions and all kinds of problems.

> In the case of fallocate the bits/fcntl-linux.h which is included by
> bits/fcntl.h which is included from fcntl.h defines these constants (on
> older glibcs, newer include linux/fallocate.h in bits/fcntl-linux.h), so
> including both fcntl.h and linux/falloc.h will cause macro
> redefinitions in certain cases...
OK. IMHO most of the time glibc headers are enough (it's a question what will be newer in
old distro: glibc header or kernel one).

> > If yes, do we want to check presence of them with autotools?

> Most of the time we do not have to, since these headers are present
> everywhere. I do not think that we should be adding autoconf checks just
> in case. So until there is a breakage we should assume that check is not
> needed.
Right!

> > What is the purpose of lapi anyway? I suppose just to backport missing features
> > added in recent glibc to older versions or missing in other libc (musl, uclibc,
> > binder).

> The purpose is to have fallback definitions in a single place,
> previously these were repeated over and over in each testcase, and
> expecially with syscall wrappers that sometimes differ sublty between
> architectures this was quite complicated to maintain.
Sure, I understand DRY principle. I just wasn't sure of the case in
testcases/network/netstress/netstress.c where no system header was used (none of
linux/tcp.h and netinet/tcp.h) and macro was defined, but missing header was probably
left accidentally. Checking that TCP_FASTOPEN was added in 2.18, so it's not in older
distros and in current RHEL (so it's valid to be in lapi header).


Kind regards,
Petr
