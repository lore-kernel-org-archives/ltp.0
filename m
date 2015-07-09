Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZDC3X-0007wL-Ah
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 13:40:03 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZDC3U-0004S7-UV
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 13:40:03 +0000
Date: Thu, 9 Jul 2015 09:39:54 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1737674583.15006076.1436449194123.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150709124503.GM17625@tarantula.localdomain>
References: <20150708194114.GA20060@tarantula.localdomain>
	<904998018.14796051.1436425198776.JavaMail.zimbra@redhat.com>
	<431985009.14827500.1436429949621.JavaMail.zimbra@redhat.com>
	<20150709124503.GM17625@tarantula.localdomain>
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
> From: "Jeffrey Bastian" <jbastian@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Thursday, 9 July, 2015 2:45:03 PM
> Subject: Re: [LTP] [PATCH] syslog/syslog-lib.sh: support systemd journal
> 
> On Thu, Jul 09, 2015 at 04:19:09AM -0400, Jan Stancek wrote:
> > It still appears supported, but turned off by default in systemd 216:
> > 
> <snip>
> > 
> > So I think we should use imjournal if possible, otherwise fall back
> > to imuxsock. But I think it should be one or the other, using both
> > in same config seems wrong to me.
> 
> 
> I was testing with systemd-219 when I ran into this problem, hence my
> patch submission.

Do the testcases pass for you with this patch? They still fail for me with
rsyslog-7.4.7-7.el7_0 and systemd-219-5.el7.

This is config used by syslogs tests:

# cat /etc/rsyslog.conf
$ModLoad imuxsock.so
$ModLoad imjournal # provides access to the systemd journal
$IMJournalStateFile imjournal.state
$SystemLogSocketName /run/systemd/journal/syslog
mail.debug      /var/log/maillog

which fails for me unless I add "$WorkDirectory" option.
I'm guessing that's needed to find imjournal.state file:
# ll /var/lib/rsyslog
total 4
-rw-r--r--. 1 root root 124 Jul  9 09:21 imjournal.state

> 
> I think it's ok to leave both modules enabled, though.  The default
> rsyslog.conf in Fedora (up to F21) had both enabled:

It seems to duplicate messages for me in quite unpredictable way.
After running syslog02:

[root@ibm-ls21-04 bin]# cat /var/log/maillog

2015-07-09T09:33:44.681130-04:00 ibm-ls21-04 syslogtst: syslogtst: mail emerg test.
2015-07-09T09:33:44.681379-04:00 ibm-ls21-04 syslogtst: syslogtst: mail emerg test.
2015-07-09T09:33:44.681379-04:00 ibm-ls21-04 syslogtst: syslogtst: mail emerg test.
2015-07-09T09:33:48.812431-04:00 ibm-ls21-04 syslogtst: syslogtst: mail alert test.
2015-07-09T09:33:48.812349-04:00 ibm-ls21-04 syslogtst: syslogtst: mail alert test.
2015-07-09T09:33:44.681379-04:00 ibm-ls21-04 syslogtst: syslogtst: mail emerg test.
2015-07-09T09:33:48.812431-04:00 ibm-ls21-04 syslogtst: syslogtst: mail alert test.
2015-07-09T09:33:52.943509-04:00 ibm-ls21-04 syslogtst: syslogtst: mail crit test.
2015-07-09T09:33:52.943588-04:00 ibm-ls21-04 syslogtst: syslogtst: mail crit test.
2015-07-09T09:33:44.681379-04:00 ibm-ls21-04 syslogtst: syslogtst: mail emerg test.
2015-07-09T09:33:48.812431-04:00 ibm-ls21-04 syslogtst: syslogtst: mail alert test.
2015-07-09T09:33:52.943588-04:00 ibm-ls21-04 syslogtst: syslogtst: mail crit test.
2015-07-09T09:33:57.072698-04:00 ibm-ls21-04 syslogtst: syslogtst: mail err test.
2015-07-09T09:33:57.072774-04:00 ibm-ls21-04 syslogtst: syslogtst: mail err test.
2015-07-09T09:33:44.681379-04:00 ibm-ls21-04 syslogtst: syslogtst: mail emerg test.
2015-07-09T09:33:48.812431-04:00 ibm-ls21-04 syslogtst: syslogtst: mail alert test.
2015-07-09T09:33:52.943588-04:00 ibm-ls21-04 syslogtst: syslogtst: mail crit test.
2015-07-09T09:33:57.072774-04:00 ibm-ls21-04 syslogtst: syslogtst: mail err test.
2015-07-09T09:34:01.202191-04:00 ibm-ls21-04 syslogtst: syslogtst: mail warning test.
2015-07-09T09:34:01.202268-04:00 ibm-ls21-04 syslogtst: syslogtst: mail warning test.
2015-07-09T09:33:44.681379-04:00 ibm-ls21-04 syslogtst: syslogtst: mail emerg test.
2015-07-09T09:33:48.812431-04:00 ibm-ls21-04 syslogtst: syslogtst: mail alert test.
2015-07-09T09:33:52.943588-04:00 ibm-ls21-04 syslogtst: syslogtst: mail crit test.
2015-07-09T09:33:57.072774-04:00 ibm-ls21-04 syslogtst: syslogtst: mail err test.
2015-07-09T09:34:01.202268-04:00 ibm-ls21-04 syslogtst: syslogtst: mail warning test.
2015-07-09T09:34:05.333899-04:00 ibm-ls21-04 syslogtst: syslogtst: mail notice test.
2015-07-09T09:34:05.333818-04:00 ibm-ls21-04 syslogtst: syslogtst: mail notice test.
2015-07-09T09:33:44.681379-04:00 ibm-ls21-04 syslogtst: syslogtst: mail emerg test.
2015-07-09T09:33:48.812431-04:00 ibm-ls21-04 syslogtst: syslogtst: mail alert test.
2015-07-09T09:33:52.943588-04:00 ibm-ls21-04 syslogtst: syslogtst: mail crit test.
2015-07-09T09:33:57.072774-04:00 ibm-ls21-04 syslogtst: syslogtst: mail err test.
2015-07-09T09:34:01.202268-04:00 ibm-ls21-04 syslogtst: syslogtst: mail warning test.
2015-07-09T09:34:05.333899-04:00 ibm-ls21-04 syslogtst: syslogtst: mail notice test.
2015-07-09T09:34:09.464783-04:00 ibm-ls21-04 syslogtst: syslogtst: mail info test.
2015-07-09T09:34:09.464862-04:00 ibm-ls21-04 syslogtst: syslogtst: mail info test.
2015-07-09T09:34:13.563791-04:00 ibm-ls21-04 syslogtst: syslogtst: mail debug test.
2015-07-09T09:34:13.563870-04:00 ibm-ls21-04 syslogtst: syslogtst: mail debug test.
Jul  9 09:34:13 ibm-ls21-04 syslogtst: syslogtst: mail debug test.

if I use only imjournal I get:
# cat /var/log/maillog

2015-07-09T09:37:30.452833-04:00 ibm-ls21-04 syslogtst: syslogtst: mail emerg test.
2015-07-09T09:37:34.583176-04:00 ibm-ls21-04 syslogtst: syslogtst: mail alert test.
2015-07-09T09:37:38.713671-04:00 ibm-ls21-04 syslogtst: syslogtst: mail crit test.
2015-07-09T09:37:42.843411-04:00 ibm-ls21-04 syslogtst: syslogtst: mail err test.
2015-07-09T09:37:46.975099-04:00 ibm-ls21-04 syslogtst: syslogtst: mail warning test.
2015-07-09T09:37:51.104797-04:00 ibm-ls21-04 syslogtst: syslogtst: mail notice test.
2015-07-09T09:37:55.236947-04:00 ibm-ls21-04 syslogtst: syslogtst: mail info test.
2015-07-09T09:37:59.366192-04:00 ibm-ls21-04 syslogtst: syslogtst: mail debug test.

Regards,
Jan

> 
> $ModLoad imuxsock # provides support for local system logging (e.g. via
> logger command)
> $ModLoad imjournal # provides access to the systemd journal
> 
> See http://pkgs.fedoraproject.org/cgit/rsyslog.git/tree/rsyslog.conf?h=f21#n9
> 
> (Fedora 22 dropped imuxsock with the rebase to rsyslog-8.8.0.)
> 
> --
> Jeff Bastian
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
