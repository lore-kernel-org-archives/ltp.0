Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZMuci-0007ca-Qw
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 09:04:32 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMuch-0002Y5-7m
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 09:04:32 +0000
Date: Wed, 5 Aug 2015 05:04:19 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <748348266.4192487.1438765459491.JavaMail.zimbra@redhat.com>
In-Reply-To: <1438334407-366-1-git-send-email-sunyuan3@huawei.com>
References: <1438334407-366-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V3] containers: new testcase userns05
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
> To: jstancek@redhat.com
> Cc: ltp-list@lists.sourceforge.net
> Sent: Friday, 31 July, 2015 11:20:07 AM
> Subject: [PATCH V3] containers: new testcase userns05
> 
> A process created via fork(2) or clone(2) without the CLONE_NEWUSER
> flag is a member of the same user namespace as its parent.
>   When unshare an user namespace, the calling process is moved into a
> new user namespace which is not shared with any previously existing
> process.
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>

Pushed with small change to one TFAIL/TBROK.

Thanks,
Jan

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
