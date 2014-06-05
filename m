Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1WsVsp-0004Nr-C1
	for ltp-list@lists.sourceforge.net; Thu, 05 Jun 2014 11:30:59 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WsVso-00074k-4A
	for ltp-list@lists.sourceforge.net; Thu, 05 Jun 2014 11:30:59 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s55BUprK013432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Jun 2014 07:30:51 -0400
Message-ID: <539054EA.2050004@redhat.com>
Date: Thu, 05 Jun 2014 13:30:50 +0200
From: Jiri Jaburek <jjaburek@redhat.com>
MIME-Version: 1.0
References: <1401272151-6563-1-git-send-email-jjaburek@redhat.com>
	<1249145583.18329328.1401964511429.JavaMail.zimbra@redhat.com>
In-Reply-To: <1249145583.18329328.1401964511429.JavaMail.zimbra@redhat.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 06/05/2014 12:35 PM, Jan Stancek wrote:
> Hi Jiri,
> 
> I was thinking about removing that check, and checking file existence
> only after test generates some log entry. That would make things simpler
> and we would still know if there is logfile after syslogtst ran:

I was considering that as well, but I went with retaining the old
behavior for other possible implementations of generic syslog (if there
are still any).

> 
> 
> diff --git a/testcases/kernel/syscalls/syslog/syslog01 b/testcases/kernel/syscalls/syslog/syslog01
> index b7bcd9e..2f3aea0 100755
> --- a/testcases/kernel/syscalls/syslog/syslog01
> +++ b/testcases/kernel/syscalls/syslog/syslog01
> @@ -66,12 +66,6 @@ syslog_case1()
>  
>         restart_syslog_daemon
>  
> -       # check if $MAILLOG script exists
> -       if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e $MAILLOG ]; then
> -               tst_resm TBROK "$MAILLOG no such log file"
> -               cleanup 1
> -       fi
> -
>         # Grepping pattern has to be changed whenever the executable name
>         # changes, ex: syslogtst executable.
>         # This check is neccessary for syslog-ng because $MAILLOG is
> @@ -87,6 +81,11 @@ syslog_case1()
>  
>                 sleep 2
>  
> +               if [ ! -e $MAILLOG ]; then
> +                       tst_resm TBROK "$MAILLOG no such log file"
> +                       cleanup 1
> +               fi
> +
>                 newvalue1=`grep -c "syslogtst: mail info test" $MAILLOG`
>                 if [ "x$(( $newvalue1 - $oldvalue1 ))" != "x1" ]; then
>                         status_flag=1
> diff --git a/testcases/kernel/syscalls/syslog/syslog02 b/testcases/kernel/syscalls/syslog/syslog02
> index a416344..7a55a84 100755
> --- a/testcases/kernel/syscalls/syslog/syslog02
> +++ b/testcases/kernel/syscalls/syslog/syslog02
> @@ -65,15 +65,6 @@ syslog_case2()
>  
>                 restart_syslog_daemon
>  
> -               # Grepping pattern is as follows:
> -               # syslogtst: mail $level test.
> -               # check if $MAILLOG script exists
> -               if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e $MAILLOG ]; then
> -                       tst_resm TBROK "$MAILLOG no such log file"
> -                       cleanup 1
> -               fi
> -
> -
>                 # Grepping pattern has to be changed whenever the executable name
>                 # changes, ex: syslogtst executable.
>                 # This check is neccessary for syslog-ng because $MAILLOG is
> diff --git a/testcases/kernel/syscalls/syslog/syslog09 b/testcases/kernel/syscalls/syslog/syslog09
> index de06fb1..9cfafa8 100755
> --- a/testcases/kernel/syscalls/syslog/syslog09
> +++ b/testcases/kernel/syscalls/syslog/syslog09
> @@ -56,15 +56,14 @@ syslog_case9()
>  
>         restart_syslog_daemon
>  
> -       # check if /var/log/messages script exists
> -       if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e /var/log/messages ]; then
> -               tst_resm TBROK "/var/log/messages no such log file"
> -               cleanup 1
> +       if [ -e /var/log/messages ]; then
> +               allow1=`grep -c "syslogtst: error level is logged" /var/log/messages`
> +               donot_allow1=`grep -c "syslogtst: warning level not to be logged" /var/log/messages`
> +       else
> +               allow1=0
> +               donot_allow1=0
>         fi
>  
> -       allow1=`grep -c "syslogtst: error level is logged" /var/log/messages`
> -       donot_allow1=`grep -c "syslogtst: warning level not to be logged" /var/log/messages`
> -
>         if ! syslogtst 9 2>/dev/null; then
>                 cleanup 1
>         fi
> 
> What do you think?

Looks good to me.

Jiri


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
