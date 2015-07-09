Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZDF15-0002Lc-IB
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 16:49:43 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZDF14-0006vL-0r
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 16:49:43 +0000
Date: Thu, 9 Jul 2015 12:49:35 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <438616599.15156602.1436460575320.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150709163341.GU17625@tarantula.localdomain>
References: <20150708194114.GA20060@tarantula.localdomain>
	<904998018.14796051.1436425198776.JavaMail.zimbra@redhat.com>
	<431985009.14827500.1436429949621.JavaMail.zimbra@redhat.com>
	<20150709124503.GM17625@tarantula.localdomain>
	<1737674583.15006076.1436449194123.JavaMail.zimbra@redhat.com>
	<20150709143700.GQ17625@tarantula.localdomain>
	<1448931194.15074761.1436453202001.JavaMail.zimbra@redhat.com>
	<20150709163341.GU17625@tarantula.localdomain>
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
> Sent: Thursday, 9 July, 2015 6:33:41 PM
> Subject: Re: [LTP] [PATCH] syslog/syslog-lib.sh: support systemd journal
> 
> On Thu, Jul 09, 2015 at 10:46:42AM -0400, Jan Stancek wrote:
> > Presumably because you are running new systemd. Can you try with
> > "ForwardToSyslog=yes" set in journald.conf (which is the case for old
> > systemd)?
> > 
> > That still gives me duplicated messages with v2 of the patch.
> 
> Ok, I see it now: systemd-208 gets duplicates with v2 of the patch, and
> systemd-219 with ForwardToSyslog=yes also gets duplicates.
> 
> This will complicate the patch a bit.  If I understand it correctly, LTP
> proc01 needs to do something like this:
> 
>   if ForwardToSyslog is enabled OR
>      (systemd version < 216 AND using default journald.conf)
>   then
>       use imuxsock
>   else
>       use imjournal
>   endif
> 

I think it's enough to look at rsyslog.conf to check if imjournal is in use.
If it's in distro rsyslog.conf, we know we can use it too. If not, we fall back
to imuxsock. 

if rsyslog.conf is using imjournal then 
  use imjournal
else
  use imuxsock

Regards,
Jan

> I'll send a new patch soon.
> 
> Thanks,
> Jeff
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
