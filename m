Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB824C5AE59
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 12:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749127968; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=PHtHHhvLW7ee4BBXOS8jtSPaPt4PmKN/PnfcPcWmvYs=;
 b=LCsKIdjx/NK7dfFiO1uesSZd0TyT7+wCJwZ0OSl1F8g3uIAXKp2d7EafAK9zPCISo0Z3J
 um6k94f27pHc3cM586Si4PG3xC5fVIutUfm17HiPO6VeVILYynboHawEKNWKJ+emurCFQ1l
 gGo3njpDuOlX5k8bfAKV/9DV9L5AFBE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A7883CA395
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 14:52:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE0363C8EDC
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:52:25 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 68D8060098C
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:52:24 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so1338993f8f.0
 for <ltp@lists.linux.it>; Thu, 05 Jun 2025 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749127944; x=1749732744; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6n0rdSJjJ5xq6odxJnJdH1OBOePaUQfgNHnJJnivT2Y=;
 b=E9Xo9cNMtmo9/END/SavRVBAEI8whUCnNahRl/siQ0yDInLLjFX977WRR8Rsw23kqx
 TUWwz4LJ8IDgIEboqV4xIZEFHvEERKh1ExGGSGoHbqsn2ZkDF1ItvHz0XD2stJ74UkSO
 KMTH3Nk/hyEQc69ld0AsBPv1vdly8FWF+MeSZ84S0Qj/eoJ047QkkTfBm+5rAdNFN9qV
 Ru7FAI/EFc/Y1mxkVAAK//7nPfyLQk0PdUoyUOTR5mqEysJWF6lgCyctnuWqnytBIwHf
 sadsrDx/5335LMqR2DmNvbJKar1H4mlAbc9wgpZbEkA9MjjsTKjwPPKjVvdK+kTJ8NHo
 i7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749127944; x=1749732744;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6n0rdSJjJ5xq6odxJnJdH1OBOePaUQfgNHnJJnivT2Y=;
 b=wNXKQ6I4VRe0v/R9gB6XLUaWdRZY5b0b6lMQfUpNnYPNF9K3wYLIN2HRREPx0k/TVt
 MJ44YQYn6R8Dg7NDx4SMls8Mcl1r0ux2xXpnwPmd1p0R/e57Un+eIT0lf6w0Qeo7ZcvA
 PelpGoGQmueOwq6A+GBWeQUMfJc7W1SvVJA2eTV55IOAkaGrg1WJhnsCbjr6EkqLxxuW
 R9yMuvo1SvlLUyz25rVwnW0J5371tVVoekQSObgXqMR11mGKgFtDmCqM96zRFP+ocpQx
 3D0EqLgKaMpq8Al28Ec3zPXgrXn+RJzMcTSx7QZyVb+flv4gneac8xq41vr2d8JJPA2U
 L9Ww==
X-Gm-Message-State: AOJu0YxFq7BLLF92DHLfU09/PQhzH7h3puBfiUeONXpqtY2+irN3OCJv
 cQEr0s1ydPjRYSzHrT9+KxWcKgJ8f8voNNyG1YuAKtqp4LYZYs695PJUJmt2/lvWrbU=
X-Gm-Gg: ASbGncvVMFdspkNcQi+RFPkHuu7KfdcFGZWumIOGw0KJB28/lyOkVhVBI0KIsr0GKxB
 hLTYF7OUUwA1CBpZAijNMtGdH/aPa3HnHbJlQknpcuJofEP5xsodkj/tEXM7EgPKVBOUb5mnAlg
 kSyIp+fGrYk+S5vAHqJo8D2WtN8D751wajrSBBm1VYbbutbDQNJECkw+XPhFPORGK60Xt2goN4n
 4DH/ZRgXoyGFo5xfKICXOCII7BRIFFh8Jdvd1V3/Ij/gxpfig64hE0yTBoH44lt5gp+OiUVvh2v
 nyoB+BqygAKx6tZ0b7yBvUMMJwoKgVzzLFybf9I=
X-Google-Smtp-Source: AGHT+IEFLIsPeKyv8TrgLPwrPQwMT4w6cadOLJuZActC4bGGeOr4TqDSfytfQmYGsagk/bwO+Hxf2w==
X-Received: by 2002:a05:6000:2385:b0:3a5:25e2:6129 with SMTP id
 ffacd0b85a97d-3a526e0cc65mr3031389f8f.21.1749127943733; 
 Thu, 05 Jun 2025 05:52:23 -0700 (PDT)
Received: from localhost ([189.99.237.136])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-53074ad91aasm12427202e0c.19.2025.06.05.05.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 05:52:23 -0700 (PDT)
Date: Thu, 05 Jun 2025 09:52:16 -0300
Message-Id: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAACTQWgC/33NzW7DIBAE4FeJOJcKFmySnvoeVQ78rGtUGSI2R
 akiv3shl1qR1eNIM9/cGWGJSOztcGcFa6SYUwvDy4H52aZP5DG0zEDAIJQ8cZ9TxdJrxJevlAP
 34eidFiaADqztLgWneHuYH+eWnSXkrtjk5y4tlq5YenGOdM3l5/FdZa//d1Mll3zSI5pRBQNCv
 NM34avPC+svFTYAyD0AGuBPHowLODhhngD1B2ip9wDFBUdxRKNH5SZrnwC9AWDYA3QDAABFADQ
 4yQ2wrusv/9ch2Y0BAAA=
X-Change-ID: 20250319-conversions-mknod-cd8cb407d24d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536; i=rbm@suse.com;
 h=from:subject:message-id; bh=LAmp5ZQFy95kK2iAwgpnWCSJHoPk7BhxCJ++WsqVOnw=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoQZMC+SWaphYCg85v4KrV/mGomWen/XGUG/XLI
 tPhJff07CWJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaEGTAgAKCRDJC4p8Y4ZY
 phCDD/9fZKIHRF8kyX/P0Q1U4SM69uFihpEscdpIToA6nWCcoVvSDjEC+DK2aQsCjLQt0LUPfUc
 Nl7fQbnE6WaGWJTJTQ5fNhCbMYFpzYBzXECKevg89qXy96R8M5FsRrJgas9XS/ovZbFJYPg4SxT
 V+yQLhWctGQk3G9edN6C9hn6TfI/eLizL8yNGzuHrDKOq5bY5z4EwpoHn9UUS0/t3pOCS2sm2bp
 mnKBfijij6UEqVxpLKIQaAb1CiJaltJrhn3snitpR+8kJgd6HYqo3YMAdulnzUvO2rSdemLY9mx
 s6cdR2fSJojrC+UzQQ4fWLe3gZf3T03BCBA3cB0w41nTkfMcWdBfpySo+1EZjNRMYadiXwzj8ge
 9lpEUL48dZ/hLyUm5ejgfEHtZgXfx49Hv8xn8NqJUFVx5d+u6QVB+S9ig1B89jag/JATC2+oMg+
 RbFR5ml/GfmahsMFXJP+pkG4EQOimC8ktL4PkS2CqyFswvFaG3rqHvYz9Aazo4WFtZPNg6UHjqk
 Dv/sIwPB3PSU7jcGT0xDAGv0W6Ux+UvsFz3W1UjTtKC8lmrKdIGfh02ja5QTC2+XHaKv9sccdG3
 US2q2nEGTQ2iasmtsosdyjWgUhFYF7qx50DaQVbeavyPXQb81Z/XTy1W6L/BiKXHUDJTEoxeTW2
 MTrZMN0rEdV9HqA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/8] syscalls/mknod: Refactor all tests
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

SWYgbmVlZGVkLCB5b3UgY2FuIGZpbmQgdGhpcyBzZXJpZXMgYXZhaWxhYmxlIGhlcmU6CgpodHRw
czovL2dpdC5tYXJsaWVyZS5uZXQvbHRwL2x0cC8KCmBnaXQgY2xvbmUgLS1icmFuY2ggY29udmVy
c2lvbnMvbWtub2QgLS1zaW5nbGUtYnJhbmNoIGh0dHBzOi8vZ2l0Lm1hcmxpZXJlLm5ldC9sdHAv
bHRwL2AKClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+
Ci0tLQpDaGFuZ2VzIGluIHY1OgotIEZpeGVkIG1pc3NpbmcgU19JRklGTyB0byBta25vZDAzIGFu
ZCBta25vZDA4Ci0gQWRkZWQgbWlzc2luZyBzdGF0aWNzIHRvIG1rbm9kMDgKLSBVc2UgJWp1IGlu
c3RlYWQgb2YgUFJJdU1BWCBpbiBta25vZDAxCi0gTGluayB0byB2NDogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDI1MDQyNS1jb252ZXJzaW9ucy1ta25vZC12NC0wLTIyMmUwZDJlN2VmMUBz
dXNlLmNvbQoKQ2hhbmdlcyBpbiB2NDoKLSBGaXhlZCBtb2RlcyBiaXRzIGluIGFsbCB0ZXN0cwot
IFJlbW92ZWQgdW5uZWNlc3NhcnkgU0FGRV9TVEFUIGNhbGwgaW4gbWtub2QwMyAoU0FGRV9DSE1P
RCBpcyBlbm91Z2gpCi0gRml4ZWQgJWxkIHdhcm5pbmcgaW4gbWtub2QwMQotIFJlYmFzZWQKLSBM
aW5rIHRvIHYzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNDE0LWNvbnZlcnNpb25z
LW1rbm9kLXYzLTAtZTA4ZTc0NjNiZmFhQHN1c2UuY29tCgpDaGFuZ2VzIGluIHYzOgotIG1rbm9k
MDM6CglGaXhlZCB0ZXN0IGRlc2NyaXB0aW9uIGFsaWdubWVudAoJUmVtb3ZlZCBhbiBvdXRkYXRl
ZCBjb21tZW50IChDVkUpCglNYWRlIGZ1bmN0aW9ucyBzdGF0aWMKCU1vdmVkIHNldGdpZCgpIGFu
ZCBzZXRyZXVpZCgpIGNhbGxzIHRvIHNldHVwKCkKCVJlbmFtZSBUU1RfRElSIGFuZCBUU1RfTk9E
RSB0byBURU1QXyoKLSBBbHNvIHJlZmFjdG9yZWQgcmVtYWluaW5nIG1rbm9kIHRlc3RzCi0gTGlu
ayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDMyMS1jb252ZXJzaW9ucy1t
a25vZC12Mi0xLWM5YzI3YmRlNWIwN0BzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2MjoKLSBNYWRlIHVz
ZSBvZiBUU1RfRVhQX0VRX0xJCi0gTW92ZWQgdGVzdCB0bXAgZGlyZWN0b3J5IGNyZWF0aW9uIGlu
dG8gc2V0dXAoKQotIFJlbW92ZWQgbm93IHVubmVlZGVkIG9yaWdfdWlkCi0gTGluayB0byB2MTog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDMxOS1jb252ZXJzaW9ucy1ta25vZC12MS0x
LWY0NmU3NjNkNzIwMEBzdXNlLmNvbQoKLS0tClJpY2FyZG8gQi4gTWFybGnDqHJlICg4KToKICAg
ICAgc3lzY2FsbHMvbWtub2QwMTogRml4IGNoZWNrcGF0Y2gucGwgd2FybmluZ3MKICAgICAgc3lz
Y2FsbHMvbWtub2QwMjogVXNlIHJlbGF0aXZlIHBhdGggdG8gYXZvaWQgdXNlIG9mIFNBRkVfQ0hE
SVIKICAgICAgc3lzY2FsbHMvbWtub2QwMzogQ29udmVydCB0byBuZXcgQVBJCiAgICAgIHN5c2Nh
bGxzL21rbm9kMDQ6IENvbnZlcnQgdG8gbmV3IEFQSQogICAgICBzeXNjYWxscy9ta25vZDA1OiBD
b252ZXJ0IHRvIG5ldyBBUEkKICAgICAgc3lzY2FsbHMvbWtub2QwNjogQ29udmVydCB0byBuZXcg
QVBJCiAgICAgIHN5c2NhbGxzL21rbm9kMDc6IENvbnZlcnQgdG8gbmV3IEFQSQogICAgICBzeXNj
YWxscy9ta25vZDA4OiBDb252ZXJ0IHRvIG5ldyBBUEkKCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL21rbm9kL21rbm9kMDEuYyB8ICAgNyArLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9t
a25vZC9ta25vZDAyLmMgfCAgIDQgKy0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWtub2Qv
bWtub2QwMy5jIHwgMzEzICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDQuYyB8IDMxOSArKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWtub2QvbWtub2QwNS5jIHwg
Mjg1ICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L21rbm9kL21rbm9kMDYuYyB8IDMwMSArKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDcuYyB8IDIwOSArKysrKystLS0tLS0t
LS0tLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ta25vZC9ta25vZDA4LmMgfCAzMTMg
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDggZmlsZXMgY2hhbmdlZCwgMjYyIGluc2Vy
dGlvbnMoKyksIDE0ODkgZGVsZXRpb25zKC0pCi0tLQpiYXNlLWNvbW1pdDogN2NiOWRkM2M4ZjRl
MGQzMWQ0ZGUyMDUzZWZlODg4ZjRmMmRhMmI3MApjaGFuZ2UtaWQ6IDIwMjUwMzE5LWNvbnZlcnNp
b25zLW1rbm9kLWNkOGNiNDA3ZDI0ZAoKQmVzdCByZWdhcmRzLAotLSAKUmljYXJkbyBCLiBNYXJs
acOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
