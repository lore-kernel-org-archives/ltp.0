Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1OlPFA-00008h-Sx
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 16:42:32 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlPF8-0002AC-Kv
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 16:42:32 +0000
Received: by fxm6 with SMTP id 6so4588145fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 09:42:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimurpbzZtn50_UNh0SRWsBPNWDcCYpbinNPH4Gj@mail.gmail.com>
References: <4C6AB19B.6060706@redhat.com>
	<AANLkTimurpbzZtn50_UNh0SRWsBPNWDcCYpbinNPH4Gj@mail.gmail.com>
Date: Tue, 17 Aug 2010 12:42:24 -0400
Message-ID: <AANLkTikdoWmHJT0-J_tSEar1698-_pO9mepCZp27ZWnZ@mail.gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [LTP] running LTP on uClinux
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
Cc: dmarlin@redhat.com, ltp-list <ltp-list@lists.sourceforge.net>

On Tue, Aug 17, 2010 at 12:31 PM, Garrett Cooper wrote:
> It should be CPPFLAGS, and the definition should be in env_post.mk; I
> never had a UCLINUX infrastructure to test with, so this might have
> fallen between the cracks by accident about 8 months ago.

building for a nommu target should work even when you're running a mmu
toolchain for an mmu target.  the testcases simply assume things like
fork() wont work and so fall back to ones that work in both places
(like vfork).  the tests should be able to run & pass even with a mmu.

> Let me know how this patch works for you.

the logic in lib/Makefile should be unified with this
-mike

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
