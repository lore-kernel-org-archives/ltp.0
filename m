Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <michal.simek@petalogix.com>) id 1RFjbD-0003lW-3p
	for ltp-list@lists.sourceforge.net; Mon, 17 Oct 2011 09:35:11 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RFjb7-0007sB-Dm
	for ltp-list@lists.sourceforge.net; Mon, 17 Oct 2011 09:35:11 +0000
Received: by bkat8 with SMTP id t8so7278568bka.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Oct 2011 02:34:58 -0700 (PDT)
Message-ID: <4E9BF106.8000906@petalogix.com>
Date: Mon, 17 Oct 2011 11:10:30 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] lseek03 - v3.1-rc1
Reply-To: michal.simek@petalogix.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi,

I see that there is problem with lseek03 test case caused by
kernel commit =93fs: add SEEK_HOLE and SEEK_DATA flags=93 (sha1: 982d816581=
eeeacfe5b2b7c6d47d13a157616eff).
It was added to kernel in v3.1 merge window.

Can someone confirm the test failure?

Thanks,
Michal


-- =

Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

---------------------------------------------------------------------------=
---
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
