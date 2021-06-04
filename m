From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Jun 2021 08:06:11 +0200
Subject: [LTP] [RFC PATCH 1/2] Add 'make checks' and clang-checks to
 build system
In-Reply-To: <20210603154825.30165-2-rpalethorpe@suse.com>
References: <20210603154825.30165-1-rpalethorpe@suse.com>
 <20210603154825.30165-2-rpalethorpe@suse.com>
Message-ID: <YLnC05icNAshbXtr@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Allows the user to run 'make check' to check all source files or
> 'make check-<target>' to check one source file corresponding to a
> target.

> Adds makefile pieces for tools/clang-checks/main which will be a
> libclang based tool. By default this is ran by 'make check'.

Compilation does not work from tools directory:

$ cd tools/ && make
../include/mk/testcases.mk:25: ../include/mk/clang-checks.mk: No such file or directory
make: *** No rule to make target '../include/mk/clang-checks.mk'.  Stop.

(works from tools/clang-checks/)

But even with compiled tools/clang-checks/main I'm not able to find how this is
supposed to be run, none of these work for me, what am I missing?

$ make autotools && ./configure

$ make check
make: *** No rule to make target 'check'.  Stop.

$ make check-clang
make: *** No rule to make target 'check-clang'.  Stop.

$ cd lib; make check
../include/mk/lib.mk:29: ../include/mk/clang-checks.mk: No such file or directory
make: *** No rule to make target '../include/mk/clang-checks.mk'.  Stop.

$ cd ../testcases/kernel/syscalls/fchown/
make check
../../../../include/mk/testcases.mk:25: ../../../../include/mk/clang-checks.mk: No such file or directory
make: *** No rule to make target '../../../../include/mk/clang-checks.mk'.  Stop.

$ tools/clang-checks/main
Failed to load translation unit: 4
=> maybe print some help info when running without parameters?

Kind regards,
Petr

> In theory allows other tools to be specified with
> 'make CHECK=tool CHECK_FLAGS=<args> check...'. e.g. 'make CHECK=sparse
> CHECK_FLAGS= check-tst_cgroup'
