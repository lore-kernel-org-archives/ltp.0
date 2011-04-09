Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q8RVD-0004XL-W3
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 06:18:36 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q8RVD-0007Gj-A9
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 06:18:35 +0000
Received: by pwj9 with SMTP id 9so2241224pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 08 Apr 2011 23:18:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3b84dec9459d115647f5e49c6b2f0b8623f5dcfe.1302319401.git.czhang@redhat.com>
References: <06e447138f8f007517bb5c09cd96ffd4804a95d5.1302319401.git.czhang@redhat.com>
	<3b84dec9459d115647f5e49c6b2f0b8623f5dcfe.1302319401.git.czhang@redhat.com>
Date: Fri, 8 Apr 2011 23:18:29 -0700
Message-ID: <BANLkTimT9NM3jkQwzRzcUoA6RSz1yH5ULA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2 2/2] [mm] mbind01: move to syscalls directory
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
> there are 2 mbind01 tests in different place: syscalls/ and mem/, after
> installation, the latter one would cover the former one, and it's not
> convenient for maintenance. So I move it to syscalls/ and changed its
> name to mbind02.

    This is getting bikeshed-y -- but does it really matter where this
stuff is located? I mean.. it's not like one is actually testing the
syscall in this application; he/she is testing a corner case of the
syscall to ensure that it doesn't blow out in a way that creates the
issue that prompted the mainline kernel.org fix.
    I really didn't care that much when I committed it as either
location is not ideal. Given the number of CVE reproducers in the tree
now, there should be a separate section like regression, or security
to go over these regression tests in more detail, or at least in a way
that's easy to comprehend and deal with.
Thanks,
-Garrett

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
