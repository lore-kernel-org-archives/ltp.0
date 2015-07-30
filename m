Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZKohJ-0000YA-Gp
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 14:20:37 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZKohH-0007WO-ID
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 14:20:37 +0000
Date: Thu, 30 Jul 2015 16:20:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150730142019.GB21727@rei.suse.de>
References: <1432630734.31833.5.camel@G08FNSTD140232>
	<20150603162630.GA8444@rei.suse.de>
	<1433398217.2651.1.camel@G08FNSTD140232.g08.fujitsu.local>
	<20150702125856.GA17802@rei.suse.de>
	<1436241863.22274.4.camel@G08FNSTD140232.g08.fujitsu.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436241863.22274.4.camel@G08FNSTD140232.g08.fujitsu.local>
Subject: Re: [LTP] [PATCH v3] cpuset: regression test for "system crash if
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
> +cleanup()
> +{
> +	if [ -d "${root_cpuset_dir}/testdir" ]; then
> +		rmdir ${root_cpuset_dir}/testdir
> +	fi
> +
> +	if [ "${mount_flag}" == "1" ]; then
> +		umount ${root_cpuset_dir}
> +		if [ $? -ne 0 ]; then
> +			tst_resm TWARN "'umount ${root_cpuset_dir}' failed"
> +		fi
> +
> +		if [ -d "${root_cpuset_dir}" ]; then
> +			rmdir ${root_cpuset_dir}
> +		fi
> +	fi
> +
> +	if [ -n ${cpu_exclusive_value} -a ${cpu_exclusive_value} -ne 1 ]; then
> +		# Need to flush, or may be output:
> +		# "write error: Device or resource busy"
> +		sync
> +
> +		echo ${cpu_exclusive_value} > \
> +		     ${root_cpuset_dir}/${cpu_exclusive}
> +	fi

I've moved the cpu_exclusive restoration before the umount above (since
we need to do the steps from setup in reverse order here) and pushed,
thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
