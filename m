Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MgxiR-0007C5-Mj
	for Ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 09:25:51 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 29vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MgxiO-0004qO-NT
	for Ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 09:25:51 +0000
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by pophost.sonytel.be (Postfix) with ESMTP id 1B9F344483
	for <Ltp-list@lists.sourceforge.net>;
	Fri, 28 Aug 2009 11:25:43 +0200 (CEST)
Date: Fri, 28 Aug 2009 11:25:43 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Message-ID: <alpine.LRH.2.00.0908281125160.31615@vixen.sonytel.be>
MIME-Version: 1.0
Subject: [LTP] [PATCH] sched_cli_serv: Wait a bit before trying to connect
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linux Test Project <Ltp-list@lists.sourceforge.net>

The sched_cli_serv test launches the server in the background and expects
the client to be able to connect to it immediately. Depending on (earlier)
system load, that may fail.
Wait a bit before starting the client.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 testcases/kernel/sched/clisrv/run_sched_cliserv.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/sched/clisrv/run_sched_cliserv.sh b/testcases=
/kernel/sched/clisrv/run_sched_cliserv.sh
index 68176c4..f063ebd 100755
--- a/testcases/kernel/sched/clisrv/run_sched_cliserv.sh
+++ b/testcases/kernel/sched/clisrv/run_sched_cliserv.sh
@@ -1,6 +1,7 @@
 #!/bin/sh -x
 =

 pthserv &
+sleep 5
 pthcli 127.0.0.1 $LTPROOT/testcases/bin/data
 clientCode=3D$?
 killall pthserv
-- =

1.6.2.4

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
