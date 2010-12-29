Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <violetleigh@gmail.com>) id 1PXsRh-0003CW-MI
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:49 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PXsRg-0004WV-Rh
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:49 +0000
Received: by mail-gw0-f47.google.com with SMTP id a12so1779203gwa.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Dec 2010 01:35:48 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 29 Dec 2010 17:35:48 +0800
Message-ID: <AANLkTi=qFxgs4CPQ2EUwHin1LTgxw0V-RENPV9rRqraF@mail.gmail.com>
From: Vivi <violetleigh@gmail.com>
Subject: [LTP]  [Bug Fix] utimensat01 can't build
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3367984293306585767=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP mailing list <ltp-list@lists.sourceforge.net>

--===============3367984293306585767==
Content-Type: multipart/alternative; boundary=0016e644cf8a5640810498894b92

--0016e644cf8a5640810498894b92
Content-Type: text/plain; charset=ISO-8859-1

LTP test case utimensat01.c can't build without file usctest.h.

Bellow is the patch:
--
Index: testcases/kernel/syscalls/utimensat/utimensat01.c
===================================================================
--- testcases/kernel/syscalls/utimensat/utimensat01.c   (revision 161)
+++ testcases/kernel/syscalls/utimensat/utimensat01.c   (revision 183)
@@ -40,6 +40,7 @@
 #include <string.h>
 #include <sys/stat.h>
 #include <test.h>
+#include "usctest.h"
 #include "linux_syscall_numbers.h"

 char *TCID = "utimensat01";    /* Test program identifier.    */
--



Best regards,
Vivi Li

--0016e644cf8a5640810498894b92
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

LTP test case utimensat01.c can&#39;t build without file usctest.h.<br><br>=
Bellow is the patch:<br>--<br>Index: testcases/kernel/syscalls/utimensat/ut=
imensat01.c<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>

--- testcases/kernel/syscalls/utimensat/utimensat01.c=A0=A0 (revision 161)<=
br>+++ testcases/kernel/syscalls/utimensat/utimensat01.c=A0=A0 (revision 18=
3)<br>@@ -40,6 +40,7 @@<br>=A0#include &lt;string.h&gt;<br>=A0#include &lt;=
sys/stat.h&gt;<br>

=A0#include &lt;test.h&gt;<br>+#include &quot;usctest.h&quot;<br>=A0#includ=
e &quot;linux_syscall_numbers.h&quot;<br><br>=A0char *TCID =3D &quot;utimen=
sat01&quot;;=A0=A0=A0 /* Test program identifier.=A0=A0=A0 */<br>--<br><br>=
<br><br>Best regards,<br>

Vivi Li

--0016e644cf8a5640810498894b92--


--===============3367984293306585767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============3367984293306585767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3367984293306585767==--

