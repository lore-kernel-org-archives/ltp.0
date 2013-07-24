Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vitti570@gmail.com>) id 1V1rnf-0005IR-TH
	for ltp-list@lists.sourceforge.net; Wed, 24 Jul 2013 05:39:47 +0000
Received: from mail-wg0-f43.google.com ([74.125.82.43])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V1rne-00023p-1s
	for ltp-list@lists.sourceforge.net; Wed, 24 Jul 2013 05:39:47 +0000
Received: by mail-wg0-f43.google.com with SMTP id z12so2627533wgg.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Jul 2013 22:39:39 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 24 Jul 2013 07:39:39 +0200
Message-ID: <CALuM2ALAOheiEA71A_=YuRqMeCAyBBe+kgHmVvOzcUd7+4kP1w@mail.gmail.com>
From: Vitti <vitti570@gmail.com>
Subject: [LTP] Two C issues with ltp-full-20130503
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
To: ltp-list@lists.sourceforge.net

In ltp-full-20130503 chmod02.c line 190 I believe that &buf should be just buf.
This is because buf, declared at line 128, is already a pointer
to the string "file contents\n" and the system function write
requires as its second argument a pointer to the buffer to be written
to the file "tfile".
By looking to tfile I found that with &buf I got unreadable data
while with buf I got "file contents" as it should be.

In sigrelse01.c line 646 the function write_pipe attempts to write
MAXMESG bytes from its second argument to the pipe.
MAXMESG is declared as 512 at line 149.
At line 291 write_pipe is called with READY as the buffer pointer.
READY is defined at line 151 as the string "ready".
"ready" is only six bytes long, including the null at its end,
while write_pipe attempts to transfer 512 bytes.
I think this is questionable because nobody knows the contents of the
other 506 bytes, you may even get a segmentation fault
because the data area is shorter, depending on the implementation.

I believe my comments are implementation independent,
anyway I have an x86-64, with Fedora 19 and gcc 4.8.1.
Best regards
Vittorio

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
