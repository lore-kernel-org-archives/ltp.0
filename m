Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1NfYdA-0001WT-R1
	for ltp-list@lists.sourceforge.net; Thu, 11 Feb 2010 12:58:52 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NfYd9-0001Ro-50
	for ltp-list@lists.sourceforge.net; Thu, 11 Feb 2010 12:58:52 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id o1BCU8mu029250
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Feb 2010 23:30:08 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1BCOx0o1638466
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Feb 2010 23:24:59 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1BCU7ie007138
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Feb 2010 23:30:08 +1100
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Date: Thu, 11 Feb 2010 18:00:06 +0530
Message-ID: <1265891406.10768.10.camel@munipradeep-laptop>
Mime-Version: 1.0
Subject: [LTP] memory_hotplug tests are not compiling properly
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
To: risrajak@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

SGkgUmlzaGksCgpJIGFtIHVuYWJsZSB0byBjb21waWxlIHRoZSBtZW1vcnlfaG90cGx1ZyB0ZXN0
cyBpbiBMVFAgU2VwIDIwMDkgcmVsZWFzZS4KSSBhbSBnZXR0aW5nIHRoZSBiZWxvdyBlcnJvci4K
CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpjYyAtc3Rk
PWdudTk5IC1PMiAgLURfR05VX1NPVVJDRSAtRF9ORUVEX01JR1JBVEVfUEFHRVMgICAgIC1jIC1v
Cm1lbXRveS5vIG1lbXRveS5jCmNjIC1zdGQ9Z251OTkgLU8yICAtRF9HTlVfU09VUkNFIC1EX05F
RURfTUlHUkFURV9QQUdFUyAgICAgLWMgLW8KY29tbWFuZHMubyBjb21tYW5kcy5jCkluIGZpbGUg
aW5jbHVkZWQgZnJvbSBjb21tYW5kcy5jOjQ1OgptaWdyYXRlX3BhZ2VzLmg6MTA6IGVycm9yOiBj
b25mbGljdGluZyB0eXBlcyBmb3Ig4oCYbWlncmF0ZV9wYWdlc+KAmQovdXNyL2luY2x1ZGUvbnVt
YWlmLmg6MTc6IGVycm9yOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBvZiDigJhtaWdyYXRlX3BhZ2Vz
4oCZCndhcyBoZXJlCm1ha2U6ICoqKiBbY29tbWFuZHMub10gRXJyb3IgMQojIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKCkV2ZW4gdGhlIHBhdGNoIGlzIG5v
dCBhcHBseWluZyBwcm9wZXJseS4gCgpAQWxsLCBBbnkgaGVscCBpcyBhcHByZWNpYXRlZC4KClRo
YW5rcwpNdW5pCgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpTT0xBUklTIDEwIGlzIHRoZSBPUyBm
b3IgRGF0YSBDZW50ZXJzIC0gcHJvdmlkZXMgZmVhdHVyZXMgc3VjaCBhcyBEVHJhY2UsClByZWRp
Y3RpdmUgU2VsZiBIZWFsaW5nIGFuZCBBd2FyZCBXaW5uaW5nIFpGUy4gR2V0IFNvbGFyaXMgMTAg
Tk9XCmh0dHA6Ly9wLnNmLm5ldC9zZnUvc29sYXJpcy1kZXYyZGV2Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAt
bGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
