Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huruomu@gmail.com>) id 1R8C4c-0003OA-Fa
	for ltp-list@lists.sourceforge.net; Mon, 26 Sep 2011 14:22:22 +0000
Received: from mail-yi0-f47.google.com ([209.85.218.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1R8C4b-0001R4-Td
	for ltp-list@lists.sourceforge.net; Mon, 26 Sep 2011 14:22:22 +0000
Received: by yia27 with SMTP id 27so5446727yia.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Sep 2011 07:22:16 -0700 (PDT)
Message-ID: <4E808A86.3020403@gmail.com>
Date: Mon, 26 Sep 2011 22:21:58 +0800
From: Romu Hu <huruomu@gmail.com>
MIME-Version: 1.0
Subject: [LTP] msgctl11 TBROK Not enough free pids
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

Hi,

msgctl11 in ltp-20110915 failed on 2.6.39 kernel:

msgctl11    1  TBROK  :  Not enough free pids

I found that before error out,

MSGMNI is 32768
MAXNKIDS is 10
free_pids is 32611
maxnkids = ((free_pids / 4) / MSGMNI);
so maxnkids is zero, which is why msgctl11 failed.

Is this problem of testcase or problem of the tested system?

Thanks

-- 
Regards,
Romu


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
