Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1Oqahl-0005up-G3
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 23:57:29 +0000
Received: from mail-qy0-f175.google.com ([209.85.216.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oqahk-0003RL-It
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 23:57:29 +0000
Received: by qyk31 with SMTP id 31so50839qyk.13
	for <ltp-list@lists.sourceforge.net>;
	Tue, 31 Aug 2010 16:57:23 -0700 (PDT)
MIME-Version: 1.0
From: Henry Yei <hyei@mvista.com>
Date: Tue, 31 Aug 2010 16:57:03 -0700
Message-ID: <AANLkTikan_6LjsZeG0E2pohutyxmx+WtKM6M-J3e=A4=@mail.gmail.com>
Subject: [LTP] [PATCH] [commands] apply relevant fixes from at_deny01 to
 at_allow01 script
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

I've prepared a patch for at_allow01 that essentially duplicates the
fixes that were checked in for at_deny01. This fixes the script to
actually run the test when the at utility in stead of returning TCONF,
correcting test environment, and let the script run normally without
changing the password. See commit
a589d12b0b49287d10f43b1a1fb72950819588eb for more details.

Signed-off-by: Henry Yei <hyei@mvista.com>

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
