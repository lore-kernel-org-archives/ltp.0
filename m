Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Feng.Gao@windriver.com>) id 1OwQ9y-0007Wf-QC
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 01:54:42 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OwQ9x-0000jy-Bk
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 01:54:42 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o8H1sZlm005506
	for <ltp-list@lists.sourceforge.net>;
	Thu, 16 Sep 2010 18:54:35 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CB560B.45542BB9"
Date: Fri, 17 Sep 2010 03:52:37 +0200
Message-ID: <52CF90264091A14888078A031D780F4306901E9A@ism-mail03.corp.ad.wrs.com>
From: "Gao, Feng" <Feng.Gao@windriver.com>
Subject: [LTP] [PATCH]Mdify the __NR_cacheflush value in the cacheflush01
	case
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
To: ltp-list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB560B.45542BB9
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01CB560B.45542BB9"


------_=_NextPart_002_01CB560B.45542BB9
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

Hi,

In the cacheflush01.c, it re-defines the __NR_cacheflush to __NR_Linux + =
197. But the operation is not alway correct.
If _MIPS_SIM is _MIPS_SIM_ABI32, Linux will use o32 style syscalls are =
in the range from 4000 to 4999.
The __NR_cacheflush is __NR_Linux + 147.

Patch attached.

Signed-off-by: Feng Gao <feng.gao@windriver.com>

BR,
Feng Gao

------_=_NextPart_002_01CB560B.45542BB9
Content-Type: text/html;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dgb2312">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>[LTP][PATCH]Mdify the __NR_cacheflush value in the cacheflush01 =
case</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
In the cacheflush01.c, it re-defines the __NR_cacheflush to __NR_Linux + =
197. But the operation is not alway correct.<BR>
If _MIPS_SIM is _MIPS_SIM_ABI32, Linux will use o32 style syscalls are =
in the range from 4000 to 4999.<BR>
The __NR_cacheflush is __NR_Linux + 147.<BR>
<BR>
Patch attached.<BR>
<BR>
Signed-off-by: Feng Gao &lt;feng.gao@windriver.com&gt;<BR>
<BR>
BR,<BR>
Feng Gao<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01CB560B.45542BB9--

------_=_NextPart_001_01CB560B.45542BB9
Content-Type: text/x-diff;
	name="0001-Modified-the-__NR_cacheflush-in-the-cacheflush01.c.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Modified-the-__NR_cacheflush-in-the-cacheflush01.c.patch
Content-Disposition: attachment;
	filename="0001-Modified-the-__NR_cacheflush-in-the-cacheflush01.c.patch"

RnJvbSA4Y2NmN2VmZjkwMzVkYTEzMDg4ZWVmNTBmYjc3M2FmMTAwYjUzZjc3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZW5nIEdhbyA8ZmVuZy5nYW9Ad2luZHJpdmVyLmNvbT4KRGF0
ZTogRnJpLCAxNyBTZXAgMjAxMCAwOTo0NzozMiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIE1vZGlm
aWVkIHRoZSBfX05SX2NhY2hlZmx1c2ggaW4gdGhlIGNhY2hlZmx1c2gwMS5jCgpJbiB0aGUgY2Fj
aGVmbHVzaDAxLmMsIGl0IHJlLWRlZmluZXMgdGhlIF9fTlJfY2FjaGVmbHVzaCB0byBfX05SX0xp
bnV4ICsgMTk3LgpCdXQgdGhlIG9wZXJhdGlvbiBpcyBub3QgYWx3YXkgY29ycmVjdC4gSXQgU2hv
dWxkIGJlIHRoZSB2YWx1ZSBpbiB0aGUgdW5pc3RkLmguCgpTaWduZWQtb2ZmLWJ5OiBGZW5nIEdh
byA8ZmVuZy5nYW9Ad2luZHJpdmVyLmNvbT4KLS0tCiAuLi4va2VybmVsL3N5c2NhbGxzL2NhY2hl
Zmx1c2gvY2FjaGVmbHVzaDAxLmMgICAgICB8ICAgIDIgKysKIDEgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvY2FjaGVmbHVzaC9jYWNoZWZsdXNoMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvY2FjaGVmbHVzaC9jYWNoZWZsdXNoMDEuYwppbmRleCBkMGE0YjFmLi5iYjIwMDY0
IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2NhY2hlZmx1c2gvY2FjaGVm
bHVzaDAxLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jYWNoZWZsdXNoL2NhY2hl
Zmx1c2gwMS5jCkBAIC02Niw3ICs2Niw5IEBACiAgKiBNSVBTIGFyY2hpdGVjdHVyZSAtLSByZWdh
cmRsZXNzLCBpdCdzIGEgZ29vZCBuZWdhdGl2ZSB0ZXN0Li4gKi8KICNpZiBkZWZpbmVkIF9fbWlw
c19fCiAjaW5jbHVkZSA8YXNtL2NhY2hlY3RsLmg+CisjaWZuZGVmIF9fTlJfY2FjaGVmbHVzaAog
I2RlZmluZSBfX05SX2NhY2hlZmx1c2gJCShfX05SX0xpbnV4ICsgMTk3KQorI2VuZGlmCiAjZWxz
ZQogLyogRmFrZSBsaW51eF9zeXNjYWxsX251bWJlcnMuaCAqLwogI2RlZmluZSBfX05SX2NhY2hl
Zmx1c2gJCTAKLS0gCjEuNS42LjMKCg==

------_=_NextPart_001_01CB560B.45542BB9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
------_=_NextPart_001_01CB560B.45542BB9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CB560B.45542BB9--

