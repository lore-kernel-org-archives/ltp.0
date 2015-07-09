Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1ZDBCV-0005Mg-9u
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 12:45:15 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZDBCS-0005yu-Fp
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 12:45:15 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 7D9E040E680
	for <ltp-list@lists.sourceforge.net>;
	Thu,  9 Jul 2015 12:45:06 +0000 (UTC)
Received: from tarantula.localdomain (ovpn-113-174.phx2.redhat.com
	[10.3.113.174])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t69Cj4L6021837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 08:45:05 -0400
Date: Thu, 9 Jul 2015 07:45:03 -0500
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20150709124503.GM17625@tarantula.localdomain>
References: <20150708194114.GA20060@tarantula.localdomain>
	<904998018.14796051.1436425198776.JavaMail.zimbra@redhat.com>
	<431985009.14827500.1436429949621.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <431985009.14827500.1436429949621.JavaMail.zimbra@redhat.com>
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

On Thu, Jul 09, 2015 at 04:19:09AM -0400, Jan Stancek wrote:
> It still appears supported, but turned off by default in systemd 216:
> 
<snip>
> 
> So I think we should use imjournal if possible, otherwise fall back
> to imuxsock. But I think it should be one or the other, using both
> in same config seems wrong to me.


I was testing with systemd-219 when I ran into this problem, hence my
patch submission.

I think it's ok to leave both modules enabled, though.  The default
rsyslog.conf in Fedora (up to F21) had both enabled:

$ModLoad imuxsock # provides support for local system logging (e.g. via logger command)
$ModLoad imjournal # provides access to the systemd journal

See http://pkgs.fedoraproject.org/cgit/rsyslog.git/tree/rsyslog.conf?h=f21#n9

(Fedora 22 dropped imuxsock with the rebase to rsyslog-8.8.0.)

-- 
Jeff Bastian

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
