Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B314AC369A1
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 11:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744111625; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=Sd6ExnkUp4SXVVbfP6gSKh5k8vOPvtrv1VPhXXBgAyE=;
 b=cj0gqctc2ZJoLwl3zKcjn2bQgD6PgvGuGQjy1u9xMP3ImnCVaTX1Td7wdiHedG7ymkU+t
 33oDrmW/KUYySf+sdtJjFOgkBzrkReHm/mNJ2iSw0mt7mw3WO/neyOfEcVQlB34C1KBpJ3X
 UJuXsE5+TIrB7mnJJPJ/1MjYb0UTEnw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D13E3CB37A
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 13:27:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CC7A3CB36B
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 13:26:43 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 05EE010005DF
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 13:26:41 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso3097223f8f.2
 for <ltp@lists.linux.it>; Tue, 08 Apr 2025 04:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744111601; x=1744716401; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UikzsRv2xQxMFd6e0aP1IYPNIo5B35NcWUU3oTvFScE=;
 b=L1CIxBZH40nT0G1AWj5H8dDrD3Hq7qGV1Ce4XXj3bMw79v1UikgJ/TGu0P0SIvGouO
 dSPlqF61Jbod86PW9MFMwo00GL9lyK1XRT9nArQ1gPe8FEo7jqQK1RR4jO079ka2mx9a
 pP/C6OyKy4KbjUKZl084HpYWDI8P5gU9fRNRmxqIrfdKqCZ2Pvgm8SwVgxJ6XV3nfO8p
 Rm8HVgCLIhBOmQGRaMvvO7cpUi5MZXEtEYUTQx1AEq4bJG2i5+pehvTFA0FlYZ797Eq4
 o3UimbXsTJ0tt0BI8D8rpGHCCPr0k0nWdbSfcqy3foHmlAOdX9XPRGuV0tsVd+uQqHdP
 dhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744111601; x=1744716401;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UikzsRv2xQxMFd6e0aP1IYPNIo5B35NcWUU3oTvFScE=;
 b=H9GXt+Yv/enlMXbHnK5AdYIOq7/LpxzMQfxUp3dPBoBA948lkBnk87GUr7yT9FvNJC
 83bAI+xiwP2YYft5PWebbFMeSaEvZMy35jNyudyY4QillDYq5W4VO5gdlE5/0R7knsCg
 kKf6rTXzeFNfbtEFz5ESRPeIyCeb5nz4TgMvHVCJKgssXtSbLXIzxoqHScY0BbPO5sRi
 vPpSg9hZN2cD/+0TypHLU+Pug5yBSmAT/3tZh1xqplD+AAetAJfUHdF28+7nkkg+TY6+
 +opzV3tTg1IR+N+4/qjmoWHs/LHy1WXgLh6Qz0noLLBGUiEJPlWiwjc+/q3fTm7D6Kne
 ZBgg==
X-Gm-Message-State: AOJu0YxKlKu7VYEo6C9/AAk/uLoEry9FYj8NiOU1NzU0On2gdZBEhcal
 m24yS2j0e/gqXKvVfDfTbL4nkAuMyLM7M43FXMajy1ry+grUueo7xawYdGLJWISkuneV+9jYXTM
 q
X-Gm-Gg: ASbGncvwjFuLQdUAXiA8yyVJfONeqjdb1zWTANzYSgNOGfxDcadDmdec+6ySzi/WZIN
 qLTXwoqh0E17ZmeSPHPtEskVGOfP0c71KyUz6eRYTbEu9ANCEy6uk+hEjkLxgCw8z+hzxJ52JCU
 hbVahUH7j7BSovyalQzx7zm1VTHio2+kAGeDFKAshOGKTvqqzL5FVwAcWyx5FbnzZ9vtF+BVdBp
 d3NuqSk60tDNu4wSKayrSYWJMdDl8f3VGadOOTqcOTrPpoaANPzokjmV5F2xhpviusj2OF6TJ65
 y270qk2Nk/+r2IEI+LrSf6W4zBtSpmg0bQ==
X-Google-Smtp-Source: AGHT+IHvW7kIAUJOrg9+yEAMyVnc1tQBrNXNVoahNzwhenS+t2sTmGJRy/+Wm1TWQ2c9/O+Cx6meuw==
X-Received: by 2002:a05:6000:1445:b0:38f:5057:5810 with SMTP id
 ffacd0b85a97d-39cb35a6bd8mr13183122f8f.25.1744111601084; 
 Tue, 08 Apr 2025 04:26:41 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-229787780b6sm97584395ad.258.2025.04.08.04.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 04:26:40 -0700 (PDT)
Date: Tue, 08 Apr 2025 08:26:33 -0300
Message-Id: <20250408-conversions-modify_ldt-v8-0-7bdba108f64a@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOkH9WcC/43Qy0rFMBAG4Fc5ZG0kmVzryvcQkVymNmBbSWrxc
 Oi7m5yNpVB0+cOfbyZzIwVzwkKeLjeScU0lzVMN9uFCwuCmd6Qp1kyAgWICJA3ztGJutULHOab
 ++vYRF2q5FtABiF4jqY8/M/bp+w6/vNbsXUHqs5vC0LjRlQVzKw6pLHO+3hdYeav/OWvllFEbd
 bTQc2a0fS5fBR/DPJI2aoW9Yk4VqAp0zEQZ69aBHRSxV+ypIqrSa68Reei4lAdF/k+RVXEK0Xh
 bf+XcQVE7RfBTRbVdokbHZcc7pQ+K/lUkg1NFt7ug9AzBWMPwoJi9cn5dU5Xg0QvTCc2c2inbt
 v0AADkG/3gCAAA=
X-Change-ID: 20250324-conversions-modify_ldt-816329223f6e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3649; i=rbm@suse.com;
 h=from:subject:message-id; bh=wuxb329GSdOz9g8hY0qsbLdt2s15+AMbiOuIqLtf4ag=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn9Qfsv92rSMqXfhClUeqSxEAGOUUTPd9HTyF/F
 bl0s2LTSJSJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ/UH7AAKCRDJC4p8Y4ZY
 pi8wEAClxZiydFdkCyCXmqMh89nXoi+ebqUINdmX2YjN47UiUpWi6wsJJJnB5tWxYGILtn3eVke
 h44wGQpih2Pym3Iom2qkXUjPw6f57TcqiOWNTgTsxedjUvotbmVk9vokOMcxkC+Cy+cGZdnoMN+
 UnkklO4iB4a0Gmjg6SNXTGEhdeGWfal3KsnPsTszpyhiAxgCoqgttTSVa1Pm8LfgY//YqtrP151
 u30CPYhhMUw98o3JM9oBjBtCqnNXSDhcJ5PQfTU2O4+zxYDSgcWqTErO10odkDROXpJbX9Q5kn0
 3RKvG1rNOjkqLMrSqpUcYkDTHYR9MNQCsUjJebHpyvTb5h/XWCy78nZzXte2AuJXRTTXu7ynPac
 /ddIPI1AU8hmDaPgMmKKBQHns2tQFubCjeWsgQ6hg2NDRF/JeIzCCqQvHNdbai9vMmWCxLPFerZ
 35oBdJ5Mw/0RQdjMfN39eg98cOPkzFiaQuc1aFc1vMObm2wEU4IvS0d51dFJKg2rd3nn1T3N/ua
 nfv/5JGlSPN1p3JCevnA03/UgU4ODAvcJ5zTSvkeuJHyCWxXckiHHHGfrl0EDl573JYNeO2f1wj
 YMqQSlXGBlqtnjREJS5KBcHJJsdCLMMEbRMwfzD3yUDi+TcX8nDJ9y2iy/shPMAHD2LB5d3BNml
 A/yr6uo62/iCPBw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 0/3] syscalls/modify_ldt: Refactor into new API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhpcyBzZXJpZXMgaXMgYXZhaWxhYmxlIGF0OgoKaHR0cHM6Ly9naXRodWIuY29tL3JibWFybGll
cmUvbHRwL3RyZWUvY29udmVyc2lvbnMvbW9kaWZ5X2xkdAoKQ0kgaXMgZ3JlZW46CgpodHRwczov
L2dpdGh1Yi5jb20vcmJtYXJsaWVyZS9sdHAvYWN0aW9ucy9ydW5zLzE0MzE2ODYyMDM0CgpTaWdu
ZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgotLS0KQ2hhbmdl
cyBpbiB2ODoKLSBBZGRlZCBlbHNlIGJsb2NrIHRvIGNhdGNoIGFsbCBvdGhlciBpbnZhbGlkIHJl
dCB2YWx1ZXMgaW4gc2FmZV9tb2RpZnlfbGR0Ci0gUmVtb3ZlZCBtb2RpZnlfbGR0MDMgZnJvbSBy
dW50ZXN0L3N5c2NhbGxzCi0gTWFkZSBjcmVhdGVfc2VnbWVudCBzdGF0aWMgaW5saW5lIHZvaWQK
LSBTaW1wbGlmaWVkIG1vZGlmeV9sZHQwMiBhcyBzaWduYWwoKSBpcyBub3QgbmVlZGVkCi0gTGlu
ayB0byB2NzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDQwNy1jb252ZXJzaW9ucy1t
b2RpZnlfbGR0LXY3LTAtY2JlYjM3OTM2MGE1QHN1c2UuY29tCgpDaGFuZ2VzIGluIHY3OgotIEFk
ZGVkIGJhY2sgdGhlIGNoZWNrIGZvciBhc20vbGR0LmggaW4gY29uZmlndXJlLmFjCi0gQWRkZWQg
YmFjayB0aGUgZmFsbGJhY2sgZGVmaW5pdGlvbiBvZiBzdHJ1Y3QgdXNlcl9kZXNjCi0gTGluayB0
byB2NjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDQwMi1jb252ZXJzaW9ucy1tb2Rp
ZnlfbGR0LXY2LTAtMmU0YjBlMjc4NzBlQHN1c2UuY29tCgpDaGFuZ2VzIGluIHY2OgotIFJlbW92
ZWQgdW5uZWNlc3NhcnkgaW5jbHVkZXMKLSBNYWRlIG1vZGlmeV9sZHQgd3JhcHBlcnMgc3RhdGlj
IGlubGluZQotIFVzZWQgY29uc3Qgc3RydWN0IHVzZXJfZGVzYyAqcHRyIGluc3RlYWQgb2Ygdm9p
ZCAqcHRyIGluIG1vZGlmeV9sZHQoKQotIEZpeGVkIG1vZGlmeV9sZHQwMSB0ZXN0IGRlc2NyaXB0
aW9uCi0gQWRkZWQgZXhwbGFuYXRpb24gb24gcmVtb3ZhbCBvZiAiYXNtL2xkdC5oIiBjaGVjayBp
biBjb21taXQgbWVzc2FnZQotIFJlbW92ZWQgcnVuX2NoaWxkKCkgaW4gbW9kaWZ5X2xkdDAyIC0g
aW5zdGVhZCwgcmVtb3ZlZCB1bnVzZWQgImludCB2YWwiCi0gUmVuYW1lZCAiZW50cnkiIHRvICJp
bnZhbGlkX2VudHJ5IiBpbiBtb2RpZnlfbGR0MDEKLSBMaW5rIHRvIHY1OiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjUwMzMxLWNvbnZlcnNpb25zLW1vZGlmeV9sZHQtdjUtMC1mZDZlYTE0
OTE5NTZAc3VzZS5jb20KCkNoYW5nZXMgaW4gdjU6Ci0gUmVtb3ZlZCB1bm5lY2Vzc2FyeSAjZXJy
b3IKLSBSZW1vdmVkIGNvbnN0IHNwZWNpZmllciBpbiBjdmUtMjAxNS0zMjkwLmMKLSBJbXByb3Zl
ZCBtb2RpZnlfbGR0MDIgdGVzdCBkZXNjcmlwdGlvbgotIEFkZGVkIHJ1bl9jaGlsZCgpIGluIG1v
ZGlmeV9sZHQwMgotIFJlbW92ZWQgdW5uZWNlc3NhcnkgI2luY2x1ZGUgImxhcGkvbGR0LmgiIGlu
IGZpbGVzIHRoYXQgaW5jbHVkZSBjb21tb24uaAotIEV4dGVuZGVkIGNvdmVyYWdlIGluIG1vZGlm
eV9sZHQwMQotIExpbmsgdG8gdjQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAzMjgt
Y29udmVyc2lvbnMtbW9kaWZ5X2xkdC12NC0wLWE1ZWU3YjhkODJhYUBzdXNlLmNvbQoKQ2hhbmdl
cyBpbiB2NDoKLSBSZS1hZGRlZCB0aGUgYXNtL2xkdC5oIGluY2x1ZGUgZGlyZWN0aXZlCi0gTGlu
ayB0byB2MzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDMyOC1jb252ZXJzaW9ucy1t
b2RpZnlfbGR0LXYzLTAtZjZiNmVlMWM5MTQ0QHN1c2UuY29tCgpDaGFuZ2VzIGluIHYzOgotIERy
b3BwZWQgdGhlIHNldF90aHJlYWRfYXJlYTAxIHBhdGNoIGZvciBhIGxhdGVyIHNlcmllcwotIFNx
dWFzaGVkIG1vZGlmeV9sZHQwMyBjb21taXQgaW50byBtb2RpZnlfbGR0MDEKLSBSZW5hbWVkIHN0
cnVjdCB0c3RfY2FzZSB0byB0Y2FzZQotIFJlbW92ZWQgZmFsbGJhY2sgZGVmaW5pdGlvbiBvZiBz
dHJ1Y3QgdXNlcl9kZXNjCi0gTGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8y
MDI1MDMyNy1jb252ZXJzaW9ucy1tb2RpZnlfbGR0LXYyLTAtMjkwN2Q0ZDNmNmMwQHN1c2UuY29t
CgpDaGFuZ2VzIGluIHYyOgotIEFsc28gcmVmYWN0b3JlZCBzZXRfdGhyZWFkX2FyZWEwMQotIE1l
cmdlZCBzaW1wbGUgdGVzdHMgKGluY2x1ZGluZyB0aGUgZXhpc3RpbmcgbW9kaWZ5X2xkdDAzKSBp
bnRvCm1vZGlmeV9sZHQwMSBpbnN0ZWFkIG9mIHNwbGl0dGluZyBpdAotIEFkZGVkIFNBRkVfTU9E
SUZZX0xEVCgpIG1hY3JvCi0gUmVtb3ZlZCBjaGVjayB0byBhc20vbGR0LmggaW4gY29uZmlndXJl
LmFjCi0gVXNlZCB0c3Rfc3lzY2FsbCgpIGluc3RlYWQgb2Ygc3lzY2FsbCgpIGluIG1vZGlmeV9s
ZHQoKSBAIGxhcGkvbGR0LmgKLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjUwMzI0LWNvbnZlcnNpb25zLW1vZGlmeV9sZHQtdjEtMC04ZDZkODJmMTA3NjhAc3VzZS5j
b20KCi0tLQpSaWNhcmRvIEIuIE1hcmxpw6hyZSAoMyk6CiAgICAgIHN5c2NhbGxzL21vZGlmeV9s
ZHQ6IEFkZCBsYXBpL2xkdC5oCiAgICAgIHN5c2NhbGxzL21vZGlmeV9sZHQwMjogUmVmYWN0b3Ig
aW50byBuZXcgQVBJCiAgICAgIHN5c2NhbGxzL21vZGlmeV9sZHQwMTogUmVmYWN0b3IgaW50byBu
ZXcgQVBJCgogaW5jbHVkZS9sYXBpL2xkdC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgNTggKysrKysKIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAxIC0KIHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jICAgICAgICAg
ICAgICAgICAgICAgIHwgIDI2ICstCiB0ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE3LTE3MDUzLmMgICAg
ICAgICAgICAgICAgICAgICB8ICAgNiArLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mb3Jr
L2ZvcmswNS5jICAgICAgICAgICAgfCAgIDUgKy0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
bW9kaWZ5X2xkdC8uZ2l0aWdub3JlICAgIHwgICA1ICstCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL21vZGlmeV9sZHQvY29tbW9uLmggICAgICB8ICAzMCArKysKIC4uLi9rZXJuZWwvc3lzY2Fs
bHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0MDEuYyAgICAgIHwgMjY0ICsrKysrLS0tLS0tLS0tLS0t
LS0tLQogLi4uL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0L21vZGlmeV9sZHQwMi5jICAgICAg
fCAyMTUgKysrKy0tLS0tLS0tLS0tLS0KIC4uLi9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9t
b2RpZnlfbGR0MDMuYyAgICAgIHwgMTA1IC0tLS0tLS0tCiAxMCBmaWxlcyBjaGFuZ2VkLCAxOTIg
aW5zZXJ0aW9ucygrKSwgNTIzIGRlbGV0aW9ucygtKQotLS0KYmFzZS1jb21taXQ6IGVhNTBlYWJk
MjI2NTEyZjE3NzM3ZWQ2NzNkZWVjY2ExMDYxZWFkYmUKY2hhbmdlLWlkOiAyMDI1MDMyNC1jb252
ZXJzaW9ucy1tb2RpZnlfbGR0LTgxNjMyOTIyM2Y2ZQoKQmVzdCByZWdhcmRzLAotLSAKUmljYXJk
byBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
