Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9A3C369C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 21:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745615287; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=ZFmlLtHMVGcbRjC+ZfXmto1/fTD3Uy2y//gXXZP7E8U=;
 b=hq/qsFd56HM22uB6F5+gIow8jH0huRy9WtGhQdL8XuczLOf9U4kGERBn+nhtDSSevwN35
 oKMhPd+xh86mlnaAYypWoZWkLxx/M0EvFEeARJbfREgzHao/rX3/0YebModGDl5iw3ZRoZV
 wKnPrKTCqbZ3rwJKD7+LIbFjrngz54g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C8CE3CBB7F
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 23:08:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BDA53CB9FA
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 23:07:44 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9BB4F20096B
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 23:07:43 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so1955615f8f.3
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745615262; x=1746220062; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1EQGhb5bUe5x6GEDk5J7aagMTWnBB+WW1mPSmIThGCs=;
 b=Fmq4ToZ/iWEZpg3ajD7tG39mPV7lSu/kV3VNX6Hh9csRabGfsvVmLIca9op2KEW8zZ
 yJHFmndMSO2fVDa+/PNt82YHUTJMwxwiZckqY8JecjsC1fh0GVIwTA41yHoDnK8JYLpQ
 r7uvSoq7UA99t16nhvuoMk0ICjRkd7qrKb3v3NcijRtYk37r7cdpDGQ0HF8O5T1CjFlk
 mxWOYi6o14PqLCRjv/eHzihOX2q1LXbyug7vaZunjAYDN8/dCpEVP0NV0SjJQkkyqIZZ
 DOVGrmhpUvNGF2daX+9J1RlPHdSBUR65SAPfhzNlDew+Es5QZy+mjwsINBw3MuRvq3J1
 xpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745615262; x=1746220062;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1EQGhb5bUe5x6GEDk5J7aagMTWnBB+WW1mPSmIThGCs=;
 b=wA1/cKM1HWE/TSKTt5jZWfmvGmMYrioG/uNOfk2JWBwy/uBhqpLdRmbvFrpPVwmTvf
 KPzm5O+FNnqIN1z1QRyd6Ax97SslUbMC/fkwdd90HqyR2sLkc/hBrMTh0Gk+yJvv543L
 ak91LdAKNZlQJ6lSf6Vqwg90jZdenoZYgaR3o3oxlz3/4XV3YKWTZsoQAjUW8ekH0E3+
 y3bWZiOK3VbtZ/BqB+pxcP0hWMIHg7qKcnhGveqTxYLSJumjryy75Jvs7myiFt9pS0ag
 3WeNamCvvjWOog4JC5r7mGXxl9TukIUaml/Ct3LTtfUAH8ZKn3GCBeY63r2GSV4Hcgb7
 E0KQ==
X-Gm-Message-State: AOJu0Yx3y/O0DluiDKPQArljhF2g4caU01v9OZ3lZ5yuWOH4CnEPdkgS
 XJHbckIBrrNX09iP/AEUHma94oP/PrXYqgLNVFUhvAuRFR6D65xyfWu8/M/i9GWjyyxvogahqIc
 d
X-Gm-Gg: ASbGnctXJ39zCdOM236NcON8SXsr93zWEEQRP4J91LicJezoQEWa0yOy0Vu9Xfyww+N
 Ak9D4DfPZ9PnGjwEmHLOrNX1pM5z0Ek6xDL3tz5E0KWxhDzD1kCmMwpcPqENY+o1zcr4wvjUfNY
 hhCeXSVE1RevFajfbZC4uEy6e5qh0/sJK48Xkox+ZSJ3lrws55I0oxKbn6rzUjcPvyofhEhMe6G
 l076qzHavjRJaLOJhbmR4OMiOmDKsRj1lVpm9SQhZtoOZwOlt0oMoH9V3NCzp3JqDzrZM7IiZUp
 XQ7ZwZl0w2S9gFc8mgl0JHUdUSu2ZAkBY6dFwsdm
X-Google-Smtp-Source: AGHT+IHk/uqjydR4k7ZIYuyMb9YH/R+jf/5eO7uhiY4YZXnpc2KbPIUf0EbowmxAwIQ+puoSWsGGnQ==
X-Received: by 2002:a05:6000:2584:b0:39e:f641:c43 with SMTP id
 ffacd0b85a97d-3a07adb233dmr510632f8f.53.1745615262229; 
 Fri, 25 Apr 2025 14:07:42 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db5101624sm37321055ad.171.2025.04.25.14.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:07:41 -0700 (PDT)
Date: Fri, 25 Apr 2025 18:07:37 -0300
MIME-Version: 1.0
Message-Id: <20250425-fix_make_clean-v4-1-65d28c11b4ef@suse.com>
X-B4-Tracking: v=1; b=H4sIAJj5C2gC/3XPSwrCMBAG4KtI1kbSpNXUlfcoIpNkYoO21aQWR
 Xp3xwcoiqt5wPcPc2UJY8DElpMrq0Pqu3h59ENGpWJSyEIoueA+nDcN7HBj9wgtHzIuuDYlOgn
 alXNYpVPCme0atp5O2CDfOhf6R0vSufalsso5YfyXVp+6/NGKNCgFOjfSoCg+9Ej8EDHi8RRS6
 B+PVfdMW0O7RR4cLf5+pbFYeI+ZRWkZoYgDpXQtmZxGAwm5idDa+p7SQOoxsudFSnodG8cbGNX
 mvlUBAAA=
X-Change-ID: 20250327-fix_make_clean-8e57ffe1ce2c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4310; i=rbm@suse.com;
 h=from:subject:message-id; bh=iKwryI+1yZMp58oHctaIIkswQGiKLOnkdySIh8d7St0=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoC/mazblg32OndrAjg/X2xZMfs0Sso6UkVnhtg
 EVeRdg1XVWJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaAv5mgAKCRDJC4p8Y4ZY
 psp4D/wMV4NsmBbDj2NmJ6Jux2JOmSbBAyE3BGNZ21VvaWB5R/eEgtXrcUl6fbvOL69eBUBSp0c
 Z120nSf2SW+31ZPe7QcNn14i8STOnh7s15qWsVoL0YuAulnl4Fk4o3Kqh251jP57T90Y7BXp8JO
 hffUctDSMHHhDaImsP5+ELZaksswRJUk9qsxhixdUwmrN/OdHb7OHI/ebIqTdmU0ROoS2khj5Dp
 yYnJGSrRtiwSRIhngk5H3mKmowua7s5TRnA2CrO9+Zuzn2/fjWMWGucgvRdFc71gl2P9M7GdU5M
 DmFNNbsjvCTuEzG9m4zYo1XzkFmTnmMllJ4VKv3AjlcjvaZOJo/Gn+E7LXGzzmGEJMBhkU0w1HZ
 En1Gk8xJEaF9rTC9jDDcDwa8QsDIP0ZNtFAO+FQMbtqRg/VB2AoYbDSYSqPdIle1PQiQ4H0J+1s
 OwwKpYLWD0isWGU5vfc4gnK2J/RZ7lEG5WhPiR98vssKeRTCnqd+7ZX51uovimEo8997j2G6Tkq
 XBQHLHxMiCMlWcmv31ptlSixlDxGvVfEFQVzLdZ4E4j3PJYWycf7Zzzg1xoN6ujrRCOWEHwmHez
 eyVhV8EP14RsLDL6bStNncxxRIM8BMsLU//pLdfEyWCLp+Bpaa7WBAT6R6Vo8nd1FUb8j2UueEz
 C2QNe9adValRp0g==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] include/Makefile: Fix cleaning targets
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
ZCAiY29tcGlsZSIgdG8gdGhlIEFVVE9NQUtFX0ZJTEVTCmxpc3QgYW5kIG1vdmUgc3RhbXAtaDEg
dG8gd2hlcmUgaXQncyBhY3R1YWxseSBjcmVhdGVkOiB3aXRoaW4gaW5jbHVkZS8KZGlyZWN0b3J5
LgoKRml4ZXM6IDgxN2Q4MDk1ZmJmZSAoIlJlbmFtZSBsaW51eF9zeXNjYWxsX251bWJlcnMuaCB0
byBsYXBpL3N5c2NhbGxzLmgiKQpSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+ClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0t
LQpDaGFuZ2VzIGluIHY0OgotIERlZmluZWQgJENMRUFOX1NVQkRJUlMKLSBGaXhlZCBnaXQgY29t
bWl0IG1lc3NhZ2UKLSBMaW5rIHRvIHYzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUw
NDA5LWZpeF9tYWtlX2NsZWFuLXYzLTAtYTMzYTg0YjJiZTA1QHN1c2UuY29tCgpDaGFuZ2VzIGlu
IHYzOgotIEFkZGVkICJpbmNsdWRlIiBkaXIgdG8gZXhpc3RpbmcgZm9yIGxvb3AgaW5zdGVhZCBv
ZiBhZGRpbmcgYSBuZXcgJChNQUtFKQogIGRpcmVjdGl2ZS4KLSBBZGRlZCBpdCBhbHNvIHRvIGBt
YWtlIGRpc3RjbGVhbmAgdGFyZ2V0LgotIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3IvMjAyNTA0MDgtZml4X21ha2VfY2xlYW4tdjItMC00OGY5M2MzZGQwYmZAc3VzZS5jb20K
CkNoYW5nZXMgaW4gdjI6Ci0gRHJvcHBlZCB0aGUgY29tbWl0IHRoYXQgYWRkZWQgZmlsZXMgdG8g
YWMtbWFpbnRhaW5lci1jbGVhbiB0YXJnZXQKCShUaGV5J3JlIGFscmVhZHkgaW4gQVVUT01BS0Vf
RklMRVMsIHRoYW5rcyBQLiBWb3JlbCEpCi0gQWRkZWQgImNvbXBpbGUiIGZpbGUgdG8gdGhlIEFV
VE9NQUtFX0ZJTEVTIGxpc3QKLSBBZGRlZCBtaXNzaW5nIGNhbGwgdG8gaW5jbHVkZS9NYWtlZmls
ZSB0byBhYy1tYWludGFpbmVyLWNsZWFuIHRhcmdldAotIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3IvMjAyNTAzMjctZml4X21ha2VfY2xlYW4tdjEtMC04YjllZDJhOGQ5NmFA
c3VzZS5jb20KLS0tCgpOT1RFOiBUaGUgImNvbXBpbGUiIGZpbGUgaXMgYWRkZWQgZHVyaW5nIHRo
ZSBhdXRvdG9vbHMgdGFyZ2V0OgokIG1ha2UgYXV0b3Rvb2xzCjxzbmlwPgpjb25maWd1cmUuYWM6
MjY6IGluc3RhbGxpbmcgJy4vY29tcGlsZScKY29uZmlndXJlLmFjOjI0OiBpbnN0YWxsaW5nICcu
L2NvbmZpZy5ndWVzcycKY29uZmlndXJlLmFjOjI0OiBpbnN0YWxsaW5nICcuL2NvbmZpZy5zdWIn
CmNvbmZpZ3VyZS5hYzo3OiBpbnN0YWxsaW5nICcuL2luc3RhbGwtc2gnCmNvbmZpZ3VyZS5hYzo3
OiBpbnN0YWxsaW5nICcuL21pc3NpbmcnCjxzbmlwPgotLS0KIGluY2x1ZGUvTWFrZWZpbGUgICAg
ICAgfCAgNCArKy0tCiBpbmNsdWRlL21rL2F1dG9tYWtlLm1rIHwgMTIgKysrKysrLS0tLS0tCiAy
IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL01ha2VmaWxlIGIvaW5jbHVkZS9NYWtlZmlsZQppbmRleCAyNWU5NmRmOWI4
Y2RkN2QxZDdlNmYxOTkyNWJmMjE2MGQ2ODJmMGQ5Li42YjMxYjA0NmU0NTJlNzFhZmI1MDk3Y2Mz
ZmFkZjhhZjAxMjgyNjI5IDEwMDY0NAotLS0gYS9pbmNsdWRlL01ha2VmaWxlCisrKyBiL2luY2x1
ZGUvTWFrZWZpbGUKQEAgLTE4LDggKzE4LDggQEAgTUFLRV9UQVJHRVRTCQk6PQogZGlzdGNsZWFu
OjogY2xlYW4gYWMtZGlzdGNsZWFuCiBtYWludGFpbmVyLWNsZWFuOjogZGlzdGNsZWFuIGFjLW1h
aW50YWluZXItY2xlYW4KIGFjLWNsZWFuIGFjLWRpc3RjbGVhbjo6Ci0JJChSTSkgLWYgY29uZmln
LmgKLWFjLW1haW50YWluZXItY2xlYW46OgorCSQoUk0pIC1mIGNvbmZpZy5oIGxhcGkvc3lzY2Fs
bHMuaCBzdGFtcC1oMQorYWMtbWFpbnRhaW5lci1jbGVhbjo6IGFjLWNsZWFuCiAJJChSTSkgLWYg
Y29uZmlnLmguaW4KIAogdnBhdGggJS5oICQoYWJzX3NyY2RpcikKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbWsvYXV0b21ha2UubWsgYi9pbmNsdWRlL21rL2F1dG9tYWtlLm1rCmluZGV4IDNkZjNiNGJh
OTljYTg2NWNhYTg5Mzg4OTk5ZTUzY2JjNTAwNjE1ZGMuLmE1OGY0MDQyNDU3YzZjMjk3Y2RkYTgz
OGYzMmYyMWE5OThkOTYyMzAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbWsvYXV0b21ha2UubWsKKysr
IGIvaW5jbHVkZS9tay9hdXRvbWFrZS5tawpAQCAtMTMsNiArMTMsOCBAQCBBVVRPTUFLRQk/PSBh
dXRvbWFrZQogQVVUT0NPTkZFRF9TVUJESVJTCT0gXAogCQkJdGVzdGNhc2VzL29wZW5fcG9zaXhf
dGVzdHN1aXRlCiAKK0NMRUFOX1NVQkRJUlMgPSAkKEFVVE9DT05GRURfU1VCRElSUykgaW5jbHVk
ZQorCiAjIFdlIHdhbnQgdG8gcnVuIHRoaXMgZXZlcnkgc2luZ2xlIHRpbWUgdG8gZW5zdXJlIHRo
YXQgYWxsIG9mIHRoZSBwcmVyZXEgZmlsZXMKICMgYXJlIHRoZXJlLgogLlBIT05ZOiB0ZXN0Y2Fz
ZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZmlndXJlCkBAIC00NSw3ICs0Nyw3IEBAIG00L2x0
cC12ZXJzaW9uLm00OiBWRVJTSU9OCiAJc2VkIC1uICcxe3M6TFRQLTptNF9kZWZpbmUoW0xUUF9W
RVJTSU9OXSxbOjtzOiQkOl0pOjtwO3F9JyAkPCA+ICRACiAKIC5QSE9OWTogYXV0b21ha2UKLUFV
VE9NQUtFX0ZJTEVTIDo9IGNvbmZpZy5ndWVzcyBjb25maWcuc3ViIGluc3RhbGwtc2ggbWlzc2lu
ZyBzdGFtcC1oMQorQVVUT01BS0VfRklMRVMgOj0gY29tcGlsZSBjb25maWcuZ3Vlc3MgY29uZmln
LnN1YiBpbnN0YWxsLXNoIG1pc3NpbmcKIGF1dG9tYWtlOiBhY2xvY2FsICQoQVVUT01BS0VfRklM
RVMpCiAkKEFVVE9NQUtFX0ZJTEVTKTogbTQvTWFrZWZpbGUuaW4KIG00L01ha2VmaWxlLmluOiBt
NC9NYWtlZmlsZS5hbSBhY2xvY2FsLm00CkBAIC01NSwxOSArNTcsMTcgQEAgbTQvTWFrZWZpbGUu
aW46IG00L01ha2VmaWxlLmFtIGFjbG9jYWwubTQKIGFjLWNsZWFuOjoKIAkkKFJNKSAtcmYgYXV0
b200dGUuY2FjaGUKIAkkKFJNKSAtZiBjb25maWcubG9nIGNvbmZpZy5zdGF0dXMKLQkkKFJNKSAt
ZiBpbmNsdWRlL2NvbmZpZy5oIGluY2x1ZGUvc3RhbXAtaDEKIAkkKFJNKSAtZiBtNC9NYWtlZmls
ZSBtNC9sdHAtdmVyc2lvbi5tNAotCWZvciBkIGluICQoQVVUT0NPTkZFRF9TVUJESVJTKTsgZG8g
XAorCWZvciBkIGluICQoQ0xFQU5fU1VCRElSUyk7IGRvIFwKIAkgICAgJChNQUtFKSAtQyAiJCh0
b3Bfc3JjZGlyKS8kJGQiICRAOyBcCiAJZG9uZQogCiBhYy1kaXN0Y2xlYW46OiBhYy1jbGVhbgog
YWMtbWFpbnRhaW5lci1jbGVhbjo6IGFjLWRpc3RjbGVhbgotCWZvciBkIGluICQoQVVUT0NPTkZF
RF9TVUJESVJTKTsgZG8gXAorCWZvciBkIGluICQoQ0xFQU5fU1VCRElSUyk7IGRvIFwKIAkgICAg
JChNQUtFKSAtQyAiJCh0b3Bfc3JjZGlyKS8kJGQiICRAOyBcCiAJZG9uZQogCSQoUk0pIC1mIGFj
bG9jYWwubTQgY29uZmlndXJlICQoQVVUT01BS0VfRklMRVMpIG00L01ha2VmaWxlLmluCi0JJChS
TSkgLWYgaW5jbHVkZS8qY29uZmlnLmguaW4KIAogIyBEb24ndCBpbmNsdWRlIGNvbmZpZy5oLCBv
ciBtYWtlIHdpbGwgKHJpZ2h0ZnVsbHkpIHdoaW5lIGFib3V0IG92ZXJyaWRpbmcKICMgcnVsZXMu
CkBAIC04Miw3ICs4Miw3IEBAIEFVVE9HRU5FUkFURURfRklMRVMJPSBcCiAJCQltNC9NYWtlZmls
ZQogCiBkaXN0Y2xlYW46OiAlOiBjbGVhbiBhYy1kaXN0Y2xlYW4KLQlmb3IgZCBpbiAkKEFVVE9D
T05GRURfU1VCRElSUyk7IGRvIFwKKwlmb3IgZCBpbiAkKENMRUFOX1NVQkRJUlMpOyBkbyBcCiAJ
ICAgICQoTUFLRSkgLUMgIiQodG9wX3NyY2RpcikvJCRkIiAkQDsgXAogCWRvbmUKIAkkKFJNKSAt
ZiAkKEFVVE9HRU5FUkFURURfRklMRVMpCgotLS0KYmFzZS1jb21taXQ6IGMxMjM4Nzg3NmE0MDgz
N2FhOTNhYWM2ZTUwMzMxNzA1ZWQwZmYzOTMKY2hhbmdlLWlkOiAyMDI1MDMyNy1maXhfbWFrZV9j
bGVhbi04ZTU3ZmZlMWNlMmMKCkJlc3QgcmVnYXJkcywKLS0gClJpY2FyZG8gQi4gTWFybGnDqHJl
IDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
