Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3E6C71130
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 19:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751917241; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=Po9G9W+kKCKBYrUi6LzB7P/K6aOGcjx+hZviA7ukm9A=;
 b=XVQbzTklP+A1vUun4wLV6aGXL/y4Zqoslgo2EnhgrZXmhzH9LAIl/SLAuZ/QaQFkuuRgT
 et0f6YraxP+c2gDK4LKw5LKi0jDwqAy8gmCXxQUFrqdxQ6e5Ved3mqN5tNUox9PQGIl1ttS
 wqfofgYu4Km7eflofWoaPEcrXcM2HQM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F08DA3CA1A0
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 21:40:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F5BF3C640B
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 21:40:19 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 34247605643
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 21:40:18 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a510432236so2431438f8f.0
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 12:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751917217; x=1752522017; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FF97Ij3NckKIxbP+PCfVoSuAexdjJBlY27BErwzwaZ0=;
 b=RLdm/uWfQ0WLAXobc8EGIGrOknv+EyNmpz5i72dORLN8mzJY6AsDFNuU8yNRazQ2GO
 ovIz9Kbc1brbJs8fIJtfZushV+Z8mvNrVghA8iQ1Uvb5Jm0ok2GmM/dYdzw1Jb3GqSTu
 +5EGOX9IK+FKzN95Hl10khYe8Y38po0xb5e3F3nSp6B5PpzPmK5MgEvpqoO2Vvbkn21W
 3gpTregoO/jwoXqQkaC9EvMcQ+mBOH3nEJsYVSTVE6RbDSRhi3dvTxPxKQGMZ+jQaq66
 7fAHYFdj8iAGI8u28ptDMO7U5VX1Bx/RloEHIqL3Rx1xn8+C6CUzjx3gM/cYCg6qJOlY
 zLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751917217; x=1752522017;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FF97Ij3NckKIxbP+PCfVoSuAexdjJBlY27BErwzwaZ0=;
 b=pxZu+83EheohJ+/6g37WtoaKl85jEZ7fERRFUjvXU+U0RkheB1g/9FyMYeUFAZRagB
 aT4in8Vb9MKM3XTTDqtwt1AxpJx1B5DQEB6r6VApg+ytJF5SmjQkCWYC9L7CL6IOG+Hq
 wS7xtgBrYQtVdXKOp5BkCTK9Vyqq1Ymlr719TFvLQS+Kah2q/BwgPZmiAahBHeVqZAJT
 bRNxatoYrwGIllQl6dRZn/0iNFBJw4qN15xQIWpDtkO/U/4VjvVdcpt24TCm2YfucBFE
 y2qHF+hnypTIrQx8KhhoB6Rn2MZNyViYOJcXNscSZxqTQ4yFm8gjIQ32gp3Uj+XAkBQJ
 yaAQ==
X-Gm-Message-State: AOJu0YyvmJoltjTdFAC6FXvn4KDAD1XrEo9cDM+ceNSZKxzJECu09HEf
 u+ar5yCKrOlHJDLJqjaA2omc45EMjXX8+JAkzvMCg3a/iOs26ZX6kvqknehwUwWA73EU3kWeV1t
 B42Ey
X-Gm-Gg: ASbGncsUhjBmOR7T3G+pDQi6Wv+ovJmQcqWdqCQCl+rMPT6YueBm5WLGuD9R+sq5rBO
 Xs1DfOIpAcbgUhCw0H9uUyaM3lL9v1VRCjjBhKl34AqCiVpzWrSx6Bfp9giENYExmimY2LM+6SI
 kIykdcJgSrcpZXkYmFUoG8OmoyBkP/0JHwYCFPzeoejJK81HzZXtDhqiaDxtqqc+v3x3oJA07tu
 pNj1pwrDlSBmVJV+vJIB1KY9ENvsWQxkfEYmO9ahWWs/S5cpaxvGrZmDwCbx1Qs5e11t/PEnMs6
 iXwPasksz1lvbZhtW/zW39rR3+NOtw2w9lBYICwszNzt8urvdUiJ0Hbqspjo
X-Google-Smtp-Source: AGHT+IFyY2srJ5F45LQ2V3glg8w+20Bl50wIr+mfa4CDqgU2o2S8LiSbqtmtyCQifvDuWLvtuI7zoA==
X-Received: by 2002:a05:6000:4a0e:b0:3a6:f2d7:e22b with SMTP id
 ffacd0b85a97d-3b4970131d6mr8859980f8f.18.1751917217376; 
 Mon, 07 Jul 2025 12:40:17 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-702c4d65a21sm63929276d6.123.2025.07.07.12.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 12:40:16 -0700 (PDT)
Date: Mon, 07 Jul 2025 16:40:11 -0300
Message-Id: <20250707-conversions-munmap-v5-0-f273ec86e50f@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJsibGgC/4XNwW7CMBAE0F9BPuNq443jpKf+R8Vh7SzEhzjIB
 qsI5d9rc4oQguNIM2/uInH0nMT37i4iZ5/8EkrQ+51wE4UTSz+WLBQoDQZQuiVkjrWW5HwNM50
 l2o7UcCRSXS/K8Bz56P8e6O+hZEuJpY0U3FSpmdKFYy1OPl2WeHuc56bW3/7kRoJEGLlXox4A2
 p90TfzlllnUm6y2QvtSUEWw5JCAqGmMfRJwK5iXAhYBOlQaDXWuH5+E9rPQVmEwxirEXmvYCOu
 6/gOe/pTJkgEAAA==
X-Change-ID: 20250703-conversions-munmap-3b6a29faa268
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=rbm@suse.com;
 h=from:subject:message-id; bh=2zAUq/9m05b+XKzc0L32J2+GDjc/TVNbxNjvi1yfcoQ=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBobCKc70W+t8RjZEkCPddx18HklyPnlQG0KTSju
 qoQX9wOx2aJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGwinAAKCRDJC4p8Y4ZY
 po1kD/4vsPmH5NPmA0Y9O6EEEPO1Bm4OCM6j3XF7nwWVqbpxm/sc0hRs0MheoAhTiPv8SUvOl7W
 G9/mfGxEkDmx4OGpXM+1De9P/1/zwFd9/GCvLecZMFoK0o2pgtxDCHbq36jt02Wjxw9DODXUGTf
 yo9jiIe+3DenPZB/V43E/yw7HcXK/s8F42mf0W/OIvTNr8zL1MSBN6g5Ab4CDuMpUD+twWXLAuy
 ySnRHvfP2jSoZSV5Nh5M3bpLrAJao1hpZMBociThiv/9c5fwBfDF19Lo1Wl3o7z4IZbPLk5c6xh
 Uq2UOfiJyqwgqkUf/RIEy3URyyesIjxmaObYMbqsFYNZrLQdvm9dO9VkEC9fFfEdoiTsFPxJER9
 ASH0N2v3Zep3BT4kJ82jrk1MsELqZ1dqncAmCpDSYdZ5n4cHUygqMRPOX2vxf5yz2vQ8MY+EjSX
 IKhaR7DC94YWkGYA66sQvawj4bnEU7R2Zb6tX1jOpP983GIFboCJvUdDe42/zGF1SdwK9p6h9Yc
 rKVhl8asc9DkpoGwOIFzhyw9cqjLaYJl7cBL7NwHTj/JnoYUyhwqsk7/VCGYw28n4uUjQlOiTWs
 WopfbN176dIa8rh4kHuadx2OO1sKaAJSRrCwmMLGep8jPqhks8maELhQHcedDadMupmUxmSGXVd
 C6JfFuyK08uAQIQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/3] syscalls: munmap: Convert to new API
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
YW5nZXMgaW4gdjU6Ci0gbXVubWFwMDE6IEZpeGVkIGNsZWFudXAgdW5tYXAgbG9naWMKLSBMaW5r
IHRvIHY0OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNzA3LWNvbnZlcnNpb25zLW11
bm1hcC12NC0wLTA5NzdiMjMzODU1MEBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2NDoKLSBtdW5tYXAw
MTogU2V0IG1hcF9hZGRyIHRvIE5VTEwgYWZ0ZXIgdW5tYXBwaW5nCi0gTGluayB0byB2MzogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDcwNy1jb252ZXJzaW9ucy1tdW5tYXAtdjMtMC0w
NjMyNTM3YTZjOGRAc3VzZS5jb20KCkNoYW5nZXMgaW4gdjM6Ci0gU3RvcHBlZCB1c2luZyAibWFw
cGVkIiB2YXJpYWJsZQotIFNpbXBsaWZpZWQgY2xlYW51cCgpIGluIG11bm1hcDAxCi0gUmVtb3Zl
ZCB1bm5lY2Vzc2FyeSBjb21tZW50cwotIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3IvMjAyNTA3MDQtY29udmVyc2lvbnMtbXVubWFwLXYyLTAtYmFjM2EwYWExMTdiQHN1c2Uu
Y29tCgpDaGFuZ2VzIGluIHYyOgotIG11bm1hcDAzOiBVc2Ugc3RhdGljIHZhcmlhYmxlcyBmb3Ig
c3BlY2lmaWMgdGVzdCBjYXNlcwotIG11bm1hcDAxOiBVc2UgZm9yaygpIGluc3RlYWQgb2Ygc2ln
bmFscwotIE92ZXJhbGwgY29tbWVudCBjbGVhbnVwCi0gTGluayB0byB2MTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci8yMDI1MDcwMy1jb252ZXJzaW9ucy1tdW5tYXAtdjEtMC0zMGRlODJkNTkw
MDRAc3VzZS5jb20KCi0tLQpSaWNhcmRvIEIuIE1hcmxpw6hyZSAoMyk6CiAgICAgIHN5c2NhbGxz
OiBtdW5tYXAwMTogQ29udmVydCB0byBuZXcgQVBJCiAgICAgIHN5c2NhbGxzOiBtdW5tYXAwMjog
TWFrZSBpdCBhIHZhcmlhbnQgb2YgbXVubWFwMDEKICAgICAgc3lzY2FsbHM6IG11bm1hcDAzOiBD
b252ZXJ0IHRvIG5ldyBBUEkKCiBydW50ZXN0L3N5c2NhbGxzICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAxIC0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwLy5naXRpZ25v
cmUgfCAgIDEgLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDEuYyB8
IDI4MiArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL211bm1hcC9tdW5tYXAwMi5jIHwgMjUyIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDAzLmMgfCAxNjkgKysrKystLS0t
LS0tLS0tLS0KIDUgZmlsZXMgY2hhbmdlZCwgMTIwIGluc2VydGlvbnMoKyksIDU4NSBkZWxldGlv
bnMoLSkKLS0tCmJhc2UtY29tbWl0OiAxNmNkNjdlZjFmODVlNmIxNGMxODJmYTQ5NjMyYTUwMTQ1
NjBlZGZhCmNoYW5nZS1pZDogMjAyNTA3MDMtY29udmVyc2lvbnMtbXVubWFwLTNiNmEyOWZhYTI2
OAoKQmVzdCByZWdhcmRzLAotLSAKUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4K
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
