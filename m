Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YuKqi-0005Wt-8U
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2015 13:12:52 +0000
Date: Mon, 18 May 2015 15:12:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150518131209.GH4104@rei>
References: <20150428163313.GA24127@rei>
	<1431596608-27065-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1431596608-27065-1-git-send-email-zenglg.jy@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/2] test.sh: Add tst_acquire_device() and
 tst_release_device()
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
Cc: ltp-list@lists.sourceforge.net, Zhang Jin <jy_zhangjin@cn.fujitsu.com>

Hi!
> Add two functions tst_acquire_device() and tst_release_device()
> 
> Signed-off-by: Zhang Jin <jy_zhangjin@cn.fujitsu.com>
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/lib/test.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> index 163c54b..3e6f742 100644
> --- a/testcases/lib/test.sh
> +++ b/testcases/lib/test.sh
> @@ -193,6 +193,50 @@ ROD()
>  	fi
>  }
>  
> +tst_acquire_device()
> +{
> +	local dd_size=$1
> +	local testdevice=$2
> +	local mntpoint=$3
> +
> +	ROD_SILENT dd if=/dev/zero of=testimg bs=1M count=${dd_size}
> +
> +	ROD_SILENT losetup ${testdevice} testimg
> +
> +	ROD_SILENT mkfs.ext2 ${testdevice}
> +
> +	ROD_SILENT mkdir -p ${mntpoint}
> +
> +	ROD_SILENT mount ${testdevice} ${mntpoint}

Hmm, I would like to keep the formatting and mounting out of the
library. Because if nothing else, user may want to use different fs than
ext2. The second reason to do so is that we may want to do exactly same
as the C function because anything else will be confusing. For that
reason the free loop device should be also queried here (and stored in a
global variable whose names starts with either tst_ or TST_).

Moreover the C function will try LTP_DEV first and if it points to a
valid block device, it will be used.

> +}
> +
> +tst_release_device()
> +{
> +	local mntpoint=$1
> +
> +	grep -q ${mntpoint} /proc/self/mounts
> +	if [ $? -eq 0 ]; then
> +		umount ${mntpoint}
> +		if [ $? -ne 0 ];then
> +			tst_resm TWARN "'umount ${mntpoint}' failed"
> +		fi
> +	fi
> +
> +	losetup -a | grep -q ${mntpoint}
> +	if [ $? -eq 0 ]; then
> +		losetup -d ${mntpoint}
> +		if [ $? -ne 0 ];then
> +			tst_resm TWARN "'losetup -d ${mntpoint}' failed"
> +		fi
> +	fi
> +
> +	if [ -d ${mntpoint} ]; then
> +		rm -r ${mntpoint}
> +	fi
> +
> +	rm testimg
> +}
> +
>  # Check that test name is set
>  if [ -z "$TCID" ]; then
>  	tst_brkm TBROK "TCID is not defined"
> -- 
> 1.9.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
