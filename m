Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<jbeckenbach=ltp-list=lists.sourceforge.net=jmtqtyzj@lancope.com>)
	id 1X9E8W-0001Yg-8O
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 14:00:16 +0000
Received: from smtp-out3.electric.net ([72.35.12.185])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X9E8U-0000OK-FZ
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 14:00:16 +0000
Received: from 1X9E8N-0008M5-VG by out3b.electric.net with emc1-ok (Exim
	4.80.1) (envelope-from <jbeckenbach@lancope.com>) id 1X9E8O-0008RY-TR
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 07:00:08 -0700
Received: from [209.182.184.2] (helo=LCHQEX03.lancope.local)
	by out3b.electric.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.80.1) (envelope-from <jbeckenbach@lancope.com>)
	id 1X9E8N-0008M5-VG
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 07:00:07 -0700
From: Joseph Beckenbach <jbeckenbach@lancope.com>
Date: Mon, 21 Jul 2014 14:00:06 +0000
Message-ID: <4506ACC2AE90484D87F9A883BA36C21C2ADF0458@LCHQEX03.lancope.local>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] Apparent trouble with HEAD of LTP
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

Hi, Cyril!

Ah, then autotools must be my issue.
I've got "autotools-dev-20120608.1" package installed, per dpkg-query on those boxes.
Must be something stuck in our local package-repo mirroring process;  maybe it's manual-only.

If we can figure out which version of autotools is fine, I suggest we document that in INSTALL
alongside putting the patch back in.

Thanks!

Joseph
Joseph Beckenbach, senior QA engineer : Automation  -- 470-299-7166
Lancope, Inc. -- makers of StealthWatch

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
