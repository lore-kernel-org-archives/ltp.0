Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <benoit.marcot@arm.com>) id 1V0Bg2-0005gN-LT
	for ltp-list@lists.sourceforge.net; Fri, 19 Jul 2013 14:28:58 +0000
Received: from service88.mimecast.com ([195.130.217.12])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V0Bg0-000873-Nu
	for ltp-list@lists.sourceforge.net; Fri, 19 Jul 2013 14:28:58 +0000
From: Benoit Marcot <Benoit.Marcot@arm.com>
Date: Fri, 19 Jul 2013 15:28:48 +0100
Message-ID: <1C23526A7C42DB45BBF55B662C7C530E25B461FD20@BUNGLE.Emea.Arm.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP]  Where is defined TEST_ERRNO when 'make UCLINUX=1'?
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi,

I am building LTP for UCLINUX, and I went through an undefined symbol TEST_ERRNO with 'make UCLINUX=1'.

As far as I understand, making with 'UCLINUX=1' defines also _USC_LIB_ in lib/Makefile:

ifeq ($(UCLINUX),1)
CFLAGS                  += -D_USC_LIB_
endif

In include/usctest.h, if _USC_LIB_ is defined then TEST_ERRNO is declared as extern, hence still not defined:

#ifdef  _USC_LIB_
extern int TEST_ERRNO;
#else

Finally, the last place where TEST_ERRNO could be defined is in lib/parse_opts.c; if UNIT_TEST is somewhere defined:

#if UNIT_TEST
int TEST_ERRNO;
...

So my questions are: should I compile with CFLAGS += -DUNIT_TEST=1? How to use parse_opts.c?

Thanks,

--
Benoit Marcot


-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
