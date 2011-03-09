Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PxAMI-0002Zg-VR
	for ltp-list@lists.sourceforge.net; Wed, 09 Mar 2011 03:46:46 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PxAMH-0003Fk-Tt
	for ltp-list@lists.sourceforge.net; Wed, 09 Mar 2011 03:46:46 +0000
Received: by wwj40 with SMTP id 40so145642wwj.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 08 Mar 2011 19:46:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110309033747.GA4731@hpt.nay.redhat.com>
References: <20110309033747.GA4731@hpt.nay.redhat.com>
Date: Tue, 8 Mar 2011 19:46:39 -0800
Message-ID: <AANLkTingdN-GrnRJ6yQ-qRw-OasXLquVZsaY5B0wQd=q@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Per-NUMA control of huge pages
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
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net

On Tue, Mar 8, 2011 at 7:37 PM, Han Pingtian <phan@redhat.com> wrote:
> There are two new features of hugetlb related to NUMA:
> Interaction of Task Memory Policy with Huge Page Allocation/Freeing and
> Per Node Hugepages Attributes. Please refer to
> Documentation/vm/hugetlbpage.txt in kernel source for details. This
> patch try to verify those two features in numa's test.

Use portable shell please.
Thanks,
-Garrett

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
