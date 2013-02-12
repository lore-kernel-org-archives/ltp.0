Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bogdan.purcareata@gmail.com>) id 1U5FIx-00039P-Uc
	for ltp-list@lists.sourceforge.net; Tue, 12 Feb 2013 12:49:47 +0000
Received: from mail-lb0-f181.google.com ([209.85.217.181])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1U5FIw-0002Rv-Ln
	for ltp-list@lists.sourceforge.net; Tue, 12 Feb 2013 12:49:47 +0000
Received: by mail-lb0-f181.google.com with SMTP id gm6so97509lbb.26
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Feb 2013 04:49:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAZGUZdwKLu=b14tV5XiuArAcN1o9ENEpc=Vyw+jdP6_CUzeog@mail.gmail.com>
References: <CAAZGUZdwKLu=b14tV5XiuArAcN1o9ENEpc=Vyw+jdP6_CUzeog@mail.gmail.com>
Date: Tue, 12 Feb 2013 14:49:39 +0200
Message-ID: <CAAZGUZfwzVLPd6HesN26c4uL=ZTug9f-axrkcxHGRveqsjnjyA@mail.gmail.com>
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
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
