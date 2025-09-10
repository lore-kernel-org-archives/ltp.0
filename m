Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03648CA101F
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757542820; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=05qPBejyqRpTIiQdHP3YwSKcPljeeU6YJo34KqSc6vY=;
 b=jeujv3w1eKvce9KNsExOpK3HyCmYV2hFg7dzdS4lPMsbG7s1fKjIxa6odT0vqBNmND4tT
 /9gKqgreZ10WKBI1/D8ndM2jbA9fm8cOu1Vt6kPaAb/zi3kJEa8gW0b99aOnE6AvB67rUfU
 ALNuwGorS3XA4a6PjB3+0cuiXmT93kE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12C763CD807
	for <ltp@archiver.kernel.org>; Thu, 11 Sep 2025 00:20:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3B8A3CA59B
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 00:19:58 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9504B14001E1
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 00:19:57 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3e4aeaa57b9so106580f8f.1
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1757542797; x=1758147597; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JeeTgttvtPKwt0R8V68tIgsFvEXFx0fAswuYPXygtKU=;
 b=A5Agl5sJ5cSZnDhTgG6mKXQ1TETVFMcLaxeCJlNQHE57wD+1KD92BwPoEwvvw1c413
 GpJJ6HYH3fmqc7wYOm7zQmpPMwS+LJbFu0NFtFc57ReL8TMHcMdc4mCoioS6hIS+aL4t
 GMr6Y4rw8S6ywEtSHMNmLlOg3gYGUzB3BO7rDDZz2eiwDc/gzVTgr7Rv3IWNJXfl9QZV
 55vZ6/UdgF5EE46QjNouRGYbGxIXs5IQSH6EPIHrfS4RvgTSWPohq5jd0y5vQ2maO/Bu
 YnY680wMU4Qr2/Wy9O0edoByViyEumA9QL56qUQSeZ/MiWVqCnqaAaWWi6HnmsJ6joLk
 u6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757542797; x=1758147597;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JeeTgttvtPKwt0R8V68tIgsFvEXFx0fAswuYPXygtKU=;
 b=fvnXO2Btbdeco8MQ9U4HdVb6uQPEdpSZ1oTjkoeEqB3N2RIGIY5nbT5rR3UtS5yOjY
 g1/wAAce41DQWxxkTlbhOWBYuENvK5sw5p3McG5F/txeGavHPVZdOlEPg5QMhyLBxhae
 RyVQOgfqYx5ZR+Ok3lKP9Xp+Z2KqFjHv7hu3Md6MRFrZAcW+Gai5bVlWpYJxno0cGHz7
 ufQllTC7yztwHJUfQfzuEkxKw8tlcEJR4VIJtF0haCFDAvnBRIBinVBwVniHAmWDuCXS
 zvAPGOWt6orITuTQYtUaSHZ897l6r2IjFBS9OfW9AX1rOxDyONZNmxKFLDfB8DXd/ECg
 3Zbw==
X-Gm-Message-State: AOJu0Yy36YDGPm7naXwSW8HvyI7wZsHXxr8lBSovOt/KUTCEeCg3W8gs
 NvsfZAAJfvaXATPCpUI/s3iRk8+/KK6DIZhEcBrhrWMSAzLha1Yg9Qmc26cGX+cFzZqJNADOaGu
 tjDcm
X-Gm-Gg: ASbGncuoSXqaeNvecvWrH/9Au0s8JFGUKHbDOVpOXbo8JyhkH1tSxpkH9853Swxz5jk
 sCDHCK1W/MtfmpcPBYZr8ctLSiarLYErakRX0vx3IGq9N/aI2J8qm9dYXSCbdcmYQVC8+a8WK5P
 DMNEz5O1AeUvAVG2IqDY17d/YTBiKZJR/TACL6zsvRCGc/U4tz1Yb3rxxgw8Sn9vInCXEV2whTA
 GrAEvc4UoZY0Nwu6ct1Mic/S9T0L5i9b45Y5HC3mSo9LzqKlwCMYB3K2mWeo9gvvJN7/Cworc0J
 ZlUUL0SNVH3xDY/Lgy6OAo/8G9cZdRxg+5don1mXIX2bnv4CpsgxDTWZcjWKE7WtJQdrbYg21qw
 JiHZ97i6vmQ==
X-Google-Smtp-Source: AGHT+IE0bmJUJ8pfY8CZDcQR4ztzp4HWKHOOUNgblBb1oGtSASFbyj4CDwmgQEvSQWn00CWUJcLxtg==
X-Received: by 2002:a5d:5f96:0:b0:3d2:82d:7da0 with SMTP id
 ffacd0b85a97d-3e645f79ddamr14370524f8f.43.1757542796814; 
 Wed, 10 Sep 2025 15:19:56 -0700 (PDT)
Received: from localhost ([177.94.120.255])
 by smtp.gmail.com with UTF8SMTPSA id
 ada2fe7eead31-553178ff52asm16295137.4.2025.09.10.15.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 15:19:56 -0700 (PDT)
Date: Wed, 10 Sep 2025 19:19:46 -0300
Message-Id: <20250910-conversions-lchown-v6-0-a133444cdb6a@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIL5wWgC/33NS07DMBgE4KtUXmPkdxxW3KNi4cdvYonayC4uq
 MrdsbshiiKWI818c0cVSoSKXk53VKDFGnPqQT2dkFtMegccfc+IESbJRBh2OTUoo1bxh1vyLWH
 trZOaB0qsRn34WSDE7wd6fuvZmgrYFpPcMqiLqVcoo7jEes3l53He6Kj/+9MoJti4yXjLTZDUv
 9avCs8uX9C4aexP0EQdCqwLXEg5kwDBGNgJfCMweSjwLjDPFLXcA+NqJ4itoA8F0QVFvJ8NoUI
 GvhPkVpgPBdmFyfHApPPUg9gI67r+AlZZVADUAQAA
X-Change-ID: 20250702-conversions-lchown-8dbc583f10b8
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2202; i=rbm@suse.com;
 h=from:subject:message-id; bh=RQjlc9niDxQPY97hPRTgrPQBDEcMlrrsOe92F8xmTy0=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBowfmHrv3k4cll05EN4qSiwh4/Y8hUUnehqexmC
 LbE6ddW3neJAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaMH5hxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKZLYg//Zigd8pyxu0l/FQoOfpBiqnDO5d+kZo0
 WvN+K8RTRYE5cRKmALkUtIiQ1im1HR/j9v7MDZuB80QId99P+Z2khhPl9l/wfU+rJiSO6wgbo54
 iKrHVFm/lxJi2D8PXLGMC0S5eCAfqXNuYN5BWwuWDDhYhma9NoM48w1hv2pTdeT+xC8RAy41S2u
 zg2Vi0o3/LHg1Mw3BJy9ObNaLV+lve6qIGPjo66NaDOD+z/qzAM3VS110TtUBMBNA5FTxtjz5v/
 V0IK15n8mtMUYYWdjj4vE43rkC9/si4n0XbRyWOTF8k8utV542Cxb2XT3VxC7nXsBgpkrZWeOmF
 nx+JDlDJVjC1jHcovXL72VER6jOEnroTgqVUxOR5JLa+phK0YbXQ1Jt/mhRms6unU8JuKHVAG7u
 tB7HNvCs/AtXpfyMRsS6waAI8yEcr0RcnYleB4wunFl+0oiuCQP4n47e1w3ZTmxicGbm4DvsQs4
 ehoJc7A0tmoi5su3ATAYI9ioWO5sK31rihlpiRLJRn9eQG6G1ApE4hY1DFFzEnku2MrrPKzZxBT
 H5xDzre24c4M5Gco/4qYi4b8Ellx8T4guduAXRQDmQrBCcLaTO1FMJF+CvVGQnFWpj3LrLlMDxb
 4dcm6syJopSWHQx5OG0bn0axoG7HNAi7Z0GztizFArc40T4cDAMw=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/4] syscalls: lchown: Convert to new API
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

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tCkNo
YW5nZXMgaW4gdjY6Ci0gbGNob3duMDI6IFNpbXBsaWZpZWQgRUxPT1AgZ2VuZXJhdGlvbiBhbmQg
bW92ZWQgdWlkfGdpZCBjaGVja3MgdG8gc2V0dXAoKSAoQ3lyaWwpCi0gTGluayB0byB2NTogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDgyOS1jb252ZXJzaW9ucy1sY2hvd24tdjUtMC03
YzNmMjVjZDFkZTRAc3VzZS5jb20KCkNoYW5nZXMgaW4gdjU6Ci0gbGNob3duMDE6IHJlY292ZXIg
b3JpZ2luYWwgdGVzdCBpbnRlbnQKLSBsY2hvd24wMjogc2ltcGxpZmllZCB0ZXN0IGRlc2NyaXB0
aW9uIGluZm8gcHJpbnQKLSBMaW5rIHRvIHY0OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIw
MjUwODI4LWNvbnZlcnNpb25zLWxjaG93bi12NC0wLTYwZGQ5YTAxNDVmM0BzdXNlLmNvbQoKQ2hh
bmdlcyBpbiB2NDoKLSBNZXJnZWQgbGNob3duMDMgaW50byBsY2hvd24wMgotIExpbmsgdG8gdjM6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA4MjUtY29udmVyc2lvbnMtbGNob3duLXYz
LTAtMmQyNjFiM2RlMjM2QHN1c2UuY29tCgpDaGFuZ2VzIGluIHYzOgotIFByb3Blcmx5IHVzZWQg
YnVmZmVyIGd1YXJkcwotIFJlYmFzZWQKLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjUwODA2LWNvbnZlcnNpb25zLWxjaG93bi12Mi0wLTM0NTU5MGZlZmFhZUBzdXNl
LmNvbQoKQ2hhbmdlcyBpbiB2MjoKLSBKb2luIHRlc3RfY2FzZV90IHN0cnVjdHMgYW5kIGFycmF5
cyBkZWZpbml0aW9ucwotIFNpbXBsaWZ5IG92ZXJhbGwgYnkgcmVtb3ZpbmcgdW5uZWVkZWQgY29t
bWVudHMKLSBVc2Ugb2N0YWwgcGVybWlzc2lvbiBtb2RlcwotIFVzZSBTQUZFX1RPVUNIIHdoZW4g
cG9zc2libGUKLSBsY2hvd24wMTogUmVtb3ZlZCB1bm5lZWRlZCB1c2Ugb2YgZ2V0ZXVpZCgpIGFu
ZCBnZXRlZ2lkKCkKLSBsY2hvd24wMjogTWVyZ2VkIGFsbCBzZXR1cCBpbnRvIGEgc2luZ2xlIGZ1
bmN0aW9uCi0gbGNob3duMDM6IEFkZGVkIHRlc3QgZGVzY3JpcHRpb25zIGFuZCB1c2VkIHNucHJp
bnRmKCkgaW5zdGVhZCBvZiBzdHJjcHkoKQotIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3IvMjAyNTA3MDItY29udmVyc2lvbnMtbGNob3duLXYxLTAtYWM3YWRiM2FmNTFkQHN1
c2UuY29tCgotLS0KUmljYXJkbyBCLiBNYXJsacOocmUgKDQpOgogICAgICBsaWI6IEFkZCBTQUZF
X0xDSE9XTgogICAgICBzeXNjYWxsczogbGNob3duMDE6IENvbnZlcnQgdG8gbmV3IEFQSQogICAg
ICBzeXNjYWxsczogbGNob3duMDI6IENvbnZlcnQgdG8gbmV3IEFQSQogICAgICBzeXNjYWxsczog
bGNob3duMDM6IE1lcmdlIGludG8gbGNob3duMDIKCiBpbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmgg
ICAgICAgICAgICAgICAgICAgIHwgICAzICsKIGluY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmggICAg
ICAgICAgICAgICAgICAgfCAgIDMgKwogbGliL3NhZmVfbWFjcm9zLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAxOSArKwogcnVudGVzdC9zeXNjYWxscyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMiAtCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xjaG93bi8uZ2l0aWdu
b3JlIHwgICAyIC0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGNob3duL01ha2VmaWxlICAg
fCAgIDUgLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sY2hvd24vbGNob3duMDEuYyB8IDE5
NSArKysrLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGNob3duL2xjaG93
bjAyLmMgfCAzNTggKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQogdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9sY2hvd24vbGNob3duMDMuYyB8IDE1MyAtLS0tLS0tLS0tLS0KIDkgZmlsZXMg
Y2hhbmdlZCwgMTU5IGluc2VydGlvbnMoKyksIDU4MSBkZWxldGlvbnMoLSkKLS0tCmJhc2UtY29t
bWl0OiA2MDNlNzcyMjAxNDRkN2JjYmY5ZjgxOGM2YjgyMWE1NmFhNGQ0YTRmCmNoYW5nZS1pZDog
MjAyNTA3MDItY29udmVyc2lvbnMtbGNob3duLThkYmM1ODNmMTBiOAoKQmVzdCByZWdhcmRzLAot
LSAKUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
