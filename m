From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 31 Jul 2020 15:02:20 +0200
Subject: [LTP] [PATCH 0/3] Build system fixes
In-Reply-To: <20200731121508.12805-1-chrubis@suse.cz>
References: <20200731121508.12805-1-chrubis@suse.cz>
Message-ID: <20200731130220.GA5413@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> This patchset does

> * Introduce LTPLDLIBS to solve linker dependencies once for all

> * Cleans up the output from make a bit, this could be even more fine
>   tuned if we agree on this part

> Cyril Hrubis (3):
>   build system: Add explicit make rules
>   testcases: Make use of LTPLDLIBS
>   build system: Silence the output a bit more

Thanks for addressing this issue!
Works as expected:
https://travis-ci.org/github/pevik/ltp/builds/713670475
LGTM and silence output is also a nice feature.

nit: I was thinking how to reduce verbosity (adding --no-print-directory and @
into a variable), but as there is also echo, it's not worth of it.

Tested-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
