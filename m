Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mrybczyn@kalray.eu>) id 1V7Nwz-0008GC-2h
	for ltp-list@lists.sourceforge.net; Thu, 08 Aug 2013 11:00:13 +0000
Received: from mailhost-d3-m0.internext.fr ([78.40.49.143]
	helo=smtp-delay2.nerim.net)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V7Nww-0003FY-Hx
	for ltp-list@lists.sourceforge.net; Thu, 08 Aug 2013 11:00:13 +0000
Received: from mallaury.nerim.net (smtp-104-thursday.noc.nerim.net
	[178.132.17.104])
	by smtp-delay2.nerim.net (Postfix) with ESMTP id 444BC19CEC46
	for <ltp-list@lists.sourceforge.net>;
	Thu,  8 Aug 2013 12:42:34 +0200 (CEST)
Received: from zimbra1.kalray.eu (kalray-montbonnot-255-203.fib.nerim.net
	[195.5.255.203])
	by mallaury.nerim.net (Postfix) with ESMTP id 10DE015341B
	for <ltp-list@lists.sourceforge.net>;
	Thu,  8 Aug 2013 12:42:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra1.kalray.eu (Postfix) with ESMTP id 783A7280E02
	for <ltp-list@lists.sourceforge.net>;
	Thu,  8 Aug 2013 12:42:29 +0200 (CEST)
Date: Thu, 8 Aug 2013 12:42:29 +0200 (CEST)
From: Marta Rybczynska <mrybczyn@kalray.eu>
Message-ID: <155339095.46628.1375958549000.JavaMail.zimbra@kalray.eu>
In-Reply-To: <600498180.46596.1375958364140.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_46625_1875659098.1375958548999"
Subject: [LTP] PATCHES: build for uCLinux
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

------=_Part_46625_1875659098.1375958548999
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

I attach two small patches for LTP build on uCLinux.

Best regards,
Marta Rybczynska
------=_Part_46625_1875659098.1375958548999
Content-Type: text/x-patch; name=0002-flock03-fix-compile-on-UCLINUX.patch
Content-Disposition: attachment;
	filename=0002-flock03-fix-compile-on-UCLINUX.patch
Content-Transfer-Encoding: base64

RnJvbSA0MmFmZDRjOWYwNTQ2ZjFhOWYyODU1NmJhZTU4MTUzMjcxYzhhODZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJ0YSBSeWJjenluc2thIDxtYXJ0YS5yeWJjenluc2thQGth
bHJheS5ldT4KRGF0ZTogVHVlLCA2IEF1ZyAyMDEzIDA5OjQwOjE0ICswMjAwClN1YmplY3Q6IFtQ
QVRDSCAyLzJdIGZsb2NrMDM6IGZpeCBjb21waWxlIG9uIFVDTElOVVgKCkZJTEVOQU1FIGRlZmlu
aXRpb24gZG9lcyBub3QgZXhpc3QsIHVzZSBGSUxFX05BTUUgaW5zdGVhZC4KClNpZ25lZC1vZmYt
Ynk6IE1hcnRhIFJ5YmN6eW5za2EgPG1hcnRhLnJ5YmN6eW5za2FAa2FscmF5LmV1PgotLS0KIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmxvY2svZmxvY2swMy5jIHwgICAgMiArLQogMSBmaWxl
cyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mbG9jay9mbG9jazAzLmMgYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2Zsb2NrL2Zsb2NrMDMuYwppbmRleCBiYWNmNGY2Li5kMGJkMjE0IDEwMDY0
NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zsb2NrL2Zsb2NrMDMuYworKysgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zsb2NrL2Zsb2NrMDMuYwpAQCAtOTIsNyArOTIsNyBA
QCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJCQkJIGVycm5vKTsKIAkJaWYgKHBp
ZCA9PSAwKSB7CiAjaWZkZWYgVUNMSU5VWAotCQkJaWYgKHNlbGZfZXhlYyhhcmd2WzBdLCAiZHMi
LCBmZCwgRklMRU5BTUUpIDwgMCkKKwkJCWlmIChzZWxmX2V4ZWMoYXJndlswXSwgImRzIiwgZmQs
IEZJTEVfTkFNRSkgPCAwKQogCQkJCXRzdF9icmttKFRGQUlMLCBjbGVhbnVwLCAic2VsZl9leGVj
IGZhaWxlZCwgIgogCQkJCQkgImVycm5vICZkIiwgZXJybm8pOwogI2Vsc2UKLS0gCjEuNy40LjQK
Cg==
------=_Part_46625_1875659098.1375958548999
Content-Type: text/x-patch;
	name=0001-ebizzy.h-mallopt-does-not-exist-on-uClinux.patch
Content-Disposition: attachment;
	filename=0001-ebizzy.h-mallopt-does-not-exist-on-uClinux.patch
Content-Transfer-Encoding: base64

RnJvbSA2YmMwMjA0NzQ1MmM4MDBlZWU0N2M3ZjdhZmUzNGZmNTI0MTk5NDU0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJ0YSBSeWJjenluc2thIDxtYXJ0YS5yeWJjenluc2thQGth
bHJheS5ldT4KRGF0ZTogVHVlLCA2IEF1ZyAyMDEzIDA5OjM5OjE2ICswMjAwClN1YmplY3Q6IFtQ
QVRDSCAxLzJdIGViaXp6eS5oOiBtYWxsb3B0IGRvZXMgbm90IGV4aXN0IG9uIHVDbGludXgKCm1h
bGxvcHQgZG9lcyBub3QgZXhpc3Qgb24gdUNsaWJjLCBpdCByZXF1aXJlcyBNTVUuCgpTaWduZWQt
b2ZmLWJ5OiBNYXJ0YSBSeWJjenluc2thIDxtYXJ0YS5yeWJjenluc2thQGthbHJheS5ldT4KLS0t
CiB1dGlscy9iZW5jaG1hcmsvZWJpenp5LTAuMy9lYml6enkuaCB8ICAgIDIgKy0KIDEgZmlsZXMg
Y2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3V0
aWxzL2JlbmNobWFyay9lYml6enktMC4zL2ViaXp6eS5oIGIvdXRpbHMvYmVuY2htYXJrL2ViaXp6
eS0wLjMvZWJpenp5LmgKaW5kZXggZGExYTc4Yy4uYWZjMThiNSAxMDA2NDQKLS0tIGEvdXRpbHMv
YmVuY2htYXJrL2ViaXp6eS0wLjMvZWJpenp5LmgKKysrIGIvdXRpbHMvYmVuY2htYXJrL2ViaXp6
eS0wLjMvZWJpenp5LmgKQEAgLTE4LDcgKzE4LDcgQEAKIC8qCiAgKiBGcmVlQlNEIGNvbXBhdGli
aWxpdHkgc3R1ZmYKICAqLwotI2lmZGVmIF9mcmVlYnNkCisjaWYgZGVmaW5lZChfZnJlZWJzZCkg
fHwgZGVmaW5lZChfX1VDTElCQ19fKQogI2RlZmluZSBtYWxsb3B0KGFyZzEsIGFyZzIpIGRvIHsg
fSB3aGlsZSAoMCk7CiAjZW5kaWYKIAotLSAKMS43LjQuNAoK
------=_Part_46625_1875659098.1375958548999
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
------=_Part_46625_1875659098.1375958548999
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_46625_1875659098.1375958548999--

