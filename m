Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N9wJ9-0002fU-An
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 07:47:31 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N9wJ2-0001PW-2o
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 07:47:31 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 16 Nov 2009 13:17:13 +0530
Message-Id: <1258357633.5677.24.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] One 1 remaining Build Error with LTP CVS 2009-11-16
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
To: Garrett Cooper <yanegomi@gmail.com>, Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list <ltp-list@lists.sf.net>

TWlrZS9HYXJyZXQsCgpUaGVyZSByZW1haW5zIG9ubHkgMSBidWlsZCBlcnJvciBub3cgd2l0aCB0
aGUgTFRQIENWUy4gVGhpcyBoYXBwZW5zIHRvIGJlIHRoZSBpc3N1ZSB3aXRoIGx0cC90ZXN0Y2Fz
ZXMva2VybmVsL2NvbnRhaW5lcnMvbGliY2xvbmUvTWFrZWZpbGUuCkl0IGlzIG5vdCBhYmxlIHRv
IHRvIGluY2x1ZGUgPHRlc3QuaD4sIDx1c2N0ZXN0Lmg+IGFuZCBsaW51eF9zeXNjYWxsX251bWJl
cnMuaC4gSG93ZXZlciwgaSBqdXN0IG1hZGUgdGVtcG9yYXJ5IGNoYW5nZXMgaW4gbXkgbG9jYWwg
cmVwbyB0byBmaXggdGhpczoKCiMgaGVhZCAtMzQgdGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJz
L2xpYmNsb25lL2xpYmNsb25lLmggfCB0YWlsIC01CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1
ZGUgIi4uLy4uL2luY2x1ZGUvbGludXhfc3lzY2FsbF9udW1iZXJzLmgiCiNpbmNsdWRlICJ0ZXN0
LmgiCiNpbmNsdWRlICJ1c2N0ZXN0LmgiCgpDYW4geW91IHBsZWFzZSBmaXggdGhpcyB1cCBpbiBD
VlMgPyBGb2xsb3dpbmcgZXJyb3IgaXMgZ2VuZXJhdGVkIG9uIGNvbXBpbGF0aW9uOgoKbWFrZVs0
XTogRW50ZXJpbmcgZGlyZWN0b3J5IGAvaG9tZS9zdWJyYXRhbW9kYWsvT0ZGSUNFX1dPUktTL0xU
UF9QUk9KRUNUX0NPREUvTFRQX1RBUlMvT0NUT0JFUl8yMDA5X1JFTEVBU0UvbHRwLWludGVybWVk
aWF0ZS0yMDA5MTExNi90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvbGliY2xvbmUnCmdjYyAt
ZyAtTzIgLWcgLU8yIC1mbm8tc3RyaWN0LWFsaWFzaW5nIC1waXBlIC1XYWxsICAtSS4uLy4uLy4u
Ly4uL2luY2x1ZGUgLUkuLi8uLi8uLi8uLi9pbmNsdWRlICAtYyAtbyBsaWJjbG9uZS5vIGxpYmNs
b25lLmMKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGxpYmNsb25lLmM6MTc6CmxpYmNsb25lLmg6MzE6
MzU6IGVycm9yOiBsaW51eF9zeXNjYWxsX251bWJlcnMuaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVj
dG9yeQpsaWJjbG9uZS5jOiBJbiBmdW5jdGlvbiDigJhkb19jbG9uZV90ZXN0c+KAmToKbGliY2xv
bmUuYzoyNTogd2FybmluZzogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYbHRw
X2Nsb25lX3F1aWNr4oCZCm1ha2VbNF06ICoqKiBbbGliY2xvbmUub10gRXJyb3IgMQoKUmVnYXJk
cy0tClN1YnJhdGEKCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxldCBDcnlzdGFsIFJlcG9ydHMg
aGFuZGxlIHRoZSByZXBvcnRpbmcgLSBGcmVlIENyeXN0YWwgUmVwb3J0cyAyMDA4IDMwLURheSAK
dHJpYWwuIFNpbXBsaWZ5IHlvdXIgcmVwb3J0IGRlc2lnbiwgaW50ZWdyYXRpb24gYW5kIGRlcGxv
eW1lbnQgLSBhbmQgZm9jdXMgb24gCndoYXQgeW91IGRvIGJlc3QsIGNvcmUgYXBwbGljYXRpb24g
Y29kaW5nLiBEaXNjb3ZlciB3aGF0J3MgbmV3IHdpdGgKQ3J5c3RhbCBSZXBvcnRzIG5vdy4gIGh0
dHA6Ly9wLnNmLm5ldC9zZnUvYm9iai1qdWx5Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGlu
Zm8vbHRwLWxpc3QK
