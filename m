Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q9LuA-00012Y-3l
	for ltp-list@lists.sourceforge.net; Mon, 11 Apr 2011 18:32:06 +0000
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by sog-mx-4.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q9Lu9-00018k-8s
	for ltp-list@lists.sourceforge.net; Mon, 11 Apr 2011 18:32:06 +0000
Received: from cf--amer001e--3.americas.sgi.com
	(cf--amer001e--3.americas.sgi.com [137.38.100.5])
	by relay1.corp.sgi.com (Postfix) with ESMTP id F1D138F804B
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Apr 2011 11:31:59 -0700 (PDT)
From: Alex Elder <aelder@sgi.com>
Date: Mon, 11 Apr 2011 13:31:36 -0500
Message-ID: <1302546696.2580.25.camel@doink>
Mime-Version: 1.0
Subject: [LTP] [PATCH 0/3, v2] ltp: eliminate more build warnings
Reply-To: aelder@sgi.com
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

I think I have addressed the concerns raised by
Garrett Cooper for the following three patches.

My original intent was to provide fairly simple
fixes to these build warnings.  This code appears
to be quite old and could really benefit from a
some more comprehensive updating, but that is
well beyond the scope of what I'm trying to do.

Nevertheless, Garrett's suggestions were quite
valid so I did what I could to address them.

					-Alex


------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
