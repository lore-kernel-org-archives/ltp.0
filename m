Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N7SFW-0001HN-KM
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 11:17:30 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N7SFP-0005ij-A8
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 11:17:30 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 09 Nov 2009 16:47:09 +0530
Message-Id: <1257765429.7677.23.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] Clone build fail with the latest CVS sanpshot
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>, Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

TWlrZS9HYXJyZXQsCgpJIGdldCB0aGUgZm9sbG93aW5nIGZhaWx1cmUgd2l0aCB0b2RhecWbIENW
Uy4gLi9jb25maWd1cmUgaGFzIGJlZW4gZG9uZQpiZWZvcmUgbWFrZToKCmdjYyAtZyAtTzIgLWcg
LU8yIC1mbm8tc3RyaWN0LWFsaWFzaW5nIC1waXBlIC1XYWxsCi1JL2x0cC1pbnRlcm1lZGlhdGUt
MjAwOTExMDkvdGVzdGNhc2VzL2tlcm5lbC9pbmNsdWRlCi1JL2x0cC1pbnRlcm1lZGlhdGUtMjAw
OTExMDkvdGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJzL21xbnMvLi4vbGliY2xvbmUgLUkuLi8u
Li8uLi8uLi9pbmNsdWRlIC1JLi4vLi4vLi4vLi4vaW5jbHVkZSAgIC1ML2x0cC1pbnRlcm1lZGlh
dGUtMjAwOTExMDkvdGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJzL21xbnMvLi4vbGliY2xvbmUg
LUwuLi8uLi8uLi8uLi9saWIgIG1xbnNfMDEuYyAgIC1sbHRwIC1sY2xvbmUgLWxwdGhyZWFkIC1s
cnQgLW8gbXFuc18wMQovbHRwLWludGVybWVkaWF0ZS0yMDA5MTEwOS90ZXN0Y2FzZXMva2VybmVs
L2NvbnRhaW5lcnMvbXFucy8uLi9saWJjbG9uZS9saWJjbG9uZS5hKGxpYmNsb25lLm8pOiBJbiBm
dW5jdGlvbiBgZG9fY2xvbmVfdGVzdHMnOgovbHRwLWludGVybWVkaWF0ZS0yMDA5MTEwOS90ZXN0
Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvbGliY2xvbmUvbGliY2xvbmUuYzoyNTogdW5kZWZpbmVk
IHJlZmVyZW5jZSB0byBgbHRwX2Nsb25lX3F1aWNrJwpjb2xsZWN0MjogbGQgcmV0dXJuZWQgMSBl
eGl0IHN0YXR1cwptYWtlWzRdOiAqKiogW21xbnNfMDFdIEVycm9yIDEKClJlZ2FyZHMtLQpTdWJy
YXRhCgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMZXQgQ3J5c3RhbCBSZXBvcnRzIGhhbmRsZSB0
aGUgcmVwb3J0aW5nIC0gRnJlZSBDcnlzdGFsIFJlcG9ydHMgMjAwOCAzMC1EYXkgCnRyaWFsLiBT
aW1wbGlmeSB5b3VyIHJlcG9ydCBkZXNpZ24sIGludGVncmF0aW9uIGFuZCBkZXBsb3ltZW50IC0g
YW5kIGZvY3VzIG9uIAp3aGF0IHlvdSBkbyBiZXN0LCBjb3JlIGFwcGxpY2F0aW9uIGNvZGluZy4g
RGlzY292ZXIgd2hhdCdzIG5ldyB3aXRoCkNyeXN0YWwgUmVwb3J0cyBub3cuICBodHRwOi8vcC5z
Zi5uZXQvc2Z1L2JvYmotanVseQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1s
aXN0Cg==
