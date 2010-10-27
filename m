Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pev@sketchymonkey.com>) id 1PB3i6-00010N-EH
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 10:58:26 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB3i5-0005hr-Ip
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 10:58:26 +0000
Received: by ywo32 with SMTP id 32so282677ywo.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Oct 2010 03:58:20 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Oct 2010 11:52:38 +0100
Message-ID: <AANLkTikbzi44SibVCGa_yJZ0LryqzhiebgxVmPjLAbDb@mail.gmail.com>
From: David Peverley <pev@sketchymonkey.com>
Subject: [LTP] Realtime test filtered out
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

Hi all,

In the ltp-full-20100831 release the realtime test is filtered out.
This comes from the code in testcases/Makefile. This looks like :
   # XXX (garrcoop): Not sure why realtime is still in this list; this was the
   # original list of disabled items...
   # XXX (garrcoop): kdump was in this list.
   # XXX (garrcoop): open_hpi_testsuite was in this list.
   ifneq ($(UCLINUX),1)
   FILTER_OUT_DIRS         += audit-test DOTS realtime
   endif

This is filtering out the tests if NOT a uclinux build. Is this
correct or inverted? I'd assume realtime tests would be built as
standard but maybe not for uclinux? Also, I can't find the audit-tests
dir so I'm guessing this may be deprecated?

Cheers,

~Pev

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
