Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MNw7G-0002tB-Sa
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 21:52:50 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNw7A-0001IJ-IL
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 21:52:50 +0000
Received: by yxe33 with SMTP id 33so5163944yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 14:52:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8368651DACC1964480F951191B94A078D0102F@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078D0102F@svexch01.mvista.com>
Date: Mon, 6 Jul 2009 14:52:42 -0700
Message-ID: <364299f40907061452k598a0890kbac3ec9742b45ad8@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] controllers/cpuset tests: use CC variable isntead
	of hardcoded cc to fix cross compiling
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Jul 6, 2009 at 2:34 PM, Henry Yei<hyei@mvista.com> wrote:
> I am submitting patches for the Makefiles of the following tests: cpuset_memory_pressure_test, cpuset_memory_spread_test , and cpuset_memory_test. Instead of using cc (host compiler), use $(CC) for provide for cross compiling.

Just delete:

+	$(CC) cpuset_memory_test.o $(LIBOBJECTS) -o cpuset_memory_test -lpthread

implicit rules will take care of the rest.

-Garrett

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
