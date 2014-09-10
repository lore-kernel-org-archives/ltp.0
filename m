Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XRbX8-0006T0-1C
	for ltp-list@lists.sourceforge.net; Wed, 10 Sep 2014 06:37:38 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XRbX6-00078g-Ev
	for ltp-list@lists.sourceforge.net; Wed, 10 Sep 2014 06:37:37 +0000
Date: Wed, 10 Sep 2014 02:37:24 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1984956924.20366068.1410331044710.JavaMail.zimbra@redhat.com>
In-Reply-To: <1410326757.6630.1.camel@G08JYZSD130126>
References: <1410326757.6630.1.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] tst_ncpus_conf: Instead of the old tst_ncpus_max
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> To: "ltp-list" <ltp-list@lists.sourceforge.net>
> Sent: Wednesday, 10 September, 2014 7:25:57 AM
> Subject: [LTP] [PATCH] tst_ncpus_conf: Instead of the old tst_ncpus_max
> 
> In commit 84d608326c59b7177c8ad4228fbcd21569b4f2fd we have updated
> tst_ncpus_max
> function. But smt_smp_enabled.sh and smt_smp_affinity.sh need the old
> tst_ncpus_max, otherwise they will fail. Use tst_ncpus_conf instead of the
> old
> tst_ncpus_max function.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>

Looks good to me, ACK.

Regards,
Jan

> ---
>  include/test.h                                         |  1 +
>  lib/tst_cpu.c                                          | 18
>  ++++++++++++------
>  .../hyperthreading/ht_affinity/smt_smp_affinity.sh     |  2 +-
>  .../sched/hyperthreading/ht_enabled/smt_smp_enabled.sh |  2 +-
>  tools/apicmds/.gitignore                               |  1 +
>  tools/apicmds/Makefile                                 |  5 +++--
>  tools/apicmds/ltpapicmd.c                              |  2 ++
>  7 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/include/test.h b/include/test.h
> index b97d9a3..775ba39 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -270,6 +270,7 @@ int tst_get_path(const char *prog_name, char *buf, size_t
> buf_len);
>  
>  /* lib/tst_cpu.c */
>  long tst_ncpus(void);
> +long tst_ncpus_conf(void);
>  long tst_ncpus_max(void);
>  
>  /* lib/tst_run_cmd.c
> diff --git a/lib/tst_cpu.c b/lib/tst_cpu.c
> index b492dc2..033155e 100644
> --- a/lib/tst_cpu.c
> +++ b/lib/tst_cpu.c
> @@ -33,6 +33,17 @@ long tst_ncpus(void)
>  	return ncpus;
>  }
>  
> +long tst_ncpus_conf(void)
> +{
> +	long ncpus_conf = -1;
> +#ifdef _SC_NPROCESSORS_CONF
> +	ncpus_conf = SAFE_SYSCONF(NULL, _SC_NPROCESSORS_CONF);
> +#else
> +	tst_brkm(TBROK, NULL, "could not determine number of CPUs configured");
> +#endif
> +	return ncpus_conf;
> +}
> +
>  #define KERNEL_MAX "/sys/devices/system/cpu/kernel_max"
>  
>  long tst_ncpus_max(void)
> @@ -56,12 +67,7 @@ long tst_ncpus_max(void)
>  		ncpus_max++;
>  	} else {
>  		/* fall back to _SC_NPROCESSORS_CONF */
> -#ifdef _SC_NPROCESSORS_CONF
> -		ncpus_max = SAFE_SYSCONF(NULL, _SC_NPROCESSORS_CONF);
> -#else
> -		tst_brkm(TBROK, NULL, "could not determine number of CPUs"
> -			" configured");
> -#endif
> +		ncpus_max = tst_ncpus_conf();
>  	}
>  	return ncpus_max;
>  }
> diff --git
> a/testcases/kernel/sched/hyperthreading/ht_affinity/smt_smp_affinity.sh
> b/testcases/kernel/sched/hyperthreading/ht_affinity/smt_smp_affinity.sh
> index 26d564b..10eb250 100755
> --- a/testcases/kernel/sched/hyperthreading/ht_affinity/smt_smp_affinity.sh
> +++ b/testcases/kernel/sched/hyperthreading/ht_affinity/smt_smp_affinity.sh
> @@ -54,7 +54,7 @@ else
>  fi
>  
>  no_of_processor=`tst_ncpus`
> -no_of_cpu=`tst_ncpus_max`
> +no_of_cpu=`tst_ncpus_conf`
>  
>  if [ $no_of_processor -lt $no_of_cpu ];then
>  
> diff --git
> a/testcases/kernel/sched/hyperthreading/ht_enabled/smt_smp_enabled.sh
> b/testcases/kernel/sched/hyperthreading/ht_enabled/smt_smp_enabled.sh
> index f4e23b5..c92d580 100755
> --- a/testcases/kernel/sched/hyperthreading/ht_enabled/smt_smp_enabled.sh
> +++ b/testcases/kernel/sched/hyperthreading/ht_enabled/smt_smp_enabled.sh
> @@ -51,7 +51,7 @@ else
>  fi
>  
>  no_of_processor=`tst_ncpus`
> -no_of_cpu=`tst_ncpus_max`
> +no_of_cpu=`tst_ncpus_conf`
>  
>  if [ $no_of_processor -lt $no_of_cpu ];then
>  	test_op="Enable:/sys/devices/system/cpu/cpuX/online"
> diff --git a/tools/apicmds/.gitignore b/tools/apicmds/.gitignore
> index 0ac3e43..b4f7922 100644
> --- a/tools/apicmds/.gitignore
> +++ b/tools/apicmds/.gitignore
> @@ -6,6 +6,7 @@ tst_get_unused_port
>  tst_kvercmp
>  tst_kvercmp2
>  tst_ncpus
> +tst_ncpus_conf
>  tst_ncpus_max
>  tst_res
>  tst_resm
> diff --git a/tools/apicmds/Makefile b/tools/apicmds/Makefile
> index aa3eefe..9c9472d 100644
> --- a/tools/apicmds/Makefile
> +++ b/tools/apicmds/Makefile
> @@ -26,8 +26,9 @@ include $(top_srcdir)/include/mk/testcases.mk
>  
>  CPPFLAGS		+= -D_GNU_SOURCE
>  
> -MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit flush kvercmp kvercmp2 \
> -				res resm ncpus ncpus_max get_unused_port fs_has_free)
> +MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit flush kvercmp \
> +			     kvercmp2 res resm ncpus ncpus_conf ncpus_max \
> +			     get_unused_port fs_has_free)
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
>  
> diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
> index c7bffa1..5238328 100644
> --- a/tools/apicmds/ltpapicmd.c
> +++ b/tools/apicmds/ltpapicmd.c
> @@ -441,6 +441,8 @@ int main(int argc, char *argv[])
>  		apicmd_kvercmp2(argc, argv);
>  	} else if (strcmp(cmd_name, "tst_ncpus") == 0) {
>  		printf("%li\n", tst_ncpus());
> +	} else if (strcmp(cmd_name, "tst_ncpus_conf") == 0) {
> +		printf("%li\n", tst_ncpus_conf());
>  	} else if (strcmp(cmd_name, "tst_ncpus_max") == 0) {
>  		printf("%li\n", tst_ncpus_max());
>  	} else if (strcmp(cmd_name, "tst_get_unused_port") == 0) {
> --
> 1.9.3
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Want excitement?
> Manually upgrade your production database.
> When you want reliability, choose Perforce
> Perforce version control. Predictably reliable.
> http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
