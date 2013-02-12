Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bogdan.purcareata@gmail.com>) id 1U5E5N-0006EO-3D
	for ltp-list@lists.sourceforge.net; Tue, 12 Feb 2013 11:31:41 +0000
Received: from mail-la0-f41.google.com ([209.85.215.41])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1U5E5M-0003Jc-2Q
	for ltp-list@lists.sourceforge.net; Tue, 12 Feb 2013 11:31:41 +0000
Received: by mail-la0-f41.google.com with SMTP id fo12so6801975lab.14
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Feb 2013 03:31:33 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 12 Feb 2013 13:31:33 +0200
Message-ID: <CAAZGUZdwKLu=b14tV5XiuArAcN1o9ENEpc=Vyw+jdP6_CUzeog@mail.gmail.com>
From: Bogdan Purcareata <bogdan.purcareata@gmail.com>
Subject: [LTP] Running LTP on embedded Busybox platforms
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

Hello,

I'm a new user of the LTP and I was wondering if it works on embedded
platforms with custom Linux distros built with Yocto. I was interested
in the "containers" set of tests, particularly the network namespace
ones. I noticed the tests were not working properly on a Busybox
system, and I've identified some differences between this and running
LTP on my host Fedora 17 system (which works fine):
- Busybox's diff outputs in the unified format by default - this
causes parsing issues in LTP
- there is no sshd server on my embedded platform - instead I have
dropbear installed, and the scripts need minor changes to work
- the networking utils - ping, ip, etc. - are from the inetutils
package, instead if the expected iputils package

I was wondering if these requirements - diff, sshd, iputils package,
and others - are somewhere listed as prerequisites in the
documentation (I haven't searched it extensively). Where should I look
for a complete list of host userspace applications needed by LTP to
work?

Also, are there any branches of the LTP project designed to work with
e.g. Busybox by default? I noticed that the ltp-full-20130109.bz2
arhive is universal and has no mentions of supported host distro
configuration (or perhaps I didn't look in the right place?).

Thank you very much,
Bogdan P.

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
