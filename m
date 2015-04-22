Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YkuEo-00012u-F9
	for ltp-list@lists.sourceforge.net; Wed, 22 Apr 2015 12:58:46 +0000
Date: Wed, 22 Apr 2015 14:58:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150422125819.GB32110@rei>
References: <1427970931.19106.8.camel@G08JYZSD130126.localdomain>
	<20150402115922.GA30680@rei>
	<1429010747.7190.25.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1429010747.7190.25.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [RFC PATCH v2 2/2] commands/du: Added new testcase to
 test du(1) command.
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
> +	tst_check_cmds dd du stat
> +
> +	tst_tmpdir
> +
> +	testfile=testfile
> +	SAFE_CALL dd if=/dev/zero of=${testfile} bs=1M count=10
> +
> +	testdir=testdir
> +	SAFE_CALL mkdir -p ${testdir}
> +
> +	SAFE_CALL ln -s ../${testfile} ${testdir}/${testfile}

Passing the testdir and testfile as variables looks like unnecessary
indirection to me.

> +	export DU_BLOCK_SIZE=1024

Maybe it deserves comment here, because at first glance this variable
looks unused, but it's in fact used by the du itself.

> +}
> +
> +cleanup()
> +{
> +	tst_rmdir
> +}
> +
> +export test_return
> +du_test()
> +{
> +	$@ > ${TCID}.temp 2>&1
> +	test_return=$?
> +}
> +
> +du_check()
> +{
> +	if [ ${test_return} -ne 0 ]; then
> +		grep -q -E "unrecognized option|invalid option" ${TCID}.temp
> +		if [ $? -eq 0 ]; then
> +			tst_resm TCONF $2 "not supported."
> +			return
> +		else
> +			tst_resm TFAIL $2 "failed."
> +			return
> +		fi
> +	fi
> +
> +	grep -q $1 ${TCID}.temp
> +	if [ $? -eq 0 ]; then
> +		tst_resm TPASS $2 "passed."
> +	else
> +		tst_resm TFAIL $2 "failed."
> +	fi
> +}

Why is the du_test() and do_check() done as two functions?

In the test below they are always called together, wouldn't it be easier
if this was just one function?

> +test1()
> +{
> +	du_test du
> +	du_check ${check1} "du(option: none)"
> +}
> +
> +test2()
> +{
> +	du_test du ${testfile}
> +	du_check ${check2} "du(option: <FILE>)"
> +}
> +
> +test3()
> +{
> +	du_test du -a
> +	du_check ${check3} "du(option: -a)"
> +}
> +
> +test4()
> +{
> +	du_test du --all
> +	du_check ${check3} "du(option: --all)"
> +}
> +
> +test5()
> +{
> +	du_test du -B ${block_size}
> +	du_check ${check5} "du(option: -B ${block_size})"
> +}
> +
> +test6()
> +{
> +	du_test du --block-size=${block_size}
> +	du_check ${check5} "du(option: --block-size=${block_size})"
> +}
> +
> +test7()
> +{
> +	du_test du -b
> +	du_check ${check7} "du(option: -b)"
> +}
> +
> +test8()
> +{
> +	du_test du --bytes
> +	du_check ${check7} "du(option: --bytes)"
> +}
> +
> +test9()
> +{
> +	du_test du -c
> +	du_check ${check9} "du(option: -c)"
> +}
> +
> +test10()
> +{
> +	du_test du --total
> +	du_check ${check9} "du(option: --total)"
> +}
> +
> +test11()
> +{
> +	du_test du -D ${testdir}/${testfile}
> +	du_check ${check11} "du(option: -D)"
> +}
> +
> +test12()
> +{
> +	du_test du --dereference-args ${testdir}/${testfile}
> +	du_check ${check11} "du(option: --dereference-args)"
> +}
> +
> +test13()
> +{
> +	du_test du --max-depth=1
> +	du_check ${check1} "du(option: --max-depth=N)"
> +}
> +
> +test14()
> +{
> +	du_test du --human-readable
> +	du_check ${check14} "du(option: --human-readable)"
> +}
> +
> +test15()
> +{
> +	du_test du -k
> +	du_check ${check1} "du(option: -k)"
> +}
> +
> +test16()
> +{
> +	du_test du -L ${testdir}/
> +	du_check ${check16} "du(option: -L)"
> +}
> +
> +test17()
> +{
> +	du_test du --dereference ${testdir}/
> +	du_check ${check16} "du(option: --dereference)"
> +}
> +
> +test18()
> +{
> +	du_test du -P
> +	du_check ${check1} "du(option: -P)"
> +}
> +
> +test19()
> +{
> +	du_test du --no-dereference
> +	du_check ${check1} "du(option: --no-dereference)"
> +}
> +
> +test20()
> +{
> +	du_test du --si
> +	du_check ${check20} "du(option: --si)"
> +}
> +
> +test21()
> +{
> +	du_test du -s
> +	du_check ${check1} "du(option: -s)"
> +}
> +
> +test22()
> +{
> +	du_test du --summarize
> +	du_check ${check1} "du(option: --summarize)"
> +}
> +
> +test23()
> +{
> +	du_test du --exclude=${testfile}
> +	du_check ${check23} "du(option: --exclude=PATTERN)"
> +}
> +
> +setup
> +TST_CLEANUP=cleanup
> +
> +block_size=512
> +
> +# The output could be different in some systems, if we use du to
> +# estimate file space usage with the same filesystem and the same size.
> +# So we use the approximate value to check.
> +check1="10[2-3][0-9][0-9][[:space:]]\."
> +check2="10[2-3][0-9][0-9][[:space:]]${testfile}"
> +check3="0[[:space:]]\.\/${testdir}\/${testfile}"
> +check5="20[4-5][0-9][0-9][[:space:]]\."
> +check7="10[4-5][0-9][0-9]\{4\}[[:space:]]\."
> +check9="10[2-3][0-9][0-9][[:space:]]total"
> +check11="10[2-3][0-9][0-9][[:space:]]${testdir}\/${testfile}"
> +check14="1[0,1]M[[:space:]]\."
> +check16="10[2-3][0-9][0-9][[:space:]]${testdir}\/"
> +check20="11M[[:space:]]\."
> +check23="[0-9]\{1,2\}[[:space:]]\."

The rest looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
