Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Wn1a9-0006BY-0U
	for ltp-list@lists.sourceforge.net; Wed, 21 May 2014 08:09:01 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wn1a7-0000Kc-Tp
	for ltp-list@lists.sourceforge.net; Wed, 21 May 2014 08:09:00 +0000
Date: Wed, 21 May 2014 04:08:48 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <109446618.9006900.1400659728106.JavaMail.zimbra@redhat.com>
In-Reply-To: <1400463915-15572-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1400463915-15572-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1400463915-15572-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v3 2/2] setpgid/setpgid01.c: add pid = 0 and pgid
 = 0	test
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Monday, 19 May, 2014 3:45:15 AM
> Subject: [LTP] [PATCH v3 2/2] setpgid/setpgid01.c: add pid = 0 and pgid = 0	test
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/setpgid/setpgid01.c | 54
>  ++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 2 deletions(-)
> 

Hi,

both patches are pushed.

Regards,
Jan

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
