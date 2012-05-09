Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SS4OK-0002n3-Dz
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 10:45:08 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SS4OG-0007qD-DJ
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 10:45:08 +0000
Date: Wed, 09 May 2012 06:44:57 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1f5de57f-c0ed-4f60-b133-4de5e05cf4db@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4FAA4782.8040401@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] move_pages08: E2BIG was removed in 2.6.29
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net, "Jeffrey Burke" <jburke@redhat.com>
> Sent: Wednesday, 9 May, 2012 12:31:30 PM
> Subject: Re: [LTP] [PATCH] move_pages08: E2BIG was removed in 2.6.29

> Hi Jan,
> 
> I think it would be better to put it in setup() function (as we
> usually
> do the kvercmp in setup phase), and just use tst_brkm(TCONF. How do
> you
> think?

Looking at random syscall tests I see it usually in main()
before setup(), but I'm OK with putting it to setup().
I'll send v2 for both.

Regards,
Jan

> 
> Thanks,
> Caspar

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
