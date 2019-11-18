From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Nov 2019 21:32:41 +0100
Subject: [LTP] [PATCH] Fix static linking with musl-fts
In-Reply-To: <20191115221038.14383-1-fontaine.fabrice@gmail.com>
References: <20191115221038.14383-1-fontaine.fabrice@gmail.com>
Message-ID: <20191118203241.GC2531@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Fabrice,

> Don't append libraries to LDLIBS but prepend them in cpuset_lib/Makefile
> and cpuset/Makefile.inc to allow the user to provide its FTS library
> such as -lfts for musl/uclibc through LDLIBS

> This will fix static build of ltp with musl-fts on uclibc

> Fixes:
>  - http://autobuild.buildroot.org/results/9155326e1ff7c2bb2218122c453872c2fc76f65e

> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>

> -LDLIBS			+= -lcpu_set -lcontrollers -lltp
> +LDLIBS			:= -lcpu_set -lcontrollers -lltp $(LDLIBS)

Thanks a lot, merged!

Kind regards,
Petr
