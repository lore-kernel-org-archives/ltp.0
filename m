Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Feng.Gao@windriver.com>) id 1OqNQM-0007EW-Di
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 09:46:38 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OqNQI-0007KY-OW
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 09:46:38 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o7V9kS5N029930
	for <ltp-list@lists.sourceforge.net>;
	Tue, 31 Aug 2010 02:46:28 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CB48F1.60B61045"
Date: Tue, 31 Aug 2010 11:42:03 +0200
Message-ID: <52CF90264091A14888078A031D780F430111B8E4@ism-mail03.corp.ad.wrs.com>
From: "Gao, Feng" <Feng.Gao@windriver.com>
Subject: [LTP] [PATCH]Modify the cacheflush01 test case
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

------_=_NextPart_001_01CB48F1.60B61045
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01CB48F1.60B61045"


------_=_NextPart_002_01CB48F1.60B61045
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

Hi,

The cacheflush system call does not return EINVAL in the latest Linux =
kernel. see the link:
A related patch about the cacheflush function:
http://lkml.org/lkml/2009/4/9/203
But Ralf had refused this patch:
http://www.spinics.net/lists/linux-man/msg00906.html
cacheflush01 testcase checks if the return value is EINVAL when the =
cache argument is not one of ICACHE, BCACHE or DCACHE. So it will fail =
in all boards.

In this modification, checking return value SUCCESS will be added, =
instead of checking EINVAL

Signed-off-by: Feng Gao <feng.gao@windriver.com>

BR,
Feng Gao



------_=_NextPart_002_01CB48F1.60B61045
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
<TITLE>[LTP][PATCH]Modify the cacheflush01 test case</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
The cacheflush system call does not return EINVAL in the latest Linux =
kernel. see the link:<BR>
A related patch about the cacheflush function:<BR>
<A =
HREF=3D"http://lkml.org/lkml/2009/4/9/203">http://lkml.org/lkml/2009/4/9/=
203</A><BR>
But Ralf had refused this patch:<BR>
<A =
HREF=3D"http://www.spinics.net/lists/linux-man/msg00906.html">http://www.=
spinics.net/lists/linux-man/msg00906.html</A><BR>
cacheflush01 testcase checks if the return value is EINVAL when the =
cache argument is not one of ICACHE, BCACHE or DCACHE. So it will fail =
in all boards.<BR>
<BR>
In this modification, checking return value SUCCESS will be added, =
instead of checking EINVAL<BR>
<BR>
Signed-off-by: Feng Gao &lt;feng.gao@windriver.com&gt;<BR>
<BR>
BR,<BR>
Feng Gao<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01CB48F1.60B61045--

------_=_NextPart_001_01CB48F1.60B61045
Content-Type: text/x-diff; name="0001-Modify-the-cacheflush01-test-case.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Modify-the-cacheflush01-test-case.patch
Content-Disposition: attachment;
	filename="0001-Modify-the-cacheflush01-test-case.patch"

RnJvbSAzOWMxNDk4NmM2MjE1NWZjYWVlMjAyNzg1Njg0ZWFlNDNkMjUyNGY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZW5nIEdhbyA8ZmVuZy5nYW9Ad2luZHJpdmVyLmNvbT4KRGF0
ZTogVHVlLCAzMSBBdWcgMjAxMCAxNzozOToyMSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIE1vZGlm
eSB0aGUgY2FjaGVmbHVzaDAxIHRlc3QgY2FzZS4KClRoZSBjYWNoZWZsdXNoIHN5c3RlbSBjYWxs
IGRvZXMgbm90IHJldHVybiBFSU5WQUwgaW4gdGhlIGxhdGVzdCBMaW51eCBrZXJuZWwuIHNlZSB0
aGUgbGluazoKQSByZWxhdGVkIHBhdGNoIGFib3V0IHRoZSBjYWNoZWZsdXNoIGZ1bmN0aW9uOgpo
dHRwOi8vbGttbC5vcmcvbGttbC8yMDA5LzQvOS8yMDMKQnV0IFJhbGYgaGFkIHJlZnVzZWQgdGhp
cyBwYXRjaDoKaHR0cDovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1tYW4vbXNnMDA5MDYu
aHRtbApjYWNoZWZsdXNoMDEgdGVzdGNhc2UgY2hlY2tzIGlmIHRoZSByZXR1cm4gdmFsdWUgaXMg
RUlOVkFMIHdoZW4gdGhlIGNhY2hlIGFyZ3VtZW50IGlzIG5vdCBvbmUgb2YgSUNBQ0hFLCBCQ0FD
SEUgb3IgRENBQ0hFLiBTbyBpdCB3aWxsIGZhaWwgaW4gYWxsIGJvYXJkcy4KCkluIHRoaXMgbW9k
aWZpY2F0aW9uLCBjaGVja2luZyByZXR1cm4gdmFsdWUgU1VDQ0VTUyB3aWxsIGJlIGFkZGVkLCBp
bnN0ZWFkIG9mIGNoZWNraW5nIEVJTlZBTAoKU2lnbmVkLW9mZi1ieTogRmVuZyBHYW8gPGZlbmcu
Z2FvQHdpbmRyaXZlci5jb20+Ci0tLQogLi4uL2tlcm5lbC9zeXNjYWxscy9jYWNoZWZsdXNoL2Nh
Y2hlZmx1c2gwMS5jICAgICAgfCAgIDI4ICsrKysrKysrKysrKy0tLS0tLS0tCiAxIGZpbGVzIGNo
YW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2FjaGVmbHVzaC9jYWNoZWZsdXNoMDEuYyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvY2FjaGVmbHVzaC9jYWNoZWZsdXNoMDEuYwppbmRleCBjY2Uw
YjcwLi5kMGE0YjFmIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2NhY2hl
Zmx1c2gvY2FjaGVmbHVzaDAxLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jYWNo
ZWZsdXNoL2NhY2hlZmx1c2gwMS5jCkBAIC0xNTIsMjAgKzE1MiwyNiBAQCBpbnQgbWFpbihpbnQg
YWMsIGNoYXIgKiphdikKIAogCS8qIEludm9rZXMgY2FjaGVmbHVzaCgpIHdpdGggcHJvcGVyIHBh
cmFtZXRlcnMgKi8KIAlURVNUKHN5c2NhbGwoX19OUl9jYWNoZWZsdXNoLCBhZGRyLCBnZXRwYWdl
c2l6ZSgpLCBJQ0FDSEUpKTsKKwlpZiAoVEVTVF9SRVRVUk4gPT0gMCkgeworCQl0c3RfcmVzbShU
UEFTUywgInBhc3NlZCB3aXRoIG5vIGVycm5vIik7CisJfSBlbHNlIHsKKwkJdHN0X3Jlc20oVEZB
SUwsICJmYWlsZWQgd2l0aCB1bmV4cGVjdGVkIGVycm5vIik7CisJfQkJCisJCiAJVEVTVChzeXNj
YWxsKF9fTlJfY2FjaGVmbHVzaCwgYWRkciwgZ2V0cGFnZXNpemUoKSwgRENBQ0hFKSk7CisJaWYg
KFRFU1RfUkVUVVJOID09IDApIHsKKwkJdHN0X3Jlc20oVFBBU1MsICJwYXNzZWQgd2l0aCBubyBl
cnJubyIpOworCX0gZWxzZSB7CisJCXRzdF9yZXNtKFRGQUlMLCAiZmFpbGVkIHdpdGggdW5leHBl
Y3RlZCBlcnJubyIpOworCX0JCQorCQogCVRFU1Qoc3lzY2FsbChfX05SX2NhY2hlZmx1c2gsIGFk
ZHIsIGdldHBhZ2VzaXplKCksIEJDQUNIRSkpOwotCi0JLyogVGVzdHMgd2hldGhlciBjYWNoZWZs
dXNoKCkgcmV0dXJucyAtRUlOVkFMICovCi0JVEVTVChzeXNjYWxsKF9fTlJfY2FjaGVmbHVzaCwg
YWRkciwgZ2V0cGFnZXNpemUoKSwgMCkpOwotCWlmIChURVNUX1JFVFVSTiA8IDApIHsKLQkJaWYg
KFRFU1RfRVJSTk8gPT0gRUlOVkFMKSB7Ci0JCQl0c3RfcmVzbShUUEFTUyB8IFRURVJSTk8sICJw
YXNzZWQgd2l0aCBleHBlY3RlZCBlcnJubyIpOwotCQl9IGVsc2UgewotCQkJdHN0X3Jlc20oVEZB
SUwgfCBUVEVSUk5PLCAiZmFpbGVkIHdpdGggdW5leHBlY3RlZCBlcnJubyIpOwotCQl9CQkKKwlp
ZiAoVEVTVF9SRVRVUk4gPT0gMCkgeworCQl0c3RfcmVzbShUUEFTUywgInBhc3NlZCB3aXRoIG5v
IGVycm5vIik7CiAJfSBlbHNlIHsKLQkgICAgICAgIHRzdF9yZXNtKFRGQUlMLCAicGFzc2VkIHVu
ZXhwZWN0ZWRseSIpOwotICAgICAgICB9CisJCXRzdF9yZXNtKFRGQUlMLCAiZmFpbGVkIHdpdGgg
dW5leHBlY3RlZCBlcnJubyIpOworCX0JCQorCiAJY2xlYW51cCgpOyAKICAgICAgICAgdHN0X2V4
aXQoKTsKIH0KLS0gCjEuNS42LjMKCg==

------_=_NextPart_001_01CB48F1.60B61045
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
------_=_NextPart_001_01CB48F1.60B61045
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CB48F1.60B61045--

