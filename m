Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WsV0x-00026R-Ss
	for ltp-list@lists.sourceforge.net; Thu, 05 Jun 2014 10:35:19 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WsV0v-000602-W1
	for ltp-list@lists.sourceforge.net; Thu, 05 Jun 2014 10:35:19 +0000
Date: Thu, 5 Jun 2014 06:35:11 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1249145583.18329328.1401964511429.JavaMail.zimbra@redhat.com>
In-Reply-To: <1401272151-6563-1-git-send-email-jjaburek@redhat.com>
References: <1401272151-6563-1-git-send-email-jjaburek@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] syslog: rsyslog doesn't create empty log files
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
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi Jiri,

I was thinking about removing that check, and checking file existence
only after test generates some log entry. That would make things simpler
and we would still know if there is logfile after syslogtst ran:


diff --git a/testcases/kernel/syscalls/syslog/syslog01 b/testcases/kernel/syscalls/syslog/syslog01
index b7bcd9e..2f3aea0 100755
--- a/testcases/kernel/syscalls/syslog/syslog01
+++ b/testcases/kernel/syscalls/syslog/syslog01
@@ -66,12 +66,6 @@ syslog_case1()
 
        restart_syslog_daemon
 
-       # check if $MAILLOG script exists
-       if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e $MAILLOG ]; then
-               tst_resm TBROK "$MAILLOG no such log file"
-               cleanup 1
-       fi
-
        # Grepping pattern has to be changed whenever the executable name
        # changes, ex: syslogtst executable.
        # This check is neccessary for syslog-ng because $MAILLOG is
@@ -87,6 +81,11 @@ syslog_case1()
 
                sleep 2
 
+               if [ ! -e $MAILLOG ]; then
+                       tst_resm TBROK "$MAILLOG no such log file"
+                       cleanup 1
+               fi
+
                newvalue1=`grep -c "syslogtst: mail info test" $MAILLOG`
                if [ "x$(( $newvalue1 - $oldvalue1 ))" != "x1" ]; then
                        status_flag=1
diff --git a/testcases/kernel/syscalls/syslog/syslog02 b/testcases/kernel/syscalls/syslog/syslog02
index a416344..7a55a84 100755
--- a/testcases/kernel/syscalls/syslog/syslog02
+++ b/testcases/kernel/syscalls/syslog/syslog02
@@ -65,15 +65,6 @@ syslog_case2()
 
                restart_syslog_daemon
 
-               # Grepping pattern is as follows:
-               # syslogtst: mail $level test.
-               # check if $MAILLOG script exists
-               if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e $MAILLOG ]; then
-                       tst_resm TBROK "$MAILLOG no such log file"
-                       cleanup 1
-               fi
-
-
                # Grepping pattern has to be changed whenever the executable name
                # changes, ex: syslogtst executable.
                # This check is neccessary for syslog-ng because $MAILLOG is
diff --git a/testcases/kernel/syscalls/syslog/syslog09 b/testcases/kernel/syscalls/syslog/syslog09
index de06fb1..9cfafa8 100755
--- a/testcases/kernel/syscalls/syslog/syslog09
+++ b/testcases/kernel/syscalls/syslog/syslog09
@@ -56,15 +56,14 @@ syslog_case9()
 
        restart_syslog_daemon
 
-       # check if /var/log/messages script exists
-       if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e /var/log/messages ]; then
-               tst_resm TBROK "/var/log/messages no such log file"
-               cleanup 1
+       if [ -e /var/log/messages ]; then
+               allow1=`grep -c "syslogtst: error level is logged" /var/log/messages`
+               donot_allow1=`grep -c "syslogtst: warning level not to be logged" /var/log/messages`
+       else
+               allow1=0
+               donot_allow1=0
        fi
 
-       allow1=`grep -c "syslogtst: error level is logged" /var/log/messages`
-       donot_allow1=`grep -c "syslogtst: warning level not to be logged" /var/log/messages`
-
        if ! syslogtst 9 2>/dev/null; then
                cleanup 1
        fi

What do you think?

Regards,
Jan

----- Original Message -----
> From: "Jiri Jaburek" <jjaburek@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Wednesday, 28 May, 2014 12:15:51 PM
> Subject: [LTP] [PATCH] syslog: rsyslog doesn't create empty log files
> 
> Newer versions of rsyslog don't create empty log files during startup -
> the files are created upon first logged entry instead.
> 
> (since rsyslog git commit de77494415ae8c169949d13ed0df0af3b1949b54)
> 
> Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
> ---
>  testcases/kernel/syscalls/syslog/syslog01 | 15 +++++++++++----
>  testcases/kernel/syscalls/syslog/syslog02 | 16 +++++++++++-----
>  testcases/kernel/syscalls/syslog/syslog09 | 15 +++++++++++----
>  3 files changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/syslog/syslog01
> b/testcases/kernel/syscalls/syslog/syslog01
> index b7bcd9e..b9c7c7f 100755
> --- a/testcases/kernel/syscalls/syslog/syslog01
> +++ b/testcases/kernel/syscalls/syslog/syslog01
> @@ -67,10 +67,17 @@ syslog_case1()
>  	restart_syslog_daemon
>  
>  	# check if $MAILLOG script exists
> -	if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e $MAILLOG ];
> then
> -		tst_resm TBROK "$MAILLOG no such log file"
> -		cleanup 1
> -	fi
> +	case "$CONFIG_FILE" in
> +	/etc/syslog-ng/syslog-ng.conf|/etc/rsyslog.conf)
> +		# syslog-ng and rsyslog don't create empty log files
> +		;;
> +	*)
> +		if [ ! -e $MAILLOG ]; then
> +			tst_resm TBROK "$MAILLOG no such log file"
> +			cleanup 1
> +		fi
> +		;;
> +	esac
>  
>  	# Grepping pattern has to be changed whenever the executable name
>  	# changes, ex: syslogtst executable.
> diff --git a/testcases/kernel/syscalls/syslog/syslog02
> b/testcases/kernel/syscalls/syslog/syslog02
> index a416344..c863daa 100755
> --- a/testcases/kernel/syscalls/syslog/syslog02
> +++ b/testcases/kernel/syscalls/syslog/syslog02
> @@ -68,11 +68,17 @@ syslog_case2()
>  		# Grepping pattern is as follows:
>  		# syslogtst: mail $level test.
>  		# check if $MAILLOG script exists
> -		if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e $MAILLOG ];
> then
> -			tst_resm TBROK "$MAILLOG no such log file"
> -			cleanup 1
> -		fi
> -
> +		case "$CONFIG_FILE" in
> +		/etc/syslog-ng/syslog-ng.conf|/etc/rsyslog.conf)
> +			# syslog-ng and rsyslog don't create empty log files
> +			;;
> +		*)
> +			if [ ! -e $MAILLOG ]; then
> +				tst_resm TBROK "$MAILLOG no such log file"
> +				cleanup 1
> +			fi
> +			;;
> +		esac
>  
>  		# Grepping pattern has to be changed whenever the executable name
>  		# changes, ex: syslogtst executable.
> diff --git a/testcases/kernel/syscalls/syslog/syslog09
> b/testcases/kernel/syscalls/syslog/syslog09
> index de06fb1..c488f43 100755
> --- a/testcases/kernel/syscalls/syslog/syslog09
> +++ b/testcases/kernel/syscalls/syslog/syslog09
> @@ -57,10 +57,17 @@ syslog_case9()
>  	restart_syslog_daemon
>  
>  	# check if /var/log/messages script exists
> -	if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e
> /var/log/messages ]; then
> -		tst_resm TBROK "/var/log/messages no such log file"
> -		cleanup 1
> -	fi
> +	case "$CONFIG_FILE" in
> +	/etc/syslog-ng/syslog-ng.conf|/etc/rsyslog.conf)
> +		# syslog-ng and rsyslog don't create empty log files
> +		;;
> +	*)
> +		if [ ! -e /var/log/messages ]; then
> +			tst_resm TBROK "/var/log/messages no such log file"
> +			cleanup 1
> +		fi
> +		;;
> +	esac
>  
>  	allow1=`grep -c "syslogtst: error level is logged" /var/log/messages`
>  	donot_allow1=`grep -c "syslogtst: warning level not to be logged"
>  	/var/log/messages`
> --
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> Time is money. Stop wasting it! Get your web API in 5 minutes.
> www.restlet.com/download
> http://p.sf.net/sfu/restlet
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
