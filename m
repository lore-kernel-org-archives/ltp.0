Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q8QsV-00036r-2b
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 05:38:35 +0000
Received: from mail-px0-f174.google.com ([209.85.212.174])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q8QsR-0001en-32
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 05:38:35 +0000
Received: by pxi15 with SMTP id 15so2061573pxi.33
	for <ltp-list@lists.sourceforge.net>;
	Fri, 08 Apr 2011 22:38:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <06e447138f8f007517bb5c09cd96ffd4804a95d5.1302319401.git.czhang@redhat.com>
References: <06e447138f8f007517bb5c09cd96ffd4804a95d5.1302319401.git.czhang@redhat.com>
Date: Fri, 8 Apr 2011 22:38:24 -0700
Message-ID: <BANLkTi=b=n56Ef8HGDF4drXLWm9RXvOH1g@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2 1/2] [mm] mbind01: not working on 32bit systems
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Fri, Apr 8, 2011 at 8:24 PM, Caspar Zhang <czhang@redhat.com> wrote:
>
> when executing mem/mbind01 testcase under 32bit systems, it returns
> ENOSYS error, indicating that the test is not suitable for running on
> 32bit systems. This patch checks wordsize before executing the actual
> case.

    This error doesn't make sense; it's not documented in the manpage [1].
    Are you sure your system actually supports mbind(2)?
Thanks,
-Garrett

1. http://www.kernel.org/doc/man-pages/online/pages/man2/mbind.2.html

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
