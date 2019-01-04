From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Jan 2019 14:47:48 +0100
Subject: [LTP] [PATCH 1/1] cgroup: Rewrite some C parts into new API
In-Reply-To: <20190104121339.32147-1-pvorel@suse.cz>
References: <20190104121339.32147-1-pvorel@suse.cz>
Message-ID: <20190104134748.GA11876@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
>  .../cgroup/cgroup_regression_6_2.c            | 29 +++++++++++++------
>  .../cgroup/cgroup_regression_fork_processes.c | 28 +++++++++---------

I'm not able to kill cgroup_regression_fork_processes.c (indefinitely forks).
Only cgroup_regression_6_2.c change is applicable.
>  2 files changed, 35 insertions(+), 22 deletions(-)

> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_6_2.c b/testcases/kernel/controllers/cgroup/cgroup_regression_6_2.c

...
>  int foo(void __attribute__ ((unused)) * arg)
int foo(void *arg LTP_ATTRIBUTE_UNUSED)


Kind regards,
Petr
