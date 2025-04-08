Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B611EC369A4
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 13:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744119920; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=3+WsmRI8Ai1nTEQphxMehjV517q5NFqa8dJxposLL0E=;
 b=hg7xd2XyztJ551ETA0TALaOJ0YxN1X53CFVfTbvbEO/LWHHqX/MOwDf14n3jNSwMBtHqi
 khsFmFC8DmLi+5CJlgX/bWz+5nuWect93P10CZvDIMVo75R5uGcqMlJtVwVwrtAB8mvWdLb
 xXKm/R5c0kBTXHAUSt6HiosDWIthsSM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FEE93CB393
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 15:45:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CE423CB388
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 15:44:13 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 38EA16001E1
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 15:44:13 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so39025025e9.0
 for <ltp@lists.linux.it>; Tue, 08 Apr 2025 06:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744119853; x=1744724653; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2lHqfS7sFwLGop6Di5esY8Ymgxx/7Suo/C2ljqh3lFk=;
 b=KahpIc5ewyhxwoJH1/IIn0UFh0RSwXnPft0sNhwnGINd73nNTpP8+4ob4IefX5mR4B
 r9tr/ztz+CHIFTsYXks2gBjaveouJ3q42xNuBGixEDiwJ1TiiHCsuGPbALdN9IXaMM0u
 FK1xFwI8vsckEIho47cwXtOLZGEFMqCZhfpRA+X+Na9zwX8Avf3FqSuesTrcs9bSRHYA
 yYvNol0BBgQtrzE2xDfWKLessMK2ZlV8cDfMcWh0nHEQCt0vXnfpxxhlQRbb4/0qJisZ
 /2GhZ6pzu9wcPlpon0oHGYx96eo/gC9511nd0eilngB1LpZDuYs5lFo7sCp3Tpgsoo8V
 AXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744119853; x=1744724653;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lHqfS7sFwLGop6Di5esY8Ymgxx/7Suo/C2ljqh3lFk=;
 b=ZM/qVnRwG9wPl2CsmCCUFgCkVDjeXaeXRoxWH82pEP9Jjqax/aFJ4zomipbahN4sDU
 DW8Sx9S5kC8CV+oi9c7RqnJusBzfu6TAd6QyQ6/A/HOonp9uLzOegmvw6mE1Iv1L7MNN
 Pgpqkk3d5Wo8GQjw3QH8wXF8BmixdFzpQru9xKA0+f2zxgcwJERz3eUYF/erIi01BD6J
 XSdI5F3wlMvcVZNOjR85g2iy84nCWrLmD3Sf5glTaw/5CLmRTELX/HpGe3/JT4v44GRf
 vh0m/lIauOvSZyu6X8i+kZ0qLVwInbuXhJ4H4F7JjqALHXvaJ7eE+dk1XsmlZby1SZFI
 muig==
X-Gm-Message-State: AOJu0Ywmq+DKGb+eo3Z7uTWVR6NK1AZUtZ7hGKtGOipTP0J6KutLwcaU
 5C3xwYDnfyS6BdqvWBt+SyGHqzX84tWsWGQe2MvGkq9GBNEqYDvo7ok5oTeszzjZTxzI4o9jb0p
 y
X-Gm-Gg: ASbGncvNOGC8a9gNCP3AzSZAWMlXMytS+ykKaXCwJkLxAc2G3xjK33Hoxe5VJjoUKb+
 cUn4QH/f0iFEenWV99Xp5CkT5e2T+jzDtLHYQNVaeCy9f48nLVS3puaVLMVq6apyYfCD5JGZ7jW
 acYkP2wvt8nKrhA9C/ucjhgLNJyvEz8tYwpFzIdjg2CE1UJ28K+/7xzcg4WWrmRhY/UadyckxWv
 MPcrhrmcmsCp4VZBlXCEAS1gtzJGrqGMSa5g/QDdFFVs9w5p4a4fvT5dpGeyWsFX1l0fRic2DM7
 RO47h5slpyMMtQwyD100L/50BbtL4Xti/g==
X-Google-Smtp-Source: AGHT+IE9g7OY+a/dNGv8k8558gy6KuNoYf2GzjtyqdQLycZXx952OJutFlF6hwx8NxJNayqzhPjGQw==
X-Received: by 2002:a05:6000:178c:b0:390:ec6e:43ea with SMTP id
 ffacd0b85a97d-39d820b4812mr3193647f8f.15.1744119852662; 
 Tue, 08 Apr 2025 06:44:12 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-30584761e65sm10993800a91.13.2025.04.08.06.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 06:44:12 -0700 (PDT)
Date: Tue, 08 Apr 2025 10:44:01 -0300
MIME-Version: 1.0
Message-Id: <20250408-fix_make_clean-v2-2-48f93c3dd0bf@suse.com>
References: <20250408-fix_make_clean-v2-0-48f93c3dd0bf@suse.com>
In-Reply-To: <20250408-fix_make_clean-v2-0-48f93c3dd0bf@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2747; i=rbm@suse.com;
 h=from:subject:message-id; bh=lYAEXO3WFB+/O2u3GrRpJ5By4lgi/xDIanaaAlVXavU=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn9Sgi7LU6DjfrmDCDD1sx0wdRuOZ1xeNpI1tRq
 js7gBhW8XaJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ/UoIgAKCRDJC4p8Y4ZY
 pt2GEACzxd8a1F2CX8KKfV2C1B01Ogc3BWKMU+spga+qWndwxY2t/uTDjAvJGAnm0IO53Nm1PvJ
 uUXbL+y1YJ+7TmcmHKzKmi1ek6megreITY8WmGgD0xuCBbcJdvUOIvXouusk6H/ktutKZeKWFE1
 2AixKf5hZkHgoZx+FNILGcUglLLY3yPc6jo6WqR+8Ek66lOhW1FwLsvOjlWTLmgeF6Ao3Nbvie/
 Eq+c7lKFijCES3XTI4SS+nB+8ds6lyfCUpK3X14THSESJXp60Xv5Ayvd7CUvFt41WsoJcUx8ICc
 pzI1f+3FJa3IIicz11obXnFQwQ6vw6XV4WA2lHizFM7sqRoGdSNey+u0VnZsDjQvGqpGs2IEkLL
 z6pnu3C70wa+iZifE7q7vHL0m/7tjiZ5sPTP3f4OTnH2aPBrNMz1fKNCVzhfIvVnPthJZRCrfgC
 LG/gJpJ6TXsdYEAJYIDkITBOg8VUrieJVXhFFVyseNWIYAodbntrU9PrKrZtG6cxvDC56kLv3Jd
 BYiKPi3aPNkNKumlWIUG9lJntB9pOTjx+hfot6RcjNP0WgMP8MMVAQ5xErRTLxDw9J8zWZdQICE
 WcX8RaiScksusl3ywvltmNHX1Gbl13T+sf0NhnnBNmgZpjWo9Ef96X+beLa1uhMHPMe00YQ2XYr
 A9Ce2FJjXst29sw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] include/Makefile: Fix cleaning targets
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCkFkZCBhYy1jbGVhbiB0
YXJnZXQgYXMgZGVwZW5kZW5jeSBvZiBhYy1tYWludGFpbmVyLWNsZWFuIGFuZCBhZGQgbWlzc2lu
ZwpmaWxlcyB0byB0aGUgcmVtb3ZhbCBsaXN0LiBUaGlzIHdheSB0aGUgcHJvamVjdCB0b3AgbGV2
ZWwgTWFrZWZpbGUgY2xlYW5pbmcKdGFyZ2V0cyBjYW4gbWFrZSB1c2Ugb2YgaXQuIEFsc28sIGFk
ZCAiY29tcGlsZSIgdG8gdGhlIEFVVE9NQUtFX0ZJTEVTCmxpc3QuCgpDYzogQW5kcmVhIENlcnZl
c2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KRml4ZXM6IDgxN2Q4MDk1ZmJmZSAoIlJl
bmFtZSBsaW51eF9zeXNjYWxsX251bWJlcnMuaCB0byBsYXBpL3N5c2NhbGxzLmgiKQpSZXZpZXdl
ZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+ClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8g
Qi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQoKTk9URTogVGhlICJjb21waWxlIiBmaWxl
IGlzIGFkZGVkIGR1cmluZyB0aGUgYXV0b3Rvb2xzIHRhcmdldDoKJCBtYWtlIGF1dG90b29scwo8
c25pcD4KY29uZmlndXJlLmFjOjI2OiBpbnN0YWxsaW5nICcuL2NvbXBpbGUnCmNvbmZpZ3VyZS5h
YzoyNDogaW5zdGFsbGluZyAnLi9jb25maWcuZ3Vlc3MnCmNvbmZpZ3VyZS5hYzoyNDogaW5zdGFs
bGluZyAnLi9jb25maWcuc3ViJwpjb25maWd1cmUuYWM6NzogaW5zdGFsbGluZyAnLi9pbnN0YWxs
LXNoJwpjb25maWd1cmUuYWM6NzogaW5zdGFsbGluZyAnLi9taXNzaW5nJwo8c25pcD4KLS0tCiBp
bmNsdWRlL01ha2VmaWxlICAgICAgIHwgNCArKy0tCiBpbmNsdWRlL21rL2F1dG9tYWtlLm1rIHwg
NiArKystLS0KIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvTWFrZWZpbGUgYi9pbmNsdWRlL01ha2VmaWxlCmluZGV4
IDI1ZTk2ZGY5YjhjZGQ3ZDFkN2U2ZjE5OTI1YmYyMTYwZDY4MmYwZDkuLjZiMzFiMDQ2ZTQ1MmU3
MWFmYjUwOTdjYzNmYWRmOGFmMDEyODI2MjkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvTWFrZWZpbGUK
KysrIGIvaW5jbHVkZS9NYWtlZmlsZQpAQCAtMTgsOCArMTgsOCBAQCBNQUtFX1RBUkdFVFMJCTo9
CiBkaXN0Y2xlYW46OiBjbGVhbiBhYy1kaXN0Y2xlYW4KIG1haW50YWluZXItY2xlYW46OiBkaXN0
Y2xlYW4gYWMtbWFpbnRhaW5lci1jbGVhbgogYWMtY2xlYW4gYWMtZGlzdGNsZWFuOjoKLQkkKFJN
KSAtZiBjb25maWcuaAotYWMtbWFpbnRhaW5lci1jbGVhbjo6CisJJChSTSkgLWYgY29uZmlnLmgg
bGFwaS9zeXNjYWxscy5oIHN0YW1wLWgxCithYy1tYWludGFpbmVyLWNsZWFuOjogYWMtY2xlYW4K
IAkkKFJNKSAtZiBjb25maWcuaC5pbgogCiB2cGF0aCAlLmggJChhYnNfc3JjZGlyKQpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9tay9hdXRvbWFrZS5tayBiL2luY2x1ZGUvbWsvYXV0b21ha2UubWsKaW5k
ZXggM2RmM2I0YmE5OWNhODY1Y2FhODkzODg5OTllNTNjYmM1MDA2MTVkYy4uYjBmZjk1ZmYwNzJj
NjFlMGQzNGI1YTMwODA2Mzg4OWI1ZTVlNmNkOCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9tay9hdXRv
bWFrZS5taworKysgYi9pbmNsdWRlL21rL2F1dG9tYWtlLm1rCkBAIC00NSw3ICs0NSw3IEBAIG00
L2x0cC12ZXJzaW9uLm00OiBWRVJTSU9OCiAJc2VkIC1uICcxe3M6TFRQLTptNF9kZWZpbmUoW0xU
UF9WRVJTSU9OXSxbOjtzOiQkOl0pOjtwO3F9JyAkPCA+ICRACiAKIC5QSE9OWTogYXV0b21ha2UK
LUFVVE9NQUtFX0ZJTEVTIDo9IGNvbmZpZy5ndWVzcyBjb25maWcuc3ViIGluc3RhbGwtc2ggbWlz
c2luZyBzdGFtcC1oMQorQVVUT01BS0VfRklMRVMgOj0gY29tcGlsZSBjb25maWcuZ3Vlc3MgY29u
ZmlnLnN1YiBpbnN0YWxsLXNoIG1pc3NpbmcKIGF1dG9tYWtlOiBhY2xvY2FsICQoQVVUT01BS0Vf
RklMRVMpCiAkKEFVVE9NQUtFX0ZJTEVTKTogbTQvTWFrZWZpbGUuaW4KIG00L01ha2VmaWxlLmlu
OiBtNC9NYWtlZmlsZS5hbSBhY2xvY2FsLm00CkBAIC01NSw4ICs1NSw4IEBAIG00L01ha2VmaWxl
LmluOiBtNC9NYWtlZmlsZS5hbSBhY2xvY2FsLm00CiBhYy1jbGVhbjo6CiAJJChSTSkgLXJmIGF1
dG9tNHRlLmNhY2hlCiAJJChSTSkgLWYgY29uZmlnLmxvZyBjb25maWcuc3RhdHVzCi0JJChSTSkg
LWYgaW5jbHVkZS9jb25maWcuaCBpbmNsdWRlL3N0YW1wLWgxCiAJJChSTSkgLWYgbTQvTWFrZWZp
bGUgbTQvbHRwLXZlcnNpb24ubTQKKwkkKE1BS0UpIC1DICIkKHRvcF9zcmNkaXIpL2luY2x1ZGUi
ICRAOwogCWZvciBkIGluICQoQVVUT0NPTkZFRF9TVUJESVJTKTsgZG8gXAogCSAgICAkKE1BS0Up
IC1DICIkKHRvcF9zcmNkaXIpLyQkZCIgJEA7IFwKIAlkb25lCkBAIC02Nyw3ICs2Nyw3IEBAIGFj
LW1haW50YWluZXItY2xlYW46OiBhYy1kaXN0Y2xlYW4KIAkgICAgJChNQUtFKSAtQyAiJCh0b3Bf
c3JjZGlyKS8kJGQiICRAOyBcCiAJZG9uZQogCSQoUk0pIC1mIGFjbG9jYWwubTQgY29uZmlndXJl
ICQoQVVUT01BS0VfRklMRVMpIG00L01ha2VmaWxlLmluCi0JJChSTSkgLWYgaW5jbHVkZS8qY29u
ZmlnLmguaW4KKwkkKE1BS0UpIC1DICIkKHRvcF9zcmNkaXIpL2luY2x1ZGUiICRAOwogCiAjIERv
bid0IGluY2x1ZGUgY29uZmlnLmgsIG9yIG1ha2Ugd2lsbCAocmlnaHRmdWxseSkgd2hpbmUgYWJv
dXQgb3ZlcnJpZGluZwogIyBydWxlcy4KCi0tIAoyLjQ5LjAKCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
