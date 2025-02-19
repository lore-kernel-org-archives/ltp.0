Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4B9C021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 06:48:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57E1A3C1BC2
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 07:48:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34D4F3C1BC2
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 07:48:19 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=chwen@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E4BF91A01949
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 07:48:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739947694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=da32g4X5VrIK7PHl3ff7Ffgge0lIV/ZooLJf7kHngZ4=;
 b=cMkdDjLRZvWjxYw2IkTeXX0iFt3p8p68G/6KsnVcnNYwdp7QCCEKFD68Kvy7pMum8HcO2d
 Olxj+7Zk+rf41xQY2L3zDgyddeiOBxP//WNmbG29RBRPtrFhFBTnEBnbX4owxaD+Yx9X5g
 T/exCTs4frzslowLU3YRYlapPT0xxiQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-4fp6Xm3HMme3LP6O7FYfrQ-1; Wed,
 19 Feb 2025 01:48:11 -0500
X-MC-Unique: 4fp6Xm3HMme3LP6O7FYfrQ-1
X-Mimecast-MFC-AGG-ID: 4fp6Xm3HMme3LP6O7FYfrQ_1739947690
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E0EA196E078
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 06:48:10 +0000 (UTC)
Received: from dell-per430-17.gsslab.pek2.redhat.com
 (dell-per430-17.gsslab.pek2.redhat.com [10.72.36.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D55E19560A3
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 06:48:08 +0000 (UTC)
From: chunfuwen <chwen@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 19 Feb 2025 01:47:43 -0500
Message-ID: <20250219064804.1313358-1-chwen@redhat.com>
In-Reply-To: <bc3276b8-8383-4ef8-a4d7-a2a786662cbd@suse.com>
References: <bc3276b8-8383-4ef8-a4d7-a2a786662cbd@suse.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XS5DPofHL13bl3JFEPEEA8TX5Fdt8UdV7_ZSzfArSII_1739947690
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add test case to cover the setting resource
 limit64 for process
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

VGhlIHRlc3QgZW5zdXJlcyB0aGF0IHRoZSBwcm9jZXNzIGdldHMgdGhlIGNvcnJlY3Qgc2lnbmFs
cyBpbiB0aGUgY29ycmVjdCBvcmRlcjoKCkZpcnN0LCBpdCBzaG91bGQgZ2V0IFNJR1hDUFUgYWZ0
ZXIgcmVhY2hpbmcgdGhlIHNvZnQgQ1BVIHRpbWUgbGltaXQ2NC4KVGhlbiwgaWYgdGhlIENQVSB0
aW1lIGV4Y2VlZHMgdGhlIGhhcmQgbGltaXQsIGl0IHNob3VsZCByZWNlaXZlIFNJR0tJTEwKClNp
Z25lZC1vZmYtYnk6IGNodW5mdXdlbiA8Y2h3ZW5AcmVkaGF0LmNvbT4KLS0tCkNoYW5nZXMgaW4g
djI6Ci0gUm9tb3ZlIHRlc3QgZGVzY3JpcHRpb25zIGFuZCB0cmFpbGluZyBsaW5lIGFzIHN1Z2dl
c3RlZCBieSBSaWNhcmRvIEIuIE1hcmxpw6hyZQotIEFkZGVkIDIwMjUgY29weXJpZ2h0IGFzIHN1
Z2dlc3RlZCBieSBSaWNhcmRvIEIuIE1hcmxpw6hyZQotIFRyaW0gZG93biBpbmNsdWRlIGZpbGVz
IGFzIHN1Z2dlc3RlZCBieSBSaWNhcmRvIEIuIE1hcmxpw6hyZQotIENyZWF0ZSBuZXcgbGFwaS9y
ZXNvdXJjZS5oIHJlc2lkaW5nIHN0cnVjdCBybGltaXQ2NCBhcyBzdWdnZXN0ZWQgYnkgQW5kcmVh
Ci0gTW92ZSBzZXRybGltaXRfdTY0KCkgc3lzY2FsbHMgZGVmaW5pdGlvbnMgaW50byBsYXBpL3Jl
c291cmNlLmggYXMgc3VnZ2VzdGVkIGJ5IEFuZHJlYQotIFNraXAgIFNBRkVfKiB2YXJpYW50cyBh
cyBzdWdnZXN0ZWQgYnkgQW5kcmVhCi0gdXNlIHRzdF9idWZmZXJzIHdoZW4gcGFzc2luZyB0aGUg
cG9pbnRlcmFzIHN1Z2dlc3RlZCBieSBBbmRyZWEKLSBMaW5rIHRvIHYxOmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI1MDIxODAyMzEwNy4xMjA4OTkwLTEtY2h3ZW5AcmVkaGF0LmNvbS8K
LS0tCiBpbmNsdWRlL2xhcGkvcmVzb3VyY2UuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgMjYg
KysrKwogLi4uL2tlcm5lbC9zeXNjYWxscy9zZXRybGltaXQvc2V0cmxpbWl0MDcuYyAgIHwgMTI3
ICsrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNTMgaW5zZXJ0aW9ucygrKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGFwaS9yZXNvdXJjZS5oCiBjcmVhdGUgbW9kZSAx
MDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRybGltaXQvc2V0cmxpbWl0MDcuYwoK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9yZXNvdXJjZS5oIGIvaW5jbHVkZS9sYXBpL3Jlc291
cmNlLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwLi4zMzEwYmM5MzQKLS0t
IC9kZXYvbnVsbAorKysgYi9pbmNsdWRlL2xhcGkvcmVzb3VyY2UuaApAQCAtMCwwICsxLDI2IEBA
CisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorLyoKKyAqIENv
cHlyaWdodCAoYykgMjAyNSBSZWQgSGF0IEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KKyAqIEF1
dGhvcjogQ2h1bmZ1IFdlbiA8Y2h3ZW5AcmVkaGF0LmNvbT4KKyAqLworCisjaWZuZGVmIExBUElf
UkVTT1VSQ0VfSF9fCisjZGVmaW5lIExBUElfUkVTT1VSQ0VfSF9fCisKKyNkZWZpbmUgX0dOVV9T
T1VSQ0UKKworI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIKKworI2lmbmRlZiBIQVZFX1NUUlVD
VF9STElNSVQ2NAorc3RydWN0IHJsaW1pdDY0IHsKKyAgICAgICAgdWludDY0X3QgcmxpbV9jdXI7
CisgICAgICAgIHVpbnQ2NF90IHJsaW1fbWF4OworfTsKKyNlbmRpZgorCitzdGF0aWMgaW50IHNl
dHJsaW1pdF91NjQoaW50IHJlc291cmNlLCBjb25zdCBzdHJ1Y3QgcmxpbWl0NjQgKnJsaW0pCit7
CisgICAgICAgIHJldHVybiB0c3Rfc3lzY2FsbChfX05SX3BybGltaXQ2NCwgMCwgcmVzb3VyY2Us
IHJsaW0sIE5VTEwpOworfQorCisjZW5kaWYgLyogTEFQSV9SRVNPVVJDRV9IX18gKi8KZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0cmxpbWl0L3NldHJsaW1pdDA3LmMg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHJsaW1pdC9zZXRybGltaXQwNy5jCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMC4uNjBhNDU4MGRhCi0tLSAvZGV2L251bGwK
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRybGltaXQvc2V0cmxpbWl0MDcuYwpA
QCAtMCwwICsxLDEyNyBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3It
bGF0ZXIKKy8qCisgKiBDb3B5cmlnaHQgKGMpIDIwMjUgUmVkIEhhdCBJbmMuIEFsbCBSaWdodHMg
UmVzZXJ2ZWQuCisgKiBBdXRob3I6IENodW5mdSBXZW4gPGNod2VuQHJlZGhhdC5jb20+CisgKi8K
KworLyoKKyAqIFNldCBDUFUgdGltZSBsaW1pdDY0IGZvciBhIHByb2Nlc3MgYW5kIGNoZWNrIGl0
cyBiZWhhdmlvcgorICogYWZ0ZXIgcmVhY2hpbmcgQ1BVIHRpbWUgbGltaXQ2NC4KKyAqIDEpIFBy
b2Nlc3MgZ290IFNJR1hDUFUgYWZ0ZXIgcmVhY2hpbmcgc29mdCBsaW1pdCBvZiBDUFUgdGltZSBs
aW1pdDY0LgorICogMikgUHJvY2VzcyBnb3QgU0lHS0lMTCBhZnRlciByZWFjaGluZyBoYXJkIGxp
bWl0IG9mIENQVSB0aW1lIGxpbWl0NjQuCisgKi8KKworI2RlZmluZSBfR05VX1NPVVJDRQorCisj
aW5jbHVkZSA8c3lzL3dhaXQuaD4KKworI2luY2x1ZGUgInRzdF90ZXN0LmgiCisKKyNpbmNsdWRl
ICJsYXBpL3N5c2NhbGxzLmgiCisKKyNpbmNsdWRlICJsYXBpL3Jlc291cmNlLmgiCisKKyNpZm5k
ZWYgSEFWRV9TVFJVQ1RfUkxJTUlUNjQKK3N0cnVjdCBybGltaXQ2NCB7CisJdWludDY0X3Qgcmxp
bV9jdXI7CisJdWludDY0X3QgcmxpbV9tYXg7Cit9OworI2VuZGlmCisKK3N0YXRpYyBzdHJ1Y3Qg
IHJsaW1pdDY0KnJsaW07CisKK3N0YXRpYyBpbnQgKmVuZDsKKworc3RhdGljIHZvaWQgc2lnaGFu
ZGxlcihpbnQgc2lnKQoreworCSplbmQgPSBzaWc7Cit9CisKK3N0YXRpYyB2b2lkIHNldHVwKHZv
aWQpCit7CisJc2lnbmFsKFNJR1hDUFUsIHNpZ2hhbmRsZXIpOworCisJZW5kID0gbW1hcChOVUxM
LCBzaXplb2YoaW50KSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwKKwkJICAgTUFQX1NIQVJFRCB8
IE1BUF9BTk9OWU1PVVMsIC0xLCAwKTsKK30KKworc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQor
eworCWlmIChlbmQpCisJCW11bm1hcChlbmQsIHNpemVvZihpbnQpKTsKK30KKy8qCitzdGF0aWMg
aW50IHNldHJsaW1pdF91NjQoaW50IHJlc291cmNlLCBjb25zdCBzdHJ1Y3QgcmxpbWl0NjQgKnJs
aW0pCit7CisJcmV0dXJuIHRzdF9zeXNjYWxsKF9fTlJfcHJsaW1pdDY0LCAwLCByZXNvdXJjZSwg
cmxpbSwgTlVMTCk7Cit9Ki8KKworc3RhdGljIHZvaWQgdmVyaWZ5X3NldHJsaW1pdDY0KHZvaWQp
Cit7CisJaW50IHN0YXR1czsKKwlwaWRfdCBwaWQ7CisKKwlybGltLT5ybGltX2N1ciA9IDE7CisJ
cmxpbS0+cmxpbV9tYXggPSAyOworCisJKmVuZCA9IDA7CisKKwlwaWQgPSBmb3JrKCk7CisJaWYg
KCFwaWQpIHsKKwkJVEVTVChzZXRybGltaXRfdTY0KFJMSU1JVF9DUFUsIHJsaW0pKTsKKwkJaWYg
KFRTVF9SRVQgPT0gLTEpIHsKKwkJCXRzdF9yZXMoVEZBSUwgfCBUVEVSUk5PLAorCQkJCSJzZXRy
bGltaXRfdTY0KFJMSU1JVF9DUFUpIGZhaWxlZCIpOworCQkJZXhpdCgxKTsKKwkJfQorCisJCWFs
YXJtKDIwKTsKKworCQl3aGlsZSAoMSkKKwkJCTsKKwl9CisKKwl3YWl0cGlkKHBpZCwgJnN0YXR1
cywgMCk7CisKKwlpZiAoV0lGRVhJVEVEKHN0YXR1cykgJiYgV0VYSVRTVEFUVVMoc3RhdHVzKSA9
PSAxKQorCQlyZXR1cm47CisKKwlpZiAoV0lGU0lHTkFMRUQoc3RhdHVzKSkgeworCQlpZiAoV1RF
Uk1TSUcoc3RhdHVzKSA9PSBTSUdLSUxMICYmICplbmQgPT0gU0lHWENQVSkgeworCQkJdHN0X3Jl
cyhUUEFTUywKKwkJCQkiR290IFNJR1hDUFUgdGhlbiBTSUdLSUxMIGFmdGVyIHJlYWNoaW5nIGJv
dGggbGltaXQiKTsKKwkJCXJldHVybjsKKwkJfQorCisJCWlmIChXVEVSTVNJRyhzdGF0dXMpID09
IFNJR0tJTEwgJiYgISplbmQpIHsKKwkJCXRzdF9yZXMoVEZBSUwsCisJCQkJIkdvdCBvbmx5IFNJ
R0tJTEwgYWZ0ZXIgcmVhY2hpbmcgYm90aCBsaW1pdCIpOworCQkJcmV0dXJuOworCQl9CisKKwkJ
aWYgKFdURVJNU0lHKHN0YXR1cykgPT0gU0lHQUxSTSAmJiAqZW5kID09IFNJR1hDUFUpIHsKKwkJ
CXRzdF9yZXMoVEZBSUwsCisJCQkJIkdvdCBvbmx5IFNJR1hDUFUgYWZ0ZXIgcmVhY2hpbmcgYm90
aCBsaW1pdCIpOworCQkJcmV0dXJuOworCQl9CisKKwkJaWYgKFdURVJNU0lHKHN0YXR1cykgPT0g
U0lHQUxSTSAmJiAhKmVuZCkgeworCQkJdHN0X3JlcyhURkFJTCwKKwkJCQkiR290IG5vIHNpZ25h
bCBhZnRlciByZWFjaGluZyBib3RoIGxpbWl0Iik7CisJCQlyZXR1cm47CisJCX0KKwl9CisKKwl0
c3RfcmVzKFRGQUlMLCAiQ2hpbGQgJXMiLCB0c3Rfc3Ryc3RhdHVzKHN0YXR1cykpOworfQorCitz
dGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7CisJLnRlc3RfYWxsID0gdmVyaWZ5X3NldHJs
aW1pdDY0LAorICAgICAgICAuYnVmcyA9IChzdHJ1Y3QgdHN0X2J1ZmZlcnMgW10pIHsKKyAgICAg
ICAgICAgICAgICB7JnJsaW0sIC5zaXplID0gc2l6ZW9mKCpybGltKX0sCisgICAgICAgICAgICAg
ICAge30sCisJfSwKKwkuc2V0dXAgPSBzZXR1cCwKKwkuY2xlYW51cCA9IGNsZWFudXAsCisJLmZv
cmtzX2NoaWxkID0gMSwKK307Ci0tIAoyLjQzLjUKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
