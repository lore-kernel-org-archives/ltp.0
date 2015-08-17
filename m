Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZRKY8-0000WP-Io
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2015 13:34:04 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZRKY5-0007Cf-UC
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2015 13:34:04 +0000
Date: Mon, 17 Aug 2015 09:33:43 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <2105335239.10970039.1439818423738.JavaMail.zimbra@redhat.com>
In-Reply-To: <1439540244-15421-1-git-send-email-sunyuan3@huawei.com>
References: <1439540244-15421-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V3] container: new testcase pidns32
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
> Sent: Friday, 14 August, 2015 10:17:24 AM
> Subject: [PATCH V3] container: new testcase pidns32
> 
> Kernel imposes a limit of 32 nested levels of pid namespaces.
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>

Hi,

pushed with updated commit message and removed kernel version check.
Since we expect that 32 levels will work on any kernel, there's
no need for it now.

Regards,
Jan

> ---
>  runtest/containers                           |   1 +
>  testcases/kernel/containers/pidns/.gitignore |   1 +
>  testcases/kernel/containers/pidns/pidns32.c  | 103
>  +++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 testcases/kernel/containers/pidns/pidns32.c
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
