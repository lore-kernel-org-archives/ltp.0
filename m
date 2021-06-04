From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Jun 2021 08:12:22 +0200
Subject: [LTP] [RFC PATCH 1/2] Add 'make checks' and clang-checks to
 build system
In-Reply-To: <YLnC05icNAshbXtr@pevik>
References: <20210603154825.30165-1-rpalethorpe@suse.com>
 <20210603154825.30165-2-rpalethorpe@suse.com>
 <YLnC05icNAshbXtr@pevik>
Message-ID: <YLnERhx/f8evU0uQ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Hi Richie,

> > Allows the user to run 'make check' to check all source files or
> > 'make check-<target>' to check one source file corresponding to a
> > target.

> > Adds makefile pieces for tools/clang-checks/main which will be a
> > libclang based tool. By default this is ran by 'make check'.

> Compilation does not work from tools directory:

> $ cd tools/ && make
> ../include/mk/testcases.mk:25: ../include/mk/clang-checks.mk: No such file or directory
> make: *** No rule to make target '../include/mk/clang-checks.mk'.  Stop.

I guess you forget to add git add include/mk/clang-checks.mk, right?

Kind regards,
Petr
