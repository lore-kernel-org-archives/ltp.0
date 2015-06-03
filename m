Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z0BVr-0006Ny-Jr
	for ltp-list@lists.sourceforge.net; Wed, 03 Jun 2015 16:27:31 +0000
Date: Wed, 3 Jun 2015 18:26:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150603162630.GA8444@rei.suse.de>
References: <1432630734.31833.5.camel@G08FNSTD140232>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1432630734.31833.5.camel@G08FNSTD140232>
Subject: Re: [LTP] [PATCH] cpuset: regression test for "system crash if
 cpuset_cpumask_can_shrink() is passed an empty cpumask"
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

Hi!
> +TCID=cpuset_regression_test
> +TST_TOTAL=1
> +. test.sh
> +
> +setup()
> +{
> +	tst_require_root
> +
> +	tst_kvercmp 3 18 0
> +	if [ $? -eq 0 ]; then
> +		tst_brkm TCONF "Test must be run with kernel 3.18.0 or newer"
> +	fi
> +
> +	local cpu_num=$(grep processor /proc/cpuinfo | wc -l)

It's better to use $(getconf _NPROCESSORS_ONLN)

> +	if [ $cpu_num -lt 2 ]; then
> +		tst_brkm TCONF "We need 2 cpus at least to have test"
> +	fi
> +
> +	tst_tmpdir
> +}
> +
> +setup1()
> +{
> +	# We need to mount cpuset if it is not found.
> +	mount_flag=0
> +	mount | grep -w cpuset > tmpfile
> +	if [ $? -eq 0 ]; then
> +		root_cpuset_dir=$(cat tmpfile | awk '{print $3}')
> +		rm -rf tmpfile
> +	else
> +		root_cpuset_dir="cpuset_test"
> +
> +		ROD_SILENT mkdir -p ${root_cpuset_dir}
> +
> +		ROD_SILENT mount -t cpuset cpuset ${root_cpuset_dir}
> +
> +		mount_flag=1
> +	fi
> +
> +	if [ -f ${root_cpuset_dir}/cpuset.cpu_exclusive ]; then
> +		cpu_exclusive=cpuset.cpu_exclusive
> +		cpus=cpuset.cpus
> +	elif [ -f ${root_cpuset_dir}/cpu_exclusive ]; then
> +		cpu_exclusive=cpu_exclusive
> +		cpus=cpus
> +	else
> +		tst_brkm TBROK "Both cpuset.cpu_exclusive and cpu_exclusive" \
> +			       "do not exist."
> +	fi
> +
> +	local cpu_exclusive_value=$(cat ${root_cpuset_dir}/${cpu_exclusive})
> +	if [ "${cpu_exclusive_value}" != "1" ];then
> +		echo 1 > ${root_cpuset_dir}/${cpu_exclusive}
> +		if [ $? -ne 0 ]; then
> +			tst_brkm TBROK "'echo 1 >" \
> +				       "${root_cpuset_dir}/${cpu_exclusive}'" \
> +				       "failed"
> +		fi
> +	fi

You should restore the cpu_exclusive value in the cpuset root at the end
of the test as well.

i.e. make this variable global and do:

if [ -n "$cpu_exclusive_value" ]; then
	echo "$cpu_exclusive_value" > ${root_cpuset_dir}/${cpu_exclusive}
fi

in the cleanup.

> +}
> +
> +cleanup()
> +{
> +	if [ -d "${root_cpuset_dir}/testdir" ]; then
> +		rmdir ${root_cpuset_dir}/testdir
> +	fi
> +
> +	if [ "${mount_flag}" == "1" ]; then
> +		umount ${root_cpuset_dir}
> +		if [ $? -ne 0 ]; then
> +			tst_resm TWARN "umount ${root_cpuset_dir} failed"
> +		fi
> +
> +		if [ -d "${root_cpuset_dir}" ]; then
> +			rmdir ${root_cpuset_dir}
> +		fi
> +	fi
> +
> +	tst_rmdir
> +}
> +
> +cpuset_test()
> +{
> +	ROD_SILENT mkdir ${root_cpuset_dir}/testdir
> +
> +	# Creat an exclusive cpuset.
> +	echo 1 > ${root_cpuset_dir}/testdir/${cpu_exclusive}
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TFAIL "'echo 1 >" \
> +			       "${root_cpuset_dir}/testdir/${cpu_exclusive}'" \
> +			       "failed"
> +	fi
> +
> +	local cpu_exclusive_value=$(cat \
> +				    ${root_cpuset_dir}/testdir/${cpu_exclusive})
> +	if [ "${cpu_exclusive_value}" != "1" ]; then
> +		tst_brkm TFAIL "${cpu_exclusive} is '${cpu_exclusive_value}'," \
> +			       "expected '1'"
> +	fi
> +
> +	# ${cpus} is empty at the begin, that maybe make the system *crash*.
> +	echo 0-1 > ${root_cpuset_dir}/testdir/${cpus}
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TFAIL "'echo 0-1 >" \
> +			       "${root_cpuset_dir}/testdir/${cpus}' failed"
> +	fi
> +
> +	local cpus_value=$(cat ${root_cpuset_dir}/testdir/${cpus})
> +	if [ "${cpus_value}" != "0-1" ]; then
> +		tst_brkm TFAIL "${cpus} is '${cpus_value}', expected '0-1'"
> +	fi
> +
> +	tst_resm TPASS "Bug is not reproduced"
> +}
> +
> +setup
> +TST_CLEANUP=cleanup
> +
> +setup1

Hmm, you can set TST_CLEANUP in the middle of the setup() function.
There is no need to artificially split the setup.

> +cpuset_test
> +
> +tst_exit
> -- 
> 1.8.3.1
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> One dashboard for servers and applications across Physical-Virtual-Cloud 
> Widest out-of-the-box monitoring support with 50+ applications
> Performance metrics, stats and reports that give you Actionable Insights
> Deep dive visibility with transaction tracing using APM Insight.
> http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
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
