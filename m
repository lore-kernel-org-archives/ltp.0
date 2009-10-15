Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MyFRD-0001yw-Bl
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 01:47:31 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyFR9-0003ex-3c
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 01:47:31 +0000
Received: by pzk26 with SMTP id 26so329278pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 18:47:21 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 18:40:33 -0700
Message-ID: <364299f40910141840v4914215fjd6809284d6937c35@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [issue 16] aiodio looking for non-existent file
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
To: LTP list <ltp-list@lists.sourceforge.net>

<output test="ltp-aiodio.part3 : FSX053">
/test/aiodio/junkfile: No such file or directory
</output>
<output test="ltp-aiodio.part3 : FSX052">
/test/aiodio/junkfile: No such file or directory
</output>
<output test="ltp-aiodio.part3 : FSX051">
/test/aiodio/junkfile: No such file or directory
</output>
<output test="ltp-aiodio.part3 : FSX050">
/test/aiodio/junkfile: No such file or directory
</output>
<output test="ltp-aiodio.part3 : FSX057">
/test/aiodio/junkfile: No such file or directory
</output>
<output test="ltp-aiodio.part3 : FSX056">
/test/aiodio/junkfile: No such file or directory
</output>
<output test="ltp-aiodio.part3 : FSX055">
/test/aiodio/junkfile: No such file or directory
</output>
<output test="ltp-aiodio.part3 : FSX054">
/test/aiodio/junkfile: No such file or directory
</output>

Thanks,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
