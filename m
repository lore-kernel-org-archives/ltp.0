Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17606C77B7F
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751042904; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=ppAoQOyPfqLjay9kW4izb83cf587iFd7XY+SuClT/f0=;
 b=H+INIsfuEkYYeh5pr+Zc6E2179CMgzOvI1rr6EIfzHPh5g6FOb9Z38yDakkgrmYWI9oxG
 1uz6UR/1st1l3MIEg9elznJFQFffEqDpHg9NGJ9iwTtLcXR/EdPDummBKHBCerHaqq+wgJT
 calL85P+pc4wSYoLpkqIdjiLeoJ+Gdg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86E2B3C91D9
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 18:48:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D8B93C0EBA
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 18:48:03 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5B7DB1A00928
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 18:48:02 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so17874f8f.2
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751042882; x=1751647682; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=09jEEfxH61xNyKOMacsgoNlPY/1UHKOXAZFUCBrws8g=;
 b=XxkyxknSItDQAyUMGao3fjip66lLfPSZJXX97XZEgVR/4IJRk5sOGYKzd0zvEkOiFB
 HNS4nCIIaR1sHXi4+yVnetRxCXf8Wgq6QFpTXYz14grpCmbB7BVGaHdnu+p5IcVaZ3y1
 2F1vMTaTDDQDcoaRI77OJwOMoYSTZi8T22QfEsCBje6VkLGhc7WFHKlNW1OYFK6yKPte
 pJILYHrMvfCnP3CabC5Nzei5ZLofrLIj+PVVD+d4ZzNUXjVOr1lZMQepooEmn2hyTEnY
 rqW54//f8kNPbh0Fcb8mZnTbkofHlm3blKjXRsgO/VgBUh2zZuQZMjEHUX6tdh6vXLG1
 /xeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751042882; x=1751647682;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=09jEEfxH61xNyKOMacsgoNlPY/1UHKOXAZFUCBrws8g=;
 b=k3WcAo7uSmpcyKxiggyBfm3S20OOcd3RGBfaFfa5ouGsCWbYh0oVHgOxm0lAYtIhlr
 GOrRgXfz1VG7XWPgKqbi250+7YM2LTvyz7sstriPU5sD9TctUg1FWhpqCIpY8NsqHXK2
 DunoKpgjYAj0cfNF1VlP7017Yw8CmTE8+s0pbT8+vo0kYGZevWmgt7PEljYFCykpP9VY
 j7RR714KVPvXs/AKsZDWLqUXHEStDu34q8hhksQK51z0OcKuGFs032ybJajIzm1YmTlW
 MFgO0Rh4kMF6eOjNw0aP/Kdx7vl8nhnGlAYsGn3UcTcYdZovwT4GQIT4FFQHJnkQ0ffi
 ZjhA==
X-Gm-Message-State: AOJu0YwofqqgrJyDQZCpFWsQyvlHOyjmCDgMa6OP6J0TANpSzRwzlFvA
 yLhgb0hIVaYKFYFBI/I/KrJGa1d9+RV8XfqygRnUD6IQStCktZJkqYAGhJFY8lvQa/A=
X-Gm-Gg: ASbGncsTwGscMAJO+bauHrZEu/gEHnrE0tOPDEUzFCyAcXHdrrng+0nm875iBjWly9B
 FZINcPfiRFYlP8tp2fjT31otEM0/b5KqJs/6DVXkl0NX/+xxxCTLJoEHZD/gt57wPEDPLEFnNZL
 xya+QE4hqj2XkW/nCcyW2KDA+IwyJRROmEAics+a+ejZSMc/yK07o2fGK6ep/ayYnN3YthqQ74f
 J2Z0BisM7bPfvrAsBpDl9TAH14MOa8mtePM0FYPE9EV6BLMo/f+iYKGBtsDOOG7d6HyD81EFT48
 EQ759Hrz3WJc+x+VGDSOHNX5OqcAd/Zw6Iji1cBOMllPxPuumw==
X-Google-Smtp-Source: AGHT+IF+HZ6ED/hVQlZxy5xa9Nb0qxU9UWuwEsmo+ECBMJZvJQUC62Ndkk+kdgoik0+hKXhzf1HWEw==
X-Received: by 2002:a05:6000:2a89:b0:3a5:8934:493a with SMTP id
 ffacd0b85a97d-3a8fec798efmr3859835f8f.44.1751042881589; 
 Fri, 27 Jun 2025 09:48:01 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-6fd771b50e1sm23389626d6.34.2025.06.27.09.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 09:48:01 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:47:55 -0300
Message-Id: <20250627-conversions-shmt-v1-0-52449291b036@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADvLXmgC/x3MwQqDMBCE4VeRPXfBprFiX6V4SNKx2YOx7IoUx
 Hdv7PGDmX8ngwqMHs1Oik1MllJxvTSUcihvsLyqybWua++u57SUDXrOjC3PK9/80MHHIfWTp3r
 7KCb5/pPPsToGA0cNJeUzNAdboXQcP11wMRt7AAAA
X-Change-ID: 20250627-conversions-shmt-3495e4b9c7f4
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474; i=rbm@suse.com;
 h=from:subject:message-id; bh=3xgd0qgPWMdX6Rpzpl4CosuJ6i5HANX/UjAC/FRfnpo=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoXss9hKOE7Wi5TDKVrFk+AsKdudA16JtLDV6GX
 u1RakwOq7SJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaF7LPQAKCRDJC4p8Y4ZY
 pkPPD/0d/GFSYSxZ2tMEMxkxx6AER7098rRMI3rfKpOaAkRzwMSJm5HyLusH7t3aqzLMjLXtvo1
 d69eLJ6YpOGsxZLATEXhrXEYYCpOLUZPfGaQbWhGX9m5SqaakcX9VlpG7SVkPkhlwzhzyl+/BwQ
 D1wouq+5ev2U3WXX17ygcqwHa3bbNJCk7ijLU8pxovCd28LEzpG+zHxm4u0jDrdml0encs52ogi
 xeJ8PhI42nOe2X3radIsuEt2FpA/bhw29IlpkegqteqvPlHkH36nhgX/K0IHuZF36W+EVmb+2my
 KOWj0Ue7l/mK+ndBUWDKODyvGS4leW6Mnajtcfc/1Kxc2OxWKEUgtxNNpOWS6VCx9UCbMUu2KvT
 eX55weBkaHC3A+fqsvvEzyhSTq3ylXJoz2zQxrbPEJ35i80Gno4mI27S5onsmF1ekjhe7Nb7J/+
 RDSrJsKMFLcGK7TtLvrWrothAmxJSTtSdeR5104FN6pZld45zX2PeeByyhfBzHwgFzEGv4gcgRZ
 T2QDEOV3aSxfkJNWPAbmUh03/4fAlRvDsmjWG9fAf8LwUtD8RIUncGkDsxTlCThyDD1RAlJVBdl
 /VI8DUkWNAQoahSzb/Glbs9xmPVBNtjB//IVkH8ZBeq6LpekNPoe0pcdknhKCTHxVSXsFGRA1AI
 pAVE437XC6r+dBw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/9] mem: shmt: Convert to new API
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
Y2FyZG8gQi4gTWFybGnDqHJlICg5KToKICAgICAgbWVtOiBzaG10MDI6IE1ha2Ugc3VyZSBtZW1v
cnkgaXMgbm8gbG9uZ2VyIGFjY2Vzc2libGUgYWZ0ZXIgY2hpbGQgZXhpdHMKICAgICAgbWVtOiBz
aG10MDM6IENvbnZlcnQgdG8gbmV3IEFQSQogICAgICBtZW06IHNobXQwNDogQ29udmVydCB0byBu
ZXcgQVBJCiAgICAgIG1lbTogc2htdDA1OiBDb252ZXJ0IHRvIG5ldyBBUEkKICAgICAgbWVtOiBz
aG10MDY6IFJlbW92ZSBpbiBmYXZvciBvZiBzaG10MDQKICAgICAgbWVtOiBzaG10MDc6IENvbnZl
cnQgdG8gbmV3IEFQSQogICAgICBtZW06IHNobXQwODogQ29udmVydCB0byBuZXcgQVBJCiAgICAg
IG1lbTogc2htdDA5OiBDb252ZXJ0IHRvIG5ldyBBUEkKICAgICAgbWVtOiBzaG10MTA6IENvbnZl
cnQgdG8gbmV3IEFQSQoKIHJ1bnRlc3QvbW0gICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEg
LQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZSAgICB8ICAgMSAtCiB0ZXN0Y2FzZXMv
a2VybmVsL21lbS9zaG10L01ha2VmaWxlIHwgICA0ICstCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9z
aG10L3NobXQwMi5jIHwgIDI0ICsrLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDAz
LmMgfCAxMzMgKysrKy0tLS0tLS0tLS0tLS0tLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vc2ht
dC9zaG10MDQuYyB8IDIxNCArKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRl
c3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDA1LmMgfCAxMzEgKysrKy0tLS0tLS0tLS0tLS0t
LS0tLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vc2htdC9zaG10MDYuYyB8IDIyMCAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9zaG10L3No
bXQwNy5jIHwgMTM3ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMva2VybmVsL21l
bS9zaG10L3NobXQwOC5jIHwgMTI1ICsrKysrLS0tLS0tLS0tLS0tLS0tLQogdGVzdGNhc2VzL2tl
cm5lbC9tZW0vc2htdC9zaG10MDkuYyB8IDIxMCArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vc2htdC9zaG10MTAuYyB8IDE4OCArKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxMiBmaWxlcyBjaGFuZ2VkLCAyNDMgaW5zZXJ0aW9u
cygrKSwgMTE0NSBkZWxldGlvbnMoLSkKLS0tCmJhc2UtY29tbWl0OiAwYzk5Yzc5MTVmMDI5ZDMy
ZGU4OTNiMTViMGEyMTNmZjNkZTIxMGFmCmNoYW5nZS1pZDogMjAyNTA2MjctY29udmVyc2lvbnMt
c2htdC0zNDk1ZTRiOWM3ZjQKCkJlc3QgcmVnYXJkcywKLS0gClJpY2FyZG8gQi4gTWFybGnDqHJl
IDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
