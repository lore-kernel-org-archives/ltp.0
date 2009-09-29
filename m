Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1Msdhj-0004TK-OE
	for ltp-list@lists.sourceforge.net; Tue, 29 Sep 2009 14:29:23 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Msdhd-0002JY-G3
	for ltp-list@lists.sourceforge.net; Tue, 29 Sep 2009 14:29:23 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 5794F126CAD6C
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Sep 2009 16:29:01 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314) id 1MsdhH-0002LZ-00
	for ltp-list@lists.sourceforge.net; Tue, 29 Sep 2009 16:28:56 +0200
Date: Tue, 29 Sep 2009 16:28:53 +0200
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
MIME-Version: 1.0
Message-ID: <op.u00vt9vju2flwt@debian>
Subject: [LTP] New test?
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hello,

I've decided to create a test for the rt_sigwaitinfo syscall. There are  
other functions with similar interface (defined by POSIX) in libc -  
particularly sigwait, sigtimedwait and sigwaitinfo. The rt_sigwaitinfo  
test could easily tests these too, so I wonder whether we want to test  
these too, and if yes, whether these tests can be located in the same  
executable.

Regards
     Jiri Palecek

-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
