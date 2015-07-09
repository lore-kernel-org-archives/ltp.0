Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZD739-0007nz-5s
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 08:19:19 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD736-0001uk-5F
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 08:19:19 +0000
Date: Thu, 9 Jul 2015 04:19:09 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <431985009.14827500.1436429949621.JavaMail.zimbra@redhat.com>
In-Reply-To: <904998018.14796051.1436425198776.JavaMail.zimbra@redhat.com>
References: <20150708194114.GA20060@tarantula.localdomain>
	<904998018.14796051.1436425198776.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] syslog/syslog-lib.sh: support systemd journal
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
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Jeffrey Bastian" <jbastian@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Thursday, 9 July, 2015 8:59:58 AM
> Subject: Re: [LTP] [PATCH] syslog/syslog-lib.sh: support systemd journal
> 
> 
> 
> 
> 
> ----- Original Message -----
> > From: "Jeffrey Bastian" <jbastian@redhat.com>
> > To: ltp-list@lists.sourceforge.net
> > Sent: Wednesday, 8 July, 2015 9:41:14 PM
> > Subject: [LTP] [PATCH] syslog/syslog-lib.sh: support systemd journal
> > 
> > rsyslog needs to use the imjournal module to communicate with
> > systemd-journald.
> 
> According to:
>   https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/s1-interaction_of_rsyslog_and_journal.html
> 
> there are 2 ways rsyslog can get messages:
> 1) By default, rsyslogd uses the imjournal module as a default input mode for
> journal files.
> 2) As an alternative, configure rsyslogd to read from the socket provided by
> journal as an output for syslog-based applications. The path to the socket
> is /run/systemd/journal/syslog.
>    $SystemLogSocketName /run/systemd/journal/syslog
> 
> Is 2) no longer supported?

It still appears supported, but turned off by default in systemd 216:

CHANGES WITH 216:
+        * journald will no longer forward all local data to another
+          running syslog daemon. This change has been made because
+          rsyslog (which appears to be the most commonly used syslog
+          implementation these days) no longer makes use of this, and
+          instead pulls the data out of the journal on its own. Since
+          forwarding the messages to a non-existant syslog server is
+          more expensive than we assumed we have now turned this
+          off. If you run a syslog server that is not a recent rsyslog
+          version, you have to turn this option on again
+          (ForwardToSyslog= in journald.conf).

So I think we should use imjournal if possible, otherwise fall back
to imuxsock. But I think it should be one or the other, using both
in same config seems wrong to me.

Regards,
Jan

> 
> Regards,
> Jan
> 
> > Copy the imjournal lines from the system's
> > /etc/rsyslog.conf if they exist.
> > 
> > Signed-off-by: Jeffrey Bastian <jbastian@redhat.com>
> > ---
> >  testcases/kernel/syscalls/syslog/syslog-lib.sh | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh
> > b/testcases/kernel/syscalls/syslog/syslog-lib.sh
> > index ef33517aa92b..4a6514a3114e 100755
> > --- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
> > +++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
> > @@ -72,8 +72,10 @@ setup()
> >  	elif [ "$SYSLOG_DAEMON" = "rsyslog" ]; then
> >  		CONFIG_FILE="/etc/rsyslog.conf"
> >  		log_socket=$(grep -ho "^\$SystemLogSocketName .*" -r /etc/rsyslog.conf
> >  		/etc/rsyslog.d/ | head -1)
> > +		systemd_journal=$(grep -hoi "^[^#].*imjournal.*" -r /etc/rsyslog.conf
> > /etc/rsyslog.d/)
> >  		RSYSLOG_CONFIG=$(cat <<EOF
> >  \$ModLoad imuxsock.so
> > +$systemd_journal
> >  $log_socket
> >  EOF
> >  )
> > --
> > 1.9.4
> > 
> > ------------------------------------------------------------------------------
> > Don't Limit Your Business. Reach for the Cloud.
> > GigeNET's Cloud Solutions provide you with the tools and support that
> > you need to offload your IT needs and focus on growing your business.
> > Configured For All Businesses. Start Your Cloud Today.
> > https://www.gigenetcloud.com/
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 
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
