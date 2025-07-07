Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2A4C8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 12:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751889600; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=vZxpKvhgBBQZb2DZ3o0cg3kGaOSbteO5R4JFYKiDWmI=;
 b=YMw//QvCL8984tXaUh5G6FndE/lw/MOa7wwa1tGfsfTSEPv4omwZ+9GfNNEwp3HUdwPZw
 75QDMO4CQhaV9xqGK9pg1D7If+aV+Etoq1bm963yFDhY0PvjW0FAeLQ6xDVA6zC5pl4YH1P
 nERwRC1P5iinfGkHnbeAAvOe43VjiSU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B2CD3C75F2
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 14:00:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 566633C282E
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 13:59:39 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6A41614004E1
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 13:59:38 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ab112dea41so1591286f8f.1
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751889577; x=1752494377; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b3+KhuXCQxzHT6hcXnrZ1uBNRUYmQKtZS4PJZtTn6sg=;
 b=DgcPABwluOkpeiIaAFkWhiSDzzY4Vxoz9WPlcCHeQNWTkHSRaJIRU2WCw9HRXcGz/+
 GBbtQ2IUf3aJudDE1XzRC0JBSuRXnHhByFKpcOEM8hv1RszROH4qBV5sB++P1GvM/rdk
 Ro4fcaN3kQ+QGCE49Tx7CHJ+PKfxcrQSYQ9ySEYAXmOxLlR+4lnBZGf2fbILZvrr2o6F
 zrySB5si3U9kbBPNXnZWgTju4/rKiWZW/Rb9aW3f0rXjV7oRPk4PUHBBwinwjEDCJpWO
 JKvoS7B1WZhCHqVrHxqhWUcicqYXB/p6VkAoGJHBPpgJI/kine2PZuNcN8BQofaqd/fa
 VcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751889577; x=1752494377;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b3+KhuXCQxzHT6hcXnrZ1uBNRUYmQKtZS4PJZtTn6sg=;
 b=p4d8DJqj2TAQbiLTf1PDD3SpFNulOfo6+KHwh3h2HrLhtEXsWFGZuqufGtIKK69gol
 /g84iUuoTmPjELwHOqHnPJLtNc9dA6+gfn+nEF7gv1Vfy49S66UYvkE/aNND599wVNFm
 17SmgsLDKDkT8XobEPwopkaJbF5UQoGrSDPm8sPPDk3VgO5Od0M8viXTqR4rduDKP0Wy
 J3PRGnfTDT5bsTd8UQ6xOYGJxINRu6IUWLetdp4qRqFxhgz7yKoJWIuaJPg3aZlNlDOz
 6rru20UduHTKSlm9o0DOxJl7JXN5+BQZLE5NnQCB7ukyo6PIGyU6SAcEC2e4TrmdCHix
 /FEQ==
X-Gm-Message-State: AOJu0YzpUZcdoAOAXgcor23aySXriRvyQZu+H/SULeahehvBjSF/AW/A
 /qS4Lu6kPiYgv1zHjOEbYkKQ9YIL9+7qIkk/jvbbgNI208ROxJ8TfWmAdLVR5Kh/t8zOhftCtlJ
 TP8Cv
X-Gm-Gg: ASbGncuqCNb1+pXKeuS+fItaOz8fKh/UHoOZIMyFdl5e0x7MpcWdhIBjsiusNvpUd+R
 5X4UjpN9ApvaufQJa334Gh6SfHXSy5J7jGChqwTVBMhftSQmWuRjs4opgDaCNf/UIxWeR/ctMhs
 Psx1LQvMNT0amXFchjekEYRs1TFnijFSG+q9RI2BC5tCmtUsG0cWjz5He32JqYJrf7kcUxBAl8L
 AtDFYs86P2lKaVMEHSbgF1ywyIShiVUZnM5zI18pcJ95D6jPgHBsv4G5KqiMZGNvHzGDjujJlDV
 E4DENw2f459XIQ6/vbEQ/zmmaNNo8iur12w/k8f2X4elSjazjA==
X-Google-Smtp-Source: AGHT+IHj3JIOnw7Kz3An6CEv/VUrGBvH1/euopN0hsx/BD49H4gmKjwkimUKSpRB04k23/HQWhzZlw==
X-Received: by 2002:a05:6000:41e3:b0:3a4:cf10:28f with SMTP id
 ffacd0b85a97d-3b49aa741edmr6188794f8f.31.1751889577530; 
 Mon, 07 Jul 2025 04:59:37 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-4a994a8bb3asm60178181cf.54.2025.07.07.04.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 04:59:34 -0700 (PDT)
Date: Mon, 07 Jul 2025 08:59:27 -0300
Message-Id: <20250707-conversions-munmap-v3-0-0632537a6c8d@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ+2a2gC/32NvQ6DIBRGX8UwlwbB3059j6bDBa+VQTRcJW2M7
 15wcmg6nuR859sYobdI7JZtzGOwZCcXQV0yZgZwL+S2i8ykkKWoheJmcgF90oiPqxth5kpXINs
 eQFYNi8PZY2/fR/TxjKyBkGsPzgwpNQIt6JM4WFom/znOQ570vz8h54Ir0WEju7IVorjTSng10
 8jSTZDnQvGzIGNBg1EgAPK81qfCvu9fjhF5XQ4BAAA=
X-Change-ID: 20250703-conversions-munmap-3b6a29faa268
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=rbm@suse.com;
 h=from:subject:message-id; bh=BcLiuitcYpn6arW4CYs0PQ8tU0AT46Uiam5AK2Nfo8Q=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoa7aiEiOhrSSucNjtZw67EkeLmPsGQhEVNDpCy
 S5zbAP/hfeJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGu2ogAKCRDJC4p8Y4ZY
 pihqD/oDDFBgQQKdDgzwz4D3eB7VKyL9KDL3XB9ebxziFpiMthK7v+WwzIOSb6eJ0hUcl1+bCOM
 TChRGqGuTtKYT1f+Hsauz7KFr4gStH2ABDgmkVByNPFwUV4SaYcN/fs5DhJMS78KkxlewccnFRL
 KSbYn1SEAGwTmDQkJJtX+EdOKwPyoRaMUz6RF7WH+eRixOgSoIkASHP4wh7THN928TZEdFlq6vT
 0EvSxnzwnGeItFA1cgmWCuxGJSa2odPQDGi/2beB+joaZfgAN7YKErUaKBoDOvaA5GjYJCITfdy
 FPII4nj7pijuVTS1WlYkl1LQ6OblYphYjG25Li/1jdKTEdeBqfqh/TraOEh+OH52kVC5sPFaPBg
 FA88KGCH5ZKx4AKIRSVkQbgNVwzHxZqutB7bZj25bmv5joSYhuwxGI+PyBge1aASdrZx3LzPJTN
 jH1njcw4E8uhF2VtNAcQsMG6ID1o/cH1dAdJgWI+yDj9qEHWLbN38tLj3Vb7NXJQh7K4Nr/SaeP
 f9CXrF7N8oOrhDZ2SQKXwFww3MuRzmT/kO7cXerL/Evdtdts3eczTjJTk4d1em9dWFbkVdXCZMV
 MOEkAPhlL+3bZIgg2W7TPF150OCCzXtWGo9VXzDcrnuibzQKjf/Hyd1Ro/HwAT8yg7ol2DBdvDp
 G7tSB5fRtJSOyyQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] syscalls: munmap: Convert to new API
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
YW5nZXMgaW4gdjM6Ci0gU3RvcHBlZCB1c2luZyAibWFwcGVkIiB2YXJpYWJsZQotIFNpbXBsaWZp
ZWQgY2xlYW51cCgpIGluIG11bm1hcDAxCi0gUmVtb3ZlZCB1bm5lY2Vzc2FyeSBjb21tZW50cwot
IExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA3MDQtY29udmVyc2lv
bnMtbXVubWFwLXYyLTAtYmFjM2EwYWExMTdiQHN1c2UuY29tCgpDaGFuZ2VzIGluIHYyOgotIG11
bm1hcDAzOiBVc2Ugc3RhdGljIHZhcmlhYmxlcyBmb3Igc3BlY2lmaWMgdGVzdCBjYXNlcwotIG11
bm1hcDAxOiBVc2UgZm9yaygpIGluc3RlYWQgb2Ygc2lnbmFscwotIE92ZXJhbGwgY29tbWVudCBj
bGVhbnVwCi0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDcwMy1j
b252ZXJzaW9ucy1tdW5tYXAtdjEtMC0zMGRlODJkNTkwMDRAc3VzZS5jb20KCi0tLQpSaWNhcmRv
IEIuIE1hcmxpw6hyZSAoMyk6CiAgICAgIHN5c2NhbGxzOiBtdW5tYXAwMTogQ29udmVydCB0byBu
ZXcgQVBJCiAgICAgIHN5c2NhbGxzOiBtdW5tYXAwMjogTWFrZSBpdCBhIHZhcmlhbnQgb2YgbXVu
bWFwMDEKICAgICAgc3lzY2FsbHM6IG11bm1hcDAzOiBDb252ZXJ0IHRvIG5ldyBBUEkKCiBydW50
ZXN0L3N5c2NhbGxzICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxIC0KIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwLy5naXRpZ25vcmUgfCAgIDEgLQogdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDEuYyB8IDI3NyArKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwMi5jIHwg
MjUyIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
bXVubWFwL211bm1hcDAzLmMgfCAxNjkgKysrKystLS0tLS0tLS0tLS0KIDUgZmlsZXMgY2hhbmdl
ZCwgMTE1IGluc2VydGlvbnMoKyksIDU4NSBkZWxldGlvbnMoLSkKLS0tCmJhc2UtY29tbWl0OiAx
NmNkNjdlZjFmODVlNmIxNGMxODJmYTQ5NjMyYTUwMTQ1NjBlZGZhCmNoYW5nZS1pZDogMjAyNTA3
MDMtY29udmVyc2lvbnMtbXVubWFwLTNiNmEyOWZhYTI2OAoKQmVzdCByZWdhcmRzLAotLSAKUmlj
YXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
