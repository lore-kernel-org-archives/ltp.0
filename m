Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDzNv-0001Pb-QQ
	for ltp-list@lists.sourceforge.net; Thu, 13 Feb 2014 16:43:35 +0000
Date: Thu, 13 Feb 2014 17:43:25 +0100
From: chrubis@suse.cz
Message-ID: <20140213164325.GA18531@rei.suse.cz>
References: <52BC269D.9060009@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52BC269D.9060009@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] controllers/memcg_lib.sh: reset root cgroup's
 memory.use_hierarchy to 0
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> index 16e30ec..f93b291 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> @@ -38,6 +38,7 @@ HUGEPAGESIZE=`grep Hugepagesize /proc/meminfo | awk '{ print $2 }'`
>  HUGEPAGESIZE=$(( $HUGEPAGESIZE * 1024 ))
>  PASS=0
>  FAIL=1
> +orig_memory_use_hierarchy="none"
>  
>  cur_id=0
>  failed=0
> @@ -396,6 +397,15 @@ test_move_charge()
>  
>  cleanup()
>  {
> +	if [ "$orig_memory_use_hierarchy" != "none" ];then

It would be a bit better to check for non empty string here, because if
the:

orig_memory_use_hierarchy=$(cat /dev/memcg/memory.use_hierarchy)

has failed for any reason the value would be set to empty string and we
will write only newline into the /dev/memcg/... file which will likely
result in error.

> +		echo $orig_memory_use_hierarchy > \
> +		     /dev/memcg/memory.use_hierarchy
> +		if [ $? -ne 0 ];then
> +			tst_resm TINFO "restore "\
> +				 "/dev/memcg/memory.use_hierarchy failed"
> +		fi
> +	fi
> +	orig_memory_use_hierarchy="none"
>  	killall -9 memcg_process 2>/dev/null
>  	if [ -e /dev/memcg ]; then
>  		umount /dev/memcg 2>/dev/null
> @@ -409,4 +419,17 @@ do_mount()
>  
>  	mkdir /dev/memcg 2> /dev/null
>  	mount -t cgroup -omemory memcg /dev/memcg
> +
> +	# For some linux distribution, such as RHEL7U0Beta,
> +	# memory.use_hierarchy is 1 by default, which will caused some tests
> +	# failed, such as memcg_stat_test.sh. According to kernel
> +	# Documentation/cgroups/memory.txt's description, the default value
> +	# should be 0, and some ltp tests are written based on this assumption,
> +	# so here we reset the root cgroup's memory.use_hierarchy to 0
> +	# before the test.

I would keep this a bit shorter (it's comment in the code, not poetry :)

Such as:

# The default value for memory.use_hierarchy is 0 and some of tests
# (memcg_stat_test.sh) expects it so while there are distributions
# (RHEL7U0Beta for example) that sets it to 1.

The fact that we set it to 0 before the test is obvious from the code.

> +	orig_memory_use_hierarchy=$(cat /dev/memcg/memory.use_hierarchy)
> +	echo 0 > /dev/memcg/memory.use_hierarchy

What about setting this only when the orig value is not 0?

Moreover setting the orig value to empty if it's 0 to avoid the
restoration in cleanup()?

> +	if [ $? -ne 0 ];then
> +		tst_resm TINFO "set /dev/memcg/memory.use_hierarchy to 0 failed"
> +	fi
>  }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
