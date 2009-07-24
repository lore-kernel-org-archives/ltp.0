Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MUMko-0000SR-R1
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 15:32:14 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MUMkf-0003B4-OR
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 15:32:14 +0000
Received: by yxe33 with SMTP id 33so3172480yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 24 Jul 2009 08:31:59 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 24 Jul 2009 21:01:59 +0530
Message-ID: <f5a7b3810907240831t75a058a2m96abdc28a28c4365@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: [LTP] Char Limit issue on 2.6.29 kernels
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
To: linux-kernel@vger.kernel.org
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Oleg Nesterov <oleg@redhat.com>, tim.bird@am.sony.com, rohit.170309@gmail.com

Hi,

I have come across with char Limit issue on 2.6.29 kernels.


SIGFAULT:

#define SIZE            8053759
char buf1[SIZE] ;

NO SIGFAULT:

#define SIZE            8053758
char buf1[SIZE] ;

This SIGFAULT not observed on 2.6.23 kernels.

What could be the changes that effecting from 2.6.23 to 2.6.29 kernels.
Please share me the information.


Best regards,
Naresh Kamboju

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
