Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rq37R-0003hJ-9X
	for ltp-list@lists.sourceforge.net; Wed, 25 Jan 2012 13:42:33 +0000
Date: Wed, 25 Jan 2012 14:55:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120125135509.GA31162@saboteur.suse.cz>
References: <20120120134016.GG4024@saboteur.suse.cz>
	<1327312869-17016-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1327312869-17016-1-git-send-email-carmelo.amoroso@st.com>
Subject: Re: [LTP] [PATCH 1/2 V3] getcontext01: fix build using uClibc C
 runtime
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: ltp-list@lists.sf.net

SGkhCj4gRml4IGEgYnVpbGQgZXJyb3Igd2hlbiBfX1VDTElCQ19fIGlzIGRlZmluZWQgKHNlZSBs
b2cgYmVsb3cpCj4gYnkgbW92aW5nIGFsbCBoZWFkZXJzIGluY2x1c2lvbiBhbmQgVENJRCBkZWZp
bml0aW9uIG9uIHRvcCBvZiBmaWxlCj4gYXMgdGhleSBhcmUgcmVxdWlyZWQgYnkgJ3RzdF9icmtt
JyBmdW5jdGlvbiB0b28uCj4gCj4gZ2V0Y29udGV4dDAxLmM6IEluIGZ1bmN0aW9uIOKAmG1haW7i
gJk6Cj4gZ2V0Y29udGV4dDAxLmM6MTAzOjI6IHdhcm5pbmc6IGltcGxpY2l0IGRlY2xhcmF0aW9u
IG9mIGZ1bmN0aW9uIOKAmHRzdF9icmtt4oCZCj4gZ2V0Y29udGV4dDAxLmM6MTAzOjExOiBlcnJv
cjog4oCYVENPTkbigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCj4g
Z2V0Y29udGV4dDAxLmM6MTAzOjExOiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBp
cyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgo+IGdl
dGNvbnRleHQwMS5jOjEwMzoxODogZXJyb3I6IOKAmE5VTEzigJkgdW5kZWNsYXJlZCAoZmlyc3Qg
dXNlIGluIHRoaXMgZnVuY3Rpb24pCj4gZ2V0Y29udGV4dDAxLmM6MTA0OjE6IHdhcm5pbmc6IGNv
bnRyb2wgcmVhY2hlcyBlbmQgb2Ygbm9uLXZvaWQgZnVuY3Rpb24KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBGcmFuY2VzY28gUnVuZG8gPGZyYW5jZXNjby5ydW5kb0BzdC5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogQ2FybWVsbyBBbW9yb3NvIDxjYXJtZWxvLmFtb3Jvc29Ac3QuY29tPgoKQm90aCBjb21taXRl
ZCwgdGhhbmtzLgoKLS0gCkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1c2UuY3oKCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQpLZWVwIFlvdXIgRGV2ZWxvcGVyIFNraWxscyBDdXJyZW50IHdpdGggTGVhcm5E
ZXZOb3chClRoZSBtb3N0IGNvbXByZWhlbnNpdmUgb25saW5lIGxlYXJuaW5nIGxpYnJhcnkgZm9y
IE1pY3Jvc29mdCBkZXZlbG9wZXJzCmlzIGp1c3QgJDk5Ljk5ISBWaXN1YWwgU3R1ZGlvLCBTaGFy
ZVBvaW50LCBTUUwgLSBwbHVzIEhUTUw1LCBDU1MzLCBNVkMzLApNZXRybyBTdHlsZSBBcHBzLCBt
b3JlLiBGcmVlIGZ1dHVyZSByZWxlYXNlcyB3aGVuIHlvdSBzdWJzY3JpYmUgbm93IQpodHRwOi8v
cC5zZi5uZXQvc2Z1L2xlYXJuZGV2bm93LWQyZApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMu
c291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3Rp
bmZvL2x0cC1saXN0Cg==
