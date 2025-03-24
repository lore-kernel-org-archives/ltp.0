Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9D6C36002
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 19:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742842803; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=dUf2wzgyZYGafjsFSoY81//38lAZLD/k/KKPEsfG20Y=;
 b=l5REsr0AZNRYQYAKFIFmo9swcaK6ARqEwxEwoVfv8YWTF391nrRC+5WZmmrQw0ogucSWc
 gkPyJ2JDyTa2EBgEoBfmThUW5ZbZOts98TjCOE6cLEUUqKFqtqu9zMM35UqW5TnYoEMy9tA
 uE4oTXnKF7KQnbvuilFbH7yYP160QuE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FF0E3C92A7
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 20:00:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77E3E3C08A6
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 19:59:40 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E84EA200218
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 19:59:39 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so3777407f8f.1
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742842779; x=1743447579; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mojsQuK2GrM8McGdAEDZilnY9pE5zvOpNXT7i9oFuag=;
 b=Q2hugv2pVknhY/1KLZ4peP8b/FMrmwaq3Fh0b5RDT+Hunr7MwPOI84deNkxsIS2WLl
 6OIKuFMW0xYVG+3QdAv94wICYNYw+1ZYhF03OCGyoIj1IkDjh5N3LokuTO63+EIHw2vy
 EgP3y58hjwIeuvGeCn5en07kTzcIAq1ewwyuXc3pZKrWgjhNl2qOrnqbkbwRl9IAvW+z
 QWCNSg9DToUvfEuCF4B7VtHKJWfjBjn1jyqDN3QWaYEdfKUxQe5eRmBr9cAHG74pSsBK
 QWxXunlpCcQAbo20BjJeFPsgH/AhqE587HMuHb2yUjDz38t9e7FkmSfa0dWJF4BUtlMS
 dhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842779; x=1743447579;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mojsQuK2GrM8McGdAEDZilnY9pE5zvOpNXT7i9oFuag=;
 b=fN+CSbXaspT6r5Oo3pmunwgyuCCdP9te36OXbH5HdIGk3Wt/dm7UNFOMhEPhTfewm7
 J8gKiZ520H+ykLY6CE8GrSFCWh39FNtCQJIWXVOaesxYrbfpcG+J2stF02p3l5xUpIkS
 u23HtbN+qKt8e/13L1IC36phlKE0rR24lS3TnmL1TltSH+Om+WWOWZdrkqc/ivfQSJd3
 VsBQbQ5XLoVMfBDzR5tGYUVlsr4QV2d/5xKmV+YmD3/Hl6WsGELmMykcx0tc8QVIdFD8
 kkt8doM1ATZC/gxAiIAq7tkHEtBkk6x9jKmO4+EnW+AJ88Wz+DrVVsV+jvW/+QFL+et2
 qL5w==
X-Gm-Message-State: AOJu0YzxE5qMFV/yQFW4zu5UgmPuK6p8UNUuwDFxUlfoAzRffzdcAtcl
 /fPNQt8JQ/UINamcf/+JeXwCv++fgP1sBUCF3iFgQR+0d5G25URctHr8HDkxQHsa5eSZjQHRD9T
 r
X-Gm-Gg: ASbGncsNUpfKJGfLbPuvPNSAqp77CGchOa+36FTqaPvf78++uiZTh6yB2r8JYCZPAEW
 mfXBvXJyJAby1UeBIjgKh11L/e5RxddZzSx6KVz/Lh7LwI55+tF7Hzu5AVhr7BJrw9fHqsX46SN
 0J6owwXOeDN51n6xiw6u6qN+gq9lOCMdbJWTVPUBDsZ0tSviIZTYsNPH/xI4XmS0bb23VKUD1T8
 0FytJ2OPbIMt/K5vrUqBeqU41rqam35wQb1qqacw+QIiMJDzomn5JCXb1O9BREX4n8UWlsWbSfJ
 b2nU17wT58R14H/47lG0HAm03KpvkoA2hQ==
X-Google-Smtp-Source: AGHT+IGrL/mgbrrnzJZnEHdbruvBPKlJJTkRNT6ckWpPvl4X+Aq0IzYsEZahH12eFEMj5IX7ovgeSg==
X-Received: by 2002:a5d:64e4:0:b0:390:f0ff:2c11 with SMTP id
 ffacd0b85a97d-3997f8f924emr13420616f8f.2.1742842778974; 
 Mon, 24 Mar 2025 11:59:38 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22780f45535sm74652815ad.54.2025.03.24.11.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:59:38 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:59:29 -0300
MIME-Version: 1.0
Message-Id: <20250324-ignore_vmx01-v1-1-5959aea16d7f@suse.com>
X-B4-Tracking: v=1; b=H4sIAJCr4WcC/x3MQQqDMBBG4avIrA0kMa3Sq0gpUf/qLIxlRkQQ7
 27q8lu8d5BCGEqv4iDBxspLynBlQf0U0wjDQzZ56x+28sHwmBbBZ5t368yzqTGEKtSNd5STn+D
 L+71r39ldVJhOYuqn/2SOukLoPC82SRjZdwAAAA==
X-Change-ID: 20250324-ignore_vmx01-687ed4347821
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=624; i=rbm@suse.com;
 h=from:subject:message-id; bh=5oU6MxnREUxS4lylBhNAi1OkijCnmr91UlRzhadTSCs=;
 b=kA0DAAgByQuKfGOGWKYByyZiAGfhq5fI+mK8BNsXIw4I+i21+FETBe7+5fYLKW1QFMGrRdwWR
 4kCMwQAAQgAHRYhBAMKjp5CTuPAZVeH4ckLinxjhlimBQJn4auXAAoJEMkLinxjhlim+fkP/jLR
 I0ZZyOM6okdBYOurJUzxW3usBozJ04QGVcaRiggV0770Iqw87GuYSNFgt3oR69VPgh0ChUaLhcw
 bM7MJO4j0nbhwUGWW5OR1URcoX9CEBblPHYlVgmwXkG9SaSnrKgPezQpYAXGXNZDYUJRztF+UIW
 m1FcKGyKTY412IN5EOVPpzqHTQxuj5S0F4WCjoYMtPCagExhB+3BU9h8Dpq9ATAQia9s4SSpcyi
 gHzUMSXRAnKxq7iA5qrA3bF4qM54NVTtnae/YPudOsAsk36WjU7M2Qya+ZNGdaUCJ+IpxB6FkxR
 8spDhTGuONWfIjej7zTSLPO9uBozfNYQE1Ey0mfz9d8gnXeVQjGk9roHTmqudpkaz25rDIcCX2p
 9Vlbfc64Oji/cv4zqp7dQ3sL6sGbuC/7VNHFAYv8AgwdTDoHDOyqHMfKa111ZSWIuIUWoc5bZXW
 pyvsVLqAUbyUvxzLTdyYwQqavz80/8PY/K7er6z+ICRatoS7O775mdH40Qq0g4BjgHHLwbbL/Ef
 xmggTHRMROdbEEUnUpnbhBgWb6lQ+BF5ayh1Qu6rifltIik5/rgoiRQWYg12euwjOSraWyVrUm8
 CBb4K5NkZXCXiywx8seQN6KgxRpgVQvFMzC2irzcFDtRWnY1AeM/WxPuf6PTsvLWTM7G4/PmhIM
 Lu2os
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] KVM: Add "kvm_vmx01" to .gitignore
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: rbm@suse.com
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KU2lnbmVkLW9mZi1ieTog
UmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVs
L2t2bS8uZ2l0aWdub3JlIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2t2bS8uZ2l0aWdub3JlIGIvdGVzdGNhc2VzL2tl
cm5lbC9rdm0vLmdpdGlnbm9yZQppbmRleCA2NjE0NzJjYWUzNzY4NjQxZTJiZWY0OTY0YmQ0NWRm
NDE1MGI5MWY2Li5jMThhMzE3OTJlZmE4MTVmY2ZlNDg4ZDc4M2RkM2MwNzE1YTUzZmQ5IDEwMDY0
NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL2t2bS8uZ2l0aWdub3JlCisrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwva3ZtLy5naXRpZ25vcmUKQEAgLTMsMyArMyw0IEBACiAva3ZtX3N2bTAyCiAva3ZtX3N2
bTAzCiAva3ZtX3N2bTA0Cisva3ZtX3ZteDAxCgotLS0KYmFzZS1jb21taXQ6IGE3OTBmYWRlYTM1
ZTY1YjQ2MDMwZjYwZTM4OWRlZWU3YTYxMThjMmIKY2hhbmdlLWlkOiAyMDI1MDMyNC1pZ25vcmVf
dm14MDEtNjg3ZWQ0MzQ3ODIxCgpCZXN0IHJlZ2FyZHMsCi0tIApSaWNhcmRvIEIuIE1hcmxpw6hy
ZSA8cmJtQHN1c2UuY29tPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
