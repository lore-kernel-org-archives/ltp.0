Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PoKue-0003T3-MP
	for ltp-list@lists.sourceforge.net; Sat, 12 Feb 2011 19:13:44 +0000
Received: from mail-iw0-f174.google.com ([209.85.214.174])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PoKud-000653-N3
	for ltp-list@lists.sourceforge.net; Sat, 12 Feb 2011 19:13:44 +0000
References: <20110212175827.6308.29198.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20110212175827.6308.29198.sendpatchset@subratamodak.linux.ibm.com>
Mime-Version: 1.0 (iPhone Mail 8C148)
Message-Id: <071128CA-BC84-401E-B7C9-7ABC66B1574D@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Sat, 12 Feb 2011 11:13:12 -0800
Subject: Re: [LTP] [PATCH] Fix Usage Reference of those tools utilities
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP Mailing List <ltp-list@lists.sf.net>

On Feb 12, 2011, at 9:58 AM, Subrata Modak <subrata@linux.vnet.ibm.com> wrote:

> Useful scripts under ltp/tools are no more installed @{LTP_ROOT}/tools,
> they are done under @{LTP_ROOT}/bin. Change their reference accordingly
> inside 'runltp' script. Nobody noticed this early as probably these
> options are least used in LTP ;-)
> 
> Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
> 
> ---
> diff --git a/runltp b/runltp
> index 2c6785f..381e123 100755
> --- a/runltp
> +++ b/runltp
> @@ -779,7 +779,7 @@ main()
>            #Go ahead to Inject Fault & Create required
>            #Command Files for LTP run
>            echo Running tests with Fault Injection Enabled in the Kernel...
> -            ${LTPROOT}/tools/create_kernel_faults_in_loops_and_probability.pl\
> +            ${LTPROOT}/bin/create_kernel_faults_in_loops_and_probability.pl\
>                ${TMP}/alltests $INJECT_FAULT_LOOPS_PER_TEST $INJECT_KERNEL_FAULT_PERCENTAGE > ${TMP}/alltests.tmp
>            cp ${TMP}/alltests.tmp ${TMP}/alltests
>            rm -rf ${TMP}/alltests.tmp
> @@ -796,15 +796,15 @@ main()
>            which valgrind || VALGRIND_CHECK_TYPE=XYZ
>            case $VALGRIND_CHECK_TYPE in
>                1)
> -                ${LTPROOT}/tools/create_valgrind_check.pl ${TMP}/alltests 1 > ${TMP}/alltests.tmp
> +                ${LTPROOT}/bin/create_valgrind_check.pl ${TMP}/alltests 1 > ${TMP}/alltests.tmp
>                cp ${TMP}/alltests.tmp ${TMP}/alltests
>                rm -rf ${TMP}/alltests.tmp;;
>                2)
> -                ${LTPROOT}/tools/create_valgrind_check.pl ${TMP}/alltests 2 > ${TMP}/alltests.tmp
> +                ${LTPROOT}/bin/create_valgrind_check.pl ${TMP}/alltests 2 > ${TMP}/alltests.tmp
>                cp ${TMP}/alltests.tmp ${TMP}/alltests
>                rm -rf ${TMP}/alltests.tmp;;
>                3)
> -                ${LTPROOT}/tools/create_valgrind_check.pl ${TMP}/alltests 3 > ${TMP}/alltests.tmp
> +                ${LTPROOT}/bin/create_valgrind_check.pl ${TMP}/alltests 3 > ${TMP}/alltests.tmp
>                cp ${TMP}/alltests.tmp ${TMP}/alltests
>                rm -rf ${TMP}/alltests.tmp;;
>                *) echo "Invalid Memory Check Type, or, Valgrind is not available";;
> @@ -859,7 +859,7 @@ main()
>        export TEST_OUTPUT_DIRECTORY="$LTPROOT/output"
>        export TEST_LOGS_DIRECTORY=$LOGS_DIRECTORY
>        echo "Generating HTML Output.....!!"
> -       ( perl $LTPROOT/bin/genhtml.pl $LTPROOT/tools/html_report_header.txt test_start test_end test_output execution_status $OUTPUT_DIRECTORY  > $HTMLFILE; )   
> +       ( perl $LTPROOT/bin/genhtml.pl $LTPROOT/bin/html_report_header.txt test_start test_end test_output execution_status $OUTPUT_DIRECTORY  > $HTMLFILE; )   
>        echo "Generated HTML Output.....!!"
>        echo "Location: $HTMLFILE";
> 
> ---
> 
> Regards--
> Subrata
> 
> 
> ------------------------------------------------------------------------------
> The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
> Pinpoint memory and threading errors before they happen.
> Find and fix more than 250 security defects in the development cycle.
> Locate bottlenecks in serial and parallel code that limit performance.
> http://p.sf.net/sfu/intel-dev2devfeb
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
