Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XRyu7-0000SB-3s
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 07:34:55 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XRyu5-0004KX-Pz
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 07:34:54 +0000
Date: Thu, 11 Sep 2014 03:34:46 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <1230443390.31148244.1410420886427.JavaMail.zimbra@redhat.com>
In-Reply-To: <1409047992-15316-1-git-send-email-xzhou@redhat.com>
References: <1409047992-15316-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 0/3] fix old commit about skipping tests on NFS
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

Ping :)

----- Original Message -----
> From: "Xiong Zhou" <xzhou@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "stanislav kholmanskikh" <stanislav.kholmanskikh@oracle.com>, xzhou@redhat.com
> Sent: Tuesday, August 26, 2014 6:13:09 PM
> Subject: [PATCH 0/3] fix old commit about skipping tests on NFS
> 
> Fix old commit 5387ba03ce8eaddc7ec330ed03e579eed92596cc
> Skip only one block in fcntl14 instead of the whole case.
> splice/tee/utime pass on NFS now, so update the obsolete
> info.
> 
> 
> Xiong Zhou (3):
>   fcntl14: dup code clean up
>   fcntl14: skip test block2 on NFS
>   splice01/tee01/utime: test back on NFS
> 
>  testcases/kernel/syscalls/fcntl/fcntl14.c   | 85
>  +++++++++++++----------------
>  testcases/kernel/syscalls/splice/splice01.c |  5 --
>  testcases/kernel/syscalls/tee/tee01.c       |  5 --
>  testcases/kernel/syscalls/utime/utime01.c   |  1 -
>  testcases/kernel/syscalls/utime/utime02.c   |  1 -
>  testcases/kernel/syscalls/utime/utime03.c   |  1 -
>  6 files changed, 38 insertions(+), 60 deletions(-)
> 
> --
> 1.8.3.1
> 
> 

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
