Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hakehuang@gmail.com>) id 1QbqQp-0000Dw-7A
	for ltp-list@lists.sourceforge.net; Wed, 29 Jun 2011 08:47:35 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QbqQo-00057t-Jr
	for ltp-list@lists.sourceforge.net; Wed, 29 Jun 2011 08:47:35 +0000
Received: by gxk3 with SMTP id 3so514799gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jun 2011 01:47:29 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 29 Jun 2011 16:47:29 +0800
Message-ID: <BANLkTikouZoRvPEB_1qyRCES+=qotQjXMA@mail.gmail.com>
From: hake huang <hakehuang@gmail.com>
Subject: [LTP] about kill child when a case is suspected in dead loop
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

Hi Sirs,

Does anyone have idea about LTP reactions to a dead loop cases? I see
there are runtime (-h) setting in runltp but what if I want to kill
only a dead case not the whole test task?

Regards,

Hake

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
