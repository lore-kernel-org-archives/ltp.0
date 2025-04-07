Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B261C3601E
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 12:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744027419; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=m138mA+LC7shrocEmAslBPYm125uW+mklnpUiES9+3Y=;
 b=L6LD5R9Oo+sGyTLnP9qoQz7qURopf7BzgWc2DtbgnUySgDxW6PkO+vxthhr52VAKuo9Od
 s9K85cpCGLLS1Sd18T14Q8ebx0XWO1G36FXMVpNPh582aseoKdiuoOLXuy1da914L5nYyqb
 KjTE+gLdKp91v+iNO9Mz5stlZy6EX6Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 579C53CAEED
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:03:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C686B3C194A
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:03:17 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AA3C96006CD
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:03:15 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso2382914f8f.1
 for <ltp@lists.linux.it>; Mon, 07 Apr 2025 05:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744027395; x=1744632195; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pgj4t55p6HhryiP5JZDhhN+YR9Ftd8VB+TogDfjrQPY=;
 b=RY2TO33DF1u7hQL1sQC3x2blSRFrlBzOG31s5BmF0e5a2e+hFBQqAxybhx1CskP79M
 SI25fC3VGuvG36SI6/93LgDqG1psnwzvWmHZxnhh9TN12G5aqDTsK4wPTkCAL6MGoL/J
 cGOMGWuUNRULOe48QR8X8khi53gaNaSCjPn4Y9kjjdXMdxA3yEWkuYcCsGIGAS2Kn3uc
 DuLTSqSC434n12yrZtzcND5Zq0rJOcc3ySRCalNPMDprSgL4/m9hENz8yvl72Jq8FX8S
 TQEy4V9fSxFQ7PX1pl5sN0m/bJh09joW94XKlHQqIBjmVzrPub+b0crp8z5xIsRreqOF
 AvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744027395; x=1744632195;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pgj4t55p6HhryiP5JZDhhN+YR9Ftd8VB+TogDfjrQPY=;
 b=aW2Tl+huIFYpohFJPL/cU8Luxf8Dd6X55rzuV0ihYR5SbZa27pRGqrw/xyLa+3Hzzf
 CrDzqwQkRgXmfyCCzPjLw6CQ3U9l/EiaaRneELjhX4JH3JoIdMeH+YCDkMrBecyXx/5s
 h9Ix+yTe5ob0nbgwhsLa3d2CMZKujhAis3Lm7b/YD3DBLnuFz6FfBNmC3BWfcND0hHDu
 w8sGevT6cFuc/70ZOZqa19wz3dtgnd38oCFvCX4C/1b8gWaE2k0keQmdNi1zEt9mA3oA
 UFIBg29CepSTAcNT05sfe48tS7mq4VpaApY46G8+u5kXwBoNgKggvcy4P46rqpPgiYVA
 PSBg==
X-Gm-Message-State: AOJu0YwtvtvxSmv+9VRUFBKk/0JPkQte4Ah86xbaCQvcjdOivzYajK1Z
 AWIg81bvDxA4oVZXU3xx7yZ9CuABmzf2keB6g8W3dsAcybM6C7Kdm1cj5btV4524Vu7oq44DxDk
 K
X-Gm-Gg: ASbGnctFoyFSjGx7rq9yVPt4x5ZGV8SwwX/AonhqdhAxq7Gb5K9ttV3GXz3Fbi6wPeR
 yygWO3wsRqCztE1Xf9TmjXdc4MYFd5b3PLz5hQuuYDZ35MT8x82osjv1C3ksF1xu9559ZSu/kW1
 harm73h1NIhTkdbkfsxEHaAqTr8dCulaCXBVMD0caRnQIf8hRuO8AW7a3+/LW1qiAlyB7+trbWD
 7wMUm1nhPfw7VXoV0wQ81ruFVRkMyOtt5rq3hIoUDd1TUi1NieXzCdCe8g9fo/1Q9oD5ECgTnvu
 q1zqlPeJs73U70aOWolU0C6Sagmoy9smkA==
X-Google-Smtp-Source: AGHT+IFvoKFW2ehnf65frl7rTWRzppHynYSbYiAC5VnKb6eNxisqIdgZuKA+gQ8KRqLIL4C2n4Xfug==
X-Received: by 2002:a05:6000:2211:b0:391:3207:2e68 with SMTP id
 ffacd0b85a97d-39c2e611194mr12691811f8f.9.1744027394849; 
 Mon, 07 Apr 2025 05:03:14 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2297866e280sm79094335ad.186.2025.04.07.05.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 05:03:14 -0700 (PDT)
Date: Mon, 07 Apr 2025 09:03:03 -0300
Message-Id: <20250407-conversions-modify_ldt-v7-0-cbeb379360a5@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPe+82cC/43QwWrEIBAG4FdZPNeio1HTU9+jlGJ00ghNLJpKl
 yXvXt1LQyC0xx9+vxnnRjKmgJk8XW4kYQk5xKUG/XAhbrLLO9LgaybAoGMCJHVxKZhaLdM5+jB
 e3z78Sg1XAnoAMSok9fFnwjF83+GX15oHm5EOyS5uatxs84qpFaeQ15iu9wUKb/U/ZxVOGTVee
 QMjZ1qZ5/yV8dHFmbRRBfaKPlWgKtAz7aWvWzt2UMReMaeKqMqoBoXIXc+lPCjyf4qsiu0Q9WD
 qr6w9KN1OEfxU6douXqHlsud9pw6K+lUkg1NFtbugHBiCNprhTtm27QdzNZGgMgIAAA==
X-Change-ID: 20250324-conversions-modify_ldt-816329223f6e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3251; i=rbm@suse.com;
 h=from:subject:message-id; bh=FRBlI0QIgdx7sezAa5HrG1Rb092QAV3tVSwzaZkAhpE=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn877+W+UDIxu+cDWVydX4mOu9weUzdiqDrjV/Y
 WHnUWVqeQiJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ/O+/gAKCRDJC4p8Y4ZY
 phc7D/98GqgsfMSqMZ1gswGdUu5V82Rr1SpoCJhqXMZp0DGlgAoPZPCwOP2efPPr7fzDCddE8On
 oIWA8oKXrfGXL0t9jPWYLCuWp1QGM5qYE8ryr8UPgo4pAjW8w/gEw2B2LBGo6lwgZuGe7sKYGZP
 8eOWOCIPpXo/+X6RCVn06VYZQImjy7I0FxfkgGp6kDMf+bYM3vSVXEcCHEP2aWSDvy221fdEVME
 0+Nc05pkJ3x8svaYxtOJqmJfkcGe8voyJVwBN5O5yQOZUtCC6eHdTcRwZ4zD8Oz+BI+SG/sS4XM
 Ixf+UiJjHVrECd58BVy5f7kwLrfHpYtcSS7W9SiXF0vnhZhJMQ/EMdh0cD9NlyaWO2ZJIRCdqU/
 jKnl/ehBQl9/4wnbslCGVTPRBD+lVVtJ74hQNeemvgU1Uw9cSLzbnLznmxcPo1V5xYzebkrGqb1
 xOntN+bt5cTlW1st+OPRL6aTLvBrvInDZrBUqIo+JPvjePwfw2kbOKI9MKz0vtMk5oXjTYhh6n8
 Kq8z/cNyThBUlxb6XaDk9SE3TWG3A1XkSUIbfOXm4TSa9WPEtVq2bA/l67kguhRDvehNe1V1j6W
 Ahx73xoqP1a5dimc1LitGKrVaJ0g6TauPgPrgEgJ/CSpjGiUkLRn66Lr3o7UX7vXLM/vDdzgFWZ
 gusxZN0U/83mc+A==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/3] syscalls/modify_ldt: Refactor into new API
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
L2dpdGh1Yi5jb20vcmJtYXJsaWVyZS9sdHAvYWN0aW9ucy9ydW5zLzE0MzA4NDM3MTUzCgpTaWdu
ZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgotLS0KQ2hhbmdl
cyBpbiB2NzoKLSBBZGRlZCBiYWNrIHRoZSBjaGVjayBmb3IgYXNtL2xkdC5oIGluIGNvbmZpZ3Vy
ZS5hYwotIEFkZGVkIGJhY2sgdGhlIGZhbGxiYWNrIGRlZmluaXRpb24gb2Ygc3RydWN0IHVzZXJf
ZGVzYwotIExpbmsgdG8gdjY6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA0MDItY29u
dmVyc2lvbnMtbW9kaWZ5X2xkdC12Ni0wLTJlNGIwZTI3ODcwZUBzdXNlLmNvbQoKQ2hhbmdlcyBp
biB2NjoKLSBSZW1vdmVkIHVubmVjZXNzYXJ5IGluY2x1ZGVzCi0gTWFkZSBtb2RpZnlfbGR0IHdy
YXBwZXJzIHN0YXRpYyBpbmxpbmUKLSBVc2VkIGNvbnN0IHN0cnVjdCB1c2VyX2Rlc2MgKnB0ciBp
bnN0ZWFkIG9mIHZvaWQgKnB0ciBpbiBtb2RpZnlfbGR0KCkKLSBGaXhlZCBtb2RpZnlfbGR0MDEg
dGVzdCBkZXNjcmlwdGlvbgotIEFkZGVkIGV4cGxhbmF0aW9uIG9uIHJlbW92YWwgb2YgImFzbS9s
ZHQuaCIgY2hlY2sgaW4gY29tbWl0IG1lc3NhZ2UKLSBSZW1vdmVkIHJ1bl9jaGlsZCgpIGluIG1v
ZGlmeV9sZHQwMiAtIGluc3RlYWQsIHJlbW92ZWQgdW51c2VkICJpbnQgdmFsIgotIFJlbmFtZWQg
ImVudHJ5IiB0byAiaW52YWxpZF9lbnRyeSIgaW4gbW9kaWZ5X2xkdDAxCi0gTGluayB0byB2NTog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDMzMS1jb252ZXJzaW9ucy1tb2RpZnlfbGR0
LXY1LTAtZmQ2ZWExNDkxOTU2QHN1c2UuY29tCgpDaGFuZ2VzIGluIHY1OgotIFJlbW92ZWQgdW5u
ZWNlc3NhcnkgI2Vycm9yCi0gUmVtb3ZlZCBjb25zdCBzcGVjaWZpZXIgaW4gY3ZlLTIwMTUtMzI5
MC5jCi0gSW1wcm92ZWQgbW9kaWZ5X2xkdDAyIHRlc3QgZGVzY3JpcHRpb24KLSBBZGRlZCBydW5f
Y2hpbGQoKSBpbiBtb2RpZnlfbGR0MDIKLSBSZW1vdmVkIHVubmVjZXNzYXJ5ICNpbmNsdWRlICJs
YXBpL2xkdC5oIiBpbiBmaWxlcyB0aGF0IGluY2x1ZGUgY29tbW9uLmgKLSBFeHRlbmRlZCBjb3Zl
cmFnZSBpbiBtb2RpZnlfbGR0MDEKLSBMaW5rIHRvIHY0OiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9yLzIwMjUwMzI4LWNvbnZlcnNpb25zLW1vZGlmeV9sZHQtdjQtMC1hNWVlN2I4ZDgyYWFAc3Vz
ZS5jb20KCkNoYW5nZXMgaW4gdjQ6Ci0gUmUtYWRkZWQgdGhlIGFzbS9sZHQuaCBpbmNsdWRlIGRp
cmVjdGl2ZQotIExpbmsgdG8gdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAzMjgt
Y29udmVyc2lvbnMtbW9kaWZ5X2xkdC12My0wLWY2YjZlZTFjOTE0NEBzdXNlLmNvbQoKQ2hhbmdl
cyBpbiB2MzoKLSBEcm9wcGVkIHRoZSBzZXRfdGhyZWFkX2FyZWEwMSBwYXRjaCBmb3IgYSBsYXRl
ciBzZXJpZXMKLSBTcXVhc2hlZCBtb2RpZnlfbGR0MDMgY29tbWl0IGludG8gbW9kaWZ5X2xkdDAx
Ci0gUmVuYW1lZCBzdHJ1Y3QgdHN0X2Nhc2UgdG8gdGNhc2UKLSBSZW1vdmVkIGZhbGxiYWNrIGRl
ZmluaXRpb24gb2Ygc3RydWN0IHVzZXJfZGVzYwotIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvMjAyNTAzMjctY29udmVyc2lvbnMtbW9kaWZ5X2xkdC12Mi0wLTI5MDdkNGQz
ZjZjMEBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2MjoKLSBBbHNvIHJlZmFjdG9yZWQgc2V0X3RocmVh
ZF9hcmVhMDEKLSBNZXJnZWQgc2ltcGxlIHRlc3RzIChpbmNsdWRpbmcgdGhlIGV4aXN0aW5nIG1v
ZGlmeV9sZHQwMykgaW50bwptb2RpZnlfbGR0MDEgaW5zdGVhZCBvZiBzcGxpdHRpbmcgaXQKLSBB
ZGRlZCBTQUZFX01PRElGWV9MRFQoKSBtYWNybwotIFJlbW92ZWQgY2hlY2sgdG8gYXNtL2xkdC5o
IGluIGNvbmZpZ3VyZS5hYwotIFVzZWQgdHN0X3N5c2NhbGwoKSBpbnN0ZWFkIG9mIHN5c2NhbGwo
KSBpbiBtb2RpZnlfbGR0KCkgQCBsYXBpL2xkdC5oCi0gTGluayB0byB2MTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci8yMDI1MDMyNC1jb252ZXJzaW9ucy1tb2RpZnlfbGR0LXYxLTAtOGQ2ZDgy
ZjEwNzY4QHN1c2UuY29tCgotLS0KUmljYXJkbyBCLiBNYXJsacOocmUgKDMpOgogICAgICBzeXNj
YWxscy9tb2RpZnlfbGR0OiBBZGQgbGFwaS9sZHQuaAogICAgICBzeXNjYWxscy9tb2RpZnlfbGR0
MDI6IFJlZmFjdG9yIGludG8gbmV3IEFQSQogICAgICBzeXNjYWxscy9tb2RpZnlfbGR0MDE6IFJl
ZmFjdG9yIGludG8gbmV3IEFQSQoKIGluY2x1ZGUvbGFwaS9sZHQuaCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDU0ICsrKysrCiB0ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAu
YyAgICAgICAgICAgICAgICAgICAgICB8ICAyNiArLQogdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNy0x
NzA1My5jICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKy0KIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZm9yay9mb3JrMDUuYyAgICAgICAgICAgIHwgICA1ICstCiB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL21vZGlmeV9sZHQvLmdpdGlnbm9yZSAgICB8ICAgNSArLQogdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0L2NvbW1vbi5oICAgICAgfCAgMzAgKysrCiAuLi4va2Vy
bmVsL3N5c2NhbGxzL21vZGlmeV9sZHQvbW9kaWZ5X2xkdDAxLmMgICAgICB8IDI2NCArKysrKy0t
LS0tLS0tLS0tLS0tLS0KIC4uLi9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0
MDIuYyAgICAgIHwgMjIxICsrKystLS0tLS0tLS0tLS0tCiAuLi4va2VybmVsL3N5c2NhbGxzL21v
ZGlmeV9sZHQvbW9kaWZ5X2xkdDAzLmMgICAgICB8IDEwNSAtLS0tLS0tLQogOSBmaWxlcyBjaGFu
Z2VkLCAxOTQgaW5zZXJ0aW9ucygrKSwgNTIyIGRlbGV0aW9ucygtKQotLS0KYmFzZS1jb21taXQ6
IDQwNTc2ZDQwZjdlZDkzZmFmYWU5OWFkNzg0MzFjZDhmYzgxNDkwZTIKY2hhbmdlLWlkOiAyMDI1
MDMyNC1jb252ZXJzaW9ucy1tb2RpZnlfbGR0LTgxNjMyOTIyM2Y2ZQoKQmVzdCByZWdhcmRzLAot
LSAKUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
