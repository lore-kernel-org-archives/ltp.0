Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZK2Xy-0001ws-Ot
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2015 10:55:46 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZK2Xx-0005bS-G5
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2015 10:55:46 +0000
Date: Tue, 28 Jul 2015 06:55:39 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <89938528.1257080.1438080939001.JavaMail.zimbra@redhat.com>
In-Reply-To: <1437403631-11091-1-git-send-email-vdavydov@parallels.com>
References: <1437403631-11091-1-git-send-email-vdavydov@parallels.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] memcg_control: fix mem_process not moved to cgroup
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
To: Vladimir Davydov <vdavydov@parallels.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Vladimir Davydov" <vdavydov@parallels.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Monday, 20 July, 2015 4:47:11 PM
> Subject: [LTP] [PATCH] memcg_control: fix mem_process not moved to cgroup
> 
> $! is not set after ( cmd & )
> 
> This bug was introduced by commit 49010e502a74c ("Replace pushd // popd
> with cd calls.").
> 
> Since we create a sub-shell in test_proc_kill only to preserve PWD,
> let's change this to cd $OLDPWD. In contrast to pushd/popd this will
> work in busybox.
> 
> Signed-off-by: Vladimir Davydov <vdavydov@parallels.com>

Pushed.

Thank you,
Jan

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
