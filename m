Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <martin.r.persson@gmail.com>) id 1MyOpo-0007St-2b
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 11:49:32 +0000
Received: from mail-ew0-f211.google.com ([209.85.219.211])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyOph-0003sw-M8
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 11:49:32 +0000
Received: by ewy7 with SMTP id 7so419774ewy.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Oct 2009 04:49:19 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 15 Oct 2009 13:49:19 +0200
Message-ID: <c651035e0910150449p2792fc3eu653719afe4c354b4@mail.gmail.com>
From: Martin Persson <martin.r.persson@gmail.com>
Subject: [LTP] LTP - usage of DESTDIR instead of relative paths
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0555630762378870288=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0555630762378870288==
Content-Type: multipart/alternative; boundary=00504502c8819cac970475f7dea0

--00504502c8819cac970475f7dea0
Content-Type: text/plain; charset=ISO-8859-1

Hi

I wonder if you plan to update the Makefiles in LTP in order to use
$(DESTDIR) instead of relative "install paths"?

I.e. update from:
install:
    @set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done

to:
install:
    @set -e; for i in $(TARGETS); do ln -f $$i $(DESTDIR)/$$i ; done

I'm only interested in /testcases/kernel/syscalls for now, so I could do it
myself and send a "patch". If so, how shuold I do this in order to make it
as easy as possible for you guys to integrate?

BR
Martin Persson

--00504502c8819cac970475f7dea0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<br><br>I wonder if you plan to update the Makefiles in LTP in order to u=
se $(DESTDIR) instead of relative &quot;install paths&quot;?<br>
<br>I.e. update from:<br>install:<br>=A0=A0=A0 @set -e; for i in $(TARGETS)=
; do ln -f $$i ../../../bin/$$i ; done<br><br>to:<br>install:<br>=A0=A0=A0 =
@set -e; for i in $(TARGETS); do ln -f $$i $(DESTDIR)/$$i ; done<br><br>I&#=
39;m only interested in /testcases/kernel/syscalls for now, so I could do i=
t myself and send a &quot;patch&quot;. If so, how shuold I do this in order=
 to make it as easy as possible for you guys to integrate?<br>
<br>BR<br>Martin Persson<br>

--00504502c8819cac970475f7dea0--


--===============0555630762378870288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============0555630762378870288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0555630762378870288==--

