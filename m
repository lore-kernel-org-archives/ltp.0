Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QmTun-0000Yp-9u
	for ltp-list@lists.sourceforge.net; Thu, 28 Jul 2011 16:58:29 +0000
Date: Thu, 28 Jul 2011 19:01:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110728170116.GB21916@saboteur.suse.cz>
References: <4E293064.5020706@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E293064.5020706@redhat.com>
Subject: Re: [LTP] [PATCH 1/6 v3] cgroups/cgroup_regression_test: clear
 dmesg before test
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> dmesg can rotate and number of found bugs can actually go down,
> clear the buffer before test to avoid this
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>   .../controllers/cgroup/cgroup_regression_test.sh   |    3 +++
>   1 files changed, 3 insertions(+), 0 deletions(-)
> 
> 
> 

> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> index 878f91a..5615053 100755
> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> @@ -40,6 +40,7 @@ elif [ "x$(id -ru)" != x0 ]; then
>  	exit 0
>  fi
>  
> +dmesg -c > /dev/null
>  nr_bug=`dmesg | grep -c "kernel BUG"`
>  nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
>  nr_warning=`dmesg | grep -c "^WARNING"`
> @@ -78,6 +79,8 @@ check_kernel_bug()
>  	nr_warning=$new_warning
>  	nr_lockdep=$new_lockdep
>  
> +	echo "check_kernel_bug found something!"
> +	dmesg
>  	failed=1
>  	return 0
>  }

Applied, but with the 'dmesg -c' the test could be simplified as storing
number of bugs in log at the start is meaningless now as it's most
likely 0.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
