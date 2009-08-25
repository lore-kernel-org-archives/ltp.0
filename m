Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1MfsQx-00017J-Um
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:35:19 +0000
Received: from smtp100.biz.mail.re2.yahoo.com ([206.190.52.46])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MfsQr-0003vW-F7
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:35:19 +0000
Date: Tue, 25 Aug 2009 17:36:15 +0800 (CST)
Message-Id: <20090825.173615.866357745773642713.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
In-Reply-To: <1251192163.5534.13.camel@subratamodak.linux.ibm.com>
References: <1251184057.5534.4.camel@subratamodak.linux.ibm.com>
	<20090825.163437.1076064300636358628.caiqian@cclom.cn>
	<1251192163.5534.13.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Let set_thread_area Choose either user_desc or
 modify_ldt_ldt_s
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
To: ltp-list@lists.sf.net

RnJvbTogU3VicmF0YSBNb2RhayA8c3VicmF0YUBsaW51eC52bmV0LmlibS5jb20+DQpTdWJqZWN0
OiBSZTogW0xUUF0gW1BBVENIXSBMZXQgc2V0X3RocmVhZF9hcmVhIENob29zZSBlaXRoZXIgdXNl
cl9kZXNjIG9yIG1vZGlmeV9sZHRfbGR0X3MNCkRhdGU6IFR1ZSwgMjUgQXVnIDIwMDkgMTQ6NTI6
NDMgKzA1MzANCg0KPiANCj4gVGhhdMWbIGhvdyB0aGUgYmFzaWMgdGVtcGxhdGUgZm9yIExUUCB0
ZXN0IGNhc2VzIHdvcmsuIEluY2x1ZGUgdGhlIExUUA0KPiBsaWJyYXJ5IHNwZWNpZmljIGhlYWRl
cnMgb25seSBmcm9tIHdpdGhpbiB0aGUgVGVzdCBjYXNlIHNvdXJjZSBjb2RlLiBBbmQNCj4gYWxz
byBpdCBpcyBsb2dpY2FsIHRvIG91dCBvbmx5IHRoZSBzZXRfdGhyZWFkKiBzcGVjaWZpYyBzdHVm
ZiBpbiBpdMWbIG93bg0KPiBzcGVjaWZpYyBoZWFkZXIgYXMgeW91IGFyZSBkb2luZy4NCj4gDQoN
ClNvLCB0aGUgY29kZSB3aWxsIG5vdCB3b3JrIHNvbWV3aGVyZSBpZiBtb3ZlIHRoZSBMVFAgbGli
cmFyeSBzcGVjaWZpYw0KaGVhZGVycyB0byBhIGNvbW1vbiBoZWFkZXI/IFRob3NlIHRlc3RzIGFy
ZSB1c2luZyB0aGUgc2FtZSBMVFAgc3BlY2lmaWMNCmhlYWRlcnMsIHNvIHdvbid0IGl0IHNpbXBs
ZXIgZnJvbSB0aGUgbWFpbnRlbmFuY2UgcG9pbnQgb2YgdmlldyB0byBoYXZlDQphbGwgaGVhZGVy
cyBpbiB0aGUgc2FtZSBwbGFjZSBpZiBwb3NzaWJsZT8gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSAi
aXQgaXMNCmxvZ2ljYWwgdG8gb3V0IG9ubHkgdGhlIHNldF90aHJlYWQqIHNwZWNpZmljIHN0dWZm
IGluIGl0xZsgb3duIHNwZWNpZmljDQpoZWFkZXIiLiBUaG9zZSBMVFAgc3BlY2lmaWMgaGVhZGVy
cyBhcmUgYWxzbyByZXF1aXJlZCBmb3IgdGhvc2UgdGVzdHMgdG8NCnJ1bi4NCg0KQ0FJIFFpYW4N
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMZXQgQ3J5c3RhbCBSZXBvcnRzIGhhbmRsZSB0aGUgcmVw
b3J0aW5nIC0gRnJlZSBDcnlzdGFsIFJlcG9ydHMgMjAwOCAzMC1EYXkgCnRyaWFsLiBTaW1wbGlm
eSB5b3VyIHJlcG9ydCBkZXNpZ24sIGludGVncmF0aW9uIGFuZCBkZXBsb3ltZW50IC0gYW5kIGZv
Y3VzIG9uIAp3aGF0IHlvdSBkbyBiZXN0LCBjb3JlIGFwcGxpY2F0aW9uIGNvZGluZy4gRGlzY292
ZXIgd2hhdCdzIG5ldyB3aXRoIApDcnlzdGFsIFJlcG9ydHMgbm93LiAgaHR0cDovL3Auc2YubmV0
L3NmdS9ib2JqLWp1bHkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5l
dApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
