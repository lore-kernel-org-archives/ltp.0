Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AEFC433F5
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 12:47:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B20833C0512
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 13:47:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A1D23C101E
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 13:46:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 351DC1400055
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 13:46:51 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C87021F39E;
 Tue, 22 Feb 2022 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1645534010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBHeSDnuF9q//P3v48Qp0+plbCypLHVxj6KDNqbBtBA=;
 b=DqpEPqqLeltQ0MXPa9Tf9snyMiFWTt+o8D8e5fuZdCCcsYqgTV5BNEzydZHXvp1NZMP1YZ
 BvQVvKc/ajCe9ciNB03kC+1bbETj9BokPTH9wMKQ4v36MHvFCi8TFKCMyfkzoMgfNd5a8j
 iqvGypzSIichUITEfi0zdD4bFj8mOxc=
Received: from g78.suse.de (unknown [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id 84E83A3B81;
 Tue, 22 Feb 2022 12:46:50 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 22 Feb 2022 12:45:46 +0000
Message-Id: <20220222124547.14396-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222124547.14396-1-rpalethorpe@suse.com>
References: <20220222124547.14396-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] API/cgroup: Expose memory_recursiveprot V2
 mount opt
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhpcyBjaGFuZ2VzIHRoZSBlZmZlY3Qgb2YgdHJ1bmsgbm9kZXMnIG1lbW9yeS5sb3cgYW5kIG1l
bW9yeS5taW4gb24KdGhlaXIgbGVhZiBub2Rlcy4gU28gd2UgbmVlZCB0byBjaGFuZ2UgdGhlIGV4
cGVjdGF0aW9ucyBvZiBzb21lIHRlc3RzLgoKU2lnbmVkLW9mZi1ieTogUmljaGFyZCBQYWxldGhv
cnBlIDxycGFsZXRob3JwZUBzdXNlLmNvbT4KU3VnZ2VzdGVkLWJ5OiBNaWNoYWwgS291dG7DvSA8
bWtvdXRueUBzdXNlLmNvbT4KLS0tCiBpbmNsdWRlL3RzdF9jZ3JvdXAuaCB8ICAzICsrKwogbGli
L3RzdF9jZ3JvdXAuYyAgICAgfCAxMyArKysrKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3RzdF9j
Z3JvdXAuaCBiL2luY2x1ZGUvdHN0X2Nncm91cC5oCmluZGV4IGQzMmQ2MjM5OS4uYjgyMjc5OGUw
IDEwMDY0NAotLS0gYS9pbmNsdWRlL3RzdF9jZ3JvdXAuaAorKysgYi9pbmNsdWRlL3RzdF9jZ3Jv
dXAuaApAQCAtMjE1LDQgKzIxNSw3IEBAIGludCBzYWZlX2NnX29jY3Vyc2luKGNvbnN0IGNoYXIg
KmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCiAJCQkgY29uc3QgY2hhciAqY29uc3QgZmlsZV9uYW1l
LAogCQkJIGNvbnN0IGNoYXIgKmNvbnN0IG5lZWRsZSk7CiAKK2ludCB0c3RfY2dfbWVtb3J5X3Jl
Y3Vyc2l2ZXByb3Qodm9pZCkKKwlfX2F0dHJpYnV0ZV9fICgod2Fybl91bnVzZWRfcmVzdWx0KSk7
CisKICNlbmRpZiAvKiBUU1RfQ0dST1VQX0ggKi8KZGlmZiAtLWdpdCBhL2xpYi90c3RfY2dyb3Vw
LmMgYi9saWIvdHN0X2Nncm91cC5jCmluZGV4IGRjMDkwYjcwYS4uMDFmYTU1ZTViIDEwMDY0NAot
LS0gYS9saWIvdHN0X2Nncm91cC5jCisrKyBiL2xpYi90c3RfY2dyb3VwLmMKQEAgLTc2LDYgKzc2
LDggQEAgc3RydWN0IGNncm91cF9yb290IHsKIAlpbnQgd2VfbW91bnRlZF9pdDoxOwogCS8qIGNw
dXNldCBpcyBpbiBjb21wYXRhYmlsaXR5IG1vZGUgKi8KIAlpbnQgbm9fY3B1c2V0X3ByZWZpeDox
OworCS8qIFYyIGlzIG1vdW50ZWQgd2l0aCBtZW1vcnlfcmVjdXJzaXZlX3Byb3QgKi8KKwlpbnQg
bWVtb3J5X3JlY3Vyc2l2ZXByb3Q6MTsKIH07CiAKIC8qIENvbnRyb2xsZXIgc3ViLXN5c3RlbXMg
Ki8KQEAgLTM2OCw3ICszNzAsNyBAQCBzdGF0aWMgdm9pZCBjZ3JvdXBfcm9vdF9zY2FuKGNvbnN0
IGNoYXIgKmNvbnN0IG1udF90eXBlLAogCWNvbnN0IHN0cnVjdCBjZ3JvdXBfY3RybCAqY29uc3Rf
Y3RybDsKIAlzdHJ1Y3QgY2dyb3VwX2N0cmwgKmN0cmw7CiAJdWludDMyX3QgY3RybF9maWVsZCA9
IDA7Ci0JaW50IG5vX3ByZWZpeCA9IDA7CisJaW50IG5vX3ByZWZpeCA9IDAsIG1lbW9yeV9yZWN1
cnNpdmVwcm90ID0gMDsKIAljaGFyIGJ1ZltCVUZTSVpdOwogCWNoYXIgKnRvazsKIAljb25zdCBp
bnQgbW50X2RmZCA9IFNBRkVfT1BFTihtbnRfZGlyLCBPX1BBVEggfCBPX0RJUkVDVE9SWSk7CkBA
IC0zNzYsNiArMzc4LDkgQEAgc3RhdGljIHZvaWQgY2dyb3VwX3Jvb3Rfc2Nhbihjb25zdCBjaGFy
ICpjb25zdCBtbnRfdHlwZSwKIAlpZiAoIXN0cmNtcChtbnRfdHlwZSwgImNncm91cCIpKQogCQln
b3RvIHYxOwogCisJZm9yICh0b2sgPSBzdHJ0b2sobW50X29wdHMsICIsIik7IHRvazsgdG9rID0g
c3RydG9rKE5VTEwsICIsIikpCisJCW1lbW9yeV9yZWN1cnNpdmVwcm90IHw9ICFzdHJjbXAoIm1l
bW9yeV9yZWN1cnNpdmVwcm90IiwgdG9rKTsKKwogCVNBRkVfRklMRV9SRUFEQVQobW50X2RmZCwg
ImNncm91cC5jb250cm9sbGVycyIsIGJ1Ziwgc2l6ZW9mKGJ1ZikpOwogCiAJZm9yICh0b2sgPSBz
dHJ0b2soYnVmLCAiICIpOyB0b2s7IHRvayA9IHN0cnRvayhOVUxMLCAiICIpKSB7CkBAIC00MzMs
NiArNDM4LDcgQEAgYmFja3JlZjoKIAlyb290LT5tbnRfZGlyLmRpcl9mZCA9IG1udF9kZmQ7CiAJ
cm9vdC0+Y3RybF9maWVsZCA9IGN0cmxfZmllbGQ7CiAJcm9vdC0+bm9fY3B1c2V0X3ByZWZpeCA9
IG5vX3ByZWZpeDsKKwlyb290LT5tZW1vcnlfcmVjdXJzaXZlcHJvdCA9IG1lbW9yeV9yZWN1cnNp
dmVwcm90OwogCiAJZm9yX2VhY2hfY3RybChjdHJsKSB7CiAJCWlmIChoYXNfY3RybChyb290LT5j
dHJsX2ZpZWxkLCBjdHJsKSkKQEAgLTEyMTIsMyArMTIxOCw4IEBAIGludCBzYWZlX2NnX29jY3Vy
c2luKGNvbnN0IGNoYXIgKmNvbnN0IGZpbGUsIGNvbnN0IGludCBsaW5lbm8sCiAKIAlyZXR1cm4g
ISFzdHJzdHIoYnVmLCBuZWVkbGUpOwogfQorCitpbnQgdHN0X2NnX21lbW9yeV9yZWN1cnNpdmVw
cm90KHZvaWQpCit7CisJcmV0dXJuIHJvb3RzWzBdLm1lbW9yeV9yZWN1cnNpdmVwcm90OworfQot
LSAKMi4zNC4xCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
