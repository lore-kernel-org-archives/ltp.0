Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1My9Ci-0007Dy-Tb
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 19:08:08 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1My9Cc-0005Lj-NU
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 19:08:08 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id 615421C3DF
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 12:07:55 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA4D01.11D6402E"
Date: Wed, 14 Oct 2009 12:04:56 -0700
Message-ID: <8368651DACC1964480F951191B94A0780153D4DC@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP] [PATCH][rwtest] use default size for blks if parsing df
	output fails to return numeric argument
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
To: LTP Mailing List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA4D01.11D6402E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

All,

This patch for rwtest.sh sets a default size for the number of blocks =
within the filesystem the test is executing on if parsing "df output" =
somehow results in a non-numeric value(unexpected df output). Also =
removes trailing whitespace.

Signed-off-by: Henry Yei <hyei@mvista.com>


Garret,

Per message Subject: [LTP] [issue 8] rwtest*: iogen / rwtest needs to =
createprerequisite directory paths,
Would a simple mkdir suffice inside the rwtest script to handle that =
issue?

------_=_NextPart_001_01CA4D01.11D6402E
Content-Type: application/octet-stream;
	name="rwtest_sh.patch"
Content-Transfer-Encoding: base64
Content-Description: rwtest_sh.patch
Content-Disposition: attachment;
	filename="rwtest_sh.patch"

LS0tIGx0cC90ZXN0Y2FzZXMva2VybmVsL2ZzL2RvaW8vcnd0ZXN0LnNoCTIwMDktMTAtMTMgMTI6
NDE6MDMuNTg4MDAwMDAwIC0wNzAwCisrKyBsdHAtd2Rpci90ZXN0Y2FzZXMva2VybmVsL2ZzL2Rv
aW8vcnd0ZXN0LnNoCTIwMDktMTAtMTQgMTE6NTI6NTMuMzY0MDAwMDAwIC0wNzAwCkBAIC0xLDMz
ICsxLDMzIEBACiAjIS9iaW4vYmFzaAogCiAjIENvcHlyaWdodCAoYykgMjAwMCBTaWxpY29uIEdy
YXBoaWNzLCBJbmMuICBBbGwgUmlnaHRzIFJlc2VydmVkLgotIyAKKyMKICMgVGhpcyBwcm9ncmFt
IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkg
aXQKICMgdW5kZXIgdGhlIHRlcm1zIG9mIHZlcnNpb24gMiBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgYXMKICMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b24uCi0jIAorIwogIyBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhh
dCBpdCB3b3VsZCBiZSB1c2VmdWwsIGJ1dAogIyBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91
dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCiAjIE1FUkNIQU5UQUJJTElUWSBvciBGSVRO
RVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4KLSMgCisjCiAjIEZ1cnRoZXIsIHRoaXMgc29m
dHdhcmUgaXMgZGlzdHJpYnV0ZWQgd2l0aG91dCBhbnkgd2FycmFudHkgdGhhdCBpdCBpcwogIyBm
cmVlIG9mIHRoZSByaWdodGZ1bCBjbGFpbSBvZiBhbnkgdGhpcmQgcGVyc29uIHJlZ2FyZGluZyBp
bmZyaW5nZW1lbnQKICMgb3IgdGhlIGxpa2UuICBBbnkgbGljZW5zZSBwcm92aWRlZCBoZXJlaW4s
IHdoZXRoZXIgaW1wbGllZCBvcgogIyBvdGhlcndpc2UsIGFwcGxpZXMgb25seSB0byB0aGlzIHNv
ZnR3YXJlIGZpbGUuICBQYXRlbnQgbGljZW5zZXMsIGlmCiAjIGFueSwgcHJvdmlkZWQgaGVyZWlu
IGRvIG5vdCBhcHBseSB0byBjb21iaW5hdGlvbnMgb2YgdGhpcyBwcm9ncmFtIHdpdGgKICMgb3Ro
ZXIgc29mdHdhcmUsIG9yIGFueSBvdGhlciBwcm9kdWN0IHdoYXRzb2V2ZXIuCi0jIAorIwogIyBZ
b3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBhbG9uZwogIyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0aGUgRnJl
ZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuLCA1OQogIyBUZW1wbGUgUGxhY2UgLSBTdWl0ZSAz
MzAsIEJvc3RvbiBNQSAwMjExMS0xMzA3LCBVU0EuCi0jIAorIwogIyBDb250YWN0IGluZm9ybWF0
aW9uOiBTaWxpY29uIEdyYXBoaWNzLCBJbmMuLCAxNjAwIEFtcGhpdGhlYXRyZSBQa3d5LAogIyBN
b3VudGFpbiBWaWV3LCBDQSAgOTQwNDMsIG9yOgotIyAKLSMgaHR0cDovL3d3dy5zZ2kuY29tIAot
IyAKLSMgRm9yIGZ1cnRoZXIgaW5mb3JtYXRpb24gcmVnYXJkaW5nIHRoaXMgbm90aWNlLCBzZWU6
IAotIyAKKyMKKyMgaHR0cDovL3d3dy5zZ2kuY29tCisjCisjIEZvciBmdXJ0aGVyIGluZm9ybWF0
aW9uIHJlZ2FyZGluZyB0aGlzIG5vdGljZSwgc2VlOgorIwogIyBodHRwOi8vb3NzLnNnaS5jb20v
cHJvamVjdHMvR2VuSW5mby9Ob3RpY2VFeHBsYW4vCiAKICMKQEAgLTU5LDcgKzU5LDcgQEAgaGVs
cCgpCiB7CiAJZWNobyAiXAogICAgIC1jICAgICAgICAgICBDbGVhbnVwIHRlc3QgZmlsZXMgY3Jl
YXRlZCBieSB0aGlzIGludm9jYXRpb24gb24gZXhpdC4KLSAgICAgICAgICAgICAgICAgRGVmYXVs
dCBpcyB0byBsZWF2ZSB0aGVtLiAgCisgICAgICAgICAgICAgICAgIERlZmF1bHQgaXMgdG8gbGVh
dmUgdGhlbS4KICAgICAtaCAgICAgICAgICAgVGhpcyBoZWxwIC0gaWdub3JlIGFsbCBvdGhlciBv
cHRpb25zL2FyZ3VtZW50cwogICAgIC1GCQkgT25seSBwcm9jZXNzIGZpbGVuYW1lcyAtIGRvZXMg
bm90IHJ1biBpb2dlbiAmIGRvaW8uCiAgICAgLVAgUGxhY2VzCSBOb3QgdXNlZApAQCAtODYsNyAr
ODYsNyBAQCBoZWxwKCkKICAgICAgICAgICAgICAgICAgd3JpdGVhIHN5c3RlbSBjYWxscy4gIElm
IGEgc2l6ZSBpcyBzdXBwbGllZCwgYW4gYXR0ZW1wdCB0bwogICAgICAgICAgICAgICAgICBjcmVh
dGUvZ3Jvdy9zaHJpbmsgcGF0aCB0byB0aGUgZGVzaXJlZCBzaXplIHdpbGwgYmUgbWFkZS4KICAg
ICAgICAgICAgICAgICAgc2l6ZSBpcyBhbiBpbnRlZ2VyIHdoaWNoIGRlZmF1bHRzIHRvIGJ5dGVz
LCBidXQgbWF5IGJlCi0gICAgICAgICAgICAgICAgIHN1ZmZpeGVkIGJ5ICdiJywgJ2snLCBvciAn
bScgZm9yIGJsb2NrcyAoNDA5NiBieXRlIHVuaXRzKSwgCisgICAgICAgICAgICAgICAgIHN1ZmZp
eGVkIGJ5ICdiJywgJ2snLCBvciAnbScgZm9yIGJsb2NrcyAoNDA5NiBieXRlIHVuaXRzKSwKIAkg
ICAgICAgICBraWxvYnl0ZXMgKDEwMjQgYnl0ZSB1bml0cyksIG9yIG1lZ2FieXRlcyAoMl4yMCBi
eXRlIHVuaXRzKS4KIAogCQkgSWYgdGhlIHNpemUgaXMgYSBwZXJjZW50YWdlLCBkZiBpcyB1c2Vk
IHRvIGZpbmQgaG93IG11Y2gKQEAgLTMyNiw4ICszMjYsOCBAQCBkbwogICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgdGVzdCAtaCAkKHdoaWNoIGRmKQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdGhlbgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRpcj0iIjsgZGZPcHRzPSIi
OwotICAgICAgICAgICAgICAgICAgICAgICAgZmkgICAgICAKLQkKKyAgICAgICAgICAgICAgICAg
ICAgICAgIGZpCisKIAkJCWJsa3M9JChkZiAkZGZPcHRzICRkaXIgfAogCQkJKHdoaWxlIHJlYWQg
ZnMgYmxrcyB1c2VkIGF2YWlsIGNhcCBtb3VudHBvaW50CiAJCQkgZG8KQEAgLTMzNiwzMyArMzM2
LDQxIEBAIGRvCiAJCQkgZG9uZQogCQkJIGVjaG8gJGIpICkKIAotCQkJY2FzZSAkKHVuYW1lKSBp
bgotCQkJTGludXgpICBibGtzPSQoIGV4cHIgJGJsa3MgLyAyICkgOzsKLQkJCWVzYWMKLQotCQkJ
c3pjYWNoZVskeyNzemNhY2hlWypdfSsxXT0kZGlyCi0JCQlzemJsa3NbJHsjc3pibGtzWypdfSsx
XT0kYmxrcwotCQlmaQotCi0JCW1heD0ke3NpemUjIypcJX0KLQkJaWYgW1sgIiRtYXgiID0gIiIg
XV0KLQkJdGhlbgotCQkJbWF4PTEwMDAwMDAKLQkJZmkKLQkJc2l6ZT0ke3NpemUlJVwlKn0KLQot
CQljYXNlICQodW5hbWUpIGluCi0JCUlSSVgqKQotCQkgIHN6PSQoIHBlcmwgLWxlICdwcmludCBp
bnQoICckYmxrcycgKiAnJHNpemUnIC8gMTAwICknICkKLQkJICA7OwotCQkqKQotCQkgIHN6PSQo
ZXhwciBcKCAkYmxrcyAnKicgJHNpemUgXCkgLyAxMDApCi0JCSAgOzsKLQkJZXNhYwotCi0JCWlm
IFsgJHN6IC1ndCAkbWF4IF0KLQkJdGhlbgotCQkJc3o9JG1heAorCQkJIyBjaGVjayBpZiBibGtz
IGlzIGEgbnVtYmVyLCBlbHNlIHNldCBhIGRlZmF1bHQgdmFsdWUgZm9yIGJsa3MKKwkJCWRlZmF1
bHRfc3o9MTAwMDAwMAorCQkJaWYgWyAkYmxrcyAtZXEgJGJsa3MgMj4gL2Rldi9udWxsIF0KKwkJ
CXRoZW4KKworCQkJCWNhc2UgJCh1bmFtZSkgaW4KKwkJCQlMaW51eCkgIGJsa3M9JCggZXhwciAk
YmxrcyAvIDIgKSA7OworCQkJCWVzYWMKKworCQkJCXN6Y2FjaGVbJHsjc3pjYWNoZVsqXX0rMV09
JGRpcgorCQkJCXN6Ymxrc1skeyNzemJsa3NbKl19KzFdPSRibGtzCisKKwkJCQltYXg9JHtzaXpl
IyMqXCV9CisJCQkJaWYgW1sgIiRtYXgiID0gIiIgXV0KKwkJCQl0aGVuCisJCQkJCW1heD0kZGVm
YXVsdF9zegorCQkJCWZpCisJCQkJc2l6ZT0ke3NpemUlJVwlKn0KKworCQkJCWNhc2UgJCh1bmFt
ZSkgaW4KKwkJCQlJUklYKikKKwkJCQkgIHN6PSQoIHBlcmwgLWxlICdwcmludCBpbnQoICckYmxr
cycgKiAnJHNpemUnIC8gMTAwICknICkKKwkJCQkgIDs7CisJCQkJKikKKwkJCQkgIHN6PSQoZXhw
ciBcKCAkYmxrcyAnKicgJHNpemUgXCkgLyAxMDApCisJCQkJICA7OworCQkJCWVzYWMKKworCQkJ
CWlmIFsgJHN6IC1ndCAkbWF4IF0KKwkJCQl0aGVuCisJCQkJCXN6PSRtYXgKKwkJCQlmaQorCQkJ
ZWxzZQorCQkJCXN6PSRkZWZhdWx0X3N6CisJCQlmaQogCQlmaQogCQlmPSRzeiJiOiIkZmlsZQog
CWZpCg==

------_=_NextPart_001_01CA4D01.11D6402E
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
------_=_NextPart_001_01CA4D01.11D6402E
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA4D01.11D6402E--

