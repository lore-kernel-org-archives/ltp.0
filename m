Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Yxciu-00048d-J3
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 14:54:24 +0000
Date: Wed, 27 May 2015 16:53:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150527145330.GC13878@rei.suse.de>
References: <20150518131209.GH4104@rei>
	<1432264251-27223-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<1432264251-27223-2-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1432264251-27223-2-git-send-email-zenglg.jy@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 2/2] commands/df: Added new testcase to test
 df(1) command.
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
> +	local get_size=$(blockdev --getsize64 ${TST_DEVICE})
> +	# 20971520 = 20 * 1024 * 1024 = 20M
> +	if [ ${get_size} != "20971520" ]; then
> +		tst_brkm TCONF "${TST_DEVICE} size is ${get_size}, excepted 20M"
> +	fi

Why can't we calculate the expected free space based on the size of the
device? Does the space taken by the ext2 internal data structures
vary unpredictedly?

> +	ROD_SILENT mkfs.ext2 ${TST_DEVICE}
> +
> +	ROD_SILENT mkdir -p mntpoint
> +
> +	ROD_SILENT mount ${TST_DEVICE} mntpoint
> +}
> +
> +cleanup()
> +{
> +	grep -q mntpoint /proc/self/mounts
> +	if [ $? -eq 0 ]; then
> +		umount mntpoint
> +		if [ $? -ne 0 ];then
> +			tst_resm TWARN "'umount mntpoint' failed"
> +		fi
> +	else
> +		tst_resm TINFO "mntpoint is not mounted"
> +	fi
> +
> +	tst_release_device
> +
> +	tst_rmdir
> +}
> +
> +df_test()
> +{
> +	$1 >${TCID}.temp 2>&1

You do tst_tmpdir in the setup, which creates unique directory for the
testcase. There is no need to construct complicated names for temporary
files. Simple $1 > out 2>&1 should be fine.

> +	if [ $? -ne 0 ]; then
> +		grep -q -E "unrecognized option | invalid option" ${TCID}.temp
> +		if [ $? -eq 0 ]; then
> +			tst_resm TCONF "'$1' not supported."
> +			return
> +		else
> +			tst_resm TFAIL "'$1' failed."
> +			return
> +		fi
> +	fi
> +
> +	grep ${TST_DEVICE} ${TCID}.temp | grep mntpoint | grep -q $2
> +	if [ $? -eq 0 ]; then
> +		tst_resm TPASS "'$1' passed."
> +	else
> +		tst_resm TFAIL "'$1' failed."
> +	fi
> +}
> +
> +test1()
> +{
> +	df_test "df" "19827"
> +}
> +
> +test2()
> +{
> +	df_test "df -a" "19827"
> +}
> +
> +test3()
> +{
> +	df_test "df -h" "20M"
> +}
> +
> +test4()
> +{
> +	df_test "df -H" "21M"
> +}
> +
> +test5()
> +{
> +	df_test "df -i" "5136"
> +}
> +
> +test6()
> +{
> +	df_test "df -k" "19827"
> +}
> +
> +test7()
> +{
> +	df_test "df -m" "20"
> +}
> +
> +test8()
> +{
> +	df_test "df -t ext2" "19827"
> +}
> +
> +test9()
> +{
> +	df_test "df -T" "19827"
> +}
> +
> +test10()
> +{
> +	df_test "df -v mntpoint" "19827"
> +}
> +
> +test11()
> +{
> +	df -x ext2 >${TCID}.temp 2>&1
> +	if [ $? -ne 0 ]; then
> +		grep -q -E "unrecognized option | invalid option" ${TCID}.temp
> +		if [ $? -eq 0 ]; then
> +			tst_resm TCONF "'df -x ext2' not supported."
> +			return
> +		else
> +			tst_resm TFAIL "'df -x ext2' failed."
> +			return
> +		fi
> +	fi
> +
> +	grep ${TST_DEVICE} ${TCID}.temp | grep -q mntpoint
> +	if [ $? -ne 0 ]; then
> +		tst_resm TPASS "'df -x ext2' passed."
> +	else
> +		tst_resm TFAIL "'df -x ext2' failed."
> +	fi
> +}
> +
> +test12()
> +{
> +	df --version >${TCID}.temp 2>&1
> +	if [ $? -ne 0 ]; then
> +		grep -q -E "unrecognized option | invalid option" ${TCID}.temp
> +		if [ $? -eq 0 ]; then
> +			tst_resm TCONF "'df --version' not supported."
> +			return
> +		else
> +			tst_resm TFAIL "'df --version' failed."
> +			return
> +		fi
> +	else
> +		tst_resm TPASS "'df --version' passed."
> +	fi
> +}
> +
> +TST_CLEANUP="cleanup"
> +setup
> +
> +for i in $(seq 1 ${TST_TOTAL})
> +do
> +	test$i
> +done
> +
> +tst_exit
> -- 
> 1.9.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
