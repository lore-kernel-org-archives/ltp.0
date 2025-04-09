Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF4BC36002
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744216700; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xLST/qUC6MMUf9VS0CPOHD8B+gIYVkRkHx9gVYM9gZU=;
 b=RjLA7oMjVUCRblmEWIbwmliXCGfppLDr6txuIbn9k9t9cdBr5xdisXyfOEj8Rgx9969Jo
 8/vay+mKIM64M0Xwib5NJ7753qGfl3uqig6g7kIsodB9TDv5mmuvCn4MLDDVOyF60s0gsMY
 aHfCDNs4BS9Z1hRy2QiZxKLHmqXwnhQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE9C13CB429
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 18:38:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 701633CB417
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 18:37:17 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 46928140077E
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 18:37:16 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so3857692f8f.3
 for <ltp@lists.linux.it>; Wed, 09 Apr 2025 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744216636; x=1744821436; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LxRqfvmn6EdCweF0fTuCjSUq2oXWiD2bIm3qCpnA+HE=;
 b=fPQhbEGwQSePdF8uQmxbFzz7cE+6BcSORQch0h4ntjhShbuZ3QX6sYj0LAKOWDZpn/
 yFrYLBfkUYgWy8hr7pBYtHbQstn+PPVuq2zIE+vivTz/ILBOEucwMI2T1QIHfeMIzGaT
 YDSmzBiBasy+aaiLgIPwtfJbmh1Qie9yqsRUrFFCwlDHVpzW/Yj7OQxKXsSFXF4KazAf
 gWOdR3f351rpCc4/v177HcQwEXnKN+MK8ef6USrSP3rz53LXNzNTcYsIsjdvaVV3dUZu
 tJ/1hKKbjN4Iit8/c3LPEptqQPrcsR0wyrzOTF8OIm9E3pxCNJIbbLD6O3Y0a5vpjsuq
 J/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744216636; x=1744821436;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LxRqfvmn6EdCweF0fTuCjSUq2oXWiD2bIm3qCpnA+HE=;
 b=aOGnvGmSsiX3tMfSJj1lNOoi1bmuqQpew80kTIX/f8qihvct9AiP4Iwjm4a7haEzca
 1KOSSOgdQMF920v+1ZXoOG7E2Wb+Hvq7HjMXPnSImOqAZYRRa0uPHcuU5eGcE0SnA9Fq
 m4QQAivYQxGJXf5rL6gewFP6fNM8UOJwCFNNX+dHylUruZHMUhkZhtkumXzKf8WAo6C2
 0EnF9UvEJfKkUUn3tei3tTwhh/aSaFlSw6G2fLsSsgEl7GFBbvP1goVJVSzc01ha/wUX
 DtBFSOi8BnN9cg2qC4jptjUeacpFx2VdyPv3kmqQntdXaLNvq1CMwbVYALTCy7DDGQdT
 OCMQ==
X-Gm-Message-State: AOJu0Yzd8EORjfC+zDq7qBspYMx6z33vGuaHo1bCqbSwk+3P0x+WNX+b
 ozKdb1zdnwp0GBOWiMcMJ5i5xnQhlANtk4HD/MHuaaKAb7bFk5Hi9yVSg9giSPm7y5xFjx8q5cH
 N
X-Gm-Gg: ASbGncuPQIeEUPI3NS9XGTDpSvOu2iGiNYoZDUVyZV8q5MkzoAzfR2eUaCAaXyaaSjR
 UZfRQ0nlIZU/oKXWrhx0goNciEpe9vuyuwKik4n4hpiNZoiHm59n/ZYC5BhUGldhB8vDzaZSRjJ
 BXhUBRHXD0tRtx0USCwpqZn7BF5KlbyXU8CgZ/Q5AHxZbPKRHhmMdsjAlRNnlM35QL5DOuEib/5
 hUtDGoZWCww7SkzzBpZSxGVB7o2uyTzaj6tM5XyqArorE9icwyeOvEZgBFke+s1uP1wX+DLB22F
 o9Pxicbq349qNFiIoJddHq1QQBTjBw==
X-Google-Smtp-Source: AGHT+IFeHTSbadk+r0AbZClo4Czjz/uKAVxzjnFs6L9Tq0VwPn9hXJ7s/13H7Lv+aLZ66xmM7kz1iQ==
X-Received: by 2002:a05:6000:2411:b0:391:4095:49b7 with SMTP id
 ffacd0b85a97d-39d885391c9mr2912853f8f.25.1744216635672; 
 Wed, 09 Apr 2025 09:37:15 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-306df400a21sm1681943a91.42.2025.04.09.09.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 09:37:15 -0700 (PDT)
Date: Wed, 09 Apr 2025 13:36:56 -0300
MIME-Version: 1.0
Message-Id: <20250409-fix_make_clean-v3-2-a33a84b2be05@suse.com>
References: <20250409-fix_make_clean-v3-0-a33a84b2be05@suse.com>
In-Reply-To: <20250409-fix_make_clean-v3-0-a33a84b2be05@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093; i=rbm@suse.com;
 h=from:subject:message-id; bh=Yad8hGVChV2ofN2BYKJBTfPvf7vQTgCCJAZl/be+Ytk=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn9qIxOC2rrdjSH1YosxNkkh+xa40NUN5FnIDjD
 oRXQAEeyTWJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ/aiMQAKCRDJC4p8Y4ZY
 pid+EACgdfp4K/yEbL3QuNKH24gulaE6g30oxop8uktEx1vEDJoasZM0XVcBB6FdjXas0PK7m5B
 IHsdPWRdgHCwhpfNd3vb75tf71P+iGrU0PsDyDedBaU0okqZT4w3IxWWRfCX64eYJZYt2xAgRiO
 sEIZL5FaWOuqycp8+1w+HDU4sV/noYerPD0JQROcyKwVM51oi2f6rfUczCMr9iKI1vA9Mb4VDWE
 R1sCj424vK73nWWJPA22hNFZiPwDN37Ciuck9mJsK8uxcbQ0MwQHvPHQAsXmf8MwC7H1cg/6mV8
 l+nRdHHWUTWwIuDj1OBtoGKvULbz7RSodKQXI5aJaoPwe2e8srf/WLAjZ0qPKvRPYRqBhbRS46S
 c5PG6bv3Xx4p5XyjCkJOv6qMnAVUDsk5OptA8cvkzVdXYixIqctQXzW5WK6bso+5jIlNaOBDiKb
 dJjuv4geWUmwfv6S8BBr659CNQ2lBLQYFgj+/YBbG6Jph1l8rYFCmwTugv4UfW7Uw7Vip3S1WPY
 FD2ZbiBBAbMqmzqAnSMyAcoEGCg5oFiHEx0RV7MgGx8r6WAdA/+z95EaMMJee17FwqUleMRefbE
 bDCL4kynATjK/1U15zipGoHGO/w6PdA8GNANL0VG6XGu+h2EI0jK3s0nf96xfpoPQa+/kwvobAJ
 WoNzXvdq2ExUJNg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] include/Makefile: Fix cleaning targets
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
bmNsdWRlL01ha2VmaWxlICAgICAgIHwgIDQgKystLQogaW5jbHVkZS9tay9hdXRvbWFrZS5tayB8
IDEwICsrKystLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvTWFrZWZpbGUgYi9pbmNsdWRlL01ha2VmaWxl
CmluZGV4IDI1ZTk2ZGY5YjhjZGQ3ZDFkN2U2ZjE5OTI1YmYyMTYwZDY4MmYwZDkuLjZiMzFiMDQ2
ZTQ1MmU3MWFmYjUwOTdjYzNmYWRmOGFmMDEyODI2MjkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvTWFr
ZWZpbGUKKysrIGIvaW5jbHVkZS9NYWtlZmlsZQpAQCAtMTgsOCArMTgsOCBAQCBNQUtFX1RBUkdF
VFMJCTo9CiBkaXN0Y2xlYW46OiBjbGVhbiBhYy1kaXN0Y2xlYW4KIG1haW50YWluZXItY2xlYW46
OiBkaXN0Y2xlYW4gYWMtbWFpbnRhaW5lci1jbGVhbgogYWMtY2xlYW4gYWMtZGlzdGNsZWFuOjoK
LQkkKFJNKSAtZiBjb25maWcuaAotYWMtbWFpbnRhaW5lci1jbGVhbjo6CisJJChSTSkgLWYgY29u
ZmlnLmggbGFwaS9zeXNjYWxscy5oIHN0YW1wLWgxCithYy1tYWludGFpbmVyLWNsZWFuOjogYWMt
Y2xlYW4KIAkkKFJNKSAtZiBjb25maWcuaC5pbgogCiB2cGF0aCAlLmggJChhYnNfc3JjZGlyKQpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9tay9hdXRvbWFrZS5tayBiL2luY2x1ZGUvbWsvYXV0b21ha2Uu
bWsKaW5kZXggM2RmM2I0YmE5OWNhODY1Y2FhODkzODg5OTllNTNjYmM1MDA2MTVkYy4uM2IyNDhh
Yzk1NzVhNjEzYzY5NWRlN2VjMjJjNDI3ZDRlOTdkYTM5ZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9t
ay9hdXRvbWFrZS5taworKysgYi9pbmNsdWRlL21rL2F1dG9tYWtlLm1rCkBAIC00NSw3ICs0NSw3
IEBAIG00L2x0cC12ZXJzaW9uLm00OiBWRVJTSU9OCiAJc2VkIC1uICcxe3M6TFRQLTptNF9kZWZp
bmUoW0xUUF9WRVJTSU9OXSxbOjtzOiQkOl0pOjtwO3F9JyAkPCA+ICRACiAKIC5QSE9OWTogYXV0
b21ha2UKLUFVVE9NQUtFX0ZJTEVTIDo9IGNvbmZpZy5ndWVzcyBjb25maWcuc3ViIGluc3RhbGwt
c2ggbWlzc2luZyBzdGFtcC1oMQorQVVUT01BS0VfRklMRVMgOj0gY29tcGlsZSBjb25maWcuZ3Vl
c3MgY29uZmlnLnN1YiBpbnN0YWxsLXNoIG1pc3NpbmcKIGF1dG9tYWtlOiBhY2xvY2FsICQoQVVU
T01BS0VfRklMRVMpCiAkKEFVVE9NQUtFX0ZJTEVTKTogbTQvTWFrZWZpbGUuaW4KIG00L01ha2Vm
aWxlLmluOiBtNC9NYWtlZmlsZS5hbSBhY2xvY2FsLm00CkBAIC01NSwxOSArNTUsMTcgQEAgbTQv
TWFrZWZpbGUuaW46IG00L01ha2VmaWxlLmFtIGFjbG9jYWwubTQKIGFjLWNsZWFuOjoKIAkkKFJN
KSAtcmYgYXV0b200dGUuY2FjaGUKIAkkKFJNKSAtZiBjb25maWcubG9nIGNvbmZpZy5zdGF0dXMK
LQkkKFJNKSAtZiBpbmNsdWRlL2NvbmZpZy5oIGluY2x1ZGUvc3RhbXAtaDEKIAkkKFJNKSAtZiBt
NC9NYWtlZmlsZSBtNC9sdHAtdmVyc2lvbi5tNAotCWZvciBkIGluICQoQVVUT0NPTkZFRF9TVUJE
SVJTKTsgZG8gXAorCWZvciBkIGluICQoQVVUT0NPTkZFRF9TVUJESVJTKSBpbmNsdWRlOyBkbyBc
CiAJICAgICQoTUFLRSkgLUMgIiQodG9wX3NyY2RpcikvJCRkIiAkQDsgXAogCWRvbmUKIAogYWMt
ZGlzdGNsZWFuOjogYWMtY2xlYW4KIGFjLW1haW50YWluZXItY2xlYW46OiBhYy1kaXN0Y2xlYW4K
LQlmb3IgZCBpbiAkKEFVVE9DT05GRURfU1VCRElSUyk7IGRvIFwKKwlmb3IgZCBpbiAkKEFVVE9D
T05GRURfU1VCRElSUykgaW5jbHVkZTsgZG8gXAogCSAgICAkKE1BS0UpIC1DICIkKHRvcF9zcmNk
aXIpLyQkZCIgJEA7IFwKIAlkb25lCiAJJChSTSkgLWYgYWNsb2NhbC5tNCBjb25maWd1cmUgJChB
VVRPTUFLRV9GSUxFUykgbTQvTWFrZWZpbGUuaW4KLQkkKFJNKSAtZiBpbmNsdWRlLypjb25maWcu
aC5pbgogCiAjIERvbid0IGluY2x1ZGUgY29uZmlnLmgsIG9yIG1ha2Ugd2lsbCAocmlnaHRmdWxs
eSkgd2hpbmUgYWJvdXQgb3ZlcnJpZGluZwogIyBydWxlcy4KQEAgLTgyLDcgKzgwLDcgQEAgQVVU
T0dFTkVSQVRFRF9GSUxFUwk9IFwKIAkJCW00L01ha2VmaWxlCiAKIGRpc3RjbGVhbjo6ICU6IGNs
ZWFuIGFjLWRpc3RjbGVhbgotCWZvciBkIGluICQoQVVUT0NPTkZFRF9TVUJESVJTKTsgZG8gXAor
CWZvciBkIGluICQoQVVUT0NPTkZFRF9TVUJESVJTKSBpbmNsdWRlOyBkbyBcCiAJICAgICQoTUFL
RSkgLUMgIiQodG9wX3NyY2RpcikvJCRkIiAkQDsgXAogCWRvbmUKIAkkKFJNKSAtZiAkKEFVVE9H
RU5FUkFURURfRklMRVMpCgotLSAKMi40OS4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
