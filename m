From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Nov 2019 14:20:04 +0100
Subject: [LTP] [PATCH v1] cgroup_fj_stress: Avoid killall
In-Reply-To: <20191105112000.20633-1-cfamullaconrad@suse.de>
References: <20191105112000.20633-1-cfamullaconrad@suse.de>
Message-ID: <20191105132004.GA20849@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clements,

> We discovered problems that killall didn't catched all processes. With
> this patch, we collect the pids manually and kill them one after the
> other.

LGTM.
I wonder if we also want to kill cgroup_fj_proc this way (see cgroup_fj_common.sh).

I guess you're not planning to create minimal reproducer to prove the problem of
left processes after killall, are you?

> Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
> ---
>  testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
> index 698aa4979..27ea7634a 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
> @@ -74,6 +74,7 @@ setup
>  export TMPFILE=./tmp_tasks.$$

>  count=0
> +collected_pids=""
nit:
collected_pids=

...

Kind regards,
Petr
