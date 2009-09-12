Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nobuhiro@andestech.com>) id 1MmOc1-0003St-F3
	for ltp-list@lists.sourceforge.net; Sat, 12 Sep 2009 09:09:41 +0000
Received: from 59-124-160-117.hinet-ip.hinet.net ([59.124.160.117]
	helo=ATCPCS06.andestech.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MmObw-00086h-Bj
	for ltp-list@lists.sourceforge.net; Sat, 12 Sep 2009 09:09:41 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA3388.BBA1A1C5"
Date: Sat, 12 Sep 2009 17:09:28 +0800
Message-ID: <50FD90C65C53FB45BADEEBCD84FF07F201B17791@ATCPCS06.andestech.com>
From: <nobuhiro@andestech.com>
Subject: Re: [LTP] [PATCH] pselect01: Fixed the checking logic to also
	consider some variation.
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
Cc: vapier@gentoo.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA3388.BBA1A1C5
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

=20
Hi Mike,

Thanks for identifying that.
Fixed patch attached.

-Nobuhiro Lin

-----Original Message-----
From: Mike Frysinger [mailto:vapier@gentoo.org]=20
Sent: Saturday, September 12, 2009 10:28 AM
To: ltp-list@lists.sourceforge.net
Cc: Shawn Hsin-Hung Lin(=AAL=ABH=A7=BB)
Subject: Re: [LTP] [PATCH] pselect01: Fixed the checking logic to also =
consider some variation.

On Friday 11 September 2009 09:20:33 Nobuhiro Lin wrote:
> -		if (total_sec >=3D (end - start))
> +		if(((end - start) >=3D total_sec) && ((end - start) <=3D total_sec =
+=20
> +1))

please fix your style.  skimping on whitespace doesnt make for smaller =
code.

that said, your test boils down to "=3D=3D total_sec" or "=3D=3D =
total_sec + 1". =20
might as well use that rather than confusing greater/less than =
comparisons.
-mike

------_=_NextPart_001_01CA3388.BBA1A1C5
Content-Type: application/octet-stream;
	name="0001-pselect01-Fixed-the-checking-logic-to-also-consider-.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-pselect01-Fixed-the-checking-logic-to-also-consider-.patch
Content-Disposition: attachment;
	filename="0001-pselect01-Fixed-the-checking-logic-to-also-consider-.patch"

RnJvbSAyMTg5Y2RiZjU1N2UxODAzMmJlMjU4MDdhOGY1MDBjNzUyMzk3OGNhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBub2J1aGlybyA8bm9idWhpcm9AYW5kZXN0ZWNoLmNvbT4KRGF0
ZTogRnJpLCAxMSBTZXAgMjAwOSAyMDo1OTowNCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHBzZWxl
Y3QwMTogRml4ZWQgdGhlIGNoZWNraW5nIGxvZ2ljIHRvIGFsc28gY29uc2lkZXIgc29tZSB2YXJp
YXRpb24uCgpTb21ldGltZXMgd2UgbWF5IGdldCBmYWlsZWQgcmVzdWx0cyB0aGF0IHRoZSBtZWFz
dXJlZCB0aW1lIGlzIDEgc2Vjb25kIGxvbmdlciB0aGFuIGV4cGVjdGVkLgpBcyBmaXhlZCBieSBD
cmFpZyBNZWllciBlYXJsaWVyLCB0aGUgc2xlZXBzIG1heSBsYXN0IHNsaWdodGx5IG1vcmUgdGhh
biB0b3RhbF9zZWMuCkFsc28gY29uc2lkZXJpbmcgdGhlIHRpbWUoKSBvdmVyaGVhZCwgd2Ugc2hv
dWxkIGV4cGVjdCB0aGUgc2xlZXBzIHRvIGxhc3QgYmV0d2Vlbgp0b3RhbF9zZWMgYW5kICh0b3Rh
bF9zZWMrMSkgc2Vjb25kcy4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BzZWxlY3Qv
cHNlbGVjdDAxLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Bz
ZWxlY3QvcHNlbGVjdDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BzZWxlY3QvcHNl
bGVjdDAxLmMKaW5kZXggMDhkMTY4Zi4uMWQyYjNjMSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9wc2VsZWN0L3BzZWxlY3QwMS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvcHNlbGVjdC9wc2VsZWN0MDEuYwpAQCAtMTA4LDcgKzEwOCw3IEBAIGludCBtYWlu
KCkKIAkJCSAgICBOVUxMKTsKIAkJZW5kID0gdGltZSgmdCk7CiAKLQkJaWYgKHRvdGFsX3NlYyA+
PSAoZW5kIC0gc3RhcnQpKQorCQlpZiAoKChlbmQgLSBzdGFydCkgPT0gdG90YWxfc2VjKSB8fCAo
KGVuZCAtIHN0YXJ0KSA9PSB0b3RhbF9zZWMgKyAxKSkKIAkJCXRzdF9yZXNtKFRQQVNTLCAiU2xl
ZXAgdGltZSB3YXMgY29ycmVjdCIpOwogCQllbHNlCiAJCQl0c3RfcmVzbShURkFJTCwgIlNsZWVw
IHRpbWUgd2FzIGluY29ycmVjdDolZCAhPSAlZCIsCi0tIAoxLjYuMy4xCgo=

------_=_NextPart_001_01CA3388.BBA1A1C5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
------_=_NextPart_001_01CA3388.BBA1A1C5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA3388.BBA1A1C5--

