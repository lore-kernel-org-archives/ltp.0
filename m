Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55696C83F1B
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752156396; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=9hlJvSX87sfiMRrIpPE4Uve63HqqL2v70B6Co5AG+Dc=;
 b=cRq/OHzrL3Lym7lPmMBh45xvWcvb4QvJBuhj40r40zzj5a+aSKpsW+cMz5d5T3YQWP5N4
 kPvdDJBGd5yYXk/FFcqi1zPHcyKDa/NHUwb55Y3X7rtRr8YBG5KRY+K1IWg2S3l8FSvnPql
 3OEUnTBsls3m79V2HEy5lcQuJSOsYTg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8362B3CB0C2
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 16:06:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC6943C9B29
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 16:06:15 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 43C491400202
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 16:06:14 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453066fad06so6328055e9.2
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752156374; x=1752761174; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P1nZEdyEEZrX2A6G28KgbJnLyVjHaVW1iN2ZVKp+TUQ=;
 b=OVcX6nKAeNlEyHCmVyk/DEe6+e4jns7Y7mjJNxE9x8yZrrIWBenzFk4ex0h3bnm/+j
 +CLTgLtlO2U2UsJGQauOS1Fw4mh1kP3WyA6KfbJEgaWoD38lNPPkoleEIwdGO+QuRXqu
 oPtifMiolaSrXE+m6YznYuH7P2fpiDpmZ+ROVLpHVK56sw2YEtZLyrXfa51QWC30uwhn
 LQ8YktAPStGCLpNeMqvc+1UnvSx1WArHRvwrjDActKOysHGQjRhqqBNfynpOxTb/RrGR
 piswWSUIYRaZvu47cG0EW0bBE0JE//dxMVDgVHw5eDqYfZ97jQ1sC8rdXvMCxljH47nh
 AhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752156374; x=1752761174;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P1nZEdyEEZrX2A6G28KgbJnLyVjHaVW1iN2ZVKp+TUQ=;
 b=NCfgZkcLNDZpr/kPNY1VcIpcOo2esk1kkDNkGqMGYVlcx4EBCGJLkH4iri4f+gAXi7
 ATFMuH6Fyzln1SmL10hvdK0KmAvG5YOVQYJ5VI7ST2gK7qdDKIAwBZ2HEd83wm6GCb+j
 YOa668cI4/86ooYKn9B+RYWGUi+G2mV43FXKE6TfdlP9FczuCPWUkL721mesQhZuh4q8
 ZXdevpmddWz/wFMUYigTQhb6RKz5TX3rWb4RlSsIumxelCP+Yo1STDQ/LiYjbG2rxJfY
 qhkWXXdn4O3Y51prXTYTwOXViWmEk79QRnFyDAi+DShmmLrUohu2oVbSxeUPiAtPJ5Q5
 25QA==
X-Gm-Message-State: AOJu0YwtIy8Rob0MfJNpw9pFowMoqNY0GL/RALkBe3YPClNoMqjxaGEr
 8/TfPvn9ec0CndsVbG9RisT0ligHVWFhFOTpzQdu4vuQBrRF4THUTUAs8GOQ/egVjng=
X-Gm-Gg: ASbGncuSkJOb4mAJ/RnPASoqmcKAbvoAHvz0BXthu2EnIzJrOZ/ch9Jc7ZCGAtZUY8q
 sFbGLiKZBTl/jqLJrbjVC8Ny1L9BI3WxXPrJzoDaTxiS2Ec5lM6oJBAFTXE1VP7KrTv+zYXSyfy
 kI+lZLAaVRe20A1UNSl0vQyE6ScYoFLZdgO2iv6EU4xoJmIlq9VKRsiNJaF3XqGD8RD/eYiJEYg
 frZyZEFKhFBtJxmL24n8vqovLpdWstv/Mnj3XPCv+cs8b/SJWf7em3tAU/TA+bU5BMqRUXmbdVv
 UyIzstz4PBshxR5XM9346KEQqVKmbHitNj1AScVhXTq79js4vw==
X-Google-Smtp-Source: AGHT+IGKScOtcIHoY8Slz84rWtHJ+blM9hOu2nngguAnehmQ0gDJxTI3GhDFOo38VU7iojkDX9O8YQ==
X-Received: by 2002:a05:6000:2211:b0:3a5:2182:bd17 with SMTP id
 ffacd0b85a97d-3b5e44e9e9fmr5142184f8f.19.1752156373193; 
 Thu, 10 Jul 2025 07:06:13 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-31c3eb62056sm2370009a91.38.2025.07.10.07.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 07:06:12 -0700 (PDT)
Date: Thu, 10 Jul 2025 11:06:08 -0300
MIME-Version: 1.0
Message-Id: <20250710-new-munmap04-v5-1-6db635172be9@suse.com>
X-B4-Tracking: v=1; b=H4sIAM/Ib2gC/33NzW6DMBAE4FeJfI4r/4FNTn2Pqoe1WYIPGGQnJ
 BXi3btwQkjtcaT5ZhZWMEcs7HZZWMY5ljgmCtX1wkIP6Y48tpSZEqoSVhie8MWHZxpgogBVE0A
 JQCECIzJl7OJ7n/v6puyhIPcZUui3kQHKA/NW7GN5jPlnv53lVv/jYZZc8hq7ppbaedGoz/Is+
 BHGgW0Hs/rPKrJG18GJlgZMfbL6aO3JarKosWvBoW2VP1lztO5kDVnnTGetkbbx8mDXdf0FrDA
 0UnQBAAA=
X-Change-ID: 20250704-new-munmap04-a59ca20ae00c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4370; i=rbm@suse.com;
 h=from:subject:message-id; bh=q09gPszutafw9L+9Auxndg0yDpLtwdz/osDc/Bo5IqY=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBob8jRv6Zub6aYB2A/Ng6KLG9csflrQKk9T3lxI
 UchZUocDIyJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaG/I0QAKCRDJC4p8Y4ZY
 pgwOEAC0l6t0b1rPkpQ2naMv1z914GlNmqIyLWGglfT2t/lkfymSFjfLatbYS6nvciAZJWzMLGo
 U3/UIbEGEBKKaodBOOFmNQVuQ8JBWHul3Z4ph3uR+nZBSiKnUqBRluDxegTQNyww6u+eHtVlEM3
 XcLtIzBAMy/E+wQ36NJZlXbKTCYgp6MLBMPu8Bagk6LvikUf/XnROLM52CWw8vxLemD5eqR++0N
 8Ss4u2fk0kplBVpiIzAYI2WeKQ4QnP+V2qgPS28t81yuIbAbOhd2gX43EuIb3yAUW2hoIdjguEV
 S1X4W5ZiOYiB5QV5wG2DlfJJsH7gG76ka5DNk/UVtfmG28b+mBDPH+btR/6heMHyfofTaNe4U7B
 5vKxSZKHRzUs6xTZhfMdXOZHFEGcOfji/vfMYstEdZL+J6+czYwxTDi7wSgxEE+5/pUYeSq6hFN
 v+dZ4eR7cFU7zYgWsDtR4C7SvaVhBFwXmm8IA+oWG0ku2b4F0fdQYAY2Q8vG1CzHXZw4IB+Xh94
 VRCoBE9xp7owafxobsB+W9qTYTodJ6Cumnn/Q0A9fji2UPIcJg5vQEyPMwMUf7dtAJl/dlfFhM3
 0KasG6lt4PKmnPt5ZjjFBxm119Kk2+4RvQ7n+OS2LUUyW232fJH2tkQ9nhddVJdTh0rsIZ4j0gU
 9m3sJ9awtE1lE0w==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] syscalls: munmap: Add munmap04 to check ENOMEM
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoZSBFUlJPUlMgc2Vj
dGlvbiBvZiB0aGUgbW1hcCgyKSBtYW5wYWdlIHNheXM6CgpFTk9NRU06IFRoZSBwcm9jZXNzJ3Mg
bWF4aW11bSBudW1iZXIgb2YgbWFwcGluZ3Mgd291bGQgaGF2ZSBiZWVuIGV4Y2VlZGVkLgpUaGlz
IGVycm9yIGNhbiBhbHNvIG9jY3VyIGZvciBtdW5tYXAoKSwgd2hlbiB1bm1hcHBpbmcgYSByZWdp
b24gaW4gdGhlCm1pZGRsZSBvZiBhbiBleGlzdGluZyBtYXBwaW5nLCBzaW5jZSB0aGlzIHJlc3Vs
dHMgaW4gdHdvIHNtYWxsZXIgbWFwcGluZ3MKb24gZWl0aGVyIHNpZGUgb2YgdGhlIHJlZ2lvbiBi
ZWluZyB1bm1hcHBlZC4KCkFkZCBhIG5ldyB0ZXN0IG11bm1hcDA0IHRvIGFkZHJlc3MgdGhpcyBz
Y2VuYXJpby4KClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5j
b20+Ci0tLQpDaGFuZ2VzIGluIHY1OgotIERyb3BwZWQgYXJndW1lbnQgcGFyc2luZyBpbiBmYXZv
ciBvZiB0c3RfdGVzdC5zYXZlX3Jlc3RvcmUKLSBMaW5rIHRvIHY0OiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjUwNzA4LW5ldy1tdW5tYXAwNC12NC0xLTg4NGY3NzQxNzliMUBzdXNlLmNv
bQoKQ2hhbmdlcyBpbiB2NDoKLSBSZWJhc2VkIGFmdGVyIG11bm1hcCBjb252ZXJzaW9uIHRvIG5l
dyBBUEkKLSBMaW5rIHRvIHYzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNzA3LW5l
dy1tdW5tYXAwNC12My0xLWUzZWZkYThlN2QyYkBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2MzoKLSBB
ZGRlZCBtaXNzaW5nIGluY2x1ZGUgdG8gImxhcGkvbW1hcC5oIgotIE1hZGUgbWF4X21hcF9jb3Vu
dCBhIHRlc3Qgb3B0aW9uCi0gS2VlcCB0aGUgbWFwcGVkIHJlZ2lvbnMgaW4gdGhlIGhlYXAKLSBS
ZXF1aXJlZCBtaW4uIGtlcm5lbCB2NC4xNwotIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3IvMjAyNTA3MDQtbmV3LW11bm1hcDA0LXYyLTEtNDM2YzgwZGY5NjQ2QHN1c2UuY29t
CgpDaGFuZ2VzIGluIHYyOgotIENvcnJlY3RlZCB0aGUgY29tbWl0IG1lc3NhZ2UKLSBMaW5rIHRv
IHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNzA0LW5ldy1tdW5tYXAwNC12MS0x
LTZlZjk2MTM4YjA5MkBzdXNlLmNvbQotLS0KIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMSArCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC8u
Z2l0aWdub3JlIHwgIDEgKwogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFw
MDQuYyB8IDc0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQs
IDc2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9ydW50ZXN0L3N5c2NhbGxzIGIvcnVudGVz
dC9zeXNjYWxscwppbmRleCA5YzgwYmNjYjA5MTE0ZDhiOTczMGZkZWUwNWUzZTI4ZjVjYzQ0YWZj
Li4wMTEyNjg3OWQyZDY3OWJkNTI5ZWUzNjU3ZjY1ODU5ODcyODkwMGYxIDEwMDY0NAotLS0gYS9y
dW50ZXN0L3N5c2NhbGxzCisrKyBiL3J1bnRlc3Qvc3lzY2FsbHMKQEAgLTk1MCw2ICs5NTAsNyBA
QCBtdW5sb2NrYWxsMDEgbXVubG9ja2FsbDAxCiAKIG11bm1hcDAxIG11bm1hcDAxCiBtdW5tYXAw
MyBtdW5tYXAwMworbXVubWFwMDQgbXVubWFwMDQKIAogbmFub3NsZWVwMDEgbmFub3NsZWVwMDEK
IG5hbm9zbGVlcDAyIG5hbm9zbGVlcDAyCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL211bm1hcC8uZ2l0aWdub3JlIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5t
YXAvLmdpdGlnbm9yZQppbmRleCBhYTZlMTRhNjcwZTg1ZGQxN2Y5NjViNGE0NjU5OTdhMDIxZjhi
NGFjLi43YWRlODYzOTBhMzRjZDZmYmJmNjUzMDM4NWU4OTFlMDFlMmI5MTM3IDEwMDY0NAotLS0g
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC8uZ2l0aWdub3JlCisrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwLy5naXRpZ25vcmUKQEAgLTEsMiArMSwzIEBACiAv
bXVubWFwMDEKIC9tdW5tYXAwMworL211bm1hcDA0CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9tdW5tYXAvbXVubWFwMDQuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLi4wNDRjZDBmNzlmYjhmODUzYTFiZTZjOGFl
YzYzYjU0Y2YzYmJhMDJmCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9tdW5tYXAvbXVubWFwMDQuYwpAQCAtMCwwICsxLDc0IEBACisvLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorLyoKKyAqIENvcHlyaWdodCAoYykgMjAyNSBT
VVNFIExMQyBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgorICovCisKKy8qXAor
ICogVmVyaWZ5IHRoYXQgbXVubWFwKCkgZmFpbHMgd2l0aCBFTk9NRU0gYWZ0ZXIgcGFydGlhbGx5
IHVubWFwcGluZyBhbgorICogZXhpc3RpbmcgbWFwLCB3aGlsZSBoYXZpbmcgdGhlIG1heGltdW0g
YW1vdW50IG9mIG1hcHMgYWxyZWFkeSBhbGxvY2F0ZWQuCisgKi8KKworI2luY2x1ZGUgInRzdF90
ZXN0LmgiCisjaW5jbHVkZSAibGFwaS9tbWFwLmgiCisKKyNkZWZpbmUgUEFEIDIgLyogYXZvaWQg
YWRqYWNlbnQgbWFwcGluZyBtZXJnZXMgKi8KKyNkZWZpbmUgTUVNU0laRSAzCisjZGVmaW5lIE1B
UF9NQVhfQ09VTlQgNjU1MzAKKworc3RhdGljIHVpbnRwdHJfdCBiYXNlID0gMHgxMDAwMDAwMDBV
TDsKK3N0YXRpYyBzaXplX3QgcGFnZV9zejsKK3N0YXRpYyB1bnNpZ25lZCBsb25nIHZtYV9zaXpl
Oworc3RhdGljIGludCBtYXBfY291bnQ7CitzdGF0aWMgdm9pZCAqKm1hcHM7CisKK3N0YXRpYyB2
b2lkIHJ1bih2b2lkKQoreworCVRTVF9FWFBfRkFJTChtdW5tYXAobWFwc1syXSArIHBhZ2Vfc3os
IHBhZ2Vfc3opLCBFTk9NRU0pOworfQorCitzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQoreworCXBh
Z2Vfc3ogPSBTQUZFX1NZU0NPTkYoX1NDX1BBR0VTSVpFKTsKKwl2bWFfc2l6ZSA9IE1FTVNJWkUg
KiBwYWdlX3N6OworCisJbWFwcyA9IFNBRkVfTUFMTE9DKE1BUF9NQVhfQ09VTlQgKiBzaXplb2Yo
Y2hhciAqKSk7CisJZm9yIChpbnQgaSA9IDA7IGkgPCBNQVBfTUFYX0NPVU5UOyBpKyspCisJCW1h
cHNbaV0gPSBOVUxMOworCisJd2hpbGUgKDEpIHsKKwkJdm9pZCAqcCA9IG1tYXAoKHZvaWQgKiko
YmFzZSArIFBBRCAqIHZtYV9zaXplICogbWFwX2NvdW50KSwKKwkJCSAgICAgdm1hX3NpemUsIFBS
T1RfTk9ORSwKKwkJCSAgICAgTUFQX1BSSVZBVEUgfCBNQVBfQU5PTllNT1VTIHwgTUFQX0ZJWEVE
X05PUkVQTEFDRSwKKwkJCSAgICAgLTEsIDApOworCQlpZiAocCA9PSBNQVBfRkFJTEVEKQorCQkJ
YnJlYWs7CisJCW1hcHNbbWFwX2NvdW50KytdID0gcDsKKwl9CisKKwlpZiAobWFwX2NvdW50ID09
IE1BUF9NQVhfQ09VTlQpCisJCXRzdF9icmsoVEJST0ssICJNYXBwZWQgYWxsICVkIHJlZ2lvbnMs
IGV4cGVjdGVkIGxlc3MiLAorCQkJbWFwX2NvdW50KTsKKworCXRzdF9yZXMoVElORk8sICJNYXBw
ZWQgJWQgcmVnaW9ucyIsIG1hcF9jb3VudCk7Cit9CisKK3N0YXRpYyB2b2lkIGNsZWFudXAodm9p
ZCkKK3sKKwlmb3IgKGludCBpID0gMDsgaSA8IG1hcF9jb3VudDsgaSsrKSB7CisJCWlmIChtYXBz
W2ldID09IE5VTEwpCisJCQlicmVhazsKKwkJU0FGRV9NVU5NQVAoKHZvaWQgKikobWFwc1tpXSks
IHZtYV9zaXplKTsKKwl9CisJZnJlZShtYXBzKTsKK30KKworc3RhdGljIHN0cnVjdCB0c3RfdGVz
dCB0ZXN0ID0geworCS50ZXN0X2FsbCA9IHJ1biwKKwkuc2V0dXAgPSBzZXR1cCwKKwkuY2xlYW51
cCA9IGNsZWFudXAsCisJLm1pbl9rdmVyID0gIjQuMTciLAorCS5zYXZlX3Jlc3RvcmUgPSAoY29u
c3Qgc3RydWN0IHRzdF9wYXRoX3ZhbFtdKXsKKwkJeyAiL3Byb2Mvc3lzL3ZtL21heF9tYXBfY291
bnQiLCBUU1RfVE9fU1RSKE1BUF9NQVhfQ09VTlQpLCBUU1RfU1JfU0tJUCB9LAorCQl7fSwKKwl9
LAorfTsKCi0tLQpiYXNlLWNvbW1pdDogMGM3MzQ2Y2IwOTc0NDA5MDI1Njg4NTY1MjdiZTcxNjJm
NTk1MDQ5NwpjaGFuZ2UtaWQ6IDIwMjUwNzA0LW5ldy1tdW5tYXAwNC1hNTljYTIwYWUwMGMKCkJl
c3QgcmVnYXJkcywKLS0gClJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
