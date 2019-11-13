From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Nov 2019 17:02:54 +0100
Subject: [LTP] [PATCH] configure.ac: Fix --with* options
In-Reply-To: <20191113104149.42407-1-lkml@jv-coder.de>
References: <20191113104149.42407-1-lkml@jv-coder.de>
Message-ID: <20191113160254.GA28826@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

> The usage of AC_ARG_WITH was wrong. This resulted in unexpected configuration.
> E.g --without-bash set with_bash=yes and --with-nume set with_numa=no.
> This is fixed by using "$withval" in the action-if-given. Also all AC_ARG_WITH
> are unified now (all use alos action-if-not-given)

> The "default=" help text did not make sense for same options.
> e.g. for --with expect was "default=yes", but it defaults to no.
> The "default=" strings are dropped, because defaultness is indicated by
> either "--with-<option>" or "--without-<option>" as done by other projects,
> that use autoconf.

> Defining AC_ARG_WITH within an if to express dependencies does not work.
> ./configure --with-realtime-testsuite set with_realtime_testsuite=yes,
> even if with_bash=no or with_python=no. The check is removed completely.

> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
LGTM, but I'll have more deep look tomorrow.
FYI: https://github.com/linux-test-project/ltp/issues/508

Kind regards,
Petr
