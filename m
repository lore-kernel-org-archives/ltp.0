Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A64C2D0CD
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 09:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747300429; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=o4vqQS3a3dh6XbxMlko1PSL1QeA3FuZ6DDYuJxnLRGo=;
 b=LIAs+qSMamsHojrYSey0nnm9rMb2txwjMNpXaNUlrK4vkxbzwO0gTWfWFiw+6V8gl65X5
 FjTrGG2fdG/ksaEtQMhT5mj0uRD0CBhG6vn/wQe8XTJmnEE5MwHAqlYQ9QGD+I+XtBIGrdB
 Xg/P5bvaXtHW5DCZWIqxnNCyiqdLcIc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6125A3CC495
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 11:13:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 806A53CC48D
 for <ltp@lists.linux.it>; Thu, 15 May 2025 11:11:57 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 95ABF2009AF
 for <ltp@lists.linux.it>; Thu, 15 May 2025 11:11:56 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a1fa0d8884so324407f8f.3
 for <ltp@lists.linux.it>; Thu, 15 May 2025 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747300316; x=1747905116; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1COaALvvzdTV8IlaPajauXF43VThqx88tkcbTFVdQco=;
 b=dasobSlUCIRXyhW+ipW0R91qOpL28QaAhHpvsejRnRFKYDjPcgnKwadKic5X8y7Jat
 M7lVbcuG7Y2fQx+1SDTMk2VLyH10QsekUAcixwUHppvUG5N2aU4RpfyZaA2EdhtIbc74
 R16R8KKnBEnM1a8VTK/I0KBZvDHZOy+J+KW/HbvERw8toLcBTjCmqL57qmumWE3+6fdJ
 xL1Hzz75W7stBkepnyc3PrLZJbAs9AUCvb6XHo1Hw5McheT1O5iGeBJN7BSKUrby2sAZ
 nwZ/dqrYjfOEfqLHrrhpWgdvzWxDaJr2AgD4BqBbXndeuh8mJz50WWjKFgMCaV+23EVA
 cLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747300316; x=1747905116;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1COaALvvzdTV8IlaPajauXF43VThqx88tkcbTFVdQco=;
 b=PF3ejjkuAQndPWFND3luTExJezlAoWPdegxuKzOYW9GrFTDTiaA5xDDFUf2f2FuMrp
 PHXr8X/Efl6yFhtWWYc/tecxPWp1Gff+QCa5faytCq83pcQKNBc5Gvn8TmF6ZJxik6YK
 amxcbF+2EmGzHy8+rm6Ogz2LsDPclaY1CFQ7Sd1zfLwZzQ80UJJLip94J5dy8koovNk0
 gX4ZIs8wABY0PVNcp9hfdaMulimQKZOI4P8AC6nAyp7zjPEUDUxiRkx+1R+O4DzGi96g
 WMYgDDcdPjC+thvtOXiO4/h+q+WtO/IDb2NnKH+7WSQKoetkilE1U96f9lB8sd7XJAVC
 KrvQ==
X-Gm-Message-State: AOJu0Yzz6zJSWl59cPHRS0c8tjzlNhxFOF1cZMhv2soGbEKGnbVucUjn
 RPNkj+Q415PeC1NoR64hUPo9CWbp8UNt8qJxFycxEu9iwKjC9tzjH2Tul937XOo=
X-Gm-Gg: ASbGncu/M0mKReDWMhtmRAFcTaSvJSpTqPa2BB8ASDumgjevBS7VDBBKzM4EPLlM9xr
 C5fvsPWG8LC858Qscgs5nOBlY1ID46yd8lgX4im86vOGg3WcHL3DhnbyHWGaG4BqfXnZomvzvP/
 B7rPJTZtS56Zfa3DKCVkZVt39XAkw/+5xt6HnV7CKcRjE3/lKnisTrZLkDSSpIQFrdyPWHcR8Hw
 CSNl+Hv4vRKCr3hdrad99cRyuK1R0OtsxCGen9/2WeDQ3qZn87SwYJzxJJdxolmoemHz3Nqnn4y
 g54Yz+gy4RnyqbugkjiTF95pjRH6uuSeGk5ebQY=
X-Google-Smtp-Source: AGHT+IHTBWOqckiapwFPmt8wKeyyDGiwMTNJXzVti3lI7hHEkAqHKgnbFP5EBtmECjdnCNeVvFyPWw==
X-Received: by 2002:a05:6000:420c:b0:3a2:1d3:defb with SMTP id
 ffacd0b85a97d-3a34991e55fmr5762701f8f.36.1747300315815; 
 Thu, 15 May 2025 02:11:55 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 ada2fe7eead31-4df9e784d08sm175691137.9.2025.05.15.02.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 02:11:55 -0700 (PDT)
Date: Thu, 15 May 2025 06:11:38 -0300
MIME-Version: 1.0
Message-Id: <20250515-conversions-kill-v2-4-431063e90b4f@suse.com>
References: <20250515-conversions-kill-v2-0-431063e90b4f@suse.com>
In-Reply-To: <20250515-conversions-kill-v2-0-431063e90b4f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=rbm@suse.com;
 h=from:subject:message-id; bh=73oNR4PVk2t0gEZSRjVy7FycGGSImMsV1+95piCPwaE=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoJa/L5ljNhyxIttiGNdnihiD4QOSqNGv9BDZH9
 8lUgnEZz6yJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCWvywAKCRDJC4p8Y4ZY
 phDFEACsFWq7LqgRoLd8RlLXQ2DiqXP9S//jQk3wiNzBT3qXE0lAlWojMbRdmP6s+AcbJmp6bid
 2BBAuODm1NSxM+Z4n836EUY/5SDgBu/7Dx92F9CE0U1NaGn5BBeUfh9r/nO9nrj40dRGcMW2DXI
 +yObyi0h2fl8P9tKzlhGWeVVMUYvkKm0yEib29QDMMPljN31OT5uZphzGabICTsftjwcjYQi3wb
 zoWU+bDzvugsVpCdiyjowUANAOZ/kJwQot1dZa1GgfD8/lMHVYqkhicjZDgR1bNput0G+NF+x8X
 KUUQrkuGXFt4NbYx/bLpQ7DxYCT9xsvJzz2iG7Jo3XEqeaVU+sBFx7tIT/VrSoRmXR6KXjERwBh
 cRzg9j54SqCbc2vUp7pXQsktTtF1zPWdVgWFxDv4phojgYI8AHfOhkW9LrDCIo5GVN6Pj21B2xn
 tEmtHNq4hMHLzExK54tY/01TtqSws10ob0TCG/xcndoNK0CCgpqgC+bIUn/Xn4QACOBgXrCA28u
 KbEqGw5XQs8v6PRc/bdZI1G2n9Rh3Kxpj6yl9N2532p1mNZKv/cLfC3wmTiFWiPJYGvufEmnp19
 dyMf7ig9N3hfxsomyDaeYLENx3MWAF3JASlS3XcHhUE9pb2kaW24+1oak1DsLOcm74anpXGcNmW
 s7tSi3C4C6uatDw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/5] syscalls/kill11: Fix test description metadata
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClJldmlld2VkLWJ5OiBM
aSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJs
acOocmUgPHJibUBzdXNlLmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwv
a2lsbDExLmMgfCA5ICsrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tp
bGwva2lsbDExLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwva2lsbDExLmMKaW5k
ZXggOTE4ZjE3ZjIyMTAxZWUyNjgzZjlkOTBkNWE1MzBlMmE1MDQwM2MxYi4uM2NmNjJmZWFlZDc3
N2M3NmQ5ZmQzOWE0OGIyNTViZjJkYTkyNzcxNiAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9raWxsL2tpbGwxMS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
a2lsbC9raWxsMTEuYwpAQCAtNiwxNSArNiwxNiBAQAogICogICBDb3B5cmlnaHQgKGMpIEludGVy
bmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgIENvcnAuLCAyMDAyCiAgKiAgIENvcHlyaWdodCAo
YykgQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IDIwMTQKICAqCi0gKiBUZXN0IGNoZWNr
cyB0aGF0IHdoZW4gYSBjaGlsZCBpcyBraWxsZWQgYnkgaXRzIHBhcmVudCB3aXRoIHNpZywgaXQK
LSAqIHJldHVybnMgdGhlIGNvcnJlY3QgdmFsdWVzKHNpZyBhbmQgY29yZSBkdW1wIGJpdCkgdG8g
dGhlIHdhaXRpbmcgcGFyZW50LgotICoKICAqIFJFU1RSSUNUSU9OUwogICogVGhlIHVsaW1pdCBm
b3IgY29yZSBmaWxlIHNpemUgbXVzdCBiZSBncmVhdGVyIHRoYW4gMC4KICAqLwogCisvKlwKKyAq
IFRlc3QgY2hlY2tzIHRoYXQgd2hlbiBhIGNoaWxkIGlzIGtpbGxlZCBieSBpdHMgcGFyZW50IHdp
dGggc2lnLCBpdAorICogcmV0dXJucyB0aGUgY29ycmVjdCB2YWx1ZXMoc2lnIGFuZCBjb3JlIGR1
bXAgYml0KSB0byB0aGUgd2FpdGluZyBwYXJlbnQuCisgKi8KKwogI2RlZmluZSBfR05VX1NPVVJD
RQotI2luY2x1ZGUgPGVycm5vLmg+CiAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiAjaW5jbHVkZSA8
c2lnbmFsLmg+CiAjaW5jbHVkZSA8c3RkbGliLmg+CgotLSAKMi40OS4wCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
