Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1Or4kL-0008CW-H1
	for ltp-list@lists.sourceforge.net; Thu, 02 Sep 2010 08:02:09 +0000
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Or4kI-0001Lf-1r
	for ltp-list@lists.sourceforge.net; Thu, 02 Sep 2010 08:02:09 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id o8281nTc024694
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Sep 2010 08:01:49 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o8281mQ93506384
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Sep 2010 09:01:48 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o8281mgD016584
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Sep 2010 09:01:48 +0100
Message-ID: <4C7F59E3.7030303@linux.vnet.ibm.com>
Date: Thu, 02 Sep 2010 10:01:39 +0200
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <8125057B1DA5D840B2E9D872C051E768307DF41DE3@cnbjmbx02.corpusers.net>
In-Reply-To: <8125057B1DA5D840B2E9D872C051E768307DF41DE3@cnbjmbx02.corpusers.net>
Subject: Re: [LTP] [Ltp-coverage] Here comes a new comer to LTP with some
	questions.
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
To: "Ren, Guangyin 2" <Guangyin2.Ren@sonyericsson.com>
Cc: ltp-list@lists.sourceforge.net

SGVsbG8sCgpxdWVzdGlvbnMgYWJvdXQgTFRQIGluIGdlbmVyYWwgYXJlIGJlc3QgYXNrZWQgb24g
dGhlIGx0cC1saXN0IChvbiBDQykuCgoKUmVnYXJkcywKICAgUGV0ZXIgT2JlcnBhcmxlaXRlcgoK
Ck9uIDAyLjA5LjIwMTAgMDM6MzQsIFJlbiwgR3Vhbmd5aW4gMiB3cm90ZToKPiBEZWFyIGFsbCwK
Pgo+IEkgYW0gYSBuZXcgY29tZXIgdG8gTFRQLCBpbiB0aGUgcGFzdCB5ZWFycyBJIGRpZCBhIGVt
YmVkZGVkIGRldmVsb3BlciBvbiBTeW1iaWFuIFM2MC9VSVEgYW5kIExpbnV4IFF0LiA6KQo+IE5v
dywgSSBoYXZlIGEgY2hhbmNlIHRvIGdldCBpbiB0byBBbmRyb2lkIHBsYXRmb3JtIHdoaWNoIGJh
c2VkIG9uIExpbnV4IE9TLgo+Cj4gU28gSSBzdHVkeSBMVFAgZm9yIG15IHRlc3RpbmcsIGRvIHRo
ZSBMaW51eCBrZXJuZWwgc3RyZXNzIHRlc3RpbmcuCj4KPiBSZWNlbnRseSwgSSBoYXZlIGEgcXVl
c3Rpb24sIGNhbiBMVFAgYmUgdXNlZCBmb3IgdGVzdGluZyBkZXZpY2UgZHJpdmVyIG9uIGVtYmVk
ZGVkIGVxdWlwbWVudD8gRS5nLiBhbiBBbmRyb2lkIHBob25lLgo+Cj4gQXMgeW91IG1pZ2h0IGtu
b3csIHNvbWUgSFcgd2lsbCBiZSBjaGFuZ2VkIGJldHdlZW4gZGlmZmVyZW50IHByb2R1Y3RzLCBz
byB3ZSBuZWVkIHRvIHdyaXRlIHNvbWUgd2hpdGUtYm94IHRlc3Qgc2NyaXB0cyB0byB2ZXJpZnkg
dGhhdCB0aGUgcmVsYXRlZCBkcml2ZXIgc2hvdWxkIHdvcmsgd2VsbC4gRS5nLiBCbHVldG9vdGgs
IGNhbWVyYSBzZW5zb3IsIGtleXBhZCBhbmQgc29tZSBvdGhlciBjaGlwc2V0Lgo+Cj4gVG8gTGlu
dXggT1MsIEkgbmVlZCBtdWNoIG1vcmUga25vd2xlZGdlLiA6KQo+Cj4gRm9yIG15IHF1ZXN0aW9u
IG9yIExpbnV4IE9TLCBJIHdlbGNvbWUgYW55IHN1Z2dlc3Rpb24gYW5kIGFkdmljZSEKPgo+IFRo
YW5rIHlvdSBpbiBhZHZhbmNlIGFuZCBsb29rIGZvcndhcmQgdG8geW91ciBmZWVkYmFjayEKPgo+
Cj4gW2NpZDppbWFnZTAwMS5naWZAMDFDQjRBODEuQjc4NzExMzBdCj4KPgo+IEJlc3QgcmVnYXJk
cywKPgo+IFJlbiBHdWFuZ3lpbgo+IFBMRCBCZWlqaW5nIFNXIFZlcmlmaWNhdGlvbgo+Cj4gU29u
eSBFcmljc3Nvbgo+IE1vYmlsZSBDb21tdW5pY2F0aW9ucwo+IFRlbDogKzg2IDEwIDU4NjUgOTI0
MQo+IE1vYmlsZTogKzg2IDEzODEwNDM3MjcyCj4gRW1haWw6IGd1YW5neWluMi5yZW5Ac29ueWVy
aWNzc29uLmNvbTxtYWlsdG86Z3Vhbmd5aW4yLnJlbkBzb255ZXJpY3Nzb24uY29tPgo+IHNvbnll
cmljc3Nvbi5jb208aHR0cDovL3d3dy5zb255ZXJpY3Nzb24uY29tLz4KPgo+IDEwRiwgU29ueSBF
cmljc3NvbiBCdWlsaWRuZywgTm8uMTYsIEd1YW5nc2h1biBTb3V0aCBTdHJlZXQsIENoYW95YW5n
IERpc3RyaWN0LCBCZWlqaW5nIFAuUi5DaGluYSAoUG9zdCBjb2RlOiAxMDAxMDIpCj4g5YyX5Lqs
5pyd6Ziz5Yy65bm/6aG65Y2X5aSn6KGXMTblj7fntKLlsLzniLHnq4vkv6HlpKfljqYo5Lic54WM
5aSn5Y6mKSAxMOWxggo+Cj4KPgo+Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gVGhpcyBTRi5u
ZXQgRGV2MkRldiBlbWFpbCBpcyBzcG9uc29yZWQgYnk6Cj4KPiBTaG93IG9mZiB5b3VyIHBhcmFs
bGVsIHByb2dyYW1taW5nIHNraWxscy4KPiBFbnRlciB0aGUgSW50ZWwoUikgVGhyZWFkaW5nIENo
YWxsZW5nZSAyMDEwLgo+IGh0dHA6Ly9wLnNmLm5ldC9zZnUvaW50ZWwtdGhyZWFkLXNmZAo+Cj4K
Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTHRw
LWNvdmVyYWdlIG1haWxpbmcgbGlzdAo+IEx0cC1jb3ZlcmFnZUBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKPiBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtY292
ZXJhZ2UKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGhpcyBTRi5uZXQgRGV2MkRldiBlbWFpbCBp
cyBzcG9uc29yZWQgYnk6CgpTaG93IG9mZiB5b3VyIHBhcmFsbGVsIHByb2dyYW1taW5nIHNraWxs
cy4KRW50ZXIgdGhlIEludGVsKFIpIFRocmVhZGluZyBDaGFsbGVuZ2UgMjAxMC4KaHR0cDovL3Au
c2YubmV0L3NmdS9pbnRlbC10aHJlYWQtc2ZkCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGlu
Zm8vbHRwLWxpc3QK
