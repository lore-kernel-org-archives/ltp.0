Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V46sP-0001tx-Nl
	for ltp-list@lists.sourceforge.net; Tue, 30 Jul 2013 10:09:57 +0000
Date: Tue, 30 Jul 2013 12:09:48 +0200
From: chrubis@suse.cz
Message-ID: <20130730100948.GD1184@rei.scz.novell.com>
References: <CALuM2ALAOheiEA71A_=YuRqMeCAyBBe+kgHmVvOzcUd7+4kP1w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALuM2ALAOheiEA71A_=YuRqMeCAyBBe+kgHmVvOzcUd7+4kP1w@mail.gmail.com>
Subject: Re: [LTP] Two C issues with ltp-full-20130503
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
To: Vitti <vitti570@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> In ltp-full-20130503 chmod02.c line 190 I believe that &buf should be just buf.
> This is because buf, declared at line 128, is already a pointer
> to the string "file contents\n" and the system function write
> requires as its second argument a pointer to the buffer to be written
> to the file "tfile".
> By looking to tfile I found that with &buf I got unreadable data
> while with buf I got "file contents" as it should be.

This test was rewritten (see commit 8a575d291217d366b6d1f04b5608d3258ebde9cf)

> In sigrelse01.c line 646 the function write_pipe attempts to write
> MAXMESG bytes from its second argument to the pipe.
> MAXMESG is declared as 512 at line 149.
> At line 291 write_pipe is called with READY as the buffer pointer.
> READY is defined at line 151 as the string "ready".
> "ready" is only six bytes long, including the null at its end,
> while write_pipe attempts to transfer 512 bytes.
> I think this is questionable because nobody knows the contents of the
> other 506 bytes, you may even get a segmentation fault
> because the data area is shorter, depending on the implementation.

That looks like a bug in the test to me, the write pipe should get
the size of the message as a parameter and use it for the write.
(And the test should be cleaned up too, there is too much useless
comments for example.)

Do you want to send a patch that fixes this one?
(signed patch against latest git is best way to go)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
