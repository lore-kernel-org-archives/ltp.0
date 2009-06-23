Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mcgrof@gmail.com>) id 1MJ7yH-00076C-QQ
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:31:41 +0000
Received: from yw-out-2324.google.com ([74.125.46.30])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJ7yG-00036R-8L
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:31:41 +0000
MIME-Version: 1.0
In-Reply-To: <1245768529.4860.61.camel@subratamodak.linux.ibm.com>
References: <9a14a0630903130632s36a7f059hd093d30e97f894eb@mail.gmail.com> 
	<1236962876.7439.3.camel@subratamodak.linux.ibm.com>
	<1237272937.5622.11.camel@subratamodak.linux.ibm.com> 
	<43e72e890903181242i1be5818et8afd1157cff8af83@mail.gmail.com> 
	<1237446038.5260.9.camel@subratamodak.linux.ibm.com>
	<1245768529.4860.61.camel@subratamodak.linux.ibm.com>
From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Date: Tue, 23 Jun 2009 08:31:19 -0700
Message-ID: <43e72e890906230831q6e6c9e2v49454ab66ca99156@mail.gmail.com>
Subject: Re: [LTP] Support of WIFI and W-LAN test cases in LTP
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
To: subrata@linux.vnet.ibm.com, Georgy Berdyshev <codingmaster@gmail.com>
Cc: ltp-list@lists.sf.net, Luis Carlos Cobo <luisca@cozybit.com>, Jouni Malinen <j@w1.fi>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "John W. Linville" <linville@tuxdriver.com>, rahul Baliyan <rahul.lpt@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, "Jouni.Malinen" <Jouni.Malinen@atheros.com>

T24gVHVlLCBKdW4gMjMsIDIwMDkgYXQgNzo0OCBBTSwgU3VicmF0YQpNb2RhazxzdWJyYXRhQGxp
bnV4LnZuZXQuaWJtLmNvbT4gd3JvdGU6Cj4gT24gVGh1LCAyMDA5LTAzLTE5IGF0IDEyOjMwICsw
NTMwLCBTdWJyYXRhIE1vZGFrIHdyb3RlOgo+PiBPbiBXZWQsIDIwMDktMDMtMTggYXQgMTI6NDIg
LTA3MDAsIEx1aXMgUi4gUm9kcmlndWV6IHdyb3RlOgo+PiA+IE9uIE1vbiwgTWFyIDE2LCAyMDA5
IGF0IDExOjU1IFBNLCBTdWJyYXRhIE1vZGFrCj4+ID4gPHN1YnJhdGFAbGludXgudm5ldC5pYm0u
Y29tPiB3cm90ZToKPj4gPiA+IEhpIFJhaHVsLAo+PiA+ID4KPj4gPiA+IE9uIEZyaSwgMjAwOS0w
My0xMyBhdCAyMjoxNyArMDUzMCwgU3VicmF0YSBNb2RhayB3cm90ZToKPj4gPiA+PiBIaSwKPj4g
PiA+Pgo+PiA+ID4+IE9uIEZyaSwgMjAwOS0wMy0xMyBhdCAxOTowMiArMDUzMCwgcmFodWwgQmFs
aXlhbiB3cm90ZToKPj4gPiA+PiA+IEhpLAo+PiA+ID4+ID4KPj4gPiA+PiA+IFBsLiDCoGNvbmZp
cm0gaWYgTFRQIGNvbnRhaW5zIHRoZSB0ZXN0IGNhc2VzIG9mIFctTEFOIGFuZCBXSS1GSS4KPj4g
PiA+Pgo+PiA+ID4+IE5vcGUuIFdlIGRvIG5vdCBoYXZlIHRpbGwgbm93LiBIb3dldmVyLCB3ZSBp
bml0aWF0ZWQgc29tZSBkaXNjdXNzaW9uCj4+ID4gPj4gc29tZSA2IG1vbnRocyBiYWNrIGluIHRo
ZSBzYW1lIG1haWxpbmcgbGlzdCByZWdhcmRpbmcgV2lyZWxlc3MgTWVzaAo+PiA+ID4+IE5ldHdv
a2luZyB0ZXN0cy4gUGxlYXNlIGZvbGxvdyB0aGUgZm9sbG93aW5nIHRocmVhZDoKPj4gPiA+Pgo+
PiA+ID4+IGh0dHA6Ly9tYXJjLmluZm8vP3Q9MTIxOTY5ODEyOTAwMDA3JnI9MSZ3PTImbj00LAo+
PiA+ID4+Cj4+ID4gPj4gVGhlcmUgYXJlIHNvbWUgdGVzdHMgYWxyZWFkeSBhdmlsYWJsZS4gV2Ug
bmVlZCBzb21lYm9keSB0byB2b2x1bnRlZXIgdG8KPj4gPiA+PiBicmluZyB0aGVtIHRvIHNvbWUg
c2hhcGUgc28gdGhhdCB0aGV5IGNhbiBiZSBhdXRvbWF0ZWQgYW5kIHRoZW4KPj4gPiA+PiBpbnRl
Z3JhdGVkIGluc2lkZSBMVFAuIFdvdWxkIHlvdSBiZSByZWFkeSB0byBkbyB0aGF0ID8KPj4gPiA+
Cj4+ID4gPiBXb3VsZCB5b3UgbGlrZSB0byB0YWtlIHVwIG15IHByb3Bvc2FsID8KPj4gPgo+PiA+
IEJUVyBJJ3ZlIHN0YXNoZWQgYSBMaW51eCB3aXJlbGVzcyB0ZXN0aW5nIGVudHJ5IGluIHRoZSBM
aW51eAo+PiA+IEZvdW5kYXRpb24gR1NvQywgaG9wZWZ1bGx5IHRoYXQgY2FuIGJlIG1lcmdlZCBi
YWNrIGludG8gTFRQLgo+PiA+Cj4+ID4gaHR0cHM6Ly93d3cubGludXhmb3VuZGF0aW9uLm9yZy9l
bi9Hb29nbGVfU3VtbWVyX29mX0NvZGVfMjAwOSNBdXRvbWF0aW9uX29mX3Rlc3RpbmdfdXNpbmdf
bWFjODAyMTFfaHdzaW1fYW5kX09yYml0Cj4+Cj4KPiBIaSwKPgo+IElzIHNvbWVib2R5IHdvcmtp
bmcgb24gdGhpcywgYW5kIHN0aWxsIGludGVyZXN0ZWQgdG8gY29udHJpYnV0ZSB0aGUgc2FtZQo+
IHRvIExUUCA/CgpZZXMsIHRoZSBpZGVhIGlzIHRvIGhvcGVmdWxseSBjb250cmlidXRlIGl0IGJh
Y2sgdG8gTFRQLiBPciBoYXZlIExUUAp1c2UgaXQuIEkndmUgYWRkZWQgR2Vvcmd5LCB0aGUgc3R1
ZGVudCB3b3JraW5nIG9uIHRoaXMgcHJvamVjdC4KCiAgTHVpcwoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCkFyZSB5b3UgYW4gb3BlbiBzb3VyY2UgY2l0aXplbj8gSm9pbiB1cyBmb3IgdGhlIE9wZW4g
U291cmNlIEJyaWRnZSBjb25mZXJlbmNlIQpQb3J0bGFuZCwgT1IsIEp1bmUgMTctMTkuIFR3byBk
YXlzIG9mIHNlc3Npb25zLCBvbmUgZGF5IG9mIHVuY29uZmVyZW5jZTogJDI1MC4KTmVlZCBhbm90
aGVyIHJlYXNvbiB0byBnbz8gMjQtaG91ciBoYWNrZXIgbG91bmdlLiBSZWdpc3RlciB0b2RheSEK
aHR0cDovL2FkLmRvdWJsZWNsaWNrLm5ldC9jbGs7MjE1ODQ0MzI0OzEzNTAzMDM4O3Y/aHR0cDov
L29wZW5zb3VyY2VicmlkZ2Uub3JnCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRw
LWxpc3QK
