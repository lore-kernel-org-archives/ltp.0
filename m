Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Wderq-0007fM-6N
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 12:04:34 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wderp-0006ga-AH
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 12:04:34 +0000
Message-ID: <535A4F41.5060607@oracle.com>
Date: Fri, 25 Apr 2014 16:04:17 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1395971064-625-1-git-send-email-xu.simon@oracle.com>
	<698021823.mA9edKhrul@vapier>
In-Reply-To: <698021823.mA9edKhrul@vapier>
Subject: Re: [LTP] [PATCH] ip_tests.sh: don't use hardcoded eth0
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
To: Mike Frysinger <vapier@gentoo.org>, ltp-list@lists.sourceforge.net, "x >> \"XU.SIMON\"" <xu.simon@oracle.com>

Hi!

On 03/28/2014 09:08 AM, Mike Frysinger wrote:
> On Fri 28 Mar 2014 09:44:24 Simon Xu wrote:
>> The script uses hardcoded 'eth0' which used to work on most systems.
>> This fix tries to find a 'working' network interface using the hostname.
>
> why doesn't hardcoding "lo" work ?
> -mike

I think we can't use the loopback interface because test06 fails if 
invoked with lo:

[root@kholmanskikh stas]# /sbin/ifconfig lo:1 1.2.3.4 netmask 
255.255.255.0 up
[root@kholmanskikh stas]# /sbin/ip maddr add 66:66:00:00:00:66 dev lo:1
ioctl: Invalid argument

[root@kholmanskikh stas]# /sbin/ifconfig eth0:1 3.4.5.6 netmask 
255.255.255.0 up
[root@kholmanskikh stas]# /sbin/ip maddr add 66:66:00:00:00:66 dev eth0:1
[root@kholmanskikh stas]#

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
