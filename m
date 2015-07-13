Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZEc8s-0003WJ-Oc
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 11:43:26 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEc8q-0000mn-Rr
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 11:43:26 +0000
Date: Mon, 13 Jul 2015 07:43:16 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1163491881.16317584.1436787796746.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150709221612.GV17625@tarantula.localdomain>
References: <20150708194114.GA20060@tarantula.localdomain>
	<20150709124503.GM17625@tarantula.localdomain>
	<1737674583.15006076.1436449194123.JavaMail.zimbra@redhat.com>
	<20150709143700.GQ17625@tarantula.localdomain>
	<1448931194.15074761.1436453202001.JavaMail.zimbra@redhat.com>
	<20150709163341.GU17625@tarantula.localdomain>
	<438616599.15156602.1436460575320.JavaMail.zimbra@redhat.com>
	<20150709221612.GV17625@tarantula.localdomain>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v3] syslog/syslog-lib.sh: support systemd journal
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
To: Jeffrey Bastian <jbastian@redhat.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Jeffrey Bastian" <jbastian@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 10 July, 2015 12:16:12 AM
> Subject: Re: [LTP] [PATCH v3] syslog/syslog-lib.sh: support systemd journal
> 
> rsyslog needs to use the imjournal module to communicate with
> systemd-journald instead of imuxsock.  Check the system's
> /etc/rsyslog.conf to see if LTP should use imjournal or imuxsock
> 
> Signed-off-by: Jeffrey Bastian <jbastian@redhat.com>

Reviewed-by: Jan Stancek <jstancek@redhat.com>

Looks good to me. I tried this patch with systemd-208 and systemd-219 with
default journald config, the results were as expected with no duplicate messages.

I also tried reversing imuxsock/imjournal to be the opposite of the default
rsyslog config, which worked too. As noted before, ForwardToSyslog=yes
was required for systemd-219 when using imuxsock as that is no longer turned
on by default. This should be of no concern, since we always try to construct
rsyslog config which mimics distro default.

Regards,
Jan

> ---
>  testcases/kernel/syscalls/syslog/syslog-lib.sh | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh
> b/testcases/kernel/syscalls/syslog/syslog-lib.sh
> index ef33517aa92b..e166d3a45261 100755
> --- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
> +++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
> @@ -71,12 +71,20 @@ setup()
>  		CONFIG_FILE="/etc/syslog-ng/syslog-ng.conf"
>  	elif [ "$SYSLOG_DAEMON" = "rsyslog" ]; then
>  		CONFIG_FILE="/etc/rsyslog.conf"
> -		log_socket=$(grep -ho "^\$SystemLogSocketName .*" -r /etc/rsyslog.conf
> /etc/rsyslog.d/ | head -1)
> -		RSYSLOG_CONFIG=$(cat <<EOF
> +		if grep -q -r '^\$ModLoad[[:space:]]*imjournal' /etc/rsyslog.conf
> /etc/rsyslog.d/ ; then
> +			systemd_journal=$(grep -Ehoi "^[^#].*(imjournal|workdirectory).*" -r
> /etc/rsyslog.conf /etc/rsyslog.d/)
> +			RSYSLOG_CONFIG=$(cat <<EOF
> +$systemd_journal
> +EOF
> +)
> +		else
> +			log_socket=$(grep -ho "^\$SystemLogSocketName .*" -r /etc/rsyslog.conf
> /etc/rsyslog.d/ | head -1)
> +			RSYSLOG_CONFIG=$(cat <<EOF
>  \$ModLoad imuxsock.so
>  $log_socket
>  EOF
>  )
> +		fi
>  	else
>  		tst_resm TBROK "Couldn't find syslogd, syslog-ng or rsyslogd"
>  		cleanup 1
> --
> 1.9.4
> 
> ------------------------------------------------------------------------------
> Don't Limit Your Business. Reach for the Cloud.
> GigeNET's Cloud Solutions provide you with the tools and support that
> you need to offload your IT needs and focus on growing your business.
> Configured For All Businesses. Start Your Cloud Today.
> https://www.gigenetcloud.com/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
