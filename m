Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AD3C7EE24
	for <ltp@archiver.kernel.org>; Fri,  2 Jun 2023 09:57:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3E753CCEEF
	for <ltp@archiver.kernel.org>; Fri,  2 Jun 2023 11:57:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC4123CCDD8
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 11:57:07 +0200 (CEST)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8FCE11400457
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 11:57:06 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="119122301"
X-IronPort-AV: E=Sophos;i="6.00,212,1681138800"; d="scan'208";a="119122301"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 18:57:04 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 55F70C68E4
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 18:57:02 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com
 [192.51.207.11])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8C5E0D5EA3
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 18:57:01 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id A7F8E2FC69FB;
 Fri,  2 Jun 2023 18:57:00 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri,  2 Jun 2023 17:55:55 +0800
Message-Id: <1685699755-4766-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27666.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27666.006
X-TMASE-Result: 10--2.123800-10.000000
X-TMASE-MatchedRID: 24Sf70/zn6qhhjsqgSuNbxF4zyLyne+AVBDQSDMig9HEosIs7IJbkIh+
 mL+ciFCpbnRB47KLJ1QzLmfGY6iDkX5uUfhNvnKzOWUWxTQJdI8UZYubbUj2DLt4BAaULwAVJf5
 otvavOZf9vT5evMX4tM0lquesZhhHpljg/F9ExYTFVAV8vDjN/6n/3nyhTdZwZYqF36J/b8ZjaQ
 GYA98fM/sRZb2bIX9Ww06evX0vRhJVnAszo0EfNLrbxxduc6FPv1wCVBblimutuWYz9oVoL2tgc
 kGXH2knxdZk3h//tzkDfZ2MQc5Ymnzh4vqEo4GEngIgpj8eDcByZ8zcONpAscRB0bsfrpPIcSqb
 xBgG0w7vCc/rjI9C+jGrCVPFEdZvTyNC1c6am3IFdR/vblG5BTW7lwZjG9qX7T34oPpSbabv9mw
 2z9YBSrXIF+5Zx9tOoJSTU+6ceilB73EZz7XBCOp1XUG/h2MOieWdV7FfKATLbAp0fm+COw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fork03: Convert into new api
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogWWFuZyBYdSA8eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4KLS0tCiB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazAzLmMgfCAxNDYgKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgMTAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3Jr
MDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMDMuYwppbmRleCAyNWIz
NmM4OTcuLjA3MmYxMjc5NyAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
b3JrL2ZvcmswMy5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMDMu
YwpAQCAtMSwxMTkgKzEsNjEgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9yLWxhdGVyCiAvKgorICogQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1h
Y2hpbmVzIENvcnAuLCAyMDAxCiAgKgotICogICBDb3B5cmlnaHQgKGMpIEludGVybmF0aW9uYWwg
QnVzaW5lc3MgTWFjaGluZXMgIENvcnAuLCAyMDAxCi0gKgotICogICBUaGlzIHByb2dyYW0gaXMg
ZnJlZSBzb2Z0d2FyZTsgIHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKLSAq
ICAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBh
cyBwdWJsaXNoZWQgYnkKLSAqICAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVy
IHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKLSAqICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkg
bGF0ZXIgdmVyc2lvbi4KLSAqCi0gKiAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0
aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAotICogICBidXQgV0lUSE9VVCBBTlkgV0FS
UkFOVFk7ICB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKLSAqICAgTUVSQ0hB
TlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlCi0gKiAg
IHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgotICoKLSAq
ICAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UKLSAqICAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07ICBpZiBub3QsIHdyaXRl
IHRvIHRoZSBGcmVlIFNvZnR3YXJlCi0gKiAgIEZvdW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGlu
IFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgMDIxMTAtMTMwMSBVU0EKKyAqIEFVVEhP
UgorICrCoMKgwqDCoMKgIDA3LzIwMDEgUG9ydGVkIGJ5IFdheW5lIEJveWVyCiAgKi8KIAotLyoK
LSAqIE5BTUUKLSAqCWZvcmswMy5jCi0gKgotICogREVTQ1JJUFRJT04KLSAqCUNoZWNrIHRoYXQg
Y2hpbGQgY2FuIHVzZSBhIGxhcmdlIHRleHQgc3BhY2UgYW5kIGRvIGEgbGFyZ2UKLSAqCW51bWJl
ciBvZiBvcGVyYXRpb25zLgotICoKLSAqIEFMR09SSVRITQotICoJRm9yayBvbmUgcHJvY2Vzcywg
Y2hlY2sgZm9yIHBpZCA9PSAwIGluIGNoaWxkLgotICoJQ2hlY2sgZm9yIHBpZCA+IDAgaW4gcGFy
ZW50IGFmdGVyIHdhaXQuCi0gKgotICogVVNBR0UKLSAqCWZvcmswMworLypcCisgKltEZXNjcmlw
dGlvbl0KICAqCi0gKiBISVNUT1JZCi0gKgkwNy8yMDAxIFBvcnRlZCBieSBXYXluZSBCb3llcgot
ICoKLSAqIFJFU1RSSUNUSU9OUwotICoJTm9uZQorICogQ2hlY2sgdGhhdCBjaGlsZCBwcm9jZXNz
IGNhbiB1c2UgYSBsYXJnZSB0ZXh0IHNwYWNlIGFuZCBkbyBhIGxhcmdlIG51bWJlcgorICogb2Yg
b3BlcmF0aW9ucy4gSW4gdGhpcyBzaXR1YXRpb24sIENoZWNrIGZvciBwaWQgPT0gMCBpbiBjaGls
ZCBhbmQgY2hlY2sKKyAqIGZvciBwaWQgPiAwIGluIHBhcmVudCBhZnRlciB3YWl0LgogICovCiAK
ICNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KKyNpbmNsdWRlIDx1bmlzdGQuaD4KICNpbmNsdWRlIDxz
eXMvd2FpdC5oPgotI2luY2x1ZGUgPHN0ZGlvLmg+Ci0jaW5jbHVkZSAidGVzdC5oIgotCi1jaGFy
ICpUQ0lEID0gImZvcmswMyI7Ci1pbnQgVFNUX1RPVEFMID0gMTsKLQotc3RhdGljIHZvaWQgc2V0
dXAodm9pZCk7Ci1zdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpOworI2luY2x1ZGUgPHN0ZGxpYi5o
PgorI2luY2x1ZGUgInRzdF90ZXN0LmgiCiAKLWludCBtYWluKGludCBhYywgY2hhciAqKmF2KQor
c3RhdGljIHZvaWQgdmVyaWZ5X2Zvcmsodm9pZCkKIHsKIAlmbG9hdCBmbDEsIGZsMjsKLQlpbnQg
aTsKLQlpbnQgcGlkMSwgcGlkMiwgc3RhdHVzOwotCi0JaW50IGxjOwotCi0JdHN0X3BhcnNlX29w
dHMoYWMsIGF2LCBOVUxMLCBOVUxMKTsKLQotCXNldHVwKCk7Ci0KLQlmb3IgKGxjID0gMDsgVEVT
VF9MT09QSU5HKGxjKTsgbGMrKykgewotCQl0c3RfY291bnQgPSAwOwotCQlwaWQxID0gZm9yaygp
OwotCQlpZiAocGlkMSA9PSAtMSkKLQkJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAiZm9yaygp
IGZhaWxlZCIpOwotCi0JCWlmIChwaWQxID09IDApIHsKLQkJCS8qIGNoaWxkIHVzZXMgc29tZSBj
cHUgY3ljbGVzICovCi0JCQlmb3IgKGkgPSAxOyBpIDwgMzI3Njc7IGkrKykgewotCQkJCWZsMSA9
IDAuMDAwMDAxOwotCQkJCWZsMSA9IGZsMiA9IDAuMDAwMDAxOwotCQkJCWZsMSA9IGZsMSAqIDEw
LjA7Ci0JCQkJZmwyID0gZmwxIC8gMS4yMzIzMjM7Ci0JCQkJZmwxID0gZmwyIC0gZmwyOwotCQkJ
CWZsMSA9IGZsMjsKLQkJCX0KLQotCQkJLyogUGlkIG11c3QgYWx3YXlzIGJlIHplcm8gaW4gY2hp
bGQgICovCi0JCQlpZiAocGlkMSAhPSAwKQotCQkJCWV4aXQoMSk7Ci0JCQllbHNlCi0JCQkJZXhp
dCgwKTsKLQkJfSBlbHNlIHsKLQkJCXRzdF9yZXNtKFRJTkZPLCAicHJvY2VzcyBpZCBpbiBwYXJl
bnQgb2YgY2hpbGQgZnJvbSAiCi0JCQkJICJmb3JrIDogJWQiLCBwaWQxKTsKLQkJCXBpZDIgPSB3
YWl0KCZzdGF0dXMpOwkvKiB3YWl0IGZvciBjaGlsZCAqLwotCi0JCQlpZiAocGlkMSAhPSBwaWQy
KSB7Ci0JCQkJdHN0X3Jlc20oVEZBSUwsICJwaWRzIGRvbid0IG1hdGNoIDogJWQgdnMgJWQiLAot
CQkJCQkgcGlkMSwgcGlkMik7Ci0JCQkJY29udGludWU7Ci0JCQl9Ci0KLQkJCWlmICgoc3RhdHVz
ID4+IDgpICE9IDApIHsKLQkJCQl0c3RfcmVzbShURkFJTCwgImNoaWxkIGV4aXRlZCB3aXRoIGZh
aWx1cmUiKTsKLQkJCQljb250aW51ZTsKLQkJCX0KLQotCQkJdHN0X3Jlc20oVFBBU1MsICJ0ZXN0
IDEgUEFTU0VEIik7CisJaW50IHBpZDEsIHBpZDIsIHN0YXR1cywgaTsKKworCXBpZDEgPSBTQUZF
X0ZPUksoKTsKKwlpZiAoIXBpZDEpIHsKKwkJLyogY2hpbGQgdXNlcyBzb21lIGNwdSB0aW1lIHNs
aWNlcyAqLworCQlmb3IgKGkgPSAxOyBpIDwgMzI3Njc7IGkrKykgeworCQkJZmwxID0gMC4wMDAw
MDE7CisJCQlmbDEgPSBmbDIgPSAwLjAwMDAwMTsKKwkJCWZsMSA9IGZsMSAqIDEwLjA7CisJCQlm
bDIgPSBmbDEgLyAxLjIzMjMyMzsKKwkJCWZsMSA9IGZsMiAtIGZsMjsKKwkJCWZsMSA9IGZsMjsK
IAkJfQorCQlpZiAoIXBpZDEpCisJCQlleGl0KDApOworCQllbHNlCisJCQlleGl0KDEpOwogCX0K
IAotCWNsZWFudXAoKTsKLQl0c3RfZXhpdCgpOwotfQotCi1zdGF0aWMgdm9pZCBzZXR1cCh2b2lk
KQotewotCXRzdF9zaWcoRk9SSywgREVGX0hBTkRMRVIsIGNsZWFudXApOwotCVRFU1RfUEFVU0U7
CisJdHN0X3JlcyhUSU5GTywgInByb2Nlc3MgaWQgaW4gcGFyZW50IG9mIGNoaWxkIGZyb20gZm9y
ayA6ICVkIiwgcGlkMSk7CisJcGlkMiA9IFNBRkVfV0FJVCgmc3RhdHVzKTsKKwlpZiAocGlkMSAh
PSBwaWQyKSB7CisJCXRzdF9yZXMoVEZBSUwsICJwaWRzIGRvbid0IG1hdGNoIDogJWQgdnMgJWQi
LCBwaWQxLCBwaWQyKTsKKwkJcmV0dXJuOworCX0KKwlpZiAoKHN0YXR1cyA+PiA4KSAhPSAwKSB7
CisJCXRzdF9yZXMoVEZBSUwsICJjaGlsZCBleGl0ZWQgd2l0aCBmYWlsdXJlIik7CisJCXJldHVy
bjsKKwl9CisJdHN0X3JlcyhUUEFTUywgInRlc3QgUEFTU0VEIik7CiB9CiAKLXN0YXRpYyB2b2lk
IGNsZWFudXAodm9pZCkKLXsKLX0KK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKKwku
dGVzdF9hbGwgPSB2ZXJpZnlfZm9yaywKKwkuZm9ya3NfY2hpbGQgPSAxLAorfTsKLS0gCjIuMzku
MQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
