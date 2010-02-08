Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NeMje-0002EO-50
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 06:04:38 +0000
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NeMjc-0004lp-Mc
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 06:04:38 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id o1864LsT000470
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Feb 2010 11:34:21 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1864Lv93002530
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Feb 2010 11:34:21 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1864KEZ001510
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Feb 2010 17:04:21 +1100
Message-ID: <4B6FA964.8010806@linux.vnet.ibm.com>
Date: Mon, 08 Feb 2010 11:34:20 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <000501caa869$41be6670$c53b3350$@co.jp>
	<001801caa86b$290aef70$7b20ce50$@co.jp>
In-Reply-To: <001801caa86b$290aef70$7b20ce50$@co.jp>
Subject: Re: [LTP] [PATCH]logrotate: /var/log/messages* disappeared
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

On 02/08/2010 08:32 AM, Yuki Yao wrote:
> Sorry, line breaks is mistake; resend.
>    
Hi Yuki Yao,

Few nits:

I would appreciate if you append your Signed-off and resend once again.

Then i will provide my review comment. And in future please create your 
patch against LTPROOT/ dir.

Thanks
Rishi


> ----------------------------------------------------
> Hi,
>
> I found a problem on LTP when I execute ./runltp.
> After execute ./runltp, all log files such as /var/log/messages*
> disappeared,
> and there is only new log files that were created after the test...
>
> This seems a problem that occurs after the "logrotate01" test.
> I found that the past log files disappeared by forcing a rotate (logrotate
> -fv $LTPTMP/tst_logrotate.conf).
>
> Besides, "logrotate"'s shell script
> ./testcases/commands/logrotate/logrotate_tests.sh creats
> logrotate configuration file ($LTPTMP/tst_logrotate.conf) for the test, and
> this config file includes
> /etc/logrotate.d as follows:
> [ ./testcases/commands/logrotate/logrotate_tests.sh line:156~ ]
> ----------
> # create config file.
> 	cat>$LTPTMP/tst_logrotate.conf<<-EOF
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
> By this, not only a log file for the test (/var/log/tst_logfile), but also
> 30 fies in my system
> such as /var/log/messages* become "logrotate" command target.
> Therefore, only a log file for this test must be made a target of the forced
> execution of "logrotate".
>
> To resolve this problem, we have to change this not to include
> /etc/logrotate.d, I think.
>
> Index: testcases/commands/logrotate/logrotate_tests.sh
> ==============================
> --- logrotate_tests.sh	2008-10-21 15:54:15.000000000 +0900
> +++ logrotate_tests.sh.new	2010-02-05 18:56:14.000000000 +0900
> @@ -163,7 +163,7 @@
>   	compress
>
>   	# RPM packages drop log rotation information into this directory
> -	include /etc/logrotate.d
> +	# include /etc/logrotate.d
>
>   	/var/log/tst_logfile {
>   		rotate 5
> @@ -200,7 +200,7 @@
>   		# check if  /etc/logrotate.d is included/
>   		# check if 5 rotations are forced.
>           # check if compression is done.
> -		grep "including /etc/logrotate.d" $LTPTMP/tst_logrotate.out
> \
> +		# grep "including /etc/logrotate.d"
> $LTPTMP/tst_logrotate.out \
>   			>  $LTPTMP/tst_logrotate.err 2>&1 || RC=$?
>   		grep "reading config file $LTPTMP/tst_logrotate.conf" \
>   			$LTPTMP/tst_logrotate.out>
> $LTPTMP/tst_logrotate.err 2>&1 || RC=$?
>
> Thank you,
>    --Yuki Yao
>
>
>
> ------------------------------------------------------------------------------
> The Planet: dedicated and managed hosting, cloud storage, colocation
> Stay online with enterprise data centers and the best network in the business
> Choose flexible plans and management services without long-term contracts
> Personal 24x7 support from experience hosting pros just a phone call away.
> http://p.sf.net/sfu/theplanet-com
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>    


------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
