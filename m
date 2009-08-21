Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1MeSjt-0003Ru-HV
	for ltp-list@lists.sourceforge.net; Fri, 21 Aug 2009 11:57:01 +0000
Received: from smtp108.biz.mail.re2.yahoo.com ([206.190.52.47])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MeSjl-0004Yi-AZ
	for ltp-list@lists.sourceforge.net; Fri, 21 Aug 2009 11:57:01 +0000
Date: Fri, 21 Aug 2009 19:57:39 +0800 (CST)
Message-Id: <20090821.195739.1000278277145530969.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
Mime-Version: 1.0
Subject: [LTP] The Best Practice to Skip Syscall Tests
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
To: ltp-list@lists.sf.net

Hi,

Test cases unshare failed to compile on systems without such a
syscall. I am unsure what the best way to handle it. The old ways are,

* add a kernel version check in the unshare tests code.

or

* add a m4 rule.
* modify the unshare tests code to check if the macro, and add stub
  functions if the macro is false.

The first approach is unable to handle non-vanilla kernels. The second
approach needs to add stub functions which are unclean. What I would
like to do is,

* add a m4 rule.
* modify unshare Makefile like this,

  ifdef HAVE_UNSHARE  <-- if the syscall is present, compile the tests.

  CFLAGS += -I../../../../include -Wall
  LDLIBS += -L../../../../lib -lltp

  SRCS    = $(wildcard *.c)
  TARGETS = $(patsubst %.c,%,$(SRCS))

  all: $(TARGETS)

  install:
          @set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done

  else               <-- Otherwise, skip them.
  all:

However, I am not sure how to pass the HAVE_UNSHARE value to the
Makefile yet.

CAI Qian

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
