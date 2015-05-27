Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YxcWV-0003vf-Tl
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 14:41:35 +0000
Date: Wed, 27 May 2015 16:40:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150527144041.GB13878@rei.suse.de>
References: <20150518131209.GH4104@rei>
	<1432264251-27223-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1432264251-27223-1-git-send-email-zenglg.jy@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 1/2] test.sh: Add tst_acquire_device() and
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
Cc: ltp-list@lists.sourceforge.net, jy_zhangjin@cn.fujitsu.com

Hi!
> +tst_acquire_device()
> +{

We should check that tst_tmpdir() has been called here, i.e. that
TST_TMPDIR is non-empty string.

> +	if [ -n "${LTP_DEV}" ]; then
> +		tst_resm TINFO "Using test device LTP_DEV='${LTP_DEV}'"
> +		stat ${LTP_DEV} | grep -q "block special file"

                [ -b "$LTP_DEV" ] ?

> +		if [ $? -ne 0 ]; then
> +			tst_brkm TBROK "${LTP_DEV} is not a block device"
> +		fi
> +		TST_DEVICE=${LTP_DEV}
> +		return
> +	fi
> +
> +	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=20480
> +
> +	TST_DEVICE=$(losetup -f)
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TBROK "Couldn't find free loop device"
> +	fi
> +
> +	tst_resm TINFO "Found free device '${TST_DEVICE}'"
> +
> +	ROD_SILENT losetup ${TST_DEVICE} test_dev.img
> +}
> +
> +tst_release_device()
> +{
> +	losetup -a | grep -q ${TST_DEVICE}
> +	if [ $? -eq 0 ]; then
> +		losetup -d ${TST_DEVICE}
> +		if [ $? -ne 0 ];then
> +			tst_resm TWARN "'losetup -d ${TST_DEVICE}' failed"
> +		fi
> +	fi
> +
> +	if [ -f "test_dev.img" ]; then
> +		rm test_dev.img
> +	fi

We don't have to delete the file here, the tst_rmdir() will do that for
us.

> +}
> +
>  # Check that test name is set
>  if [ -z "$TCID" ]; then
>  	tst_brkm TBROK "TCID is not defined"

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
