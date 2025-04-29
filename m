Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF26CC369DC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 10:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745923493; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=JQAS0NAXNlm78CXXUULdGEw/flpCxxTHW0/+hm1hbxQ=;
 b=RdC4mO6FmNFrrWQ5Dp/X0AA0o+sQSkF7GGRiFbkVVPqSBM0DCPtMaNzAMBMtIU8o9QzJ8
 6hTkzwvnyt3yv+uZTcd3O/Vlp/6+Xdespxyg7ER4NCqVOvoHskjIpkH+hK5g89a3LPh2iPC
 IF1tpzkoYcrVOhWbT5vAZugnGqwca0w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A7F93CBC18
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 12:44:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 635133C82FB
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 12:44:31 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2DA412000FE
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 12:44:30 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f62ef3c383so10855817a12.2
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 03:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745923469; x=1746528269; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PhhPBVxJF1VptTm/Bo6/FNuxPoXuKFKfq+NmvwpjmXY=;
 b=dWREBnBPtn08K2mFV1zzQW0AI9JJYHEzA1X9KZRkTVAqRpVmi8pNuW2BsO8F1f7Uay
 fdt6o/DwdyZrQAj5x4bFNR7a7daBsCg4+UKC1h3RGSwoszck2cllLpVQh9MbIUbaEby6
 WVIAsooM+Nk2lkIOA6tN1pWQQV9SlcR19XZJSyRtNhT6jEbZTxoEyCqTlgNAghZIpZMk
 RGVXtR8ufvgd0EuxLu78oEY7NjsP3vk90Qep/mTBXwv0OlLxqLixBL+dWL86gJn7I16W
 kNb5T2tQn+/20wGK4PJfVpdz2hYHeYGxd1Am33oxMV5wonzPbrxGANLtl7wwS38+B7Mc
 ufiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745923469; x=1746528269;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PhhPBVxJF1VptTm/Bo6/FNuxPoXuKFKfq+NmvwpjmXY=;
 b=CfXhI8kXW5RPyMm7JaUfgNpImhMGl3XFfnC1gI0Rg0Drb/uv6Q1SUWG0EiyNbGzNAK
 NUNW07hpK9GPmKPfzU1eziUtd5/uI9CWKEW6DL+eRE48z7HamDAbhYx8eK19bk/1uJDE
 EUNUQZvFs59gbUOkRZO2Cjq9SVhwt5ZTCb1GsqbCdfb2SJfVXkctoAbw/kKwvvNFu8dP
 U/We3JrBSQR9HQ1icoi+afF1XcywwO5veDSPDXTWVKKicmb8tJO6CX4Q4HUX2EBc6lnw
 Ayfqz3fB3RHPYShae6HX+R45qaOYK2pJqM/Zqzktvxbc6w+k0ipyjb6vNLri12PNTB9I
 mH8w==
X-Gm-Message-State: AOJu0YxXkADdgOvRO36qEi33wUh0kbr6ngmZwXOpwU0bH0fDGaocnYX/
 jKOyjNoxOv7/PGPwEyxPsa6XDVvAEE3ajK+R+MHR0U+6292LWHSV4czJS9Y6nXB0we+jnu0M02k
 Z
X-Gm-Gg: ASbGncsyLJH5n8wbaXf59fbU6V8+YE8nl/rQyw1DTSjLs17ZqzktUWHKCTivQlS5psD
 mFcyrqGs0E6jaMaeEGvqUuf37le9W6/8bwF8YLqnIjrkxOhJL1Vq/qYkNR0lc9qTCmRHSe2Jvts
 wDz57AdCDLnZ5XKh4hJFECgUdCi7OvgmofoGNU2uSwVa6NEK/4zdBdi/LI+83Dgnl1I3b+Vv5RN
 bZqIzNR+6sxI+PjZVvMDqfopWC2gLzUlHrtJN4+USz6q8BgPeCYvwPnPkXu4Vg+taX0YVNa9z9N
 r42K1+Fxf4RBRkj4bmaEElGUVO/L1w==
X-Google-Smtp-Source: AGHT+IFh7LQcIQAJZUa3FG2is2gJiFOKwuVEmhmR1aZFM2tl1gJz1OaiRUMcKfIrR1sdNVDDKIlhFg==
X-Received: by 2002:a17:907:3d4e:b0:ace:3c0b:1951 with SMTP id
 a640c23a62f3a-ace84aad6e5mr1210701566b.46.1745923469261; 
 Tue, 29 Apr 2025 03:44:29 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-309f77521cfsm8988672a91.14.2025.04.29.03.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 03:44:28 -0700 (PDT)
Date: Tue, 29 Apr 2025 07:44:22 -0300
Message-Id: <20250429-conversions-modify_ldt-v9-0-97e4664c25c5@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIatEGgC/43Qy0rFMBAG4Fc5ZG0k94sr30NEcpnagG0lqcXDo
 e9ucjaGQtHlwJ9vJv8NFcgJCnq63FCGLZW0zHWwDxcURje/A06xzogRJglnAodl3iC3WMHTEtN
 wffuIKzZUcWYZ44MCVB9/ZhjS9x1+ea2zdwWwz24OY+MmV1bILTimsi75ej9goy3+566NYoJNV
 NGwgRKtzHP5KvAYlgm1VRvrFX2qsKowS3QUsV4dyEHhvWJOFV6VQXkFQIOlQhwU8T9FVMVJAO1
 N/ZVzB0V2Cqenimy3RAWOCkutVAdF/SqCsFNFtV5AeAJMG03goOheOW9XVyV48FxbroiTB8X0y
 nkvpiraR+8oMYMSfS/7vv8Arctuwb4CAAA=
X-Change-ID: 20250324-conversions-modify_ldt-816329223f6e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3621; i=rbm@suse.com;
 h=from:subject:message-id; bh=i/hN3pUArrGrWP81w6Y9ZV2C2tdldZKYv/v1xAtqsyc=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoEK2I04FRlKodmlCWMF2Xw9MV29uf5C3PyXabQ
 9V3NFF8ESSJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaBCtiAAKCRDJC4p8Y4ZY
 pkLRD/0Xe9G4ZPw54MTSZn5bDvp9wz2ZfPEQR2xh4o7v5m4lHOUPZ1XnvpMVLI1pUAfXVYEGWua
 +Wjh0LNhk5+ObCCRlIoXAcpvi0qjBlRtldRXm/h09fBZcvJbSyzjQ+GilNa5LpDIUBt7U/vPeOk
 XgMPrQizrTsUrTOGXezHZ+RtBv19RcU4WDSpavqkWYJSmBGq9G2Vo2VsK5fVGj6bKI8js8GdIsU
 nmAMPI+OEc7rNCuxXt9Z0XsH5zrGhfIH6w2MwbMcMRRhqwjiesUGVvt3YtSxxjZGTXYaSKYmc2q
 TG2KOo8poT3C+al8Y18L8l7JGojhnka1s6vtaHrsMkmD6voJD7P9VAkxzMmFI+jpCMY7SKvUcyw
 0wD5t2AtNw90OYmWWdzRNziUimCAu74OFtfv6VrmK5PbNHZh653W5OYAJUHlHQsdBtPYYZrQqu4
 Y5FL8cKkDVhhCiZdMhQ4o4buQE3tcY5lUQgTnrdOCAuLzRy8GtL+h2mLDx0M3snSECTeKAa2Gg9
 35YGVJXZ+SdtcbI6tkRxt4GglZuC359GtKIzm/PesFFc02J+3efkMYH/sVDLWIVFq3sF08raI2L
 Wbjs0eGGF8Ct1+S0iwc4IZ0qaU/KRuX+EeoVSBC1dg0MfR8VJtHRd8fhTceJjx1hGHTmooeh3Ow
 8MxtB9G/Sqi7EAw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 0/3] syscalls/modify_ldt: Refactor into new API
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
YW5nZXMgaW4gdjk6Ci0gRml4ZWQgY2hlY2twYXRjaCB3YXJuaW5ncwotIExpbmsgdG8gdjg6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA0MDgtY29udmVyc2lvbnMtbW9kaWZ5X2xkdC12
OC0wLTdiZGJhMTA4ZjY0YUBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2ODoKLSBBZGRlZCBlbHNlIGJs
b2NrIHRvIGNhdGNoIGFsbCBvdGhlciBpbnZhbGlkIHJldCB2YWx1ZXMgaW4gc2FmZV9tb2RpZnlf
bGR0Ci0gUmVtb3ZlZCBtb2RpZnlfbGR0MDMgZnJvbSBydW50ZXN0L3N5c2NhbGxzCi0gTWFkZSBj
cmVhdGVfc2VnbWVudCBzdGF0aWMgaW5saW5lIHZvaWQKLSBTaW1wbGlmaWVkIG1vZGlmeV9sZHQw
MiBhcyBzaWduYWwoKSBpcyBub3QgbmVlZGVkCi0gTGluayB0byB2NzogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDI1MDQwNy1jb252ZXJzaW9ucy1tb2RpZnlfbGR0LXY3LTAtY2JlYjM3OTM2
MGE1QHN1c2UuY29tCgpDaGFuZ2VzIGluIHY3OgotIEFkZGVkIGJhY2sgdGhlIGNoZWNrIGZvciBh
c20vbGR0LmggaW4gY29uZmlndXJlLmFjCi0gQWRkZWQgYmFjayB0aGUgZmFsbGJhY2sgZGVmaW5p
dGlvbiBvZiBzdHJ1Y3QgdXNlcl9kZXNjCi0gTGluayB0byB2NjogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8yMDI1MDQwMi1jb252ZXJzaW9ucy1tb2RpZnlfbGR0LXY2LTAtMmU0YjBlMjc4NzBl
QHN1c2UuY29tCgpDaGFuZ2VzIGluIHY2OgotIFJlbW92ZWQgdW5uZWNlc3NhcnkgaW5jbHVkZXMK
LSBNYWRlIG1vZGlmeV9sZHQgd3JhcHBlcnMgc3RhdGljIGlubGluZQotIFVzZWQgY29uc3Qgc3Ry
dWN0IHVzZXJfZGVzYyAqcHRyIGluc3RlYWQgb2Ygdm9pZCAqcHRyIGluIG1vZGlmeV9sZHQoKQot
IEZpeGVkIG1vZGlmeV9sZHQwMSB0ZXN0IGRlc2NyaXB0aW9uCi0gQWRkZWQgZXhwbGFuYXRpb24g
b24gcmVtb3ZhbCBvZiAiYXNtL2xkdC5oIiBjaGVjayBpbiBjb21taXQgbWVzc2FnZQotIFJlbW92
ZWQgcnVuX2NoaWxkKCkgaW4gbW9kaWZ5X2xkdDAyIC0gaW5zdGVhZCwgcmVtb3ZlZCB1bnVzZWQg
ImludCB2YWwiCi0gUmVuYW1lZCAiZW50cnkiIHRvICJpbnZhbGlkX2VudHJ5IiBpbiBtb2RpZnlf
bGR0MDEKLSBMaW5rIHRvIHY1OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwMzMxLWNv
bnZlcnNpb25zLW1vZGlmeV9sZHQtdjUtMC1mZDZlYTE0OTE5NTZAc3VzZS5jb20KCkNoYW5nZXMg
aW4gdjU6Ci0gUmVtb3ZlZCB1bm5lY2Vzc2FyeSAjZXJyb3IKLSBSZW1vdmVkIGNvbnN0IHNwZWNp
ZmllciBpbiBjdmUtMjAxNS0zMjkwLmMKLSBJbXByb3ZlZCBtb2RpZnlfbGR0MDIgdGVzdCBkZXNj
cmlwdGlvbgotIEFkZGVkIHJ1bl9jaGlsZCgpIGluIG1vZGlmeV9sZHQwMgotIFJlbW92ZWQgdW5u
ZWNlc3NhcnkgI2luY2x1ZGUgImxhcGkvbGR0LmgiIGluIGZpbGVzIHRoYXQgaW5jbHVkZSBjb21t
b24uaAotIEV4dGVuZGVkIGNvdmVyYWdlIGluIG1vZGlmeV9sZHQwMQotIExpbmsgdG8gdjQ6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAzMjgtY29udmVyc2lvbnMtbW9kaWZ5X2xkdC12
NC0wLWE1ZWU3YjhkODJhYUBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2NDoKLSBSZS1hZGRlZCB0aGUg
YXNtL2xkdC5oIGluY2x1ZGUgZGlyZWN0aXZlCi0gTGluayB0byB2MzogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDI1MDMyOC1jb252ZXJzaW9ucy1tb2RpZnlfbGR0LXYzLTAtZjZiNmVlMWM5
MTQ0QHN1c2UuY29tCgpDaGFuZ2VzIGluIHYzOgotIERyb3BwZWQgdGhlIHNldF90aHJlYWRfYXJl
YTAxIHBhdGNoIGZvciBhIGxhdGVyIHNlcmllcwotIFNxdWFzaGVkIG1vZGlmeV9sZHQwMyBjb21t
aXQgaW50byBtb2RpZnlfbGR0MDEKLSBSZW5hbWVkIHN0cnVjdCB0c3RfY2FzZSB0byB0Y2FzZQot
IFJlbW92ZWQgZmFsbGJhY2sgZGVmaW5pdGlvbiBvZiBzdHJ1Y3QgdXNlcl9kZXNjCi0gTGluayB0
byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDMyNy1jb252ZXJzaW9ucy1tb2Rp
ZnlfbGR0LXYyLTAtMjkwN2Q0ZDNmNmMwQHN1c2UuY29tCgpDaGFuZ2VzIGluIHYyOgotIEFsc28g
cmVmYWN0b3JlZCBzZXRfdGhyZWFkX2FyZWEwMQotIE1lcmdlZCBzaW1wbGUgdGVzdHMgKGluY2x1
ZGluZyB0aGUgZXhpc3RpbmcgbW9kaWZ5X2xkdDAzKSBpbnRvCm1vZGlmeV9sZHQwMSBpbnN0ZWFk
IG9mIHNwbGl0dGluZyBpdAotIEFkZGVkIFNBRkVfTU9ESUZZX0xEVCgpIG1hY3JvCi0gUmVtb3Zl
ZCBjaGVjayB0byBhc20vbGR0LmggaW4gY29uZmlndXJlLmFjCi0gVXNlZCB0c3Rfc3lzY2FsbCgp
IGluc3RlYWQgb2Ygc3lzY2FsbCgpIGluIG1vZGlmeV9sZHQoKSBAIGxhcGkvbGR0LmgKLSBMaW5r
IHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwMzI0LWNvbnZlcnNpb25zLW1v
ZGlmeV9sZHQtdjEtMC04ZDZkODJmMTA3NjhAc3VzZS5jb20KCi0tLQpSaWNhcmRvIEIuIE1hcmxp
w6hyZSAoMyk6CiAgICAgIHN5c2NhbGxzL21vZGlmeV9sZHQ6IEFkZCBsYXBpL2xkdC5oCiAgICAg
IHN5c2NhbGxzL21vZGlmeV9sZHQwMjogUmVmYWN0b3IgaW50byBuZXcgQVBJCiAgICAgIHN5c2Nh
bGxzL21vZGlmeV9sZHQwMTogUmVmYWN0b3IgaW50byBuZXcgQVBJCgogaW5jbHVkZS9sYXBpL2xk
dC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNTkgKysrKysKIHJ1bnRlc3Qv
c3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxIC0KIHRlc3Rj
YXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jICAgICAgICAgICAgICAgICAgICAgIHwgIDI2ICstCiB0
ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE3LTE3MDUzLmMgICAgICAgICAgICAgICAgICAgICB8ICAgNiAr
LQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mb3JrL2ZvcmswNS5jICAgICAgICAgICAgfCAg
IDUgKy0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC8uZ2l0aWdub3JlICAg
IHwgICA1ICstCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQvY29tbW9uLmgg
ICAgICB8ICAzMCArKysKIC4uLi9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0
MDEuYyAgICAgIHwgMjY0ICsrKysrLS0tLS0tLS0tLS0tLS0tLQogLi4uL2tlcm5lbC9zeXNjYWxs
cy9tb2RpZnlfbGR0L21vZGlmeV9sZHQwMi5jICAgICAgfCAyMTUgKysrKy0tLS0tLS0tLS0tLS0K
IC4uLi9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0MDMuYyAgICAgIHwgMTA1
IC0tLS0tLS0tCiAxMCBmaWxlcyBjaGFuZ2VkLCAxOTMgaW5zZXJ0aW9ucygrKSwgNTIzIGRlbGV0
aW9ucygtKQotLS0KYmFzZS1jb21taXQ6IGVjN2ZiMzYxZTZkNDc4MTE1MmEwYzUwZjIwODk0NWMw
NzExYmNmMDgKY2hhbmdlLWlkOiAyMDI1MDMyNC1jb252ZXJzaW9ucy1tb2RpZnlfbGR0LTgxNjMy
OTIyM2Y2ZQoKQmVzdCByZWdhcmRzLAotLSAKUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNl
LmNvbT4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
