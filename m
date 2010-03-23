Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nu0ag-0003O4-J2
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 09:40:02 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nu0af-0004hp-C5
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 09:40:02 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2N9ZQ6j008502
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 05:35:26 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2N9dtTF151324
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 05:39:55 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2N9dtde023680
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 06:39:55 -0300
Received: from rishikesh.in.ibm.com ([9.124.35.169])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o2N9dsRG023635
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 06:39:55 -0300
Received: from rishikesh.in.ibm.com (rishikesh.in.ibm.com [127.0.0.1])
	by rishikesh.in.ibm.com (Postfix) with ESMTP id 8F8E76080D
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Mar 2010 15:09:53 +0530 (IST)
Received: (from rishikesh@localhost)
	by rishikesh.in.ibm.com (8.14.3/8.14.3/Submit) id o2N9drPH012510
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 15:09:53 +0530
Date: Tue, 23 Mar 2010 15:09:53 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100323093953.GE4384@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] Removed Warning from filecaps
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

VGhlc2Ugd2FybmluZyB3aWxsIGFwcGVhciB3aGVuIEhBVkVfTElCQ0FQIGlzIG5vdCBkZWZpbmVk
LgoKYy5jOiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgpjLmM6Mjg6IHdhcm5pbmc6IHVudXNlZCB2
YXJpYWJsZSDigJhyZXTigJkKYy5jOjI3OiB3YXJuaW5nOiB1bnVzZWQgdmFyaWFibGUg4oCYY2Fw
czLigJkKYy5jOjI3OiB3YXJuaW5nOiB1bnVzZWQgdmFyaWFibGUg4oCYY2Fwc+KAmQoKU2lnbmVk
LW9mZiBCeTogUmlzaGlrZXNoIEsgUmFqYWs8cmlzcmFqYWtAbGludXgudm5ldC5pYm0uY29tPgot
LS0KZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvZmlsZWNhcHMvYy5jIGIv
dGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9maWxlY2Fwcy9jLmMKaW5kZXggZWU2Y2YwNS4uNWUx
Njk2YyAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9maWxlY2Fwcy9jLmMK
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9maWxlY2Fwcy9jLmMKQEAgLTI0LDEwICsy
NCwxMSBAQAogCiBpbnQgbWFpbigpCiB7CisKKyNpZmRlZiBIQVZFX0xJQkNBUAogICAgICAgIGNh
cF90IGNhcHMsIGNhcHMyOwogICAgICAgIGludCByZXQ7CiAKLSNpZmRlZiBIQVZFX0xJQkNBUAog
ICAgICAgIGNhcHMgPSBjYXBfZnJvbV90ZXh0KCJjYXBfc2V0cGNhcCtlcCIpOwogICAgICAgIGNh
cHMyID0gY2FwX2Zyb21fdGV4dCgiY2FwX3NldHBjYXArZXAiKTsKICAgICAgICByZXQgPSBjYXBf
c2V0X3Byb2MoY2Fwcyk7CgotLSAKVGhhbmtzICYgUmVnYXJkcwpSaXNoaQpMVFAgTWFpbnRhaW5l
cgpJQk0sIExUQywgQmFuZ2Fsb3JlClBsZWFzZSBqb2luIElSQyAjbHRwIEAgaXJjLmZyZWVub2Rl
Lm5ldAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkRvd25sb2FkIEludGVsJiMxNzQ7IFBhcmFsbGVs
IFN0dWRpbyBFdmFsClRyeSB0aGUgbmV3IHNvZnR3YXJlIHRvb2xzIGZvciB5b3Vyc2VsZi4gU3Bl
ZWQgY29tcGlsaW5nLCBmaW5kIGJ1Z3MKcHJvYWN0aXZlbHksIGFuZCBmaW5lLXR1bmUgYXBwbGlj
YXRpb25zIGZvciBwYXJhbGxlbCBwZXJmb3JtYW5jZS4KU2VlIHdoeSBJbnRlbCBQYXJhbGxlbCBT
dHVkaW8gZ290IGhpZ2ggbWFya3MgZHVyaW5nIGJldGEuCmh0dHA6Ly9wLnNmLm5ldC9zZnUvaW50
ZWwtc3ctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Ckx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
