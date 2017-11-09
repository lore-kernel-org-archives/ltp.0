From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Nov 2017 15:54:43 +0100
Subject: [LTP] [RFC PATCH 0/4] Add headers in lapi
In-Reply-To: <20171109113947.24609-1-pvorel@suse.cz>
References: <20171109113947.24609-1-pvorel@suse.cz>
Message-ID: <20171109145443.GA30136@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I posted this originally in "netstress: Add imports for TCP_FASTOPEN definition" [1], got reply from Alexey [2].
> 
> Do we want to include system headers which originaly define definitions in lapi
> headers? (e.g. include <linux/falloc.h> in include/lapi/fallocate.h as it
> defines FALLOC_FL_KEEP_SIZE from linux/falloc.h)?
> Some of them do it, some not.

I think that it's a bit cleaner to include the system header before we
define the fallback definitions, since that way we are sure to pick the
system ones even if test writer forgets to include the system header in
the test.

But be wary of combining the linux and glibc headers, sometimes that
causes collisions and all kinds of problems.

In the case of fallocate the bits/fcntl-linux.h which is included by
bits/fcntl.h which is included from fcntl.h defines these constants (on
older glibcs, newer include linux/fallocate.h in bits/fcntl-linux.h), so
including both fcntl.h and linux/falloc.h will cause macro
redefinitions in certain cases...

> If yes, do we want to check presence of them with autotools?

Most of the time we do not have to, since these headers are present
everywhere. I do not think that we should be adding autoconf checks just
in case. So until there is a breakage we should assume that check is not
needed.

> What is the purpose of lapi anyway? I suppose just to backport missing features
> added in recent glibc to older versions or missing in other libc (musl, uclibc,
> binder).

The purpose is to have fallback definitions in a single place,
previously these were repeated over and over in each testcase, and
expecially with syscall wrappers that sometimes differ sublty between
architectures this was quite complicated to maintain.

-- 
Cyril Hrubis
chrubis@suse.cz
