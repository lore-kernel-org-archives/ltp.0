Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CDCC369A2
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 13:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744119868; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=mC0+aqqe24uQx3udrh83uYHT5/b/wVRn4F0nlYk0np8=;
 b=UExlERJPNpdoCTHcjt8HeDV3EIUTDOIZrbwmKWgyMQanUTDyW0pMMR320FtAf+Rj0n+qU
 h8IFkzxogtjTCAjSXVf216LLuVqAa+0VXgs4TkHMhfkur5qeTGKswjf7mc96SuRg/+QVGrj
 7cCE6pJFn4pi9u1sDasHOUEPCoxFawM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E26583CB3A2
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 15:44:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E5743CB35B
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 15:44:07 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 14C941400262
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 15:44:07 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso39548695e9.2
 for <ltp@lists.linux.it>; Tue, 08 Apr 2025 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744119846; x=1744724646; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zK5vAO0BY7C0t7/7XNWaoDFwOfbazZPXlsxd9IHAh3s=;
 b=NRpB+JzPpVLZ579OEXzS3N1oOZJsEO1t+/0Vtd8FTywoTK15UM6hgP8xAKn9ow7sjl
 X3S5xv/5G/3FPI5KOYO/6OrZmLqEsHO3XP6DpkY/rRJZ3QKNR7nhdz8Cf2DGYTZQBBlH
 Yjcdjf17OP8QuydvUXnHBtPOzgbZshKFYc0Rod4GcTjEcDuhEhkBr213ckgJwYRCDAu/
 2WE3FRshVw322Gjn/2GE8iJsI7wt5tzc4JDFVz17H9T3ZkOKpxH6MuZ5TPwEt2GN6YcO
 fnH5tyoxInAr1Lx9QiyXXFPyJrhvUbBCJKGAH0W/22x7BH3l+M6ldM7n9z8qNQfL2mbA
 RjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744119846; x=1744724646;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zK5vAO0BY7C0t7/7XNWaoDFwOfbazZPXlsxd9IHAh3s=;
 b=nHsH2KHJdrf5Ij38HjZTDvj0AtZrzX35HC/7qoDOaShBveRJtvFB2RmpSTJX0jg7Hk
 kvE+EWG0Lqbd/Zo4g4cLTtZRWrfjBsqh3BprNkchCwewpjjFiX5OrGrLswLOu0IeaW78
 +I1BojM9QPsvZ30kNm+HsoNdXnwNScLyGNdupG0UDaTffnZ1JwzZh1awWWXGwMAQ01S8
 fPzk58ngKZkcfqBgmTbx7oN9URbNYNHOIVDnsScj0IS4pGGXg/SHIL7SuuMJhaqgfaIw
 CfZeY9QkTHx5jEe3yiARIwWwPLi50l7mHCZsKwQJ9iGHCfgnJR85u8zk9wznnRMmNfM0
 JFdA==
X-Gm-Message-State: AOJu0YxEmfwugoK99VojZRXCcqrPBputhVsdYhRsTDqyafndXsd38pjU
 yAjR07HS5e5BoOyMd/zxmduvUAfSZhK9qKRuw6ovC3HiTXC/r1bx4GdlJGjv5p0=
X-Gm-Gg: ASbGncvcG48iYCXgNngUNv0nhK6b7bFtXizZgWm1QbKw1Q/crW6e83Qs7GJRb46Tq1Z
 QQ3Mu7pQlH+mHHvM/3XIbhzK5cL20b8j8x7VVpRqLOhOMeSxQXNPuk3pSgPCz2UmUe653QG+kMf
 J+jDR244zmEAHnHHBtkx6LNxHfOd+CaBZtwtUqqQGdCGkNlT/rFgYm5BVlQP0Dr8tmhAEVpMJO6
 6+OccywT5EJwt/K8Dvuuu9A/q7p1Yf6vzDblaHwLVAqJCyOdvIWLq/x+5lJgoYkT8lf9VkL52fS
 BLf/j7V9BLmWZ3ySrQUYoeyXWrM1BwoqBw==
X-Google-Smtp-Source: AGHT+IHM6+XliTOqsHY9vJJBHEORJz4Qp76lbAHqvKgmg50+xUTKPYcfW4A7rd+JTrHscAJ5ulOSww==
X-Received: by 2002:a05:6000:1a8d:b0:391:487f:282a with SMTP id
 ffacd0b85a97d-39cba93cdd3mr13819127f8f.50.1744119846460; 
 Tue, 08 Apr 2025 06:44:06 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-739da0b9608sm10541313b3a.154.2025.04.08.06.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 06:44:06 -0700 (PDT)
Date: Tue, 08 Apr 2025 10:43:59 -0300
Message-Id: <20250408-fix_make_clean-v2-0-48f93c3dd0bf@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB8o9WcC/3WNTQ6CMBCFr0JmbQ3UIODKexBChjJIo7TaAaIh3
 N0R3bp6P8n73gJMwRLDKVqgtzz68Nr8nIiUoGOdxgedqc4+6wGvVJsboVNzomKVNwW1GvO2OOK
 ZJ6a98QNU6y6Ce6BAj8myHTd4WUlpenQXUraV4i85pzTrOkoMaQMyCjQLxTvZaIkNMqkmoDP9h
 zIgjxTg+yik39m6vgH23uWI2QAAAA==
X-Change-ID: 20250327-fix_make_clean-8e57ffe1ce2c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=rbm@suse.com;
 h=from:subject:message-id; bh=8iinDKziKa7BypuZlLnUTfu4s/ccxAKOD0iF9pwtKuE=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn9SgifFAcWpwtqDN/5RxNg2Czz22GKdosd1APM
 5TqEFlUGICJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ/UoIgAKCRDJC4p8Y4ZY
 pkbBD/0f35S8VsBmJ9ybGHo+hUALmf8jV5PzQ7cjLXqeZ8c37O2qdlrn9DFxzjy+p5REi0tUEjn
 mBgZWR8EHKGTM5eH8k0mJk4DTtrNl/b90rxvRp+ancqZZH0nQOx7fs7+34C7fU9FoSIF9wMd7+q
 A0XRqqNPDRgXHjdaJyx4SG80HSPA7HrCggm9K/bWbvYDuYpf1mMVOTDiXFiXmV8ynJfyBK5J4tf
 D1lh9n3RfLvmnInp/mUiv6YdKANhDbkmVHkmv7eqVqpdz9El7VbOtp/OI75Deolc5hYaRh3o26i
 DmYaFarsgOa3p9heGUCNKXV0Tjo3xyGIEAIWqTpDX+ta5+u8Mg/Y77j/NuKsvTmaKSYAxQMH3hK
 EsP8CiBMPuccZYWWshvskcTw1IMRyqvz++qnLb4mWm0IgLfl/nV+GpMve3EjcZYu87uID+bXDxZ
 +FuKoaAHdlfx80zxLtP0CSXros+6cRRifM1gtlGPNEXf5Ybhp+KJwbbDUB/RW7MJnpTVVZn4h5f
 mwOIsVEoP5jwQJnYC2OJZkR2M75EIH3OoecQYC/NcpETrjs55SnwcitHuPKOYk+A8VJ1WObnfiP
 7W5eahdr6A5Uj8xTbI0y3aS0L4zls2WY9QrOxOIOrImecRUV91bTxbD+0yd6fzvIsLsegIZ1NhY
 SSnbCcbYmcz23Tw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] configure: Tidy up removal of generated
 artifacts
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
YW5nZXMgaW4gdjI6Ci0gRHJvcHBlZCB0aGUgY29tbWl0IHRoYXQgYWRkZWQgZmlsZXMgdG8gYWMt
bWFpbnRhaW5lci1jbGVhbiB0YXJnZXQKCShUaGV5J3JlIGFscmVhZHkgaW4gQVVUT01BS0VfRklM
RVMsIHRoYW5rcyBQLiBWb3JlbCEpCi0gQWRkZWQgImNvbXBpbGUiIGZpbGUgdG8gdGhlIEFVVE9N
QUtFX0ZJTEVTIGxpc3QKLSBBZGRlZCBtaXNzaW5nIGNhbGwgdG8gaW5jbHVkZS9NYWtlZmlsZSB0
byBhYy1tYWludGFpbmVyLWNsZWFuIHRhcmdldAotIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvMjAyNTAzMjctZml4X21ha2VfY2xlYW4tdjEtMC04YjllZDJhOGQ5NmFAc3Vz
ZS5jb20KCi0tLQpSaWNhcmRvIEIuIE1hcmxpw6hyZSAoMik6CiAgICAgIG9wZW5wb3NpeDogTWFr
ZWZpbGU6IEFkZCB0aGUgc3RhbmRhcmQgIm1haW50YWluZXItY2xlYW4iIHRhcmdldAogICAgICBp
bmNsdWRlL01ha2VmaWxlOiBGaXggY2xlYW5pbmcgdGFyZ2V0cwoKIGluY2x1ZGUvTWFrZWZpbGUg
ICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICsrLS0KIGluY2x1ZGUvbWsvYXV0b21ha2UubWsg
ICAgICAgICAgICAgICAgICB8ICA2ICsrKy0tLQogdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1
aXRlL01ha2VmaWxlIHwgMTAgKysrKysrKysrLQogMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQotLS0KYmFzZS1jb21taXQ6IDgwMDBjOTUwZDZiYTYxYTU0
MWE5Mjc4Y2RkYTZkNjgxNDFjMmZjMGQKY2hhbmdlLWlkOiAyMDI1MDMyNy1maXhfbWFrZV9jbGVh
bi04ZTU3ZmZlMWNlMmMKCkJlc3QgcmVnYXJkcywKLS0gClJpY2FyZG8gQi4gTWFybGnDqHJlIDxy
Ym1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
