Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RufOu-0002B6-WB
	for ltp-list@lists.sourceforge.net; Tue, 07 Feb 2012 07:23:41 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RufOs-0000vf-FG
	for ltp-list@lists.sourceforge.net; Tue, 07 Feb 2012 07:23:40 +0000
Message-ID: <4F30D138.7000509@cn.fujitsu.com>
Date: Tue, 07 Feb 2012 15:22:32 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1327811245-12314-1-git-send-email-YanFeng.Shang@windriver.com>
In-Reply-To: <1327811245-12314-1-git-send-email-YanFeng.Shang@windriver.com>
Subject: Re: [LTP] [PATCH] updated logrotate_test.sh for some issue
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
To: Shang Yanfeng <YanFeng.Shang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Markos.Chandras@imgtec.com

Hi Shang:

> 1. fixed some formatting issue.


You should submit a separated patch to fix the formatting or coding style
issue, than with other fixes.

Since, this patch is so messy that making it hardly to be reviewed. ;)

Thanks
-Wanlong Gao

> 2. Because some log file isn't exist defaultly in configure file in
>    logrotate.d directory,add missingok parameter.
> 3. previous case use tst_logrotate.cron and tst_addtolog.cron configure file,
>    when using the second cron confiure file,the first expires,so updated its
>    to one configure.
> 
> Signed-off-by: Shang Yanfeng <YanFeng.Shang@windriver.com>
> ---
>  testcases/commands/logrotate/logrotate_tests.sh |   59 ++++++++---------------
>  1 files changed, 21 insertions(+), 38 deletions(-)
> 
> diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
> index 827dd5f..6efb184 100755
> --- a/testcases/commands/logrotate/logrotate_tests.sh
> +++ b/testcases/commands/logrotate/logrotate_tests.sh
> @@ -28,11 +28,11 @@
>  #                logfile is set for rotation every week. Execute the command
>  #                logrotate -f <file.conf>, check to see if it forced rotation.
>  #                Test #2: Check if logrotate running as a cronjob will rotate a
> -#                logfile when it exceeds a specific size. Create two cronjobs 
> +#                logfile when it exceeds a specific size. Create two cronjobs
>  #                1. runs a command to log a string to a logfile. 2. runs
>  #                logrotate <file.conf> every minute. The conf file specifies
>  #                that the rotation happen only if the log file exceeds 2k file
> -#                size. 
> +#                size.
>  #
>  # Author:        Manoj Iyer, manjo@mail.utexas.edu
>  #
> @@ -47,7 +47,7 @@
>  #
>  # Input:        - $1 - calling test case.
>  #               - $2 - command that needs to be checked.
> -# 
> +#
>  # Return:		- zero on success.
>  # 				- non-zero on failure.
>  chk_ifexists()
> @@ -66,9 +66,9 @@ chk_ifexists()
>  # Function: init
>  #
>  # Description:  - Check if command required for this test exits.
> -#               - Create temporary directories required for this test. 
> +#               - Create temporary directories required for this test.
>  #               - Initialize global variables.
> -# 
> +#
>  # Return:		- zero on success.
>  # 				- non-zero on failure.
>  init()
> @@ -134,7 +134,7 @@ cleanup()
>  #               - use force option to force logrotate to cause the log file to
>  #                 be rotated.
>  #               - compress the file after rotation.
> -# 
> +#
>  # Return:		- zero on success.
>  # 				- non-zero on failure.
>  test01()
> @@ -161,7 +161,7 @@ test01()
>  
>  	# compress the log files
>  	compress
> -
> +	missingok
>  	# RPM packages drop log rotation information into this directory
>  	include /etc/logrotate.d
>  
> @@ -182,7 +182,7 @@ test01()
>  	while [ $count -lt 10 ]
>  	do
>  		echo "This a dummy log file used to test logrotate command." >> \
> -			/var/log/tst_logfile 
> +			/var/log/tst_logfile
>  		 		 count=$(( $count+1 ))
>  	done
>  
> @@ -283,41 +283,24 @@ cat >/var/log/tst_largelogfile <<EOF
>  # getting rotated.
>  EOF
>  
> -# create logrotate cron job.
> -cat >$LTPTMP/tst_logrotate.cron <<EOF
> -* * * * * logrotate $LTPTMP/tst_largelog.conf
> -EOF
> -
> -chmod 777 $LTPTMP/tst_logrotate.cron > /dev/null 2>&1
> -
> -tst_resm TINFO "Test #2: Installing cron job to run logrotate"
> -crontab $LTPTMP/tst_logrotate.cron > $LTPTMP/tst_logrotate.out 2>&1 || RC=$?
> -if [ $RC -ne 0 ]
> -then
> -    echo "Exit status of crontab command: $RC" >> tst_logrotate.out 2>/dev/null
> -    tst_brk TBROK $LTPTMP/tst_logrotate.out NULL \
> -        "Test #2: crontab Broke while installing cronjob. Reason:"
> -    TFAILCNT=$(( $TFAILCN+1 ))
> -else
> -    tst_resm TINFO "Test #2: Cronjob installed successfully"
> -fi
> -
> -# cron job to increase the log file size.
> -cat >$LTPTMP/tst_addtolog.cron <<EOF
>  
> -* * * * * echo "To Err Is Human, To Really Screw Up You Need A Computer."  >>/var/log/tst_largelogfile 2>/dev/null 
> +tst_resm TINFO "Test #2: Installing cron jobs to run logrotate and to increase logsize"
> +# Path of cron does not include /usr/sbin
> +crontab - > $LTPTMP/tst_logrotate.out 2>&1 <<EOF
> +* * * * * $(which logrotate) $LTPTMP/tst_largelog.conf
> +* * * * * echo "To Err Is Human, To Really Screw Up You Need A Computer."  >>/var/log/tst_largelogfile 2>/dev/null
>  EOF
>  
> -tst_resm TINFO "Test #2: Installing cron job to increase logsize"
> -crontab $LTPTMP/tst_addtolog.cron > $LTPTMP/tst_logrotate.out 2>&1 || RC=$?
> +RC=$?
> +
>  if [ $RC -ne 0 ]
>  then
>      echo "Exit status of crontab command: $RC" >> tst_logrotate.out 2>/dev/null
> -    tst_brk TBROK $LTPTMP/tst_logrotate.out NULL \
> -        "Test #2: crontab Broke while installing cronjob. Reason:"
> -    TFAILCNT=$(( $TFAILCN+1 ))
> +        tst_brk TBROK $LTPTMP/tst_logrotate.out NULL \
> +        "Test #2: crontab Broke while installing cron jobs. Reason:"
> +	    TFAILCNT=$(( $TFAILCN+1 ))
>  else
> -    tst_resm TINFO "Test #2: Cronjob installed successfully"
> +	tst_resm TINFO "Test #2: Cron jobs installed successfully"
>  fi
>  
>  # let cron jobs get started.
> @@ -368,12 +351,12 @@ fi
>  #
>  # Description:	- Execute all tests and report results.
>  #
> -# Exit:			- zero on success 
> +# Exit:			- zero on success
>  #               - non-zero on failure.
>  
>  RC=0
>  init || exit $?
>  
> -test01 || RC=$?
> +test01 && test02 || RC=$?
>  
>  exit $RC



------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
