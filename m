Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1W0WzK-0002TU-AQ
	for ltp-list@lists.sourceforge.net; Tue, 07 Jan 2014 13:46:34 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W0WzG-0006iT-RD
	for ltp-list@lists.sourceforge.net; Tue, 07 Jan 2014 13:46:34 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s07DkOmE008228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jan 2014 08:46:24 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s07DkNGT006781
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jan 2014 08:46:24 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  7 Jan 2014 14:46:15 +0100
Message-Id: <c3a64332100498deedfb1b27b83545e42deb2d54.1389101980.git.jstancek@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/3] lib: errnos: use ERFKILL only if it's defined
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
To: ltp-list@lists.sourceforge.net

VGhpcyBpcyB0byBmaXggY29tcGlsYXRpb24gb24gUkhFTDUuMzoKICBJbiBmaWxlIGluY2x1ZGVk
IGZyb20gdHN0X3Jlcy5jOjIxNjoKICBlcnJub3MuaDogSW4gZnVuY3Rpb24g4oCYc3RyZXJybm9k
ZWbigJk6CiAgZXJybm9zLmg6MTY0OiBlcnJvcjog4oCYRVJGS0lMTOKAmSB1bmRlY2xhcmVkIChm
aXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKICBlcnJub3MuaDoxNjQ6IGVycm9yOiAoRWFjaCB1
bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlCiAgZXJybm9zLmg6MTY0
OiBlcnJvcjogZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbi4pCiAgZXJybm9zLmg6MTY0
OiBlcnJvcjogYXJyYXkgaW5kZXggaW4gaW5pdGlhbGl6ZXIgbm90IG9mIGludGVnZXIgdHlwZQog
IGVycm5vcy5oOjE2NDogZXJyb3I6IChuZWFyIGluaXRpYWxpemF0aW9uIGZvciDigJhlcnJub19w
YWlyc+KAmSkKICBtYWtlWzFdOiAqKiogW3RzdF9yZXMub10gRXJyb3IgMQoKU2lnbmVkLW9mZi1i
eTogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Ci0tLQogbGliL2Vycm5vcy5oIHwg
ICAgMiArKwogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvbGliL2Vycm5vcy5oIGIvbGliL2Vycm5vcy5oCmluZGV4IDc5N2FlZDQu
LmVlOTYyMGIgMTAwNjQ0Ci0tLSBhL2xpYi9lcnJub3MuaAorKysgYi9saWIvZXJybm9zLmgKQEAg
LTE2MSw3ICsxNjEsOSBAQCBzdGF0aWMgY29uc3QgY2hhciAqc3RyZXJybm9kZWYoaW50IGVycikK
IAkJUEFJUihFS0VZUkVKRUNURUQpCiAJCVBBSVIoRU9XTkVSREVBRCkKIAkJUEFJUihFTk9UUkVD
T1ZFUkFCTEUpCisjaWZkZWYgRVJGS0lMTAogCQlQQUlSKEVSRktJTEwpCisjZW5kaWYKICNpZmRl
ZiBFSFdQT0lTT04KIAkJUEFJUihFSFdQT0lTT04pCiAjZW5kaWYKLS0gCjEuNy4xCgoKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tClJhcGlkbHkgdHJvdWJsZXNob290IHByb2JsZW1zIGJlZm9yZSB0aGV5
IGFmZmVjdCB5b3VyIGJ1c2luZXNzLiBNb3N0IElUIApvcmdhbml6YXRpb25zIGRvbid0IGhhdmUg
YSBjbGVhciBwaWN0dXJlIG9mIGhvdyBhcHBsaWNhdGlvbiBwZXJmb3JtYW5jZSAKYWZmZWN0cyB0
aGVpciByZXZlbnVlLiBXaXRoIEFwcER5bmFtaWNzLCB5b3UgZ2V0IDEwMCUgdmlzaWJpbGl0eSBp
bnRvIHlvdXIgCkphdmEsLk5FVCwgJiBQSFAgYXBwbGljYXRpb24uIFN0YXJ0IHlvdXIgMTUtZGF5
IEZSRUUgVFJJQUwgb2YgQXBwRHluYW1pY3MgUHJvIQpodHRwOi8vcHViYWRzLmcuZG91YmxlY2xp
Y2submV0L2dhbXBhZC9jbGs/aWQ9ODQzNDk4MzEmaXU9LzQxNDAvb3N0Zy5jbGt0cmsKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGlu
ZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
