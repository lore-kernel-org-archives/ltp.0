Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lina.zhao@windriver.com>) id 1Oj7E0-0004bN-CD
	for ltp-list@lists.sourceforge.net; Wed, 11 Aug 2010 09:03:52 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Oj7Dw-0001Da-Ul
	for ltp-list@lists.sourceforge.net; Wed, 11 Aug 2010 09:03:52 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o7B93hxT010759
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Aug 2010 02:03:43 -0700 (PDT)
Message-ID: <4C626764.5030203@windriver.com>
Date: Wed, 11 Aug 2010 17:03:32 +0800
From: "lina.zhao" <lina.zhao@windriver.com>
MIME-Version: 1.0
Subject: [LTP] hugeshmat01 and hugeshmat02 issue
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
in hugeshmat01.c and hugeshmat02.c

#if __WORDSIZE==64
#define UNALIGNED      0x10000000eee
#else
#define UNALIGNED      0x90000eee
#endif

but for 32bits mips/Linux system, user space is under 0x7FFFFFFF, 
0x90000eee is too big for it.

regards,

Lina Zhao

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
