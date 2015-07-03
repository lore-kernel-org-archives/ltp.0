Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZAyCm-0002hu-Kl
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 10:28:24 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZAyCl-0004pF-Be
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 10:28:24 +0000
Date: Fri, 3 Jul 2015 06:27:49 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1708470684.12227407.1435919269525.JavaMail.zimbra@redhat.com>
In-Reply-To: <559657E9.4060103@huawei.com>
References: <1435724565-19631-1-git-send-email-sunyuan3@huawei.com>
	<5595FC03.10602@huawei.com>
	<1526251635.12159899.1435909417100.JavaMail.zimbra@redhat.com>
	<55965241.5020206@huawei.com>
	<20150703091815.GA2855@dustball.brq.redhat.com>
	<559654BB.5050300@huawei.com>
	<40301374.12208438.1435915931114.JavaMail.zimbra@redhat.com>
	<559657E9.4060103@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V2] userns01: add capability verification
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
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Yuan Sun" <sunyuan3@huawei.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Friday, 3 July, 2015 11:37:45 AM
> Subject: Re: [PATCH V2] userns01: add capability verification
> 
> 
> Log is as follow. I am not clear if new feature is added.

I have installed "ubuntu-15.04-server-amd64.iso" and I get
the same failure:

root@ubuntu:~# apt-cache show libcap2 | grep Vers
Version: 1:2.24-6

root@ubuntu:~# uname -r
3.19.0-15-generic

root@ubuntu:~# cat /proc/self/status | grep Eff
CapEff: 0000003fffffffff

root@ubuntu:~# ./a.out
ffffffff 0000003f
ffffffff ffffffff
cap_compare: 3

Regards,
Jan

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
