Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D51BECAAA1
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 14:00:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EDD53CABC5
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 14:59:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 156CF3C9761
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 09:35:09 +0200 (CEST)
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6F394600F38
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 09:35:04 +0200 (CEST)
X-UUID: c33f74c1bcf841cabdc3b14ed5cd35ac-20221027
X-CPASD-INFO: cdcc552ddd524c078d3e132a8f6ae660@rLSdg2JnYJSQhHd-g6Z7cViVY5ViX1K
 weqBWkZNmYlCVhH5xTV5uYFV9fWtVYV9dYVR6eGxQY2BgZFJ4i3-XblBgXoZgUZB3sqadg2VjYg==
X-CLOUD-ID: cdcc552ddd524c078d3e132a8f6ae660
X-CPASD-SUMMARY: SIP:-1, APTIP:-2.0, KEY:0.0, FROMBLOCK:1, OB:0.0, URL:-5,
 TVAL:173.
 0, ESV:0.0, ECOM:-5.0, ML:0.0, FD:1.0, CUTS:97.0, IP:-2.0, MAL:-5.0, PHF:-5.0,
 PHC:-5.
 0, SPF:4.0, EDMS:-5, IPLABEL:4480.0, FROMTO:0, AD:0, FFOB:0.0, CFOB:0.0, SPC:0,
 SIG:-5
 , AUF:42, DUF:6908, ACD:123, DCD:123, SL:0, EISP:0, AG:0, CFC:0.195, CFSR:0.213,
 UAT:0, 
 RAF:0, IMG:-5.0, DFA:0, DTA:0, IBL:-2.0, ADI:-5, SBL:0, REDM:0, REIP:0, ESB:0,
 ATTNUM:0 ,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: c33f74c1bcf841cabdc3b14ed5cd35ac-20221027
X-CPASD-BLOCK: 1001
X-CPASD-STAGE: 1
X-UUID: c33f74c1bcf841cabdc3b14ed5cd35ac-20221027
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain.localdomain [(112.64.161.44)] by mailgw
 (envelope-from <zenghongling@kylinos.cn>) (Generic MTA)
 with ESMTP id 1349941853; Thu, 27 Oct 2022 15:34:55 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: ltp@lists.linux.it
Date: Thu, 27 Oct 2022 15:35:18 +0800
Message-Id: <1666856118-18962-1-git-send-email-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 31 Oct 2022 14:59:49 +0100
Subject: [LTP] [LTP|PATCH] du: bug fix for testcase/du/du01.sh
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
Cc: zhongling0719@126.com, Hongling Zeng <zenghongling@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhlIHJ1bmx0cCBpbnRlcmZhY2UgdGVzdCBmb3IgY29tbWFuZCBkdSByZXBvcnQgZXJyb3IgOgpk
dTAxIDkgVEZBSUw6ICdkdSAtYycgZmFpbGVkCmR1MDEgOSBUSU5GTzogTG9va2luZyBmb3IgJ14x
MFsyLTNdWzAtOV1bMC05XVtbOnNwYWNlOl1ddG90YWwnIGluOgo0CS4vdGVzdGRpcgo0CS4vYmFz
ZWRpcgoxMDI1NgkuCjEwMjU2CeaAu+eUqOmHjwpkdTAxIDEwIFRGQUlMOiAnZHUgLS10b3RhbCcg
ZmFpbGVkCgpBZGQgc2xlY3RpdmUganVkZ2VtZW50IGZvciBjaGluZXNlIGNvbW1hbmQgYW5kIGZp
eCB0aGlzIGVycm9yLgoKU2lnbmVkLW9mZi1ieTogemVuZ2hvbmdsaW5nIDx6ZW5naG9uZ2xpbmdA
a3lsaW5vcy5jbj4KLS0tCiB0ZXN0Y2FzZXMvY29tbWFuZHMvZHUvZHUwMS5zaCB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9jb21tYW5kcy9kdS9kdTAxLnNoIGIvdGVzdGNhc2VzL2NvbW1hbmRzL2R1L2R1
MDEuc2gKaW5kZXggNzk3N2ZkNC4uYTljNDM3NyAxMDA3NTUKLS0tIGEvdGVzdGNhc2VzL2NvbW1h
bmRzL2R1L2R1MDEuc2gKKysrIGIvdGVzdGNhc2VzL2NvbW1hbmRzL2R1L2R1MDEuc2gKQEAgLTc0
LDcgKzc0LDcgQEAgY2hlY2syPSJeMTBbMi0zXVswLTldWzAtOV1bWzpzcGFjZTpdXXRlc3RmaWxl
IgogY2hlY2szPSJeXCgwXHwke3BhZ2Vfc2l6ZX1cKVtbOnNwYWNlOl1dXC5cL3Rlc3RkaXJcL3Rl
c3RzeW1saW5rIgogY2hlY2s1PSJeMjBbNC02XVswLTldWzAtOV1bWzpzcGFjZTpdXVwuIgogY2hl
Y2s3PSJeMTBbNC01XVswLTldWzAtOV1cezRcfVtbOnNwYWNlOl1dXC4iCi1jaGVjazk9Il4xMFsy
LTNdWzAtOV1bMC05XVtbOnNwYWNlOl1ddG90YWwiCitjaGVjazk9Il4xMFsyLTNdWzAtOV1bMC05
XVtbOnNwYWNlOl1dWyjmgLvnlKjph498dG90YWwpXSIKIGNoZWNrMTE9Il4xMFsyLTNdWzAtOV1b
MC05XVtbOnNwYWNlOl1ddGVzdGRpclwvdGVzdHN5bWxpbmsiCiBjaGVjazE0PSJeMVswLDFdTVtb
OnNwYWNlOl1dXC4iCiBjaGVjazE2PSJeMTBbMi0zXVswLTldWzAtOV1bWzpzcGFjZTpdXXRlc3Rk
aXJcLyIKLS0gCjIuMS4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
