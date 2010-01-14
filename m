Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sakoman@gmail.com>) id 1NVTJL-0007NW-VI
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 17:16:43 +0000
Received: from mail-qy0-f194.google.com ([209.85.221.194])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVTJL-0000gi-33
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 17:16:43 +0000
Received: by qyk32 with SMTP id 32so4110223qyk.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Jan 2010 09:16:35 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 14 Jan 2010 09:16:34 -0800
Message-ID: <5e088bd91001140916n6b6d9979m3847be14d86c7920@mail.gmail.com>
From: Steve Sakoman <sakoman@gmail.com>
Subject: [LTP] ltp on OMAP3 embedded linux systems
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

I've just begun working with ltp on an embedded linux platform
(OMAP3530, 256MB RAM, 8GB flash rootfs, ethernet, linux 2.6.32)

I'm using the December 2009 Stable version of ltp.

There was really only one glitch in the build process (looking for
libraries in an odd location) and I am now in the process of running
the test.

I've found it necessary to disable a few tests because of hangs or
running out of memory (all of the clone syscall tests, msgctl10 and
11, pipeio_5 and hackbench01)

Is this typical for limited resource machines?

The test is still running.  Most tests are passing but there are more
failures than I would like to see.  Should I expect all of the tests
to pass on a machine like this?

Regards,

Steve

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
