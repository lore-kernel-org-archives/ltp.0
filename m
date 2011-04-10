Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q8mIu-0005iD-U6
	for ltp-list@lists.sourceforge.net; Sun, 10 Apr 2011 04:31:16 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q8mIt-0006mI-QT
	for ltp-list@lists.sourceforge.net; Sun, 10 Apr 2011 04:31:16 +0000
Message-ID: <4DA13284.3090007@redhat.com>
Date: Sun, 10 Apr 2011 12:31:00 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <06e447138f8f007517bb5c09cd96ffd4804a95d5.1302319401.git.czhang@redhat.com>
	<BANLkTi=b=n56Ef8HGDF4drXLWm9RXvOH1g@mail.gmail.com>
In-Reply-To: <BANLkTi=b=n56Ef8HGDF4drXLWm9RXvOH1g@mail.gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/09/2011 01:38 PM, Garrett Cooper wrote:
>> > when executing mem/mbind01 testcase under 32bit systems, it returns
>> > ENOSYS error, indicating that the test is not suitable for running on
>> > 32bit systems. This patch checks wordsize before executing the actual
>> > case.
>     This error doesn't make sense; it's not documented in the manpage [1].
>     Are you sure your system actually supports mbind(2)?

Hmmm... Seems CONFIG_NUMA is not set in RHEL6 on x86 systems, so that
all mempolicy related syscalls not work on this platform. I shouldn't
simply check the WORDSIZE but need to check the kernel configuration
option, yet it's kind of difficult from previous discussion[1]...

Thanks,
Caspar

[1] http://thread.gmane.org/gmane.linux.ltp/12234/focus=12255

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
