Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1Rg7wf-0007rC-0s
	for ltp-list@lists.sourceforge.net; Thu, 29 Dec 2011 04:50:25 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rg7wc-0001l6-MU
	for ltp-list@lists.sourceforge.net; Thu, 29 Dec 2011 04:50:24 +0000
Date: Wed, 28 Dec 2011 23:50:16 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <b43188da-4121-41c3-bbfe-9c1ab377ad4b@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <127b3264-b65b-4768-89e6-e33dfc1234c7@zmail13.collab.prod.int.phx2.redhat.com>
Content-Type: multipart/mixed;
	boundary="=_2d2d5a53-aebd-429b-95f9-9475e79762e9"
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] runtest/mm: add tunable/overcommit_memory
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

--=_2d2d5a53-aebd-429b-95f9-9475e79762e9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

hi,

add the overcommit_memory tests into runtest/mm

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 runtest/mm |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)
-- 
Thanks,
Zhouping Liu

--=_2d2d5a53-aebd-429b-95f9-9475e79762e9
Content-Type: text/x-patch;
	name=0002-runtest-mm-add-tunable-overcommit_memory.patch
Content-Disposition: attachment;
	filename=0002-runtest-mm-add-tunable-overcommit_memory.patch
Content-Transfer-Encoding: base64

RnJvbSA5ZTZkNDIyYWM0ODYwYjJiZjhhOGRmN2UyOGM0NTVmNWU1YTYyMmU0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaG91cGluZyBMaXUgPHpsaXVAcmVkaGF0LmNvbT4KRGF0ZTog
VGh1LCAyOSBEZWMgMjAxMSAxMjo0NDozMCArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBydW50
ZXN0L21tOiBhZGQgdHVuYWJsZS9vdmVyY29tbWl0X21lbW9yeQoKYWRkIHRoZSBvdmVyY29tbWl0
X21lbW9yeSB0ZXN0cyBpbnRvIHJ1bnRlc3QvbW0KClNpZ25lZC1vZmYtYnk6IFpob3VwaW5nIExp
dSA8emxpdUByZWRoYXQuY29tPgotLS0KIHJ1bnRlc3QvbW0gfCAgICA3ICsrKysrKysKIDEgZmls
ZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3J1bnRlc3QvbW0gYi9ydW50ZXN0L21tCmluZGV4IDlkZDFkZTAuLjViNjM2MTEgMTAwNjQ0Ci0t
LSBhL3J1bnRlc3QvbW0KKysrIGIvcnVudGVzdC9tbQpAQCAtODQsMyArODQsMTAgQEAgdm1hMDEg
dm1hMDEKIHZtYTAyIHZtYTAyCiAKIHpyYW0wMSB6cmFtMDEKKworb3ZlcmNvbW1pdF9tZW1vcnkg
b3ZlcmNvbW1pdF9tZW1vcnkKK292ZXJjb21taXRfbWVtb3J5IG92ZXJjb21taXRfbWVtb3J5IC1S
IDAKK292ZXJjb21taXRfbWVtb3J5IG92ZXJjb21taXRfbWVtb3J5IC1SIDMwCitvdmVyY29tbWl0
X21lbW9yeSBvdmVyY29tbWl0X21lbW9yeSAtUiA4MAorb3ZlcmNvbW1pdF9tZW1vcnkgb3ZlcmNv
bW1pdF9tZW1vcnkgLVIgMTAwCitvdmVyY29tbWl0X21lbW9yeSBvdmVyY29tbWl0X21lbW9yeSAt
UiAyMDAKLS0gCjEuNy43LjQKCg==

--=_2d2d5a53-aebd-429b-95f9-9475e79762e9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
--=_2d2d5a53-aebd-429b-95f9-9475e79762e9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=_2d2d5a53-aebd-429b-95f9-9475e79762e9--

