From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Aug 2021 14:52:45 +0200
Subject: [LTP] [PATCH 1/2] docs: rm explicit reference to checkpatch.pl
In-Reply-To: <20210831122554.14590-1-rpalethorpe@suse.com>
References: <20210831122554.14590-1-rpalethorpe@suse.com>
Message-ID: <YS4mHaWi3eqPkaqp@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

...
>  1. Test compiles and runs fine (check with `-i 10` too)
> -2. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl[checkpatch.pl]
> -   does not report any errors
> +2. `make check` does not emit any warnings for the test you are working on
> +   (hint: run it in the test's directory and/or use `make check-$TCID`)

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I was thinking about mention what exactly make check does, but that'd again
require being kept in sync.

Kind regards,
Petr
