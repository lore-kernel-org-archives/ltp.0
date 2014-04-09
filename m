Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1WXli5-0007dc-Ct
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 06:10:09 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WXli4-0004mr-L1
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 06:10:09 +0000
Message-ID: <5344E42D.9050801@oracle.com>
Date: Wed, 09 Apr 2014 14:09:49 +0800
From: Simon Xu <xu.simon@oracle.com>
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
To: Mike Frysinger <vapier@gentoo.org>, ltp-list@lists.sourceforge.net

In my CentOS box, running "ifconfig lo:1 10.1.1.12" immediately hangs 
the ssh connection, I have to run "systemctl restart network" in local 
tty to make network work again.  Could you help to try the testcases in 
ip_tests.sh on your box and report back?

Thanks
Simon

On 2014/3/28 13:08, Mike Frysinger wrote:
> On Fri 28 Mar 2014 09:44:24 Simon Xu wrote:
>> The script uses hardcoded 'eth0' which used to work on most systems.
>> This fix tries to find a 'working' network interface using the hostname.
> why doesn't hardcoding "lo" work ?
> -mike


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
