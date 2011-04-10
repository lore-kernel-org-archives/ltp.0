Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q8n3g-0001d7-5g
	for ltp-list@lists.sourceforge.net; Sun, 10 Apr 2011 05:19:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q8n3f-00012T-Av
	for ltp-list@lists.sourceforge.net; Sun, 10 Apr 2011 05:19:36 +0000
Message-ID: <4DA13DD5.4060202@redhat.com>
Date: Sun, 10 Apr 2011 13:19:17 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <06e447138f8f007517bb5c09cd96ffd4804a95d5.1302319401.git.czhang@redhat.com>	<3b84dec9459d115647f5e49c6b2f0b8623f5dcfe.1302319401.git.czhang@redhat.com>
	<BANLkTimT9NM3jkQwzRzcUoA6RSz1yH5ULA@mail.gmail.com>
In-Reply-To: <BANLkTimT9NM3jkQwzRzcUoA6RSz1yH5ULA@mail.gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/09/2011 02:18 PM, Garrett Cooper wrote:
> This is getting bikeshed-y -- but does it really matter where this
> stuff is located? I mean.. it's not like one is actually testing the
> syscall in this application; he/she is testing a corner case of the
> syscall to ensure that it doesn't blow out in a way that creates the
> issue that prompted the mainline kernel.org fix.
>     I really didn't care that much when I committed it as either
> location is not ideal. Given the number of CVE reproducers in the tree
> now, there should be a separate section like regression, or security
> to go over these regression tests in more detail, or at least in a way
> that's easy to comprehend and deal with.

I agree with that either location is not ideal, but looked at existed
testcases, some similar regression testcases are put together under
syscalls/: mmap10, mmap11, mlock04, etc. At least doing so makes the
maintenance easier and produces less confusions (in mbind case, there
were two mbind01 tests, obviously when you install whole LTP testcases,
there will be only one exist, the other one is covered).

Creating a 'regression' dir under mem/ and moving mmap10, mmap11,
mlock04, mbind01 tests there may be a good choice. But how to name these
testcases? I don't want to see it happens again like two "XXX01" tests
exist in LTP, to avoid so, the new testcase writer should look into all
testcases and then give a different number suffix...

Thanks,
Caspar

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
