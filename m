Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maxin.john@gmail.com>) id 1NiBSb-0004fB-Qd
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 18:50:49 +0000
Received: from mail-px0-f201.google.com ([209.85.216.201])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NiBSb-0005Je-0q
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 18:50:49 +0000
Received: by pxi40 with SMTP id 40so1189225pxi.22
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Feb 2010 10:50:42 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 19 Feb 2010 00:20:41 +0530
Message-ID: <9debc4411002181050u1a041f7cm72ed35337513834c@mail.gmail.com>
From: Maxin John <maxin.john@gmail.com>
Content-Type: multipart/mixed; boundary=0016368e23e091a230047fe471c9
Subject: [LTP] [PATCH] fix for 'stress_floppy' not getting installed properly
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
To: ltp-list@lists.sourceforge.net

--0016368e23e091a230047fe471c9
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have tried to execute the 'io_floppy' test in  LTP Version:  LTP-20100131.1

maxin@maxin-laptop:/opt/ltp$ ./runltp -f io_floppy

This test failed since the 'stress_floppy' script was not installed properly.
Please find the below given log:
-----------------------------------------------------------
....
Running tests.......
<<<test_start>>>
tag=stress_floppy stime=1266516562
cmdline="export TCdat=$LTPROOT/testcases/kernel/io/stress_floppy; stress_floppy"
contacts=""
analysis=exit
<<<test_output>>>
sh: stress_floppy: not found
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=127 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20100131.1

       ###############################################################"

            Done executing testcases."
            LTP Version:  LTP-20100131.1
       ###############################################################"
-----------------------------------------------------------

Attached patch(stress_floppy_Makefile.patch) fixes Makefile and the
'stress_floppy' script gets installed properly.

-----------------------------------------------------------
Running tests.......
<<<test_start>>>
tag=stress_floppy stime=1266518427
cmdline="export TCdat=$LTPROOT/testcases/kernel/io/stress_floppy; stress_floppy"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
Testing format...
/dev/fd0: No such file or directory
Format failed!
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20100131.1
-----------------------------------------------------------

Well, after applying this patch, the 'io_floppy' test fails successfully :)
(Expected failure as I don't have a floppy drive)

Signed-off-by: Maxin B. John <maxin.john@gmail.com>

--
Warm Regards,
Maxin B. John
www.maxinbjohn.info

--0016368e23e091a230047fe471c9
Content-Type: text/x-patch; charset=US-ASCII;
	name="stress_floppy_Makefile.patch"
Content-Disposition: attachment; filename="stress_floppy_Makefile.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5tvvdnh0

ZGlmZiAtdU5yIGx0cC1mdWxsLTIwMTAwMTMxLjEtb3JpZy90ZXN0Y2FzZXMva2VybmVsL2lvL3N0
cmVzc19mbG9wcHkvTWFrZWZpbGUgbHRwLWZ1bGwtMjAxMDAxMzEuMS90ZXN0Y2FzZXMva2VybmVs
L2lvL3N0cmVzc19mbG9wcHkvTWFrZWZpbGUKLS0tIGx0cC1mdWxsLTIwMTAwMTMxLjEtb3JpZy90
ZXN0Y2FzZXMva2VybmVsL2lvL3N0cmVzc19mbG9wcHkvTWFrZWZpbGUJMjAwOS0xMC0wOSAyMzoy
NTo0OC4wMDAwMDAwMDAgKzA1MzAKKysrIGx0cC1mdWxsLTIwMTAwMTMxLjEvdGVzdGNhc2VzL2tl
cm5lbC9pby9zdHJlc3NfZmxvcHB5L01ha2VmaWxlCTIwMTAtMDItMTggMjM6NTE6NDIuMDAwMDAw
MDAwICswNTMwCkBAIC0yNCw2ICsyNCw4IEBACiAKIElOU1RBTExfREVQUwkJOj0gZHVtcGRpciAK
IAorSU5TVEFMTF9UQVJHRVRTCQk6PSBzdHJlc3NfZmxvcHB5IAorCiBNQUtFX1RBUkdFVFMJCTo9
CiAKICMgZHVtcGRpcidzIGEgZGlyZWN0b3J5Lgo=
--0016368e23e091a230047fe471c9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--0016368e23e091a230047fe471c9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016368e23e091a230047fe471c9--

