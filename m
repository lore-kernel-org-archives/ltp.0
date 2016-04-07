From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Apr 2016 17:31:05 +0200
Subject: [LTP] [PATCH] cpuset: change default cpuset mount value
In-Reply-To: <57062A03.70705@linux.vnet.ibm.com>
References: <57062A03.70705@linux.vnet.ibm.com>
Message-ID: <20160407153105.GA8287@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh 
> b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> index cd7000e..4c5a17b 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> @@ -35,7 +35,7 @@ fi
>   N_NODES=${N_NODES#*-*}
>   N_NODES=$(($N_NODES + 1))
> 
> -CPUSET="/dev/cpuset"
> +CPUSET="/sys/fs/cgroup/cpuset"
>   CPUSET_TMP="/tmp/cpuset_tmp"

This does not seem like a good solution for two reasons. The first is
that LTP should be backward compatible with older distributions and the
second is that the testcase umounts and removes the directory at the end
of the test which will break the system since the /sys/fs/cgroup/cpuset
directory is mounted (and possibly used) by default on newer
distributions.

So the test should be changed to:

* Create and mount cpuset on older distros

* Make use of allready moutned cpuset on newer distros

The cgroup_fj/cgroup_fj_common.sh was allready fixed to work this way.

-- 
Cyril Hrubis
chrubis@suse.cz
