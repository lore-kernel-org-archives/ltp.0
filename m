Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Yn8S8-0008PV-Q1
	for ltp-list@lists.sourceforge.net; Tue, 28 Apr 2015 16:33:44 +0000
Date: Tue, 28 Apr 2015 18:33:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150428163313.GA24127@rei>
References: <1430219455.7745.4.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1430219455.7745.4.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH] commands/df: Added new testcase to test df(1)
 command.
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
> +setup()
> +{
> +	tst_require_root
> +
> +	tst_check_cmds df
> +
> +	tst_tmpdir
> +
> +	dd if=/dev/zero of=test.img bs=1M count=20 >/dev/null 2>&1
> +	if [ $? -ne 0 ];then

Unless we set cleanup we need to do tst_rmdir here and below.

> +		tst_brkm TBROK "dd failed."
> +	fi
> +
> +	device_name=$(/sbin/losetup -f)
> +	if [ $? -ne 0 ];then
> +		tst_brkm TBROK "device_name failed."
> +	fi
> +
> +	losetup ${device_name} test.img
> +	if [ $? -ne 0 ];then
> +		tst_brkm TBROK "losetup failed."
> +	fi

Hmm, we may need tst_acquire_device and tst_release_device for shell as
well. Because as this is we cannot make use of the device passed to the
runltp script.

> +	mkfs.ext2 ${device_name} >/dev/null 2>&1
> +	if [ $? -ne 0 ];then

If we end up here because, for example, mkfs.ext2 is not installed, the
device will still be attached. We need either create a cleanup that is
able to handle to cleanup interrupted setup or just detach the device
and tst_rmdir() here and in the steps below.

> +		tst_brkm TBROK "mkfs.ext2 failed."
> +	fi
> +
> +	mkdir mntpoint
> +	if [ $? -ne 0 ];then
> +		tst_brkm TBROK "mkdir testdir failed."
> +	fi

This can be moved before the losetup when the only cleanup we need to do
is tst_rmdir()

> +	mount ${device_name} mntpoint
> +	if [ $? -ne 0 ];then
> +		tst_brkm TBROK "mount failed."
> +	fi

Can we use the ROD and ROD_SILENT here instead? :)

> +}
> +
> +cleanup()
> +{
> +	umount -d mntpoint
> +	if [ $? -ne 0 ];then
> +		tst_resm TINFO "umount error."
> +	fi

You need to detach the loop device here with losetup -d

> +	tst_rmdir
> +}
> +
> +df_test()
> +{
> +	$1 >${TCID}.temp 2>&1
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
> +	grep ${device_name} ${TCID}.temp | grep mntpoint | grep -q $2
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
> +	grep ${device_name} ${TCID}.temp | grep -q mntpoint
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
> +setup
> +TST_CLEANUP="cleanup"
> +
> +for i in $(seq 1 ${TST_TOTAL})
> +do
> +	test$i
> +done
> +
> +tst_exit

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
