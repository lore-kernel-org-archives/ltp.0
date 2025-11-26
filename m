Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9086ED10396
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 08:51:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 081543CF2B6
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 09:51:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C6F93C79B9
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 09:34:43 +0100 (CET)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9D1A21400E04
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 09:34:39 +0100 (CET)
X-UUID: ba981948caa211f0a38c85956e01ac42-20251126
X-CID-CACHE: Type:Local,Time:202511261628+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6, REQID:54031998-d522-4586-a8b1-c7f67ebcde79, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:a9d874c, CLOUDID:bf17b512b5d001d0c35d1c41a722e0ec,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
 3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
 V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ba981948caa211f0a38c85956e01ac42-20251126
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <fangqiurong@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1842037038; Wed, 26 Nov 2025 16:34:31 +0800
From: fangqiurong <fangqiurong@kylinos.cn>
To: ltp@lists.linux.it
Date: Wed, 26 Nov 2025 16:33:05 +0800
Message-Id: <20251126083305.228598-1-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 26 Nov 2025 09:51:08 +0100
Subject: [LTP] [PATCH] syscalls: add RT group scheduling check to
 sched_setparam03
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
Cc: fangqiurong <fangqiurong@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

QWRkIHRzdF9jaGVja19ydF9ncm91cF9zY2hlZF9zdXBwb3J0KCkgY2FsbCBpbiBzZXR1cCgpIHRv
IGVuc3VyZQp0aGUgdGVzdCBwcm9wZXJseSB2YWxpZGF0ZXMgUlQgZ3JvdXAgc2NoZWR1bGluZyBz
dXBwb3J0IGJlZm9yZQpydW5uaW5nIFNDSEVEX0ZJRk8gdGVzdHMuCgpUaGUgc2NoZWRfc2V0cGFy
YW0wMyB0ZXN0IGNhc2UgZmFpbGVkIHdpdGggYSBUQlJPSyBzdGF0dXMgd2hlbiBydW5uaW5nIG9u
IGNncm91cHYyIGVudmlyb25tZW50cyB3aGVyZSB0aGUgcHJvY2VzcyB3YXMgcmVzdHJpY3RlZCBm
cm9tIHNldHRpbmcgdGhlIHJlYWwtdGltZSBwb2xpY3kgKHJldHVybmluZyBFUEVSTSkuCgpUaGlz
IGNvbW1pdCBhZGRzIGEgY2FsbCB0byB0c3RfY2hlY2tfcnRfZ3JvdXBfc2NoZWRfc3VwcG9ydCgp
IHdoaWNoIHVzZXMgdGhlIGNvbmZpZ3VyYXRpb24gbWVzc2FnZSBUQ09ORjogQ09ORklHX1JUX0dS
T1VQX1NDSEVEIG5vdCBzdXBwb3J0IG9uIGNncm91cHYyLgoKVGhlIHRlc3Qgbm93IGNvcnJlY3Rs
eSBza2lwcyBpbnN0ZWFkIG9mIHJlcG9ydGluZyBhIFRCUk9LIGZhaWx1cmUgZHVlIHRvIGV4cGVj
dGVkIGtlcm5lbCBjb25maWd1cmF0aW9uIGxpbWl0YXRpb25zLgoKQkVGT1JF77yaCnNjaGVkX3Nl
dHBhcmFtMDMuYzo0NzogVElORk86IFRlc3RpbmcgbGliYyB2YXJpYW50CnNjaGVkX3NldHBhcmFt
MDMuYzo1MDogVEJST0s6IHNjaGVkX3NldHNjaGVkdWxlcigwLCBTQ0hFRF9GSUZPLCAxKTogRVBF
Uk0gKDEpCgpTdW1tYXJ5OgpwYXNzZWQgMApmYWlsZWQgMApicm9rZW4gMQpza2lwcGVkIDAKd2Fy
bmluZ3MgMAoKTk9X77yaCnNjaGVkX3NldHBhcmFtMDMuYzo0NzogVElORk86IFRlc3RpbmcgbGli
YyB2YXJpYW50CnRzdF9rY29uZmlnLmM6ODg6IFRJTkZPOiBQYXJzaW5nIGtlcm5lbCBjb25maWcg
Jy9wcm9jL2NvbmZpZy5neicKdHN0X2Nncm91cC5jOjE1NDM6IFRDT05GOiBDT05GSUdfUlRfR1JP
VVBfU0NIRUQgbm90IHN1cHBvcnQgb24gY2dyb3VwdjIKc2NoZWRfc2V0cGFyYW0wMy5jOjQ3OiBU
SU5GTzogVGVzdGluZyBzeXNjYWxsIHZhcmlhbnQKdHN0X2tjb25maWcuYzo4ODogVElORk86IFBh
cnNpbmcga2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6Jwp0c3RfY2dyb3VwLmM6MTU0Mzog
VENPTkY6IENPTkZJR19SVF9HUk9VUF9TQ0hFRCBub3Qgc3VwcG9ydCBvbiBjZ3JvdXB2MgoKU3Vt
bWFyeToKcGFzc2VkIDAKZmFpbGVkIDAKYnJva2VuIDAKc2tpcHBlZCAyCndhcm5pbmdzIDAKClNp
Z25lZC1vZmYtYnk6IGZhbmdxaXVyb25nIDxmYW5ncWl1cm9uZ0BreWxpbm9zLmNuPgotLS0KIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2NoZWRfc2V0cGFyYW0vc2NoZWRfc2V0cGFyYW0wMy5j
IHwgMSArCiB0ZXN0Y2FzZXMvcmVhbHRpbWUvZnVuYy9zY2hlZF9mb290YmFsbC9zY2hlZF9mb290
YmFsbC5jICAgICB8IDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NjaGVkX3NldHBhcmFtL3NjaGVkX3Nl
dHBhcmFtMDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2NoZWRfc2V0cGFyYW0vc2No
ZWRfc2V0cGFyYW0wMy5jCmluZGV4IGE4ZWZmY2FkYi4uYTg2ZWQ4NWM1IDEwMDY0NAotLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NjaGVkX3NldHBhcmFtL3NjaGVkX3NldHBhcmFtMDMu
YworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NjaGVkX3NldHBhcmFtL3NjaGVkX3Nl
dHBhcmFtMDMuYwpAQCAtNDUsNiArNDUsNyBAQCB2b2lkIHNldHVwKHZvaWQpCiAJc3RydWN0IHNj
aGVkX3BhcmFtIHAgPSB7IC5zY2hlZF9wcmlvcml0eSA9IDEgfTsKIAogCXRzdF9yZXMoVElORk8s
ICJUZXN0aW5nICVzIHZhcmlhbnQiLCB0di0+ZGVzYyk7CisJdHN0X2NoZWNrX3J0X2dyb3VwX3Nj
aGVkX3N1cHBvcnQoKTsKIAogCWlmICh0di0+c2NoZWRfc2V0c2NoZWR1bGVyKDAsIFNDSEVEX0ZJ
Rk8sICZwKSkKIAkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgInNjaGVkX3NldHNjaGVkdWxlcigw
LCBTQ0hFRF9GSUZPLCAxKSIpOwpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL3JlYWx0aW1lL2Z1bmMv
c2NoZWRfZm9vdGJhbGwvc2NoZWRfZm9vdGJhbGwuYyBiL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5j
L3NjaGVkX2Zvb3RiYWxsL3NjaGVkX2Zvb3RiYWxsLmMKaW5kZXggNDQ2NWJkZGU4Li45M2Q3MTEx
NDYgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5jL3NjaGVkX2Zvb3RiYWxsL3Nj
aGVkX2Zvb3RiYWxsLmMKKysrIGIvdGVzdGNhc2VzL3JlYWx0aW1lL2Z1bmMvc2NoZWRfZm9vdGJh
bGwvc2NoZWRfZm9vdGJhbGwuYwpAQCAtMTYxLDYgKzE2MSw3IEBAIHN0YXRpYyB2b2lkIGRvX3Rl
c3Qodm9pZCkKIAogCXRzdF9yZXMoVElORk8sICJwbGF5ZXJzX3Blcl90ZWFtOiAlZCBnYW1lX2xl
bmd0aDogJWQiLAogCSAgICAgICBwbGF5ZXJzX3Blcl90ZWFtLCBnYW1lX2xlbmd0aCk7CisJdHN0
X2NoZWNrX3J0X2dyb3VwX3NjaGVkX3N1cHBvcnQoKTsKIAogCS8qIHRvdGFsID0gb2ZmZW5zZSAr
IGRlZmVuc2UgKyBmYW5zICsgcmVmZXJlZSAqLwogCXB0aHJlYWRfYmFycmllcl9pbml0KCZzdGFy
dF9iYXJyaWVyLCBOVUxMLCBwbGF5ZXJzX3Blcl90ZWFtICogNCArIDEpOwotLSAKMi4yNS4xCgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
