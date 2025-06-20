Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E58BC71155
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 09:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750412524; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=mXcs4GobF8yyjMtpjlCO4TMmXbc79uowDsoh4aY7a8I=;
 b=Yg2QpLJLfxhpYucfubbae4zhUC2E8ZT670BoyMdlDxyb1fBkWHFe0pWgwwsD65Be47ix+
 6CRzLsg5jYkeQW+0oY2bTHTEjLZwsoFn4FQMqgvLTeU9IA+swrhEvgi0BjmBVDtIyqATiKa
 93wCDPIuUa+9okpbAQoIP4af6krWlh4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12B733CC85E
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 11:42:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE90D3CC83A
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 11:41:42 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C565D600AFC
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 11:41:41 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4fea34e07so821111f8f.1
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750412501; x=1751017301; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/1oA0Pv5FFQiJL/n2un1NtTVV+9Z6fi0uuGsZvcH5Bo=;
 b=YXJitsdNYLGqey41h/Rzwcq+uOE4vjwN50VsZ0EumGuV7S6Y/e/doNTdg3o1P5hX0z
 UT7Ai4KNn/ouEY21MO+B9AMbDmSuQLeO/8uXKV3ERrupl2HR+14MGvF5VGpJBZ0wxDkz
 vKsw0d6UAwa108pFJFOlV14LQCLZEILe3UfYzafQvmxvzCjGpIIAzzhdBYpdMxQ8Ioe2
 Bz7elZD3XfvXBDSnuVRJMebAn15Nf7cOjyTNrR1JyhbEtOhHYo5tqbibS3jRwjZLXuCU
 3BKyxPGk7PF54jbL+GPic6TQ6XhyeeBgtgwiQoK67KCjzaS3uML8hjmEbuLhLER5329c
 514A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750412501; x=1751017301;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/1oA0Pv5FFQiJL/n2un1NtTVV+9Z6fi0uuGsZvcH5Bo=;
 b=vVeV4n5KvYoqN+buhC1zuNwDj5fiSyrs7k+j1tVW63KNqLGGNWkopxiRvsYEkRha+f
 JHCQ5RMnTq0dwOxDhLz98I6sPD+NgGl1le2B+e9DEawCuVkwMtECvzoanfNt3Xx4wgXY
 ItqQsYgTEXx+WvjzlH2gU8v0WoNiTOOAY42Kn5lMevWFOrh7vAkZqQfexAZxf4wbH1K+
 SBS3Co6WrhM2j/GrAdwhfGCAK2paD1w9g4DqGkhBGs2//fRKWxBaNtND6VV6lwjKpaUL
 9sUtZLAt7uGcecPzcJiMEg0S/983eHnUd/ESfcBQ1baOnXbUTyT9gtR5VhKIEITPbEOG
 px+A==
X-Gm-Message-State: AOJu0YwDc6Dh9Ib3b84+VJsi5/7jr7GiZF8wfr2CPWuxUGmWBF3YnKiT
 X7BWG4ix/3BIDlnlEDqSkJFpLXvoS1chpibYX8ZRzYT/QsHfzFKzxBBOzBLgXdmqPLfqpLt/AYB
 tBfTo
X-Gm-Gg: ASbGncv+6xWtGN56lz2W8lXq357upNwOnO7blwUv02JU5k3Q1splVvGA4zw7V7Xgei+
 1FgB5VJmw1YDQFwCynDuqcOATs6vAH8TYtCPgn81vXCfpT5HBjdDlUUFk4MNpje/zdf056BuuBG
 nudy5nlJxgfKsmMPMw4eW4Q4qnoNbe6t1Tly3wwiADGuqyAco2QRsMn/+ML923U9YtlorXuVGTe
 M8PvfIq9FYtT8U2AVne8D6/1HnraS8DfqOQ0+1fl8m/BXUCfYMgj5i8S3D0ryIRDuQUkbHXClPW
 FuriB1VBkK9ySxfIrSUUwzux5GDGNEPM1xbB/IlZrtXgKnn1jQ==
X-Google-Smtp-Source: AGHT+IHKeD0rXNA2gqbDIdgrtkIhaj3AwEcJZL2qTFlQhN+ZTN3l9CPcMzCu4s2PJoUnIs1OQTTTew==
X-Received: by 2002:a5d:5f91:0:b0:3a4:dd00:9af3 with SMTP id
 ffacd0b85a97d-3a6d12ecb03mr1985805f8f.56.1750412500715; 
 Fri, 20 Jun 2025 02:41:40 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7490a6903a6sm1598904b3a.151.2025.06.20.02.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 02:41:40 -0700 (PDT)
Date: Fri, 20 Jun 2025 06:41:33 -0300
MIME-Version: 1.0
Message-Id: <20250620-conversions-shmt-v2-1-56cae20e184f@suse.com>
X-B4-Tracking: v=1; b=H4sIAMwsVWgC/32NQQ7CIBBFr2JYO6bUjLauvIfpYqBTYVEwTCWap
 ncXegCXL3n//VUJJ8+ibodVJc5efAwF2uNBWUfhyeDHwqptWmwuugMbQ+ZUNQFx8wLIhIRsGJF
 Vmb0ST/6zJx9DYUPCYBIF62poJlk4VdF5WWL67tdZV/3PS9agAU1/xunaYU/jXd7CJxtnNWzb9
 gPGNnwwyAAAAA==
X-Change-ID: 20250618-conversions-shmt-5ea5a5ebe55e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4612; i=rbm@suse.com;
 h=from:subject:message-id; bh=gobRNJHLCrkxAJyR3yeIqtwXzOZzARyd7/mNpQpngKM=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoVSzQKPC3qSVqLQNLSr4zmqbxlov9Zjq5DdMGE
 RB61SvaCFCJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaFUs0AAKCRDJC4p8Y4ZY
 pkuGD/oCkYEYOksDQRb5toyXKLNzvrY51TBCoRU9pImpQEcb9r57PptnZt/RkBbMf5/4N7hQOUi
 RC3H+gau9ByY3Mb4mbMkhGxhFT7V1PrjpoT0L/FZ+odig1JDfciiDWnGerSE3C7VgGow285oipi
 4anwdQ6TmeXD1PmpI8H08vpemj+kDqTBz5t550CXYGfReI5DAzNuFhw/a2cWe5HUfEjqhhw4R5q
 4ymW5IpeMNUO9Y1Ek+gEg0q3YCXZ4HOICTocpGndsGiR/G12zJGFkgJeDujUUbIPoNxECsdI0pw
 dzlK8N2FgMaeMQKcRaT4H8RbI2YNvTlqqYZ4WBjTSgHxP6SQB+YbmUbxHCsz2ha+/RlNcS9+QEc
 awW55skHzNplqbLLCjcOWowSD/g3pFb6QP1KP4kAccGdgEBeWUN4zLDjITCigAe9y5xWRJDKDOc
 LI4C0n6Er2GbXOkIN7byg8l8j97P1cRA7luxoANOvCOUcyBg0VwbPNKjSIYt81XECKl5v9yS71w
 PEGYI4eIGqXggPNf8+VgfMNb1eTjKUJQgaK2QcSqc3aOYoD9sywD2/7B6kHMdbeo84XFWPF/jzR
 4ebbb9FKSFKIaW2FTW9TvB3dh/FjUkeocqscd0wKrf4A5+MVuZWyo9YTcfVri9PkVgQDZJXfW8u
 G2GnYvFIfRpH58Q==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mem: Convert shmt02 to new API
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClNpZ25lZC1vZmYtYnk6
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQpDaGFuZ2VzIGluIHYyOgot
IFVzZSB0c3RfcmFuZF9kYXRhIGFuZCBUU1RfRVhQX0VRX1NUUk4oKQotIExpbmsgdG8gdjE6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA2MTgtY29udmVyc2lvbnMtc2htdC12MS0xLTVi
OTM1Zjc4NTlhZEBzdXNlLmNvbQotLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDAy
LmMgfCAxMjAgKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDk5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDAyLmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9z
aG10L3NobXQwMi5jCmluZGV4IGIzM2EwNDJmOTM2MjVjZjQ0YWYxYzNkZTYzNTQyNDg5MTlmMjE1
MjIuLmU5NDRhY2VjZTlkNzYzNTY0ODhhNzQ1MzMzNzU0NjE5ZGFlZGY2MDMgMTAwNjQ0Ci0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDAyLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9tZW0vc2htdC9zaG10MDIuYwpAQCAtMSwxMjAgKzEsNDIgQEAKKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCiAvKgotICoKLSAqICAgQ29weXJpZ2h0IChjKSBJ
bnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwMgotICoKLSAqICAgVGhp
cyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7ICB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQv
b3IgbW9kaWZ5Ci0gKiAgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5Ci0gKiAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5k
YXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCi0gKiAgIChhdCB5b3Vy
IG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCi0gKgotICogICBUaGlzIHByb2dyYW0gaXMgZGlz
dHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKLSAqICAgYnV0IFdJ
VEhPVVQgQU5ZIFdBUlJBTlRZOyAgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9m
Ci0gKiAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9T
RS4gIFNlZQotICogICB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0
YWlscy4KLSAqCi0gKiAgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCi0gKiAgIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyAg
aWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQotICogICBGb3VuZGF0aW9uLCBJbmMu
LCA1MSBGcmFua2xpbiBTdHJlZXQsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BIDAyMTEwLTEzMDEg
VVNBCisgKiBDb3B5cmlnaHQgKGMpIEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgIENv
cnAuLCAyMDAyCisgKgkxMi8yMC8yMDAyCVBvcnQgdG8gTFRQCXJvYmJpZXdAdXMuaWJtLmNvbQor
ICoJMDYvMzAvMjAwMQlQb3J0IHRvIExpbnV4CW5zaGFyb2ZmQHVzLmlibS5jb20KKyAqIENvcHly
aWdodCAoYykgMjAyNSBTVVNFIExMQyBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29t
PgogICovCiAKLS8qIDEyLzIwLzIwMDIJCSBQb3J0IHRvIExUUAkJIHJvYmJpZXdAdXMuaWJtLmNv
bSAqLwotLyogMDYvMzAvMjAwMQkJIFBvcnQgdG8gTGludXgJCSBuc2hhcm9mZkB1cy5pYm0uY29t
ICovCi0KLS8qCi0gKiBOQU1FCi0gKgkJIHNobXQwMgotICoKLSAqIENBTExTCi0gKgkJIHNobWN0
bCgyKSBzaG1nZXQoMikKLSAqCi0gKiBBTEdPUklUSE0KKy8qXAogICogQ3JlYXRlIGFuZCBhdHRh
Y2ggYSBzaGFyZWQgbWVtb3J5IHNlZ21lbnQsIHdyaXRlIHRvIGl0Ci0gKiBhbmQgdGhlbiByZW1v
dmUgaXQuCQkgIFZlcmlmeSB0aGF0IHRoZSBzaGFyZWQgbWVtb3J5IHNlZ21lbnQKKyAqIGFuZCB0
aGVuIHJlbW92ZSBpdC4gVmVyaWZ5IHRoYXQgdGhlIHNoYXJlZCBtZW1vcnkgc2VnbWVudAogICog
aXMgYWNjZXNzaWJsZSBhcyBsb25nIGFzIHRoZSBwcm9jZXNzIGlzIHN0aWxsIGFsaXZlLgotICoK
ICAqLwogCi0jaW5jbHVkZSA8c3RkaW8uaD4KLSNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KLSNpbmNs
dWRlIDxzeXMvaXBjLmg+Ci0jaW5jbHVkZSA8c3lzL3NobS5oPgotI2luY2x1ZGUgPHN5cy91dHNu
YW1lLmg+Ci0jaW5jbHVkZSA8ZXJybm8uaD4KLQotLyoqIExUUCBQb3J0ICoqLwotI2luY2x1ZGUg
InRlc3QuaCIKLQotY2hhciAqVENJRCA9ICJzaG10MDIiOwkJLyogVGVzdCBwcm9ncmFtIGlkZW50
aWZpZXIuICAgICovCi1pbnQgVFNUX1RPVEFMID0gMzsJCS8qIFRvdGFsIG51bWJlciBvZiB0ZXN0
IGNhc2VzLiAqLwotCi0vKioqKioqKioqKioqKiovCisjaW5jbHVkZSAidHN0X3Rlc3QuaCIKKyNp
bmNsdWRlICJ0c3Rfc2FmZV9zeXN2X2lwYy5oIgorI2luY2x1ZGUgInRzdF9yYW5kX2RhdGEuaCIK
IAotI2RlZmluZSBLXzEgMTAyNAorI2RlZmluZSBTSE1TSVpFIDE2CiAKLXN0YXRpYyBpbnQgcm1f
c2htKGludCk7Ci0KLWludCBtYWluKHZvaWQpCitzdGF0aWMgdm9pZCBydW4odm9pZCkKIHsKIAly
ZWdpc3RlciBpbnQgc2htaWQ7CiAJY2hhciAqY3A7CiAJa2V5X3Qga2V5OwogCiAJZXJybm8gPSAw
OwotCWtleSA9IChrZXlfdCkgZ2V0cGlkKCk7Ci0KLS8qLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovCi0KLQlpZiAoKHNobWlk
ID0gc2htZ2V0KGtleSwgMTYgKiBLXzEsIElQQ19DUkVBVCB8IDA2NjYpKSA8IDApIHsKLQkJcGVy
cm9yKCJzaG1nZXQiKTsKLQkJdHN0X2Jya20oVEZBSUwsIE5VTEwsCi0JCQkgInNobWdldCBGYWls
ZWQ6IHNobWlkID0gJWQsIGVycm5vID0gJWQiLAotCQkJIHNobWlkLCBlcnJubyk7Ci0JfQotCi0J
dHN0X3Jlc20oVFBBU1MsICJzaG1nZXQiKTsKKwlrZXkgPSAoa2V5X3QpZ2V0cGlkKCk7CiAKLS8q
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLSovCisJc2htaWQgPSBTQUZFX1NITUdFVChrZXksIFNITVNJWkUsIElQQ19DUkVBVCB8
IDA2NjYpOwogCi0JY3AgPSBzaG1hdChzaG1pZCwgTlVMTCwgMCk7CisJY3AgPSBTQUZFX1NITUFU
KHNobWlkLCBOVUxMLCAwKTsKKwltZW1jcHkoY3AsIHRzdF9yYW5kX2RhdGEsIFNITVNJWkUpOwog
Ci0JaWYgKGNwID09IChjaGFyICopLTEpIHsKLQkJcGVycm9yKCJzaG1hdCIpOwotCQl0c3RfcmVz
bShURkFJTCwgInNobWF0IEZhaWxlZDogc2htaWQgPSAlZCwgZXJybm8gPSAlZCIsCi0JCQkgc2ht
aWQsIGVycm5vKTsKLQkJcm1fc2htKHNobWlkKTsKLQkJdHN0X2V4aXQoKTsKLQl9CisJU0FGRV9T
SE1DVEwoc2htaWQsIElQQ19STUlELCBOVUxMKTsKIAotCSpjcCA9ICcxJzsKLQkqKGNwICsgMSkg
PSAnMic7Ci0KLQl0c3RfcmVzbShUUEFTUywgInNobWF0Iik7Ci0KLS8qLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovCi0KLQly
bV9zaG0oc2htaWQpOwotCi0JaWYgKCpjcCAhPSAnMScgfHwgKihjcCArIDEpICE9ICcyJykgewot
CQl0c3RfcmVzbShURkFJTCwKLQkJCSAiRXJyb3IgaW4gc2hhcmVkIG1lbW9yeSBjb250ZW50czog
c2htaWQgPSAlZCIsCi0JCQkgc2htaWQpOwotCX0KLQotCXRzdF9yZXNtKFRQQVNTLCAiQ29ycmVj
dCBzaGFyZWQgbWVtb3J5IGNvbnRlbnRzIik7Ci0KLS8qLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8KLQotCXRzdF9leGl0
KCk7CisJVFNUX0VYUF9FUV9TVFJOKGNwLCB0c3RfcmFuZF9kYXRhLCBTSE1TSVpFKTsKIH0KIAot
c3RhdGljIGludCBybV9zaG0oaW50IHNobWlkKQotewotCWlmIChzaG1jdGwoc2htaWQsIElQQ19S
TUlELCBOVUxMKSA9PSAtMSkgewotCQlwZXJyb3IoInNobWN0bCIpOwotCQl0c3RfYnJrbShURkFJ
TCwKLQkJCSBOVUxMLAotCQkJICJzaG1jdGwgRmFpbGVkIHRvIHJlbW92ZTogc2htaWQgPSAlZCwg
ZXJybm8gPSAlZCIsCi0JCQkgc2htaWQsIGVycm5vKTsKLQl9Ci0JcmV0dXJuICgwKTsKLX0KK3N0
YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKKwkudGVzdF9hbGwgPSBydW4sCit9OwoKLS0t
CmJhc2UtY29tbWl0OiBkZjU5MTExM2FmZWIzMTEwN2JjNDViZDViYTI4YTk5YjU1NmQxMDI4CmNo
YW5nZS1pZDogMjAyNTA2MTgtY29udmVyc2lvbnMtc2htdC01ZWE1YTVlYmU1NWUKCkJlc3QgcmVn
YXJkcywKLS0gClJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
