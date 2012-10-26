Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TRht8-00038s-T1
	for ltp-list@lists.sourceforge.net; Fri, 26 Oct 2012 11:15:42 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TRht3-0002Dn-1j
	for ltp-list@lists.sourceforge.net; Fri, 26 Oct 2012 11:15:42 +0000
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q9QBFUn8027423
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Oct 2012 07:15:30 -0400
Date: Fri, 26 Oct 2012 07:15:30 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <830469677.390108.1351250130900.JavaMail.root@redhat.com>
In-Reply-To: <a8673441164c2c578dc5a485640a433f3e92c5d3.1351248861.git.jstancek@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] ipc/shmat: pick suitable base_addr before
	each	testcase
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



----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 26 October, 2012 12:54:37 PM
> Subject: [LTP] [PATCH] ipc/shmat: pick suitable base_addr before each	testcase
> 
> This test picked fixed address in setup() which was used throughout
> the test. There has been reports that it can fail with EINVAL.
> 
> I could reproduce it by adding single printf in between
> detach/attach:
> http://article.gmane.org/gmane.linux.ltp/16480
> 
> This patch picks suitable base_addr before each test. So even if
> glibc
> would mmap extra page with addr == base_addr picked by setup(),
> new suitable address will be chosen.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

I'll send v2, getipckey() appears to return only few unique
keys and after couple loops this fails because it returns key
which already exists.

Regards,
Jan

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
