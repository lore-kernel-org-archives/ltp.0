Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Wei.Yang@windriver.com>) id 1OqOHA-0001h6-KD
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 10:41:12 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OqOH7-0001ob-7S
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 10:41:12 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o7VAf2IA011227
	for <ltp-list@lists.sourceforge.net>;
	Tue, 31 Aug 2010 03:41:03 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CB48F9.004B7039"
Date: Tue, 31 Aug 2010 12:36:10 +0200
Message-ID: <52CF90264091A14888078A031D780F430D093D@ism-mail03.corp.ad.wrs.com>
References: <4C7CDA7E.2020505@windriver.com>
From: "Yang, Wei" <Wei.Yang@windriver.com>
Subject: [LTP] [PATCH] Probe an bigger linear available address to
	attachment.
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB48F9.004B7039
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01CB48F9.004B7039"


------_=_NextPart_002_01CB48F9.004B7039
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

Hi

When running shmat01 on some platforms, it fails on
"addr =3D shmat(*(tc.shmid), base_addr + tc.offset,tc.flags);"
with a INVAL error. Look at codes in "setup()", it probes
an available address and align the address to SHMLBA. After
alignment, the new address is no guarantee to be available
any more. Here a bigger size is used to probe so that it's
still valid address after alignment.Pertaining to the function=20
setup_tc(lc, &tc) ,when it outside of "for (i =3D 0; i < TST_TOTAL;=20
i++)",and printf the tc.offset value is always 0,add correct a mistake
of original codes to move "setup_tc()" to right place.

Signed-off-by: Yang Wei <wei.yang@windriver.com>

wei yang
BR





------_=_NextPart_002_01CB48F9.004B7039
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
<TITLE>[LTP][PATCH]  Probe an bigger linear available address to =
attachment.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi<BR>
<BR>
When running shmat01 on some platforms, it fails on<BR>
&quot;addr =3D shmat(*(tc.shmid), base_addr + =
tc.offset,tc.flags);&quot;<BR>
with a INVAL error. Look at codes in &quot;setup()&quot;, it probes<BR>
an available address and align the address to SHMLBA. After<BR>
alignment, the new address is no guarantee to be available<BR>
any more. Here a bigger size is used to probe so that it's<BR>
still valid address after alignment.Pertaining to the function<BR>
setup_tc(lc, &amp;tc) ,when it outside of &quot;for (i =3D 0; i &lt; =
TST_TOTAL;<BR>
i++)&quot;,and printf the tc.offset value is always 0,add correct a =
mistake<BR>
of original codes to move &quot;setup_tc()&quot; to right place.<BR>
<BR>
Signed-off-by: Yang Wei &lt;wei.yang@windriver.com&gt;<BR>
<BR>
wei yang<BR>
BR<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01CB48F9.004B7039--

------_=_NextPart_001_01CB48F9.004B7039
Content-Type: text/x-diff;
	name="0001-Probe-an-bigger-linear-available-address-to-attachme.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Probe-an-bigger-linear-available-address-to-attachme.patch
Content-Disposition: attachment;
	filename="0001-Probe-an-bigger-linear-available-address-to-attachme.patch"

RnJvbSAyMmIyNGEzZDE2YTc1MWY2NTEyYTc2OTFhYmM0NmY5ZDc0NGMwOTFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZYW5nIFdlaSA8d3lhbmdAd2luZHJpdmVyLmNvbT4KRGF0ZTog
VHVlLCAzMSBBdWcgMjAxMCAxODowMjoxNiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIFByb2JlIGFu
IGJpZ2dlciBsaW5lYXIgYXZhaWxhYmxlIGFkZHJlc3MgdG8gYXR0YWNobWVudC4KCldoZW4gcnVu
bmluZyBzaG1hdDAxIG9uIHNvbWUgcGxhdGZvcm1zLCBpdCBmYWlscyBvbgoiYWRkciA9IHNobWF0
KCoodGMuc2htaWQpLCBiYXNlX2FkZHIgKyB0Yy5vZmZzZXQsdGMuZmxhZ3MpOyIKd2l0aCBhIEVJ
TlZBTCBlcnJvci4gTG9vayBhdCBjb2RlcyBpbiAic2V0dXAoKSIsIGl0IHByb2JlcwphbiBhdmFp
bGFibGUgYWRkcmVzcyBhbmQgYWxpZ24gdGhlIGFkZHJlc3MgdG8gU0hNTEJBLiBBZnRlcgphbGln
bm1lbnQsIHRoZSBuZXcgYWRkcmVzcyBpcyBubyBndWFyYW50ZWUgdG8gYmUgYXZhaWxhYmxlCmFu
eSBtb3JlLiBIZXJlIGEgYmlnZ2VyIHNpemUgaXMgdXNlZCB0byBwcm9iZSBzbyB0aGF0IGl0J3MK
c3RpbGwgdmFsaWQgYWRkcmVzcyBhZnRlciBhbGlnbm1lbnQuQW5kIGNvcnJlY3QgYSBtaXN0YWtl
Cm9mIG9yaWdpbmFsIGNvZGVzIHRvIG1vdmUgInNldHVwX3RjKCkiIHRvIHJpZ2h0IHBsYWNlLgoK
U2lnbmVkLW9mZi1ieTogWWFuZyBXZWkgPHdlaS55YW5nQHdpbmRyaXZlci5jb20+Ci0tLQogdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvc2htYXQvc2htYXQwMS5jIHwgICAxNSArKysrKysr
KysrKystLS0KIDEgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9zaG1hdC9zaG1h
dDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9zaG1hdC9zaG1hdDAxLmMKaW5k
ZXggNGNiNWVhZi4uZWM2YWU4OSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9pcGMvc2htYXQvc2htYXQwMS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBj
L3NobWF0L3NobWF0MDEuYwpAQCAtMTIwLDExICsxMjAsMTIgQEAgaW50IG1haW4oaW50IGFjLCBj
aGFyICoqYXYpCiAJCS8qIHJlc2V0IFRzdF9jb3VudCBpbiBjYXNlIHdlIGFyZSBsb29waW5nICov
CiAJCVRzdF9jb3VudCA9IDA7CiAKLQkJLyogc2V0dXAgdGVzdCBjYXNlIHBhcmVtZXRlcnMgKi8K
LQkJc2V0dXBfdGMobGMsICZ0Yyk7CiAKIAkJLyogbG9vcCB0aHJvdWdoIHRoZSB0ZXN0IGNhc2Vz
ICovCiAJCWZvciAoaSA9IDA7IGkgPCBUU1RfVE9UQUw7IGkrKykgeworCQkKKwkJCS8qIHNldHVw
IHRlc3QgY2FzZSBwYXJlbWV0ZXJzICovCisJCQlzZXR1cF90YyhpLCAmdGMpOwogCiAJCQkvKgog
CQkJICogVXNlIFRFU1QgbWFjcm8gdG8gbWFrZSB0aGUgY2FsbApAQCAtMjQ2LDYgKzI0Nyw4IEBA
IHZvaWQgY2hlY2tfZnVuY3Rpb25hbGl0eShpbnQgaSkKICAqLwogdm9pZCBzZXR1cCh2b2lkKQog
eworCWludCBzaG1faWRfMjsKKwogCS8qIGNhcHR1cmUgc2lnbmFscyAqLwogCXRzdF9zaWcoTk9G
T1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7CiAKQEAgLTI3MCwxMiArMjczLDE4IEBAIHZvaWQg
c2V0dXAodm9pZCkKIAl9CiAKIAkvKiBQcm9iZSBhbiBhdmFpbGFibGUgbGluZWFyIGFkZHJlc3Mg
Zm9yIGF0dGFjaG1lbnQgKi8KLQlpZiAoKGJhc2VfYWRkciA9IHNobWF0KHNobV9pZF8xLCBOVUxM
LCAwKSkgPT0gKHZvaWQgKiktMSkgeworCWlmICgoc2htX2lkXzIgPSBzaG1nZXQoc2hta2V5Kyss
IFNITUxCQSArIElOVF9TSVpFLCBTSE1fUlcgfCBJUENfQ1JFQVQgfAorCQkJICAgICAgIElQQ19F
WENMKSkgPT0gLTEpIHsKKwkJdHN0X2Jya20oVEJST0ssIGNsZWFudXAsICJGYWlsZWQgdG8gY3Jl
YXRlIHNoYXJlZCBtZW1vcnkgIgorCQkJICJyZXNvdXJjZSAxIGluIHNldHVwKCkiKTsKKwl9CisJ
aWYgKChiYXNlX2FkZHIgPSBzaG1hdChzaG1faWRfMiwgTlVMTCwgMCkpID09ICh2b2lkICopLTEp
IHsKIAkJdHN0X2Jya20oVEJST0ssIGNsZWFudXAsICJDb3VsZG4ndCBhdHRhY2ggc2hhcmVkIG1l
bW9yeSIpOwogCX0KIAlpZiAoc2htZHQoKGNvbnN0IHZvaWQgKiliYXNlX2FkZHIpID09IC0xKSB7
CiAJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAiQ291bGRuJ3QgZGV0YWNoIHNoYXJlZCBtZW1v
cnkiKTsKIAl9CisJcm1fc2htKHNobV9pZF8yKTsKIAogCS8qIHNvbWUgYXJjaGl0ZWN0dXJlcyAo
ZS5nLiBwYXJpc2MpIGFyZSBzdHJhbmdlLCBzbyBiZXR0ZXIgYWx3YXlzIGFsaWduIHRvCiAJICog
bmV4dCBTSE1MQkEgYWRkcmVzcy4gKi8KLS0gCjEuNi4wLjQKCg==

------_=_NextPart_001_01CB48F9.004B7039
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
------_=_NextPart_001_01CB48F9.004B7039
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CB48F9.004B7039--

