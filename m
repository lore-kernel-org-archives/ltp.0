Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZFKuH-0004AI-2x
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2015 11:31:21 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZFKuF-0007dm-Am
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2015 11:31:21 +0000
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t6FBVDMR022191
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Jul 2015 07:31:13 -0400
Date: Wed, 15 Jul 2015 07:31:11 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <145230294.17766706.1436959871967.JavaMail.zimbra@redhat.com>
In-Reply-To: <7392d2ee56d8b865a4edefc0e72bff60f54c8db0.1435648319.git.jstancek@redhat.com>
References: <7392d2ee56d8b865a4edefc0e72bff60f54c8db0.1435648319.git.jstancek@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] checkpoints: support for propagating value
 from	wake to wait
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
> Sent: Tuesday, 30 June, 2015 9:20:25 AM
> Subject: [LTP] [PATCH v2] checkpoints: support for propagating value from	wake to wait
> 
> This patch changes name of tst_futexes array and is using it to
> store futexes as well as propagated values. The values are of newly
> defined type: tst_chp_value_t, which is initially defined as int32_t.
> 
> Patch is adding optional 3rd parameter to TST_SAFE_CHECKPOINT_WAKE,
> which can be used to propagate this integer.
> TST_SAFE_CHECKPOINT_WAIT has been changed to return it.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
> Changes in v2:
> - prefix types and macro with tst_
> - remove volatile from tst_chp_value_t
> - pass by value where possible
> - special value to not propagate anything defined as TST_CHP_IGN
> - is_index_valid renamed to valid_id
> - dropped casts in tst_rmdir

Any thoughts about v2?

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
