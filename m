Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VR233-00061f-Pz
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 15:39:41 +0000
Date: Tue, 1 Oct 2013 17:40:04 +0200
From: chrubis@suse.cz
Message-ID: <20131001154004.GA16669@rei.suse.cz>
References: <1380635095-21403-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1380635095-21403-9-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1380635095-21403-9-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V2 8/8] controllers/cpuset: reorganization
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, miaox@cn.fujitsu.com

Hi!
> A separate name (from controller_cpuset01 to controller_cpuset11) is
> assigned to each cpuset shell testcase (which was invoked earlier
> by run_cpuset_test.sh).
> 
> This will simplify results analysis.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  runtest/controllers                                |   13 ++
>  .../cpuset_base_ops_testset.sh                     |    8 +-
>  .../cpuset_exclusive_test/cpuset_exclusive_test.sh |    8 +-
>  .../kernel/controllers/cpuset/cpuset_funcs.sh      |   23 ++-
>  .../cpuset_hierarchy_test/cpuset_hierarchy_test.sh |    8 +-
>  .../cpuset_hotplug_test/cpuset_hotplug_test.sh     |    6 +-
>  .../cpuset_inherit_test/cpuset_inherit_testset.sh  |    8 +-
>  .../cpuset_load_balance_test.sh                    |    8 +-
>  .../cpuset_sched_domains_test.sh                   |    8 +-
>  .../cpuset_memory_pressure_testset.sh              |    8 +-
>  .../cpuset_memory_spread_testset.sh                |    8 +-
>  .../cpuset_memory_test/cpuset_memory_testset.sh    |    8 +-
>  .../cpuset_syscall_test/cpuset_syscall_testset.sh  |    8 +-
>  .../kernel/controllers/cpuset/run_cpuset_test.sh   |  183 --------------------
>  testcases/kernel/controllers/test_controllers.sh   |   20 --
>  15 files changed, 75 insertions(+), 250 deletions(-)
>  delete mode 100755 testcases/kernel/controllers/cpuset/run_cpuset_test.sh
> 
> diff --git a/runtest/controllers b/runtest/controllers
> index 94fc185..a737b2f 100644
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -12,4 +12,17 @@ memcg_stress		memcg_stress_test.sh
>  memcg_control		PAGESIZE=$(mem_process -p);memcg_control_test.sh $PAGESIZE $PAGESIZE $((PAGESIZE * 2))
>  cgroup_fj	run_cgroup_test_fj.sh
>  controllers	test_controllers.sh
> +
> +controller_cpuset01	cpuset_base_ops_testset.sh
> +controller_cpuset02	cpuset_inherit_testset.sh
> +controller_cpuset03	cpuset_exclusive_test.sh
> +controller_cpuset04	cpuset_hierarchy_test.sh
> +controller_cpuset05	cpuset_syscall_testset.sh
> +controller_cpuset06	cpuset_sched_domains_test.sh
> +controller_cpuset07	cpuset_load_balance_test.sh
> +controller_cpuset08	cpuset_hotplug_test.sh
> +controller_cpuset09	cpuset_memory_testset.sh
> +controller_cpuset10	cpuset_memory_pressure_testset.sh
> +controller_cpuset11	cpuset_memory_spread_testset.sh

Looking at this part made me think if it would  be better to name the
testcases accordingly to the the shell script names, rather than just
numbering them. What do you think?

The rest of the patchset is pushed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
