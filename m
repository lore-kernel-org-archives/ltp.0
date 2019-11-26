From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 Nov 2019 13:59:01 +0100
Subject: [LTP] [Automated-testing] [PATCH 1/2] Wrapper for Syzkaller
 reproducers
In-Reply-To: <20191107153458.16917-2-rpalethorpe@suse.com>
References: <20191107153458.16917-1-rpalethorpe@suse.com>
 <20191107153458.16917-2-rpalethorpe@suse.com>
Message-ID: <20191126125901.GA6579@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> +++ b/testcases/kernel/syzkaller-repros/Makefile
...
> +# If the reproducers directory is missing then we automatically clone the repo.
> +# We then have to call make recursively to revaluate the targets
> +SYZKALLER_REPROS_DIR ?= $(abs_top_srcdir)/testcases/linux-arts/syzkaller-repros/linux
> +$(SYZKALLER_REPROS_DIR):
> +	git submodule update --init $(abs_top_srcdir)/testcases/linux-arts
Hm, that does not get submodule code.
Reproduced locally and also on travis:
https://travis-ci.org/pevik/ltp/builds/617186693

https://api.travis-ci.org/v3/job/617186701/log.txt
fatal: Not a git repository (or any of the parent directories): .git

or

https://api.travis-ci.org/v3/job/617186700/log.txt
error: pathspec '/usr/src/ltp/testcases/linux-arts' did not match any file(s) known to git

Maybe it's due the fact I already run locally (and the same did travis):
git submodule update --init --recursive

Kind regards,
Petr
