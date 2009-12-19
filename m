Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NLohI-0003fI-PW
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:05:32 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLohB-0001d3-Cc
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:05:32 +0000
Date: Sat, 19 Dec 2009 03:06:00 +0100
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
MIME-Version: 1.0
Message-ID: <op.u45xgah3u2flwt@debian>
Subject: [LTP] Patch from 4.11.
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hello,

in your patch from 4.11., "1. Use linux_syscall_numbers.h. 2. Fix a format  
string (use inttypes.h)....", there is:


@@ -174,7 +177,7 @@ void test_mbind(void)
  		ret = 1;
  		return;
  	}
-	printf("%lx\n", addr);
+	printf("%" __PRI64_PREFIX "x\n", (long) addr);
  	ret = mbind(addr, len, MPOL_BIND, &mask, 8 * sizeof(mask), 0);
  }

I am not happy with that, particularly:

1. You use a 64-bit format specifier, but pass a long. A long may not be  
64-bit, in which case the code is buggy.

2. You use __PRI64_PREFIX, which, as all underscore-prefixed names is an  
implementation detail of the library.

3. Why didn't use just printf("%p\n", addr), when addr is a void* and "p"  
is a format specifier for pointers.

Regards
     Jiri Palecek

-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
