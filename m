Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1W08XL-0005r2-Q7
	for ltp-list@lists.sourceforge.net; Mon, 06 Jan 2014 11:40:03 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W08XK-00081Q-Gf
	for ltp-list@lists.sourceforge.net; Mon, 06 Jan 2014 11:40:03 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s06BdujC013262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jan 2014 06:39:56 -0500
Received: from robin.brq.redhat.com (robin.brq.redhat.com [10.34.24.36])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id s06BdtOQ006727
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jan 2014 06:39:56 -0500
Message-ID: <52CA960B.9080709@redhat.com>
Date: Mon, 06 Jan 2014 12:39:55 +0100
From: Jiri Jaburek <jjaburek@redhat.com>
MIME-Version: 1.0
References: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
In-Reply-To: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
Subject: Re: [LTP] [PATCH 0/5] various tcp_cmds/ssh/* fixes, rewrites
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

On 12/03/2013 11:16 AM, Jiri Jaburek wrote:
> Jiri Jaburek (5):
>   ssh: unify code style amongst ssh tests
>   ssh: remove unused ssh_set_passwd script
>   ssh: properly create/remove user home dir, if possible
>   ssh: try to prevent invalid PASS when remote cmd fails
>   ssh: don't use crypt-based pre-encrypted passwords
> 
>  testcases/network/tcp_cmds/ssh/ssh01          | 42 ++++++++++++------------
>  testcases/network/tcp_cmds/ssh/ssh01_s1       | 39 +++++++++++++----------
>  testcases/network/tcp_cmds/ssh/ssh02          | 39 +++++++++++------------
>  testcases/network/tcp_cmds/ssh/ssh02_s1       | 17 +++++-----
>  testcases/network/tcp_cmds/ssh/ssh03          | 46 +++++++++++++--------------
>  testcases/network/tcp_cmds/ssh/ssh03_s1       | 15 +++++----
>  testcases/network/tcp_cmds/ssh/ssh_set_passwd | 28 ----------------
>  7 files changed, 103 insertions(+), 123 deletions(-)
>  delete mode 100755 testcases/network/tcp_cmds/ssh/ssh_set_passwd
> 

Could somebody review these changes, please? All patches should be well
commented using commit messages.

Thanks,
Jiri


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
