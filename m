Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NhlQO-0000qt-TK
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 15:02:48 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NhlQN-0005Cs-MO
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 15:02:48 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1HEx2OR004695
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 07:59:02 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o1HF2X2f210228
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 08:02:33 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1HF2Q5f026125
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 08:02:26 -0700
Date: Wed, 17 Feb 2010 20:32:14 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100217150214.GB9825@rishikesh.in.ibm.com>
References: <000f01caae08$ce91e640$6bb5b2c0$@co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000f01caae08$ce91e640$6bb5b2c0$@co.jp>
Subject: Re: [LTP] "logrotate01" has problem
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
To: Yuki Yao <y_yao@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Mon, Feb 15, 2010 at 03:33:37PM +0900, Yuki Yao wrote:
> Hi,
> 
> I contributed following problem previously, but it's not yet revised.
> So, I contribute this again.
> 
> After "./runltp" execution, all log files such as "/var/log/messages*" 
> disappeared, and there is only new log file created after the test.
> 
> This seems a problem that occurs after the "logrotate01" test. 
> I found that the past log files were deleted by forcing a "logrotate"
> (logrotate -fv $LTPTMP/tst_logrotate.conf).
> 
> Besides, logrotate01's shell script "./testcases/commands/logrotate
> /logrotate_tests.sh" creats logrotate configuration file ($LTPTMP
> /tst_logrotate.conf) for the test, and this configration file includes
> "/etc/logrotate.d" as follows:
> 
> [ ./testcases/commands/logrotate/logrotate_tests.sh line:156~ ]
> ----------
> # create config file.
> 	cat >$LTPTMP/tst_logrotate.conf <<-EOF
> 	#****** Begin Config file *******
> 	# create new (empty) log files after rotating old ones
> 	create
> 
> 	# compress the log files
> 	compress
> 
> 	# RPM packages drop log rotation information into this directory
> 	include /etc/logrotate.d
> 
> 	/var/log/tst_logfile {
> 		rotate 5
> 		weekly
> 	}
> 	#****** End Config file *******
> 	EOF
> ----------
> 
> By This, not only a log file for the test (/var/log/tst_logfile) 
> but also 30 fies such as "/var/log/messages*" become "logrotate" 
> command target.
> Only a log file for this test must become a target of the forced 
> execution of "logrotate".
> 
> To resolve this problem, we must change "/logrotate_tests.sh" not to 
> include "/etc/logrotate.d", I think.
> 
> Signed-off-by: Yuki Yao<y_yao@ryobi.co.jp>

Hello Garret,

Any input for this patch ?

Thanks
-Rishi
> 
> Index: ./testcases/commands/logrotate/logrotate_tests.sh
> ============
> --- ./testcases/commands/logrotate/logrotate_tests.sh.orig	2008-10-21
> 15:54:15.000000000 +0900
> +++ ./testcases/commands/logrotate/logrotate_tests.sh	2010-02-15
> 13:32:02.000000000 +0900
> @@ -163,7 +163,7 @@
>  	compress
> 
>  	# RPM packages drop log rotation information into this directory
> -	include /etc/logrotate.d
> +	# include /etc/logrotate.d
> 
>  	/var/log/tst_logfile {
>  		rotate 5
> @@ -200,7 +200,7 @@
>  		# check if  /etc/logrotate.d is included/
>  		# check if 5 rotations are forced.
>          # check if compression is done.
> -		grep "including /etc/logrotate.d" $LTPTMP/tst_logrotate.out
> \
> +		# grep "including /etc/logrotate.d"
> $LTPTMP/tst_logrotate.out \
>  			> $LTPTMP/tst_logrotate.err 2>&1 || RC=$?
>  		grep "reading config file $LTPTMP/tst_logrotate.conf" \
>  			$LTPTMP/tst_logrotate.out   >
> $LTPTMP/tst_logrotate.err 2>&1 || RC=$?
> ============
> 
> 
> I'm glad if I got some opinion about this.
> 
> Thank you,
> -Yuki Yao
> 
> 
> 
> ------------------------------------------------------------------------------
> SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
> Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
> http://p.sf.net/sfu/solaris-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
