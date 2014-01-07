Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1W0WzJ-0005H7-MK
	for ltp-list@lists.sourceforge.net; Tue, 07 Jan 2014 13:46:33 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W0WzI-0000Ga-Gy
	for ltp-list@lists.sourceforge.net; Tue, 07 Jan 2014 13:46:33 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s07DkQRd008242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jan 2014 08:46:26 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s07DkNGV006781
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jan 2014 08:46:26 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  7 Jan 2014 14:46:17 +0100
Message-Id: <0b8108bfd30d8b684c7c264670254473fb8c43d3.1389101980.git.jstancek@redhat.com>
In-Reply-To: <c3a64332100498deedfb1b27b83545e42deb2d54.1389101980.git.jstancek@redhat.com>
References: <c3a64332100498deedfb1b27b83545e42deb2d54.1389101980.git.jstancek@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/3] syscalls/dup3_02: define O_CLOEXEC if needed
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

VGhpcyBpcyB0byBmaXggY29tcGlsYXRpb24gb24gUkhFTDUuMzoKICBnY2MgLWcgLU8yIC1nIC1P
MiAtZm5vLXN0cmljdC1hbGlhc2luZyAtcGlwZSAtV2FsbCAtRF9GT1JUSUZZX1NPVVJDRT0yCiAg
LUkvcm9vdC9sdHAvdGVzdGNhc2VzL2tlcm5lbC9pbmNsdWRlIC1JLi4vLi4vLi4vLi4vaW5jbHVk
ZQogIC1JLi4vLi4vLi4vLi4vaW5jbHVkZSAgIC1MLi4vLi4vLi4vLi4vbGliICBkdXAzXzAyLmMg
ICAtbGx0cCAtbyBkdXAzXzAyCiAgZHVwM18wMi5jOjU1OiBlcnJvcjog4oCYT19DTE9FWEVD4oCZ
IHVuZGVjbGFyZWQgaGVyZSAobm90IGluIGEgZnVuY3Rpb24pCiAgbWFrZVs0XTogKioqIFtkdXAz
XzAyXSBFcnJvciAxCiAgbWFrZVs0XTogTGVhdmluZyBkaXJlY3RvcnkgYC9yb290L2x0cC90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2R1cDMnCiAgbWFrZVszXTogKioqIFthbGxdIEVycm9yIDIK
CkluIHNpbWlsYXIgbWFubmVyIGFzIGluIGR1cDNfMDEuYywgZGVmaW5lIE9fQ0xPRVhFQyBpZiBu
ZWVkZWQuCgpTaWduZWQtb2ZmLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4K
LS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2R1cDMvZHVwM18wMi5jIHwgICAgMyArKysK
IDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZHVwMy9kdXAzXzAyLmMgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2R1cDMvZHVwM18wMi5jCmluZGV4IDA0MDFkZGMuLjNhNDU1ZGEg
MTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZHVwMy9kdXAzXzAyLmMKKysr
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9kdXAzL2R1cDNfMDIuYwpAQCAtMzcsNiArMzcs
OSBAQAogI2luY2x1ZGUgInNhZmVfbWFjcm9zLmgiCiAjaW5jbHVkZSAibGludXhfc3lzY2FsbF9u
dW1iZXJzLmgiCiAKKyNpZm5kZWYgT19DTE9FWEVDCisjZGVmaW5lIE9fQ0xPRVhFQyAwMjAwMDAw
MAorI2VuZGlmCiAKIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpOwogc3RhdGljIHZvaWQgY2xlYW51
cCh2b2lkKTsKLS0gCjEuNy4xCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClJhcGlkbHkgdHJvdWJs
ZXNob290IHByb2JsZW1zIGJlZm9yZSB0aGV5IGFmZmVjdCB5b3VyIGJ1c2luZXNzLiBNb3N0IElU
IApvcmdhbml6YXRpb25zIGRvbid0IGhhdmUgYSBjbGVhciBwaWN0dXJlIG9mIGhvdyBhcHBsaWNh
dGlvbiBwZXJmb3JtYW5jZSAKYWZmZWN0cyB0aGVpciByZXZlbnVlLiBXaXRoIEFwcER5bmFtaWNz
LCB5b3UgZ2V0IDEwMCUgdmlzaWJpbGl0eSBpbnRvIHlvdXIgCkphdmEsLk5FVCwgJiBQSFAgYXBw
bGljYXRpb24uIFN0YXJ0IHlvdXIgMTUtZGF5IEZSRUUgVFJJQUwgb2YgQXBwRHluYW1pY3MgUHJv
IQpodHRwOi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0L2dhbXBhZC9jbGs/aWQ9ODQzNDk4MzEm
aXU9LzQxNDAvb3N0Zy5jbGt0cmsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAt
bGlzdAo=
