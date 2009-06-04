Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1MCA9Q-00027K-W5
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2009 10:26:24 +0000
Received: from e28smtp05.in.ibm.com ([59.145.155.5])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MCA9M-0004Hf-Ar
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2009 10:26:24 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id n54AQFVV015002
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Jun 2009 15:56:15 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n54AQFCC2285628
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Jun 2009 15:56:15 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id n54AQEi6029637
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Jun 2009 20:26:14 +1000
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
In-Reply-To: <4A276FFC.9020807@renesas.com>
References: <1244027049.16185.6.camel@munipradeep-laptop>
	<4A276FFC.9020807@renesas.com>
Date: Thu, 04 Jun 2009 15:56:32 +0530
Message-Id: <1244111192.17248.0.camel@munipradeep-laptop>
Mime-Version: 1.0
Subject: Re: [LTP] LTP May 2009 build failing on RHEL5.4 pre-Alpha
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
To: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: ltp-list@lists.sourceforge.net

SGksCgpJdCBmYWlsZWQgb24gYm90aCB4ODYgYW5kIHg4Nl82NCBhcmNoaXRlY3R1cmVzCgpSZWdh
cmRzCk11bmkKCk9uIFRodSwgMjAwOS0wNi0wNCBhdCAxNTo1NSArMDkwMCwgTm9idWhpcm8gSXdh
bWF0c3Ugd3JvdGU6Cj4gSGksCj4gCj4gTXVuaXByYWRlZXAgQmVlcmFrYW0gd3JvdGU6Cj4gID4g
SGksCj4gID4KPiAgPiBJIHRyaWVkIHRvIGJ1aWxkIHRoZSBMVFAgdGFyYmFsbCBsdHAtZnVsbC0y
MDA5MDUzMS50Z3ogb24gUkhFTDUuNAo+ICA+IHByZS1BbHBoYSBEaXN0cmlidXRpb24uIEJ1dCBi
dWlsZCBmYWlsZWQgd2l0aCB0aGUgZm9sbG93aW5nIGVycm9yOgo+ICA+Cj4gID4gLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gID4KPiAgPiBtYWtlWzRdOiBFbnRlcmluZyBkaXJlY3RvcnkKPiAgPiBgL3Jvb3QvbHRwLWZ1
bGwtMjAwOTA1MzEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZ2V0bWFzaycKPiAgPiBnY2Mg
LWcgLU8yIC1JLi4vLi4vaW5jbHVkZSAtZyAtV2FsbCAtSS4uLy4uLy4uLy4uL2luY2x1ZGUgLVdh
bGwKPiAgPiBzZ2V0bWFzazAxLmMgIC1MLi4vLi4vLi4vLi4vbGliIC1sbHRwIC1vIHNnZXRtYXNr
MDEKPiAgPiBzZ2V0bWFzazAxLmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6Cj4gID4gc2dldG1h
c2swMS5jOjE0MjogZXJyb3I6IOKAmF9fTlJfc3NldG1hc2vigJkgdW5kZWNsYXJlZCAoZmlyc3Qg
dXNlIGluIHRoaXMKPiAgPiBmdW5jdGlvbikKPiAgPiBzZ2V0bWFzazAxLmM6MTQyOiBlcnJvcjog
KEVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkKPiAgPiBvbmNlCj4g
ID4gc2dldG1hc2swMS5jOjE0MjogZXJyb3I6IGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMg
aW4uKQo+ICA+IG1ha2VbNF06ICoqKiBbc2dldG1hc2swMV0gRXJyb3IgMQo+ICA+IG1ha2VbNF06
IExlYXZpbmcgZGlyZWN0b3J5Cj4gID4gYC9yb290L2x0cC1mdWxsLTIwMDkwNTMxL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvc2dldG1hc2snCj4gID4gbWFrZVszXTogKioqIFthbGxdIEVycm9y
IDIKPiAgPiBtYWtlWzNdOiBMZWF2aW5nIGRpcmVjdG9yeQo+ICA+IGAvcm9vdC9sdHAtZnVsbC0y
MDA5MDUzMS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzJwo+ICA+IG1ha2VbMl06ICoqKiBbYWxs
XSBFcnJvciAyCj4gID4gbWFrZVsyXTogTGVhdmluZyBkaXJlY3RvcnkgYC9yb290L2x0cC1mdWxs
LTIwMDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwnCj4gID4gbWFrZVsxXTogKioqIFthbGxdIEVycm9y
IDIKPiAgPiBtYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Jvb3QvbHRwLWZ1bGwtMjAwOTA1
MzEvdGVzdGNhc2VzJwo+ICA+IG1ha2U6ICoqKiBbYWxsXSBFcnJvciAyCj4gID4KPiAgPiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KPiAgPgo+ICA+IFRoZSB2YXJpYWJsZSAnX19OUl9zc2V0bWFzaycgZGVjbGFyYXRpb24g
aXMgYXZhaWxhYmxlIGluIC91c3IvaW5jbHVkZQo+ICA+Cj4gID4gfiMgZ3JlcCAtciAiX19OUl9z
c2V0bWFzayIgL3Vzci9pbmNsdWRlLwo+ICA+IC91c3IvaW5jbHVkZS9iaXRzL3N5c2NhbGwuaDoj
ZGVmaW5lIFNZU19zc2V0bWFzayBfX05SX3NzZXRtYXNrCj4gID4gL3Vzci9pbmNsdWRlL2FzbS1p
Mzg2L3VuaXN0ZC5oOiNkZWZpbmUgX19OUl9zc2V0bWFzayAgICAgICAgICAgICA2OQo+ICA+Cj4g
ID4gV2hhdCBjb3VsZCBiZSB0aGUgcmVhc29uIGZvciBmYWlsdXJlPwo+ICA+Cj4gV2hhdCBraW5k
IG9mIGFyY2ggZG8geW91IHVzZT8KPiB4ODZfNjQ/IEkgYmVjYW1lIHRoZSBzYW1lIHByb2JsZW0g
dG9vLgo+IHg4Nl82NCBkb2VzIG5vdCBzZWVtIHRvIGhhdmUgdGhpcyBzeXN0ZW1jYWxsLgo+IAo+
IEJlc3QgcmVnYXJkcywKPiAgIE5vYnVoaXJvCj4gCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCk9w
ZW5Tb2xhcmlzIDIwMDkuMDYgaXMgYSBjdXR0aW5nIGVkZ2Ugb3BlcmF0aW5nIHN5c3RlbSBmb3Ig
ZW50ZXJwcmlzZXMgCmxvb2tpbmcgdG8gZGVwbG95IHRoZSBuZXh0IGdlbmVyYXRpb24gb2YgU29s
YXJpcyB0aGF0IGluY2x1ZGVzIHRoZSBsYXRlc3QgCmlubm92YXRpb25zIGZyb20gU3VuIGFuZCB0
aGUgT3BlblNvdXJjZSBjb21tdW5pdHkuIERvd25sb2FkIGEgY29weSBhbmQgCmVuam95IGNhcGFi
aWxpdGllcyBzdWNoIGFzIE5ldHdvcmtpbmcsIFN0b3JhZ2UgYW5kIFZpcnR1YWxpemF0aW9uLiAK
R28gdG86IGh0dHA6Ly9wLnNmLm5ldC9zZnUvb3BlbnNvbGFyaXMtZ2V0Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApM
dHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
