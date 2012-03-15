Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S85Z0-0003ef-Py
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 07:57:34 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S85Yw-0003dU-2A
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 07:57:34 +0000
Message-ID: <4F61A0A7.1030402@cn.fujitsu.com>
Date: Thu, 15 Mar 2012 15:56:23 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <dfd33bd8-1212-4dd8-b7a9-87ea6d05760c@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <dfd33bd8-1212-4dd8-b7a9-87ea6d05760c@zmail17.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] io_submit: uninitialized iocb may not return
	-EINVAL
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

SGkgSmFu77yMCgo+Pj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb19zdWJtaXQv
aW9fc3VibWl0MDEuYwo+Pj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb19zdWJt
aXQvaW9fc3VibWl0MDEuYwo+Pj4gQEAgLTEyNiw3ICsxMjYsMjEgQEAgaW50IG1haW4oaW50IGFy
Z2MsIGNoYXIgKmFyZ3ZbXSkKPj4+ICAJCS8qIDEuMyAtIEVJTlZBTDogdW5pbml0aWFsaXplZCBp
b2NiICovCj4+PiAgCQlpb2Nic1swXSA9ICZpb2NiOwo+Pj4gIAkJVEVTVChpb19zdWJtaXQoY3R4
LCAxLCBpb2NicykpOwo+Pj4gLQkJY2hlY2tfcmVzdWx0KC1FSU5WQUwsIFRFU1RfUkVUVVJOKTsK
Pj4+ICsJCXN3aXRjaChURVNUX1JFVFVSTikgewo+Pj4gKwkJCWNhc2UgLUVJTlZBTDoKPj4+ICsJ
CQljYXNlIC1FQkFERjoKPj4+ICsJCQljYXNlIC1FRkFVTFQ6Cj4+PiArCQkJY2FzZSAtRVBFUk06
Cj4+Cj4+Cj4+IEkgZG9uJ3QgdGhpbmsgaW9fc3VibWl0KDIpIGNhbiByZXR1cm4gLUVQRVJNLgo+
Pgo+PiBEbyB5b3UgdGhpbmsgc28/Cj4gCj4gSSB3YXMgdHJ5aW5nIGFsbCBzb3J0cyBvZiByYW5k
b20gZGF0YSBhbmQgSSByZW1lbWJlciBzZWVpbmcgb25jZSAiLTEiLgo+IEknbSBmYWlsaW5nIHRv
IHJlcHJvZHVjZSBpdCB0b2RheSwgc28gSSBjb3VsZCBiZSB3cm9uZy4gSWYgSSBmYWlsIHRvIGZp
bmQKPiBkYXRhIHRoYXQgZ2l2ZXMgLUVQRVJNLCBJJ2xsIHJlbW92ZSBpdCBpbiB2Mi4KCgpJIGxv
b2tlZCBpbnRvIHRoZSBpb19zdWJtaXQoMikgY29kZSBpbiBrZXJuZWwgYW5kIGRpZG4ndCBzZWUg
YW55IHBhdGggY2FuCnJldHVybiAtRVBFUk0sIHNvIEkgdGhpbmsgeW91IHNob3VsZCBjb25maXJt
IG9uIGl0IGFnYWluLgoKVGhhbmtzLApXYW5sb25nIEdhbwoKPiAKPiBSZWdhcmRzLAo+IEphbgo+
IAo+Pgo+PiBUaGFua3MsCj4+IFdhbmxvbmcgR2FvCj4+Cj4gCj4gCgoKCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpUaGlzIFNGIGVtYWlsIGlzIHNwb25zb3NyZWQgYnk6ClRyeSBXaW5kb3dzIEF6dXJl
IGZyZWUgZm9yIDkwIGRheXMgQ2xpY2sgSGVyZSAKaHR0cDovL3Auc2YubmV0L3NmdS9zZmQyZC1t
c2F6dXJlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0
cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
