Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MZOmT-0007HP-SJ
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:42:45 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZOmP-0006Sl-Th
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:42:45 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40908061921i39ad3e51q4aeffc666166c496@mail.gmail.com>
References: <d51f89b0908032310k20c3843am7ea069d03436a7a@mail.gmail.com>
	<1249387637.15587.29.camel@subratamodak.linux.ibm.com>
	<d51f89b0908040516i7c65740bi3e30e0972c8374fa@mail.gmail.com>
	<4A7A9DFB.7050305@petalogix.com>
	<8368651DACC1964480F951191B94A078F8A312@svexch01.mvista.com>
	<364299f40908061921i39ad3e51q4aeffc666166c496@mail.gmail.com>
Date: Fri, 07 Aug 2009 18:11:55 +0530
Message-Id: <1249648916.4851.45.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Issue with rt_sigqueueinfo testcase in LTP.
Reply-To: subrata@linux.vnet.ibm.com
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
To: Garrett Cooper <yanegomi@gmail.com>, Henry Yei <hyei@mvista.com>
Cc: ltp-list <ltp-list@lists.sf.net>, rohit verma <rohit.170309@gmail.com>

T24gVGh1LCAyMDA5LTA4LTA2IGF0IDE5OjIxIC0wNzAwLCBHYXJyZXR0IENvb3BlciB3cm90ZTog
Cj4gT24gVGh1LCBBdWcgNiwgMjAwOSBhdCA1OjUwIFBNLCBIZW5yeSBZZWk8aHllaUBtdmlzdGEu
Y29tPiB3cm90ZToKPiA+IFllcywgSSBoYWQganVzdCBub3RpY2VkIHRoaXMgYXMgd2VsbC4gIFNp
bmNlIGl0IHdhcyAicGFzc2luZyIsIGl0IHRvb2sgYXdoaWxlIHRvIHNwb3QuCj4gPgo+ID4gUmV0
dXJuaW5nIHBhc3MgZXZlbiB3aXRoIHRzdF9yZXNtKFRGQUlMLC4uIEJlaW5nIGNhbGxlZCBtdXN0
IGhhdmUgc29tZXRoaW5nIHRvIGRvIHdpdGggdGhlIGZvcmtpbmcsIGJ1dCBJJ20gbm90IGZhbWls
aWFyIHdpdGggaG93IHRoZSBMVFAgZnJhbWV3b3JrIGRlYWxzIHdpdGggdGhhdC4KPiAKPiBJIGRv
bid0IHRoaW5rIHRoYXQncyB0aGUgcHJvYmxlbS4gSSB0aGluayB0aGF0IHRoZSByZWFsIHByb2Js
ZW0gaXMgaG93CgpUaGUgcGFydCBvZiB0aGUgcHJvYmxlbSBpcyBob3cgYW5kIHdoZW4gYXJlIHNl
dHVwKCkgYW5kIGNsZWFudXAoKXMgYXJlCmhhbmRsZWQuCgo+IHRoZSB0ZXN0Y2FzZSBpdHNlbGYg
aXMgd3JpdHRlbiwgYmVjYXVzZSBJIGRvbid0IHNlZSBhbnkgY29kZSB0aGF0Cj4gY2hlY2tzIFdJ
RkVYSVRFRCBhbmQgV0lGU0lHTkFMRUQgKEkgd291bGQgY2hlY2sgZm9yIGJvdGggdGhvc2UgaXRl
bXMKPiB3aGVuIGRvaW5nIHNpZ3F1ZXVlKSwgYW5kIEkgZG9uJ3Qgc2VlIHdoZXJlIHRoZSBjaGls
ZChyZW4pIGFjdHVhbGx5CgpDYW4geW91IGp1c3QgYWRkIHRoZW0gdXAgd2hlbiB5b3UgZmluZCB0
aW1lLiBNZWFud2hpbGUgaSBhbSBjaGVja2luZyBpbgpIZW5yecWbIHBhdGNoLiBUaGFua3MuCgpS
ZWdhcmRzLS0KU3VicmF0YQoKPiBleGl0Li4uIEhNTU0uLi4KPiAKPiBUaG91Z2h0cz8KPiAtR2Fy
cmV0dAo+IAo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IExldCBDcnlzdGFsIFJlcG9ydHMgaGFu
ZGxlIHRoZSByZXBvcnRpbmcgLSBGcmVlIENyeXN0YWwgUmVwb3J0cyAyMDA4IDMwLURheSAKPiB0
cmlhbC4gU2ltcGxpZnkgeW91ciByZXBvcnQgZGVzaWduLCBpbnRlZ3JhdGlvbiBhbmQgZGVwbG95
bWVudCAtIGFuZCBmb2N1cyBvbiAKPiB3aGF0IHlvdSBkbyBiZXN0LCBjb3JlIGFwcGxpY2F0aW9u
IGNvZGluZy4gRGlzY292ZXIgd2hhdCdzIG5ldyB3aXRoIAo+IENyeXN0YWwgUmVwb3J0cyBub3cu
ICBodHRwOi8vcC5zZi5uZXQvc2Z1L2JvYmotanVseQo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gTHRwLWxpc3QgbWFpbGluZyBsaXN0Cj4gTHRwLWxp
c3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vbHRwLWxpc3QKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KTGV0IENyeXN0
YWwgUmVwb3J0cyBoYW5kbGUgdGhlIHJlcG9ydGluZyAtIEZyZWUgQ3J5c3RhbCBSZXBvcnRzIDIw
MDggMzAtRGF5IAp0cmlhbC4gU2ltcGxpZnkgeW91ciByZXBvcnQgZGVzaWduLCBpbnRlZ3JhdGlv
biBhbmQgZGVwbG95bWVudCAtIGFuZCBmb2N1cyBvbiAKd2hhdCB5b3UgZG8gYmVzdCwgY29yZSBh
cHBsaWNhdGlvbiBjb2RpbmcuIERpc2NvdmVyIHdoYXQncyBuZXcgd2l0aCAKQ3J5c3RhbCBSZXBv
cnRzIG5vdy4gIGh0dHA6Ly9wLnNmLm5ldC9zZnUvYm9iai1qdWx5Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAt
bGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
