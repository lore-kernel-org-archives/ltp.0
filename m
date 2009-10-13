Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mxgvf-00057I-IC
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 12:56:39 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxgvZ-0000cm-Af
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 12:56:39 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DC68Hc005705
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:06:08 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DCDsW5243776
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:13:54 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DCASd9031960
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:10:28 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40910022123k700ee146q5c8a8aa5ccf535eb@mail.gmail.com>
References: <364299f40910022123k700ee146q5c8a8aa5ccf535eb@mail.gmail.com>
Date: Tue, 13 Oct 2009 17:43:39 +0530
Message-Id: <1255436019.8438.37.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Remove `verbose mode' from runltp*
Reply-To: subrata@linux.vnet.ibm.com
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Fri, 2009-10-02 at 21:23 -0700, Garrett Cooper wrote: 
> 1. This option really doesn't buy us much in runltp*, and we've almost
> already run out of options anyhow...
> 2. Correct some ugly indentation.
> 
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Was difficult to apply over the changes you recently made. However, i
was able to ;-)

Regards--
Subrata

> 
> Index: runltp
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/runltp,v
> retrieving revision 1.49
> diff -u -r1.49 runltp
> --- runltp	26 Aug 2009 07:00:25 -0000	1.49
> +++ runltp	3 Oct 2009 04:21:33 -0000
> @@ -156,7 +156,6 @@
>                        -t 24h = 24 hours
>                        -t 2d  = 2 days
>      -T REPETITION   Execute the testsuite for REPETITION no. of times
> -    -v              Print more verbose output to screen.
>      -w CMDFILEADDR  Uses wget to get the user's list of testcases.
>      -x INSTANCES    Run multiple instances of this testsuite.
>      -b DEVICE       Some tests require an unmounted block device
> @@ -182,18 +181,17 @@
>      local RUN_NETEST=0
>      local RUN_REPEATED=0
>      local QUIET_MODE=""
> -    local VERBOSE_MODE=""
>      local NETPIPE=0
>      local GENLOAD=0
>      local MEMSIZE=0
>      local DURATION=""
>      local CMDFILEADDR=""
>      local FAILCMDFILE=""
> -	local INJECT_KERNEL_FAULT=""
> -	local INJECT_KERNEL_FAULT_PERCENTAGE=""
> -	local INJECT_FAULT_LOOPS_PER_TEST=""
> -	local VALGRIND_CHECK=""
> -	local VALGRIND_CHECK_TYPE=""
> +    local INJECT_KERNEL_FAULT=""
> +    local INJECT_KERNEL_FAULT_PERCENTAGE=""
> +    local INJECT_FAULT_LOOPS_PER_TEST=""
> +    local VALGRIND_CHECK=""
> +    local VALGRIND_CHECK_TYPE=""
>      local LOGFILE_NAME=""
>      local LOGFILE=""
>      local OUTPUTFILE_NAME=""
> @@ -207,7 +205,7 @@
>      local DEFAULT_FILE_NAME_GENERATION_TIME=`date +"%Y_%b_%d-%Hh_%Mm_%Ss"`
>      version_date=`head -n 1 $LTPROOT/ChangeLog`
> 
> -    while getopts a:c:C:d:D:f:F:ehi:g:l:m:M:Nno:pqr:s:S:t:T:vw:x:b:B: arg
> +    while getopts a:c:C:d:D:f:F:ehi:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B: arg
>      do  case $arg in
>          a)  EMAIL_TO=$OPTARG
>              ALT_EMAIL_OUT=1;;
> @@ -398,8 +396,6 @@
>          T)  # In case you want the testcases to runsequentially
> RUN_REPEATED times
>              RUN_REPEATED=$OPTARG;;
> 
> -        v)  VERBOSE_MODE=1;;
> -
>          w)  CMDFILEADDR=$OPTARG;;
> 
>          x)  # number of ltp's to run
> @@ -755,11 +751,9 @@
>      [ ! -z "$QUIET_MODE" ] && { echo "INFO: Test start time: $(date)" ; }
>      PAN_COMMAND="${LTPROOT}/pan/ltp-pan $QUIET_MODE -e -S $INSTANCES
> $DURATION -a $$ \
>      -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE"
> -    if [ ! -z "$VERBOSE_MODE" ] ; then
> -      echo "COMMAND:    $PAN_COMMAND"
> -      if [ ! -z "$TAG_RESTRICT_STRING" ] ; then
> -        echo "INFO: Restricted to $TAG_RESTRICT_STRING"
> -      fi
> +    echo "COMMAND:    $PAN_COMMAND"
> +    if [ ! -z "$TAG_RESTRICT_STRING" ] ; then
> +      echo "INFO: Restricted to $TAG_RESTRICT_STRING"
>      fi
>      #$PAN_COMMAND #Duplicated code here, because otherwise if we
> fail, only "PAN_COMMAND" gets output
> 
> Index: runltplite.sh
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/runltplite.sh,v
> retrieving revision 1.5
> diff -u -r1.5 runltplite.sh
> --- runltplite.sh	19 May 2009 09:39:11 -0000	1.5
> +++ runltplite.sh	3 Oct 2009 04:21:33 -0000
> @@ -85,7 +85,6 @@
>      -p              Human readable format logfiles.
>      -q              Print less verbose output to screen.
>      -r LTPROOT      Fully qualified path where testsuite is installed.
> -    -v              Print more verbose output to screen.
> 
>      example: ./${0##*/} -i 1024 -m 128 -p -q  -l /tmp/resultlog.$$ -d ${PWD}
> 
> @@ -114,7 +113,7 @@
>      local TAG_RESTRICT_STRING=""
>      local PAN_COMMAND=""
> 
> -    while getopts c:d:hi:l:m:No:pqr:v arg
> +    while getopts c:d:hi:l:m:No:pqr: arg
>      do  case $arg in
>          c)
>  	    NUM_PROCS=$(($OPTARG))
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
> http://p.sf.net/sfu/devconf
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
