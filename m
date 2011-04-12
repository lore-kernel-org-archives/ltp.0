Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q9Woy-0007kZ-7j
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:11:28 +0000
Received: from mail-px0-f174.google.com ([209.85.212.174])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q9Wox-0007mA-FP
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:11:28 +0000
Received: by pxi15 with SMTP id 15so3200360pxi.33
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Apr 2011 23:11:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cd5131a04961c81e7a09a88c2d6c3020429d451a.1302586505.git.czhang@redhat.com>
References: <cd5131a04961c81e7a09a88c2d6c3020429d451a.1302586505.git.czhang@redhat.com>
Date: Mon, 11 Apr 2011 23:11:21 -0700
Message-ID: <BANLkTi=Hr6z7p=PPhROwMbs0FUSszfktPA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] [hugetlb] hugeshmctl01: should exit when shmat
	fails
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Mon, Apr 11, 2011 at 10:35 PM, Caspar Zhang <czhang@redhat.com> wrote:
>
> if shmat() fails in hugeshmctl01 test, the test should exit, else -1
> will return, which may cause SIGSEGV due to this line:
>
> *(int *)test = i;
>
> thus incorrect signal sent to parent and test gets blocked infiniately.

Committed.
Thanks!
-Garrett

------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
