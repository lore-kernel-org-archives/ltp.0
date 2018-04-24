From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Apr 2018 13:05:56 +0200
Subject: [LTP] [RFC PATCH 1/1] Remove old build scripts
In-Reply-To: <20180424101429.26799-1-pvorel@suse.cz>
References: <20180424101429.26799-1-pvorel@suse.cz>
Message-ID: <20180424110556.GB32248@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> These scripts are from CVS era, expect git://ltp.git.sourceforge.net.
> Although they have support for git and testing our make build system
> it's important, we use travis and anything important should be moved
> there.

I do agree here, let's apply this, unless anybody objects, next week.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> BTW: my wish is to move from custom make build system to automake based.
> Why: 'make install' for Open POSIX testsuite is broken (some files are missing)
> and due being moved-in as sort of sub-project it's not easy to fix it.
> And we use autoconf anyway.

I do not like automake that much. To be honest I think that the whole
autotools suite is years behind the rest of the world, hence I would
consider moving to it to be a step back.

-- 
Cyril Hrubis
chrubis@suse.cz
