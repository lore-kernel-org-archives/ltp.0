Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <duynv@tsdv.com.vn>) id 1TsQqo-00020U-DR
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 04:31:46 +0000
Received: from mail.tsdv.com.vn ([210.245.58.36])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TsQql-00033a-BV
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 04:31:46 +0000
Message-ID: <50EB99FB.5020100@tsdv.com.vn>
Date: Tue, 08 Jan 2013 11:00:59 +0700
From: duynv <duynv@tsdv.com.vn>
MIME-Version: 1.0
Subject: [LTP] Question mapping LTP testcases with Kernel setting?
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
To: shubham@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net

RGVhciBTaXIhCkknbSBEdXkuCgpJIGFtIHdvcmtpbmcgd2l0aCBMVFAgdG8gdGVzdCBvdXIgbGlu
dXgga2VybmVsLgp3ZSB3YW50IHRvIGNvbGxlY3QgTFRQIHRlc3QgY2FzZXMgdG8gdGVzdCBvdXIg
a2VybmVsIGJhc2Ugb24gdGhlIGtlcm5lbCAKc2V0dGluZyhjb25maWd1cmF0aW9uIGZpbGUgY3Jl
YXRlIGJ5ICJtYWtlIG1lbnVjb25maWciKS4KKHdlIHdhbnQgdG8gb21pdCB1bm5lY2Vzc2FyeSB0
ZXN0IGNhc2UpCgpCdXQgTFRQIGhhcyBzbyBtYW55IHRlc3QgY2FzZXMuIEkgY2FuJ3QgbWFwcGlu
ZyBMVFAgdGVzdCBjYXNlIHdpdGggCmFwcHJvcHJpYXRlIGtlcm5lbCBzZXR0aW5nCkNvdWxkIHlv
dSBwbGVhc2UgdGVsbCBtZSB0aGUgd2F5IHRvIG1ha2UgYSBtYXBwaW5nIGxpc3QgYmV0d2VlbiBM
VFAgdGVzdCAKY2FzZSB3aXRoIGtlcm5lbCBzZXR0aW5nCgpUaGFuayB5b3UKCi0tIApOZ3V54buF
biBWxINuIER1eQpUb3NoaWJhIFNvZnR3YXJlIERldmVsb3BtZW5044CAKFZpZXQgTmFtKSBDbywg
THRkCioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKgpBZGQgICA6IDE2dGggRmxvb3IsNTE5IEtpbSBNYSBTdHIgLCBCYSBEaW5oIERpc3QgLCBI
YSBOb2kKRW1haWwgOmR1eW52QHRzZHYuY29tLnZuCioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgpOb3RlOiBUaGlzIGUtbWFpbCBtZXNzYWdl
IG1heSBjb250YWluIHBlcnNvbmFsIGluZm9ybWF0aW9uIG9yIGNvbmZpZGVudGlhbCBpbmZvcm1h
dGlvbi4KSWYgeW91IGFyZSBub3QgdGhlIGFkZHJlc3NlZSBvZiB0aGlzIG1lc3NhZ2UsIHBsZWFz
ZSBkZWxldGUgdGhpcyBtZXNzYWdlIGFuZCBraW5kbHkgbm90aWZ5IHRoZSBzZW5kZXIgYXMgc29v
biBhcyBwb3NzaWJsZSwgZG8gbm90IGNvcHksIHVzZSwgb3IgZGlzY2xvc2UgdGhpcyBtZXNzYWdl
LgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpNYXN0ZXIgU1FMIFNlcnZlciBEZXZlbG9wbWVudCwg
QWRtaW5pc3RyYXRpb24sIFQtU1FMLCBTU0FTLCBTU0lTLCBTU1JTCmFuZCBtb3JlLiBHZXQgU1FM
IFNlcnZlciBza2lsbHMgbm93IChpbmNsdWRpbmcgMjAxMikgd2l0aCBMZWFybkRldk5vdyAtCjIw
MCsgaG91cnMgb2Ygc3RlcC1ieS1zdGVwIHZpZGVvIHR1dG9yaWFscyBieSBNaWNyb3NvZnQgTVZQ
cyBhbmQgZXhwZXJ0cy4KU0FMRSAkOTkuOTkgdGhpcyBtb250aCBvbmx5IC0gbGVhcm4gbW9yZSBh
dDoKaHR0cDovL3Auc2YubmV0L3NmdS9sZWFybm1vcmVfMTIyNTEyCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAt
bGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
