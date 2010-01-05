Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <brianzhang2007@gmail.com>) id 1NS561-00055D-NR
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 08:48:57 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NS560-0002wL-C7
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 08:48:57 +0000
Received: by pwj11 with SMTP id 11so10858594pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 05 Jan 2010 00:48:48 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 5 Jan 2010 01:48:48 -0700
Message-ID: <7d5af59c1001050048q23e24f5fu18955c7884378d9e@mail.gmail.com>
From: Yongjian Zhang <brianzhang2007@gmail.com>
Subject: [LTP] err msg: FATAL: Test suite not installed correctly
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hi all,
I have just downloaded the latest source code=A0ltp-full-20091130.tgz
and compiled and installed using:

./configure
sudo make all
sudo make install

No error was spotted.

But I don't see many files under the /opt/ltp folder and the following
error messages appear whenever I run "runltp".

FATAL: Test suite not installed correctly
INFO: as root user type 'make ; make install'

I have tried "make clean" and installed again but it still did not work.

My OS is ubuntu 9.04 desktop. I had installed an older version of ltp
using the software source of ubuntu but had it removed successfully
before I installed the new one.

Could anyone tell me how I can get ltp to run?

Thanks a lot!

Jack

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
