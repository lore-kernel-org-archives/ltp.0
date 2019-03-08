From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 8 Mar 2019 16:20:53 +0100
Subject: [LTP] [PATCH] Fix out-of-tree build.
In-Reply-To: <20190308145554.17299-1-chrubis@suse.cz>
References: <20190308145554.17299-1-chrubis@suse.cz>
Message-ID: <20190308152052.GB30032@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Ths fixes out of tree build by making the libs directory to be
> dependency of libs-all.

> Not that the the lib and include directory are created as the side efect
> of the AC_CONFIG_FILES() and hence don't need to be created in the
> top-level Makefile.


> This should be last fix for the numa build troubles.
Tested-by: Petr Vorel <pvorel@suse.cz>

Thanks for all todays fixes, nice to be green again!

Tested all 4, locally and via travis:
https://travis-ci.org/pevik/ltp/builds/503638096


> I still have out-of-tree build failures in ffsb configure but I had
> enough autoconf and make for today...
:).

BTW That reminds me some problems with out-of-tree builds: missing files.
It'd be nice to get back to it again.

Kind regards,
Petr
