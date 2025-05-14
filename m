Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7E0C3ABD9
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747219831; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=ElHsV9+zgeY9vh5n/UoMLY9V/MUnL3/AMEAmoju/UJI=;
 b=jNzh1eUvOWqzNHU44vlqRgc6mnuaXbGpg0YEQlRXIq5XgFMVtHCMiejhxAnNFAPSWh7Eu
 YPBs7ogXytpJjIFYn/Wv5REX9qZTogOg7qcocNgJeuVKVN4844sQ4KCyHPax/cQLv1Tpc5V
 RyQyZueaJnQi3mHvzbQsUw+3dcU7yYM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C6913CC3B4
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 12:50:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C7053C1D15
 for <ltp@lists.linux.it>; Wed, 14 May 2025 12:50:08 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BC0F31A00EBA
 for <ltp@lists.linux.it>; Wed, 14 May 2025 12:50:07 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a0b9303998so525126f8f.0
 for <ltp@lists.linux.it>; Wed, 14 May 2025 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747219807; x=1747824607; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ia7Gi6wQg6LEQ4oKJwoecXLEmE9aP6T0/VvA3liRXfM=;
 b=cSrft3aw+XcNhkmF7HmeAbiKzZtNIgku3DljEX3jw1eZcHq/y/dYry/cux6EPwQx2x
 98qWh4g+Ag6HdvmDRnEbfoRcxLzK7fhN7e9SbsThsbQ1laojrULsawaqfBeE7S7+9sW9
 vG7P1Lo/5hKSZVMgTtNsi07Pv09BZSiJyj2XAHvraby0Sb/EhK8eY+RyK8XfmF9sz1EL
 aW5XI81XVSCFVy+e1aUVhOXD2CViSJ31VYF4hX5UWWNuGL0JJgriFsoRoG/AYl8m9ptg
 qan9m1cgFcdX02+rAU6MOtG+g//c1kpYFQh8rwSS+VLm61DjPApSlFP3qnxyENJWjH7B
 9A1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747219807; x=1747824607;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ia7Gi6wQg6LEQ4oKJwoecXLEmE9aP6T0/VvA3liRXfM=;
 b=gGzNI8L7gpHHak8gSidz5jLYmv/Rr+7CiOlCoK/GcliqMCZw+k/nBA1U3f5qhi3LQx
 siZ2xIv0lp/Xq6a4gPEmFeMagh5MGQwUz61SYIEbn7OxqKePLkjnckVforqBwMFI12CW
 CthdI01b3eN6adhmgA/ZTuE5LMSjQe/42f2xCaH/k0ejfuLCHS5l2MSDia3VPtQgOAQX
 3M8W3jpPu2tN01sPA7JUlkuAipGUzWpKglreilRWClLRCh8FxTjB06DaQ5Kg9eMlbVUg
 e9SpuUW0Rp2PXhFuqbHTgZfG/47eCWZ5chc1XRHXRhAEvNwgPY5NucL+dh3AdPIebOH/
 IMxA==
X-Gm-Message-State: AOJu0YybfzM5uoRoEHJwS9sGxyQfhVHCZVDq6XGCcDLs+jSMPgTa4fHb
 N2OIUOcflq0zMy89B/5PBLXJDHLQjHwM891vhgguwNq++z9ALDURpPweHDbL7SaqO8Ytjwot36t
 p
X-Gm-Gg: ASbGnctwIXBLU+gjYwSxzVgESFQQ+ywYaQGPqf3hvl9i16ZpMDsCr0DMC6YiPkAgjkE
 IdhgH5woAzinYM1U1NxsYfu1u1RR5xyz1FEsEQHFm94e/pMEhlRi7XJc/E5vtqm4XzertLotVne
 8fIzPeBmNfCUcOWScZWqACjyCK1x4wOUZjlzQn8XPb50f1bbJ1Z5Y2b633gCrDeFBqJhf7aA0MQ
 /g+16rUS63kkQRMSK4zg1KOIMHF/YoPUmvnhxkbK39qP1RN6DXm8zEsWMO6nAdxoyfM066DLMK/
 xVFQxd+ah7cl0vD6qhwzENHstRzloQOo/W0o/8U=
X-Google-Smtp-Source: AGHT+IFRNPoO6vrNKpXp6UZJQ515L/QLDSfu33ydFi9A1o7nzDpSz2JKiOykS6l91tRv/q6namMiFA==
X-Received: by 2002:a05:6000:2a5:b0:3a0:af41:f92f with SMTP id
 ffacd0b85a97d-3a340d2d318mr6344492f8f.20.1747219806836; 
 Wed, 14 May 2025 03:50:06 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 ada2fe7eead31-4dea0298db9sm8292365137.0.2025.05.14.03.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 03:50:06 -0700 (PDT)
Date: Wed, 14 May 2025 07:49:53 -0300
Message-Id: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFF1JGgC/x3M3QqDMAyG4VuRHC/QdvOH3crwIO2ihrk6kiED8
 d5XPXzg+94NjFXY4F5toLyKyZIL/KWCNFEeGeVZDMGF2tX+hmnJK+sxM3zJPKPrmnagkK5d9FB
 uH+VBfmfy0RdHMsaolNN0hN5kX1bY9z8sN+sXewAAAA==
X-Change-ID: 20250514-conversions-kill-0867fa2c38b1
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=998; i=rbm@suse.com;
 h=from:subject:message-id; bh=DwC4CSmeRQ/2XhiZR2KuFjYh46j0Pots9Cci6be0Veo=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoJHVZtlTUEdJwlwLQ9SyDiybKNpPLKydh3wofp
 5VLYXNT+TaJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCR1WQAKCRDJC4p8Y4ZY
 pifYD/95QFtqlVODAdT45WIhQAs72vCUTntAE6lPHcXkrQOETyKtHntwKCCkkX6C/gZgNPXqhyv
 D9wAdx9cpf7weGA2ceZyr8swe7EPh7djbq2ZyUjUm636N2jtgJZTlqt9Oc1yoUauSfp8/Mol3la
 tTdAaUuvpfL3dmLecN7IK7aYMibkl/H2se3qQ16I3TzRUoxnkfQO23Vi2jJCFYWnlpdaw85Sxxu
 07py2neqfo5UK0Gipu/+X7PpJTL+Ay4OVrczrCuKjzQDKEYrRp2WLz4dq1nE34ctx5h0QS8plIt
 tFY2vIoTns6b17VdofIUBSdz4yVYe7ZNEvJpjbTTy//DCD8zC8AU7GpA9KgTku1XXS2RjFxWLW2
 2bGyyg3dudqKrufQTDI0kSAM9Sgr/S0nmc0c13AulXS3BlA6OgvysiEvWM03NzUobc1vdfCJNbR
 GuYw8y5y9qzPNRVDgQmetMytlhrMENwqb4n5+6CrUVWPniAyuI9cgpZBcr9TAVsQ/BcFJlOBbQ6
 jNrMQy120bGsZJEmtik4H2o4B3NVtuYLc4eQgngTlxobXfq6Utu/DHsezTlOu8l6FE7tt1t+d5u
 QjO3+Q3FKF/ZobMiNXbif90yXICXaMZw+AvIz8ITxty5OQJdKdVMcseKtN4oXrfqh3s+F1xh1kl
 by/mUpDsSgUlzcg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] syscalls/kill: Small cleanup
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

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tClJp
Y2FyZG8gQi4gTWFybGnDqHJlICg2KToKICAgICAgc3lzY2FsbHMva2lsbDAzOiBGaXggdGVzdCBk
ZXNjcmlwdGlvbiBtZXRhZGF0YQogICAgICBzeXNjYWxscy9raWxsMDU6IEZpeCB0ZXN0IGRlc2Ny
aXB0aW9uIG1ldGFkYXRhCiAgICAgIHN5c2NhbGxzL2tpbGwwNjogRml4IHRlc3QgZGVzY3JpcHRp
b24gbWV0YWRhdGEKICAgICAgc3lzY2FsbHMva2lsbDExOiBGaXggdGVzdCBkZXNjcmlwdGlvbiBt
ZXRhZGF0YQogICAgICBzeXNjYWxscy9raWxsMDk6IENvbnZlcnQgdG8gbmV3IEFQSQogICAgICBz
eXNjYWxsczogUmVtb3ZlIGtpbGwwOQoKIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAxIC0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC8uZ2l0aWdu
b3JlIHwgICAxIC0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDMuYyAgIHwg
IDE0ICsrLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9raWxsL2tpbGwwNS5jICAgfCAgIDkg
Ky0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDYuYyAgIHwgICA4ICstCiB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwva2lsbDA5LmMgICB8IDE5OCAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxs
MTEuYyAgIHwgICA5ICstCiA3IGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDIxOSBk
ZWxldGlvbnMoLSkKLS0tCmJhc2UtY29tbWl0OiA0YTBlM2E4ZmE3YjU5Mjk1OGY4ZTNjZDM2NmY2
M2M3OGZiYTlmMDE0CmNoYW5nZS1pZDogMjAyNTA1MTQtY29udmVyc2lvbnMta2lsbC0wODY3ZmEy
YzM4YjEKCkJlc3QgcmVnYXJkcywKLS0gClJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5j
b20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
