Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mwenzel@novell.com>) id 1NkLaV-000319-0z
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 18:03:55 +0000
Received: from sinclair.provo.novell.com ([137.65.248.137])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkLaT-0001Sa-KN
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 18:03:54 +0000
Message-Id: <4B8502D7020000E80005EEE6@sinclair.provo.novell.com>
Date: Wed, 24 Feb 2010 10:43:35 -0700
From: "Murlin Wenzel" <mwenzel@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part94BE5757.0__="
Subject: [LTP] [PATCH] swapon03 cleanup
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

--=__Part94BE5757.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This cleans up existing swap files in swapon03 test in failing test case.  =
Otherwise, deleted swap files would still exist in /proc/swaps.

Signed-off-by: Murlin Ray Wenzel mwenzel@novell.com


Murlin Ray Wenzel
Sr. Engineer
mwenzel@novell.com
Office: 801 861 5748
Cell: 801 380 4520

Novell
Making IT Work As One.
www.novell.com







--=__Part94BE5757.0__=
Content-Type: text/plain; name="swap03-cleanup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="swap03-cleanup.patch"

--- ltp-intermediate-20100228-orig/testcases/kernel/syscalls/swapon/swapon0=
3.c	2010-02-24 09:00:53.000000000 -0700=0A+++ ltp-intermediate-20100228=
/testcases/kernel/syscalls/swapon/swapon03.c	2010-02-24 09:02:56.0000000=
00 -0700=0A@@ -291,6 +291,8 @@=0A =0A 			/* turn on the =
swap file */=0A 			if ((res =3D syscall(__NR_swapon, =
filename, 0)) !=3D 0) {=0A+				/* Must clean up =
existing swap files since tst_brkm doesn't return*/=0A+				=
clean_swap();=0A 				tst_brkm(TFAIL | TERRNO, =
cleanup,=0A 					 "Failed swapon for file =
%s", filename);=0A 				/* must cleanup already =
swapon files */=0A
--=__Part94BE5757.0__=
Content-Type: application/octet-stream; name="Murlin Wenzel.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Murlin Wenzel.vcf"

QkVHSU46VkNBUkQNClZFUlNJT046Mi4xDQpQUk9ESUQ6LS8vTm92ZWxsIEluYy8vR3JvdXB3aXNl
IDguMC4xIA0KWC1HV1RZUEU6VVNFUg0KRk46TXVybGluIFdlbnplbA0KTjpXZW56ZWw7TXVybGlu
OztTci4gRW5naW5lZXINCkVNQUlMO0lOVEVSTkVUO1BSRUY6TVdFTlpFTEBub3ZlbGwuY29tDQpB
RFI7V09SSztQUkVGOjtQUlYtRC0xMzE7MTgwMCBTb3V0aCBOb3ZlbGwgUGxhY2U7UHJvdm87VVQ7
ODQ2MDY7DQpMQUJFTDtXT1JLO1BSRUY7RU5DT0RJTkc9UVVPVEVELVBSSU5UQUJMRToxODAwIFNv
dXRoIE5vdmVsbCBQbGFjZT0wRD0wQT0NClByb3ZvPTBEPTBBPQ0KVVQ9MEQ9MEE9DQo4NDYwNg0K
VUlEOjEzRDRCNTIwLTA5MkYtMDAwMC04NkRFLTAwODA1RjhBMDlDNQ0KVEVMO1ZPSUNFO1BSRUY6
MS04MDEtODYxLTU3NDgNClRFTDtWT0lDRTtXT1JLOjEtODAxLTg2MS01NzQ4DQpURUw7RkFYO1BS
RUY6ODAxLzg2MS01NDE1DQpUSVRMRTpTci4gRW5naW5lZXINClJFVjoyMDEwMDIyMlQxMTA5NTda
DQpYLUdXVURGOjkoTWFpbCBTdG9wKVBSVi1ELTEzMQ0KWC1HV1VERjoxMShFbXBsb3llZSBJRCkw
MjY2MQ0KWC1HV1VERjo4KE1haWxzdG9wKVBSVi1FLTE0MQ0KWC1HV1VERjoxMihXb3JrZm9yY2Ug
SUQpMDI2NjENClgtR1dVREY6NyhDb3VudHJ5KVVTQQ0KWC1HV1VERjoyNChBT0wgSW5zdGFudCBN
ZXNzYWdpbmcgSUQpbXdlbnplbHNlcw0KRU5EOlZDQVJEDQoNCg==

--=__Part94BE5757.0__=
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
--=__Part94BE5757.0__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=__Part94BE5757.0__=--

