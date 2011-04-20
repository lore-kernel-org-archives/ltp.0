Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1QCXw8-0003hi-0R
	for ltp-list@lists.sourceforge.net; Wed, 20 Apr 2011 13:59:20 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QCXw7-0007na-0d
	for ltp-list@lists.sourceforge.net; Wed, 20 Apr 2011 13:59:19 +0000
Date: Wed, 20 Apr 2011 09:59:11 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1340377970.49928.1303307951314.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <BANLkTini_6Bk04Vm9di+88pgcYDBzY+ubA@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] cgroups/cpuacct_setup: fix task_kill() search for
 process
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gRnJvbTogIkdhcnJldHQgQ29vcGVyIiA8
eWFuZWdvbWlAZ21haWwuY29tPgo+IFRvOiAiSmFuIFN0YW5jZWsiIDxqc3RhbmNla0ByZWRoYXQu
Y29tPgo+IENjOiBsdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiBTZW50OiBXZWRuZXNk
YXksIEFwcmlsIDIwLCAyMDExIDg6MTQ6NDYgQU0KPiBTdWJqZWN0OiBSZTogW0xUUF0gW1BBVENI
XSBjZ3JvdXBzL2NwdWFjY3Rfc2V0dXA6IGZpeCB0YXNrX2tpbGwoKSBzZWFyY2ggZm9yIHByb2Nl
c3MKPiBPbiBUdWUsIEFwciAxOSwgMjAxMSBhdCA2OjE2IEFNLCBKYW4gU3RhbmNlayA8anN0YW5j
ZWtAcmVkaGF0LmNvbT4KPiB3cm90ZToKPiA+Cj4gPiAxLiAiaSogaW4gImdyZXAgY3B1YWNjdF90
YXNraSoiIHNlZW1zIHBvaW50bGVzcyBhcwo+ID4gaXRzIHRhcmdldCBpcyBjcHVhY2N0X3Rhc2sw
MQo+ID4KPiA+IDIuIHVzaW5nIGN1dCBmYWlscyB3aGVuIHBzIGluZGVudHMgdGhlIG91dHB1dCBh
cyBmb2xsb3dpbmc6Cj4gPiDCoDk5IGNwdWFjY3RfdGFzazAxCj4gPiDCoDExMiBjcHVhY2N0X3Rh
c2swMQo+ID4gMTExMSBjcHVhY2N0X3Rhc2swMQo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEphbiBT
dGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgo+IAo+IFBhdGNoIGRvZXNuJ3QgYXBwbHkuCgpJ
IGd1ZXNzIEkgZm91bmQgYW5vdGhlciBiYWQgYmVoYXZpbmcgY2xpZW50OiBaaW1icmEgd2VibWFp
bApJdCBjb252ZXJ0ZWQgYWxsIExGIHRvIENSL0xGLiAKCkknbSBnb2luZyB0byB0cnkgc29tZXRo
aW5nIGVsc2UgZm9yIHYyIChmaW5nZXJzIGNyb3NzZWQpLgoKPiBUaGFua3MsCj4gLUdhcnJldHQK
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpCZW5lZml0aW5nIGZyb20gU2VydmVyIFZpcnR1YWxpemF0
aW9uOiBCZXlvbmQgSW5pdGlhbCBXb3JrbG9hZCAKQ29uc29saWRhdGlvbiAtLSBJbmNyZWFzaW5n
IHRoZSB1c2Ugb2Ygc2VydmVyIHZpcnR1YWxpemF0aW9uIGlzIGEgdG9wCnByaW9yaXR5LlZpcnR1
YWxpemF0aW9uIGNhbiByZWR1Y2UgY29zdHMsIHNpbXBsaWZ5IG1hbmFnZW1lbnQsIGFuZCBpbXBy
b3ZlIAphcHBsaWNhdGlvbiBhdmFpbGFiaWxpdHkgYW5kIGRpc2FzdGVyIHByb3RlY3Rpb24uIExl
YXJuIG1vcmUgYWJvdXQgYm9vc3RpbmcgCnRoZSB2YWx1ZSBvZiBzZXJ2ZXIgdmlydHVhbGl6YXRp
b24uIGh0dHA6Ly9wLnNmLm5ldC9zZnUvdm13YXJlLXNmZGV2MmRldgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRw
LWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
