Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TNxBq-000886-7m
	for ltp-list@lists.sourceforge.net; Tue, 16 Oct 2012 02:47:30 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TNxBo-0003TC-H3
	for ltp-list@lists.sourceforge.net; Tue, 16 Oct 2012 02:47:30 +0000
Message-ID: <507CC7E8.1070200@cn.fujitsu.com>
Date: Tue, 16 Oct 2012 10:35:20 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1350279542-16623-1-git-send-email-jin.li@windriver.com>
	<1350279542-16623-2-git-send-email-jin.li@windriver.com>
In-Reply-To: <1350279542-16623-2-git-send-email-jin.li@windriver.com>
Subject: Re: [LTP] [PATCH] runltp: Change -s option to select single case
 instead of matched name string of case
Reply-To: gaowanlong@cn.fujitsu.com
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
To: jin.li@windriver.com
Cc: ltp-list@lists.sourceforge.net, haotian.zhang@windriver.com

On 10/15/2012 01:39 PM, jin.li@windriver.com wrote:
> From: Jin Li <jin.li@windriver.com>
> 
> The scenario group file can be used if a set of related test cases need executing
> at one time. Therefore, it's better to use runltp -s to select single test case.
> 
> Also, it is not a good practice to bind the option format of runltp with the implementation
> of runltp internal code.Say the test case ar should be invoked in this way:
> 
> ./runltp -s ar
> 
> instead of
> 
> ./runltp -s "^ar "

I don't think yours is better than matching with a PATTERN, so I vote to the original implementation.

Thanks,
Wanlong Gao

> 
> Signed-off-by: Jin Li <jin.li@windriver.com>
> ---
>  runltp | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/runltp b/runltp
> index f95c17b..7788275 100755
> --- a/runltp
> +++ b/runltp
> @@ -150,7 +150,7 @@ usage()
>      -p              Human readable format logfiles. 
>      -q              Print less verbose output to screen.
>      -r LTPROOT      Fully qualified path where testsuite is installed.
> -    -s PATTERN      Only run test cases which match PATTERN.
> +    -s TESTCASE     Only run single test case.
>      -S SKIPFILE     Skip tests specified in SKIPFILE
>      -t DURATION     Execute the testsuite for given duration. Examples:
>                        -t 60s = 60 seconds
> @@ -203,7 +203,7 @@ main()
>      local HTMLFILE=""
>      local DMESG_DIR=""
>      local EMAIL_TO=""
> -    local TAG_RESTRICT_STRING=""
> +    local TESTCASE=""
>      local PAN_COMMAND=""
>      local DEFAULT_FILE_NAME_GENERATION_TIME=`date +"%Y_%b_%d-%Hh_%Mm_%Ss"`
>  
> @@ -394,7 +394,7 @@ main()
>      
>          r)  LTPROOT=$OPTARG;;
>      
> -        s)  TAG_RESTRICT_STRING=$OPTARG;;
> +        s)  TESTCASE=$OPTARG;;
>  
>  	S)  case $OPTARG in
>              /*)
> @@ -647,11 +647,11 @@ main()
>           }
>      }
>  
> -    # If enabled, execute only test cases that match the PATTERN
> -    if [ -n "$TAG_RESTRICT_STRING" ]
> +    # If enabled, execute single test cases
> +    if [ -n "$TESTCASE" ]
>      then
>          mv -f ${TMP}/alltests ${TMP}/alltests.orig
> -	    grep $TAG_RESTRICT_STRING ${TMP}/alltests.orig > ${TMP}/alltests #Not worth checking return codes for this case
> +	    grep "^$TESTCASE " ${TMP}/alltests.orig > ${TMP}/alltests #Not worth checking return codes for this case
>      fi
>  
>      # Blacklist or skip tests if a SKIPFILE was specified with -S
> @@ -743,8 +743,8 @@ main()
>      PAN_COMMAND="${LTPROOT}/bin/ltp-pan $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ \
>      -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE"
>      echo "COMMAND:    $PAN_COMMAND"
> -    if [ ! -z "$TAG_RESTRICT_STRING" ] ; then
> -      echo "INFO: Restricted to $TAG_RESTRICT_STRING"
> +    if [ ! -z "$TESTCASE" ] ; then
> +      echo "INFO: Run single test case $TESTCASE"
>      fi
>      #$PAN_COMMAND #Duplicated code here, because otherwise if we fail, only "PAN_COMMAND" gets output
>      
> 


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
