Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1T6efQ-0001Fe-7e
	for ltp-list@lists.sourceforge.net; Wed, 29 Aug 2012 09:34:32 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1T6efP-0003Vy-B3
	for ltp-list@lists.sourceforge.net; Wed, 29 Aug 2012 09:34:32 +0000
Received: by pbcwy7 with SMTP id wy7so746150pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Aug 2012 02:34:25 -0700 (PDT)
Message-ID: <503DE20A.8010200@casparzhang.com>
Date: Wed, 29 Aug 2012 17:34:02 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
Subject: [LTP] hugemmap02/03?
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
To: LTP List <ltp-list@lists.sourceforge.net>

I looked into hugemmap02 and hugemmap03, they were about huge maping in 
high region/low region. After checked the codes, I don't think they're 
well-implmented, or even worse, I don't think the tests make too much 
sense. I don't know mmap regions very well, is there any other comments 
against these two cases?

Caspar

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
