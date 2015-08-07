Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <a22017@motorola.com>) id 1ZNpST-0005mb-Hq
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2015 21:45:45 +0000
Received: from mail-vk0-f50.google.com ([209.85.213.50])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZNpSS-00078A-I0
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2015 21:45:45 +0000
Received: by vkfi73 with SMTP id i73so368106vkf.2
	for <ltp-list@lists.sourceforge.net>;
	Fri, 07 Aug 2015 14:45:38 -0700 (PDT)
MIME-Version: 1.0
From: Sandy Sun <a22017@motorola.com>
Date: Fri, 7 Aug 2015 14:17:22 -0700
Message-ID: <CACwVHNqEdn8kuQ-pdD35=O64criD+d3R1S2jUnMgVQt-XxrTyg@mail.gmail.com>
Content-Type: multipart/mixed; boundary=bcaec51d205abdf618051cbf2bb9
Subject: [LTP] Test Patch for diotest6
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

--bcaec51d205abdf618051cbf2bb9
Content-Type: multipart/alternative; boundary=bcaec51d205abdf614051cbf2bb7

--bcaec51d205abdf614051cbf2bb7
Content-Type: text/plain; charset=UTF-8

Hi All,

How are you!

I found pointer issue in diotest6. It wrongly use iov1/iov2 as pointer to
"buf" when read/write
from fd_r/w.  It should be iov1[j].iov_base.

And this patch adds loop to read/write nvector times.

Attachment is the patch.

Have a nice weekend!

BRs,
Sandy

--bcaec51d205abdf614051cbf2bb7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>How are you!=C2=A0</div><div><b=
r></div><div>I found pointer issue in diotest6. It wrongly use iov1/iov2 as=
 pointer to &quot;buf&quot; when read/write</div><div>from fd_r/w.=C2=A0 It=
 should be iov1[j].iov_base.</div><div><br></div><div>And this patch adds l=
oop to read/write nvector times.</div><div><br></div><div>Attachment is the=
 patch.=C2=A0</div><div><br></div><div>Have a nice weekend!</div><div><br><=
/div><div>BRs,</div><div>Sandy</div></div>

--bcaec51d205abdf614051cbf2bb7--

--bcaec51d205abdf618051cbf2bb9
Content-Type: application/octet-stream; 
	name="0001-PATCH-diotest6-Fix-buf-pointer-issue.patch"
Content-Disposition: attachment; 
	filename="0001-PATCH-diotest6-Fix-buf-pointer-issue.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_id24v66h0

RnJvbSA0ZWNmMWYwYmMzODVmN2YxYzhmOGE4ZWI2ZWVmNmJjMzIzMDlhOTI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW5nLUp1YW4gU3VuIDxhMjIwMTdAbW90b3JvbGEuY29tPgpE
YXRlOiBGcmksIDcgQXVnIDIwMTUgMTQ6MDE6NTggLTA3MDAKU3ViamVjdDogW1BBVENIXSBbUEFU
Q0hdIGRpb3Rlc3Q2OiBGaXggYnVmIHBvaW50ZXIgaXNzdWUKCkl0IHdyb25nbHkgdXNlIGlvdjEv
aW92MiBhcyBwb2ludGVyIHRvICJidWYiIHdoZW4gcmVhZC93cml0ZQpmcm9tIGZkX3Ivdy4gIEl0
IHNob3VsZCBiZSBpb3YxW2pdLmlvdl9iYXNlLgpBbmQgdGhpcyBwYXRjaCBhZGRzIGxvb3AgdG8g
cmVhZC93cml0ZSBudmVjdG9yIHRpbWVzLgoKU2lnbmVkLW9mZi1ieTogTGluZy1KdWFuIFN1biA8
YTIyMDE3QG1vdG9yb2xhLmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL2lvL2RpcmVjdF9pby9k
aW90ZXN0Ni5jIHwgNjAgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL2lvL2RpcmVjdF9pby9kaW90ZXN0Ni5jIGIvdGVzdGNhc2VzL2tlcm5l
bC9pby9kaXJlY3RfaW8vZGlvdGVzdDYuYwppbmRleCA1ODQxOTc3Li4zZGFjYzg2IDEwMDY0NAot
LS0gYS90ZXN0Y2FzZXMva2VybmVsL2lvL2RpcmVjdF9pby9kaW90ZXN0Ni5jCisrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvaW8vZGlyZWN0X2lvL2Rpb3Rlc3Q2LmMKQEAgLTk3LDcgKzk3LDcgQEAgdm9p
ZCBwcmdfdXNhZ2UoKQogaW50IHJ1bnRlc3QoaW50IGZkX3IsIGludCBmZF93LCBpbnQgY2hpbGRu
dW0sIGludCBhY3Rpb24pCiB7CiAJb2ZmNjRfdCBzZWVrb2ZmOwotCWludCBpLCBidWZzaXplID0g
QlVGU0laRTsKKwlpbnQgaSwgaiwgYnVmc2l6ZSA9IEJVRlNJWkU7CiAJc3RydWN0IGlvdmVjICpp
b3YxLCAqaW92MiwgKmlvdnA7CiAKIAkvKiBBbGxvY2F0ZSBmb3IgYnVmZmVycyBhbmQgZGF0YSBw
b2ludGVycyAqLwpAQCAtMTM1LDM2ICsxMzUsMzggQEAgaW50IHJ1bnRlc3QoaW50IGZkX3IsIGlu
dCBmZF93LCBpbnQgY2hpbGRudW0sIGludCBhY3Rpb24pCiAJCSAgIGZpbGxidWYoYnVmMSwgYnVm
c2l6ZSwgY2hpbGRudW0raSk7CiAJCSAqLwogCQl2ZmlsbGJ1Zihpb3YxLCBudmVjdG9yLCBjaGls
ZG51bSArIGkpOwotCQlpZiAobHNlZWsoZmRfdywgc2Vla29mZiwgU0VFS19TRVQpIDwgMCkgewot
CQkJdHN0X3Jlc20oVEZBSUwsICJsc2VlayBiZWZvcmUgd3JpdGUgZmFpbGVkOiAlcyIsCi0JCQkJ
IHN0cmVycm9yKGVycm5vKSk7Ci0JCQlyZXR1cm4gKC0xKTsKLQkJfQotCQlpZiAod3JpdGUoZmRf
dywgaW92MSwgYnVmc2l6ZSkgPCBidWZzaXplKSB7Ci0JCQl0c3RfcmVzbShURkFJTCwgIndyaXRl
IGZhaWxlZDogJXMiLCBzdHJlcnJvcihlcnJubykpOwotCQkJcmV0dXJuICgtMSk7Ci0JCX0KLQkJ
aWYgKGFjdGlvbiA9PSBSRUFEX0RJUkVDVCkgewotCQkJLyogTWFrZSBzdXJlIGRhdGEgaXMgb24g
dG8gZGlzayBiZWZvcmUgcmVhZCAqLwotCQkJaWYgKGZzeW5jKGZkX3cpIDwgMCkgewotCQkJCXRz
dF9yZXNtKFRGQUlMLCAiZnN5bmMgZmFpbGVkOiAlcyIsCi0JCQkJCSBzdHJlcnJvcihlcnJubykp
OworCQlmb3IgKGogPSAwOyBqIDwgbnZlY3RvcjsgaisrKSB7CisJCQlpZiAobHNlZWsoZmRfdywg
c2Vla29mZiwgU0VFS19TRVQpIDwgMCkgeworCQkJCXRzdF9yZXNtKFRGQUlMLCAibHNlZWsgYmVm
b3JlIHdyaXRlIGZhaWxlZDogJXMiLAorCQkJCQlzdHJlcnJvcihlcnJubykpOworCQkJCXJldHVy
biAoLTEpOworCQkJfQorCQkJaWYgKHdyaXRlKGZkX3csIChpb3YxICsgaiktPmJhc2UsIGJ1ZnNp
emUpIDwgYnVmc2l6ZSkgeworCQkJCXRzdF9yZXNtKFRGQUlMLCAid3JpdGUgZmFpbGVkOiAlcyIs
IHN0cmVycm9yKGVycm5vKSk7CisJCQkJcmV0dXJuICgtMSk7CisJCQl9CisJCQlpZiAoYWN0aW9u
ID09IFJFQURfRElSRUNUKSB7CisJCQkJLyogTWFrZSBzdXJlIGRhdGEgaXMgb24gdG8gZGlzayBi
ZWZvcmUgcmVhZCAqLworCQkJCWlmIChmc3luYyhmZF93KSA8IDApIHsKKwkJCQkJdHN0X3Jlc20o
VEZBSUwsICJmc3luYyBmYWlsZWQ6ICVzIiwKKwkJCQkJCXN0cmVycm9yKGVycm5vKSk7CisJCQkJ
CXJldHVybiAoLTEpOworCQkJCX0KKwkJCX0KKwkJCWlmIChsc2VlayhmZF9yLCBzZWVrb2ZmLCBT
RUVLX1NFVCkgPCAwKSB7CisJCQkJdHN0X3Jlc20oVEZBSUwsICJsc2VlayBiZWZvcmUgcmVhZCBm
YWlsZWQ6ICVzIiwKKwkJCQkJc3RyZXJyb3IoZXJybm8pKTsKKwkJCQlyZXR1cm4gKC0xKTsKKwkJ
CX0KKwkJCWlmIChyZWFkKGZkX3IsIChpb3YyICsgaiktPmJhc2UsIGJ1ZnNpemUpIDwgYnVmc2l6
ZSkgeworCQkJCXRzdF9yZXNtKFRGQUlMLCAicmVhZCBmYWlsZWQ6ICVzIiwgc3RyZXJyb3IoZXJy
bm8pKTsKKwkJCQlyZXR1cm4gKC0xKTsKKwkJCX0KKwkJCWlmIChidWZjbXAoKGNoYXIgKilpb3Yx
LCAoY2hhciAqKWlvdjIsIGJ1ZnNpemUpICE9IDApIHsKKwkJCQl0c3RfcmVzbShURkFJTCwgImNv
bXBhcnNpb24gZmFpbGVkLiBDaGlsZD0lZCBvZmZzZXQ9JWQiLAorCQkJCQljaGlsZG51bSwgKGlu
dClzZWVrb2ZmKTsKIAkJCQlyZXR1cm4gKC0xKTsKIAkJCX0KLQkJfQotCQlpZiAobHNlZWsoZmRf
ciwgc2Vla29mZiwgU0VFS19TRVQpIDwgMCkgewotCQkJdHN0X3Jlc20oVEZBSUwsICJsc2VlayBi
ZWZvcmUgcmVhZCBmYWlsZWQ6ICVzIiwKLQkJCQkgc3RyZXJyb3IoZXJybm8pKTsKLQkJCXJldHVy
biAoLTEpOwotCQl9Ci0JCWlmIChyZWFkKGZkX3IsIGlvdjIsIGJ1ZnNpemUpIDwgYnVmc2l6ZSkg
ewotCQkJdHN0X3Jlc20oVEZBSUwsICJyZWFkIGZhaWxlZDogJXMiLCBzdHJlcnJvcihlcnJubykp
OwotCQkJcmV0dXJuICgtMSk7Ci0JCX0KLQkJaWYgKGJ1ZmNtcCgoY2hhciAqKWlvdjEsIChjaGFy
ICopaW92MiwgYnVmc2l6ZSkgIT0gMCkgewotCQkJdHN0X3Jlc20oVEZBSUwsICJjb21wYXJzaW9u
IGZhaWxlZC4gQ2hpbGQ9JWQgb2Zmc2V0PSVkIiwKLQkJCQkgY2hpbGRudW0sIChpbnQpc2Vla29m
Zik7Ci0JCQlyZXR1cm4gKC0xKTsKIAkJfQogCX0KIAlyZXR1cm4gMDsKLS0gCjEuOC40LjMKCg==
--bcaec51d205abdf618051cbf2bb9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--bcaec51d205abdf618051cbf2bb9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--bcaec51d205abdf618051cbf2bb9--

