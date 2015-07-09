Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1ZDElo-0000Hc-1j
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 16:33:56 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZDEli-0003A9-96
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 16:33:56 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 1BA1083F66
	for <ltp-list@lists.sourceforge.net>;
	Thu,  9 Jul 2015 16:33:44 +0000 (UTC)
Received: from tarantula.localdomain (ovpn-113-174.phx2.redhat.com
	[10.3.113.174])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t69GXgZN022138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 12:33:43 -0400
Date: Thu, 9 Jul 2015 11:33:41 -0500
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20150709163341.GU17625@tarantula.localdomain>
References: <20150708194114.GA20060@tarantula.localdomain>
	<904998018.14796051.1436425198776.JavaMail.zimbra@redhat.com>
	<431985009.14827500.1436429949621.JavaMail.zimbra@redhat.com>
	<20150709124503.GM17625@tarantula.localdomain>
	<1737674583.15006076.1436449194123.JavaMail.zimbra@redhat.com>
	<20150709143700.GQ17625@tarantula.localdomain>
	<1448931194.15074761.1436453202001.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1448931194.15074761.1436453202001.JavaMail.zimbra@redhat.com>
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
To: ltp-list@lists.sourceforge.net

On Thu, Jul 09, 2015 at 10:46:42AM -0400, Jan Stancek wrote:
> Presumably because you are running new systemd. Can you try with
> "ForwardToSyslog=yes" set in journald.conf (which is the case for old systemd)?
> 
> That still gives me duplicated messages with v2 of the patch.

Ok, I see it now: systemd-208 gets duplicates with v2 of the patch, and
systemd-219 with ForwardToSyslog=yes also gets duplicates.

This will complicate the patch a bit.  If I understand it correctly, LTP
proc01 needs to do something like this:

  if ForwardToSyslog is enabled OR
     (systemd version < 216 AND using default journald.conf)
  then
      use imuxsock
  else
      use imjournal
  endif

I'll send a new patch soon.

Thanks,
Jeff

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
