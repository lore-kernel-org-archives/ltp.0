Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1OlSfR-0002qt-Be
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:21:53 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlSfQ-0003XJ-FW
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:21:53 +0000
Received: by fxm6 with SMTP id 6so4762123fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 13:21:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimTbSmbAf+sVJz6KsMxcYsg0Em6+1jrgcNLuDcF@mail.gmail.com>
References: <4C6AD62B.2010905@redhat.com>
	<AANLkTimTbSmbAf+sVJz6KsMxcYsg0Em6+1jrgcNLuDcF@mail.gmail.com>
Date: Tue, 17 Aug 2010 16:21:45 -0400
Message-ID: <AANLkTikyYz7wHceMA_CJ9TgXMmRp4EbNWzBRmx1vrCXS@mail.gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [LTP] problems building lchown02.c for uClinux
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
Cc: dmarlin@redhat.com, LTP list <ltp-list@lists.sourceforge.net>

On Tue, Aug 17, 2010 at 3:50 PM, Garrett Cooper wrote:
> It would help if
> there was a breakdown of what functionality is and isn't available in
> uclinux that's gating builds / testing (I honestly don't know right
> offhand what those pieces are).

it's not that hard, but maybe it's just because i'm used to it now.
some of the checks are outdated though.

i guess i could write up a small ltp guide for people who arent
familiar with nommu ...
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
