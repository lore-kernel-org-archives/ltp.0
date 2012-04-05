Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFbBF-0005ka-Lh
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 01:08:05 +0000
Received: from mail-vb0-f47.google.com ([209.85.212.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFbBF-0004ne-2b
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 01:08:05 +0000
Received: by vbbfr13 with SMTP id fr13so1113646vbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Apr 2012 18:07:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1333587726-8962-1-git-send-email-penght@cn.fujitsu.com>
References: <1333587726-8962-1-git-send-email-penght@cn.fujitsu.com>
Date: Wed, 4 Apr 2012 18:07:59 -0700
Message-ID: <CAGH67wRCFcJO8Nhz+at-6MTGJAqqm0JGBRQEuj=hpAxhcdKZRw@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] at_deny01: fix a bug of /etc/init.d/atd is
	nonexistent
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Apr 4, 2012 at 6:02 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> /etc/init.d/atd is nonexistent in fedora16, so should use systemctl.
>
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

Reviewed-by: Garrett Cooper <yanegomi@gmail.com>

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
