Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1MBoGG-0001Yw-Mz
	for ltp-list@lists.sourceforge.net; Wed, 03 Jun 2009 11:04:00 +0000
Received: from e28smtp01.in.ibm.com ([59.145.155.1])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MBoGC-0005aC-Vr
	for ltp-list@lists.sourceforge.net; Wed, 03 Jun 2009 11:04:00 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp01.in.ibm.com (8.13.1/8.13.1) with ESMTP id n53B3rP5015736
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Jun 2009 16:33:53 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n53B3r582150498
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Jun 2009 16:33:53 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n53B3q85015089
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Jun 2009 16:33:52 +0530
Received: from [9.124.158.24] (E67wks351459wss.in.ibm.com [9.124.158.24])
	by d28av01.in.ibm.com (8.13.1/8.12.11) with ESMTP id n53B3qgs015086
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Jun 2009 16:33:52 +0530
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Date: Wed, 03 Jun 2009 16:34:09 +0530
Message-Id: <1244027049.16185.6.camel@munipradeep-laptop>
Mime-Version: 1.0
Subject: [LTP] LTP May 2009 build failing on RHEL5.4 pre-Alpha
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

SGksCgpJIHRyaWVkIHRvIGJ1aWxkIHRoZSBMVFAgdGFyYmFsbCBsdHAtZnVsbC0yMDA5MDUzMS50
Z3ogb24gUkhFTDUuNApwcmUtQWxwaGEgRGlzdHJpYnV0aW9uLiBCdXQgYnVpbGQgZmFpbGVkIHdp
dGggdGhlIGZvbGxvd2luZyBlcnJvcjoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKbWFrZVs0XTogRW50ZXJpbmcgZGly
ZWN0b3J5CmAvcm9vdC9sdHAtZnVsbC0yMDA5MDUzMS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3NnZXRtYXNrJwpnY2MgLWcgLU8yIC1JLi4vLi4vaW5jbHVkZSAtZyAtV2FsbCAtSS4uLy4uLy4u
Ly4uL2luY2x1ZGUgLVdhbGwKc2dldG1hc2swMS5jICAtTC4uLy4uLy4uLy4uL2xpYiAtbGx0cCAt
byBzZ2V0bWFzazAxCnNnZXRtYXNrMDEuYzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToKc2dldG1h
c2swMS5jOjE0MjogZXJyb3I6IOKAmF9fTlJfc3NldG1hc2vigJkgdW5kZWNsYXJlZCAoZmlyc3Qg
dXNlIGluIHRoaXMKZnVuY3Rpb24pCnNnZXRtYXNrMDEuYzoxNDI6IGVycm9yOiAoRWFjaCB1bmRl
Y2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seQpvbmNlCnNnZXRtYXNrMDEuYzoxNDI6
IGVycm9yOiBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluLikKbWFrZVs0XTogKioqIFtz
Z2V0bWFzazAxXSBFcnJvciAxCm1ha2VbNF06IExlYXZpbmcgZGlyZWN0b3J5CmAvcm9vdC9sdHAt
ZnVsbC0yMDA5MDUzMS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NnZXRtYXNrJwptYWtlWzNd
OiAqKiogW2FsbF0gRXJyb3IgMgptYWtlWzNdOiBMZWF2aW5nIGRpcmVjdG9yeQpgL3Jvb3QvbHRw
LWZ1bGwtMjAwOTA1MzEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscycKbWFrZVsyXTogKioqIFth
bGxdIEVycm9yIDIKbWFrZVsyXTogTGVhdmluZyBkaXJlY3RvcnkgYC9yb290L2x0cC1mdWxsLTIw
MDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwnCm1ha2VbMV06ICoqKiBbYWxsXSBFcnJvciAyCm1ha2Vb
MV06IExlYXZpbmcgZGlyZWN0b3J5IGAvcm9vdC9sdHAtZnVsbC0yMDA5MDUzMS90ZXN0Y2FzZXMn
Cm1ha2U6ICoqKiBbYWxsXSBFcnJvciAyCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KClRoZSB2YXJpYWJsZSAnX19OUl9z
c2V0bWFzaycgZGVjbGFyYXRpb24gaXMgYXZhaWxhYmxlIGluIC91c3IvaW5jbHVkZQoKfiMgZ3Jl
cCAtciAiX19OUl9zc2V0bWFzayIgL3Vzci9pbmNsdWRlLwovdXNyL2luY2x1ZGUvYml0cy9zeXNj
YWxsLmg6I2RlZmluZSBTWVNfc3NldG1hc2sgX19OUl9zc2V0bWFzawovdXNyL2luY2x1ZGUvYXNt
LWkzODYvdW5pc3RkLmg6I2RlZmluZSBfX05SX3NzZXRtYXNrICAgICAgICAgICAgIDY5CgpXaGF0
IGNvdWxkIGJlIHRoZSByZWFzb24gZm9yIGZhaWx1cmU/CgpUaGFua3MKTXVuaQoKCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQpPcGVuU29sYXJpcyAyMDA5LjA2IGlzIGEgY3V0dGluZyBlZGdlIG9wZXJh
dGluZyBzeXN0ZW0gZm9yIGVudGVycHJpc2VzIApsb29raW5nIHRvIGRlcGxveSB0aGUgbmV4dCBn
ZW5lcmF0aW9uIG9mIFNvbGFyaXMgdGhhdCBpbmNsdWRlcyB0aGUgbGF0ZXN0IAppbm5vdmF0aW9u
cyBmcm9tIFN1biBhbmQgdGhlIE9wZW5Tb3VyY2UgY29tbXVuaXR5LiBEb3dubG9hZCBhIGNvcHkg
YW5kIAplbmpveSBjYXBhYmlsaXRpZXMgc3VjaCBhcyBOZXR3b3JraW5nLCBTdG9yYWdlIGFuZCBW
aXJ0dWFsaXphdGlvbi4gCkdvIHRvOiBodHRwOi8vcC5zZi5uZXQvc2Z1L29wZW5zb2xhcmlzLWdl
dApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlz
dCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
