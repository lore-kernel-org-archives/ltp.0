From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Jan 2019 04:45:55 +0100
Subject: [LTP] [PATCH v3]  cgroup_regression_test.sh ported to newlib
In-Reply-To: <20181221182516.45689-1-cristian.marussi@arm.com>
References: <20181221182516.45689-1-cristian.marussi@arm.com>
Message-ID: <20190104034555.GA5992@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cristian,

> Ported to newlib and cleaned up.

>  - removed absolute/relative commands invocations
>  - avoid bashism
>   + removed bash shebang
>   + giving up 'kill' bash-builtin: this needs redefining
>     used sigspec strings
>  - A common function 'get_cgroup_mountpoint' is added to help
>    parse /proc/mounts in search of specific cgroup subsystems
>    mountpoints. It is added as part of a common cgroup_lib.sh.
>  - converted Copyright headers to SPDX
>  - renamed each helper to include a tag prefix (cgroup_regress_)
>    in order to avoid possible name clashes once installed all together
>    into testcases/bin

> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks for your patch, merged with several code style changes:
 - unify file names (cgroup_regress_* => cgroup_regression_)
 - rename also getdelays.c and fork_processes.c
 - redirect wait's stderr to /dev/null to keep it quiet
 - remove mandatory commands from TST_NEEDS_CMDS
 - move tst_test.sh loading into library
 - cleanup get_cgroup_mountpoint()
 - minor code style fixes

See diff bellow. I also added 4 commits related to this test,
one of them is fixing regression I added while changing your code
(I'm sorry).

Kind regards,
Petr
