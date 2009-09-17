Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MoFNl-00080m-Dt
	for ltp-list@lists.sourceforge.net; Thu, 17 Sep 2009 11:42:37 +0000
Date: Thu, 17 Sep 2009 13:42:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090917114222.GA26142@schrodinger.suse.cz>
References: <20090909181541.GA31549@schrodinger.suse.cz>
	<1252847821.5357.39.camel@subratamodak.linux.ibm.com>
	<20090915142001.GA9600@schrodinger.suse.cz>
	<1253114228.6343.29.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <1253114228.6343.29.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] ftest cleanup II
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> > The previous patch had missing changes in Makefile and ftest04.c.
> > Fixed patch (that was tested on ltp cvs checkout) is attched.
> > 
> > Signed-off-by: Cyril Hrubis chrubis@suse.cz
> 
> This Fixes the earlier issues, but introduced a new one.
> 
> # make
> will work fine, but
> # make -j4
> will not,
> 
> because,
> 
> ltp/testcases/kernel/fs/ftest/libftest.o
> 
> may not have been created when:
> 
> # gcc ... libftest.o ftest01.c
> or,
> # gcc ... libftest.o ftest02.c
> 

Attached patch should fix this.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--IJpNTDwzlM2Ie8A6
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="ftest_makefile.patch"

Index: ltp/testcases/kernel/fs/ftest/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/Makefile
+++ ltp/testcases/kernel/fs/ftest/Makefile
@@ -22,12 +22,14 @@
 # description	: make(1) description file for the send(2) tests.	  #
 ###########################################################################
 CFLAGS+=	-I../../../../include -W -Wall -g
-LOADLIBES+=	-L../../../../lib libftest.o -lltp
+LOADLIBES+=	-L../../../../lib -lltp
 
 SRCS=$(wildcard ftest*.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
 
-all: libftest.o $(TARGETS)
+all: $(TARGETS)
+
+$(TARGETS): libftest.o
 
 install:
 	@set -e; for i in $(TARGETS) ; do ln -f $$i ../../../bin/$$i ; done ;

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--IJpNTDwzlM2Ie8A6--

