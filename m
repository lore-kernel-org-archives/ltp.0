Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PY83b-0003Fl-9w
	for ltp-list@lists.sourceforge.net; Thu, 30 Dec 2010 02:15:59 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PY83a-0005He-Hh
	for ltp-list@lists.sourceforge.net; Thu, 30 Dec 2010 02:15:59 +0000
Received: by iwn8 with SMTP id 8so10648618iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Dec 2010 18:15:53 -0800 (PST)
From: Garrett Cooper <yanegomi@gmail.com>
Date: Sun, 26 Dec 2010 15:34:52 -0800
Message-Id: <F5A66950-5708-425F-A254-4483F29CA0F0@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Subject: [LTP] realtime lookup_pi_state potential bug concerns
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
To: dvhltc@ibm.com
Cc: "ltp-list@lists.sourceforge.net List" <ltp-list@lists.sourceforge.net>

Reading through some of the comments about CS, MS, whatever, the code looks extremely questionable. Can someone from IBM look at that code and fix it please or delete the comments if they're not applicable anymore?
Thanks,
-Garrett
------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
