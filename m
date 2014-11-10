Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xnqh4-0007mP-VB
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 15:15:50 +0000
Date: Mon, 10 Nov 2014 16:15:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141110151513.GA23095@rei.suse.de>
References: <83f98a9de7c4e97c958bd7f9c33610898b998e29.1415630966.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <83f98a9de7c4e97c958bd7f9c33610898b998e29.1415630966.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 1/2 v4] controllers/cpuset: update to use test.sh
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
>  	tst_kvercmp 2 6 28
>  	if [ $? -eq 0 ]; then
> -		tst_brkm TCONF ignored "kernel is below 2.6.28"
> +		tst_brkm TCONF "kernel is below 2.6.28"
>  		return 1

The 'return 1' here is useless after the conversion and so with the
rest of the tst_brkm statements.


...


>  	mkdir "$CPUSET"
>  	mount -t cpuset cpuset "$CPUSET" 2> /dev/null
>  	if [ $? -ne 0 ]; then
> -		tst_brkm TFAIL ignored "Could not mount cgroup filesystem with"\
> +		tst_brkm TFAIL "Could not mount cgroup filesystem with"\
>  					" cpuset on $CPUSET..Exiting test"
>  		cleanup

Here the cleanup will not be executed. We should either call it before
the tst_brkm() or as:

TST_CLEANUP=cleanup
tst_brkm TFAIL "..."

>  		return 1
> @@ -173,14 +175,14 @@ cleanup()
>  		do
>  			/bin/kill -9 $pid > /dev/null 2>&1
>  			if [ $? -ne 0 ]; then
> -				tst_brkm TFAIL ignored "Couldn't kill task - "\
> +				tst_brkm TFAIL "Couldn't kill task - "\
>  							"$pid in the cpuset"
>  				return 1
>  			fi
>  		done < "$subdir/tasks"
>  		rmdir "$subdir"
>  		if [ $? -ne 0 ]; then
> -			tst_brkm TFAIL ignored "Couldn't remove subdir - "
> +			tst_brkm TFAIL "Couldn't remove subdir - "
>  						"$subdir in the cpuset"
>  			return 1
>  		fi
> @@ -188,7 +190,7 @@ cleanup()
>  
>  	umount "$CPUSET"
>  	if [ $? -ne 0 ]; then
> -		tst_brkm TFAIL ignored "Couldn't umount cgroup filesystem with"\
> +		tst_brkm TFAIL "Couldn't umount cgroup filesystem with"\
>  					" cpuset on $CPUSET..Exiting test"
>  		return 1
>  	fi
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
> index 611ea62..05a9ea6 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
> @@ -150,7 +150,7 @@ general_cpu_hotplug_test()
>  	cpu_hotplug $HOTPLUG_CPU $cpuhotplug 2> $CPUSET_TMP/stderr
>  	if [ $? -ne 0 ]; then
>  		cpuset_log_error $CPUSET_TMP/stderr
> -		tst_resm TFAIL ignored "$cpuoffline CPU#$HOTPLUG_CPU failed."
> +		tst_resm TFAIL "$cpuoffline CPU#$HOTPLUG_CPU failed."
>  		/bin/kill -s SIGKILL $tst_pid
>  		return 1
>  	fi
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> index ad989f3..99d4c8e 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> @@ -331,20 +331,20 @@ test_spread_page2()
>  init_memsinfo_array
>  freemem_check
>  if [ $? -ne 0 ]; then
> -	tst_brkm TFAIL ignored "Some node doesn't has enough free memory(100MB) to do test(MemFree_For_Nodes(KB): ${memsinfo[*]})."
> +	tst_brkm TFAIL "Some node doesn't has enough free memory(100MB) to do test(MemFree_For_Nodes(KB): ${memsinfo[*]})."
>  	exit 1
>  fi
>  
>  dd if=/dev/zero of=./DATAFILE bs=1M count=100
>  if [ $? -ne 0 ]; then
> -	tst_brkm TFAIL ignored "Creating DATAFILE failed."
> +	tst_brkm TFAIL "Creating DATAFILE failed."
>  	exit 1
>  fi
>  
>  mkfifo $FIFO
>  if [ $? -ne 0 ]; then
>  	rm -f DATAFILE
> -	tst_brkm TFAIL ignored "failed to mkfifo $FIFO"
> +	tst_brkm TFAIL "failed to mkfifo $FIFO"
>  	exit 1
>  fi
>  
> -- 
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
