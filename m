Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946E6C021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740423240; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=M33yOAf7TevIX5PVPXpXPXY9Fobtk5HrfbY7V/H9aFc=;
 b=JMomYhGofVNeJWvvgAPIYkaWbrOU0iZJ1qB4n43/ZD+wW5naUwq+22MGHJ5UwBUyF63+1
 YnPQI5zZvOkyb6Zd92ekOoDTI5LNcepZcAEKnTpyxK1/Bt34MX0PrgFR85ElwKYR6zpsWNp
 vK/D8IrgXWSH+kLbEhN9tKMPZhLzVcI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F6023C99FD
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 19:54:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB9083C99A2
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:53:20 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2788E1BC6082
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:53:20 +0100 (CET)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso740157566b.3
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740423199; x=1741027999; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0oHyBAPdxEupJoaoHWKeh9k2dr/f4nmDjKP168oX3gc=;
 b=Yj45eb7zCGPAjBGHxrAEG86CwhoSFaELWVPxIDsKb7bYiJPSWkbpch9dEMmnzsGTWN
 +tj2wGdIJ7aFZMCRZxXizWr1rBTtYEvbK/69sJfIOb4Rlp90aE/hJp7g+mbUfXvHOrUp
 M1cZTVNGTutIG8m+9KBAnhiJAm44hw4j2W9t3PEi+p10SyFw37+TjpBaziDpWQASAZ8s
 wxHOGyaUiZHFrsey0A2a2Osn6p9q7gQhe3HX83dv4PjwbgY4musLbj58FbOcsCWSUd3k
 M+FO67n61186F0f/tjWHZXYJoAzOrwtgU+OyYI2hyvJ+FICfIXs4NmGIW2313hq1StYC
 EpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740423199; x=1741027999;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0oHyBAPdxEupJoaoHWKeh9k2dr/f4nmDjKP168oX3gc=;
 b=WEfI1V/XjKyo5AWOXo5LfPulJKfOdkaY6SUPn4P4s70ITwIHYWNtL/gpwFiQ4mdjdA
 31bx44LapqJsKAdIx8L6SgrPc4NsYGQCuj1KhWhiSGAsbXUjWRF+ZpxRuevmCRRJUUiN
 g/Ss4GR8xTasNuiRjX1UmSV9WCpF1V3c0QykdPDcrBmTTk2O6LrxBa5kyywlQelX1yWt
 OZkRRddX3cSE0q1rMsCNCh+2Zo+lYipZQWZNkkzDeRG0SLB5iGwAIIcCKPee4XqUYJRb
 NaQsato45jecx3eRtgry5S+Is4XVIGfOfIYyzZLjDS8plTrXC2zlINaB+NlSOpg0ku05
 VHuA==
X-Gm-Message-State: AOJu0Yz32rghFzr2+Mp+40OOtX/JFl3WOxBiaQe2sMCv16ZSaNeHzcm3
 eD04UqsvJYuglIFoBApUGX6bWrMhZ0tWNS2x9SxHEzduEEtSwbBrMtD438CCClpe6TAYKJwbK9B
 Y
X-Gm-Gg: ASbGncsscMb7VC5t5fb/G7T/Bg8/jJVTM3q9OU2OuWKkuxt7jXzPX57fm6cm2iTWT+M
 y8NHXt4SFQ+PH3QS4DdvJd7RS7t0k8VDYqTnp075QgURj6Gf7GQoYb5Pmm2HYpsQaO+8h1D3Zab
 kBicrsbGNTqV7dbPWnXZwQhEzZsyylEAvKwiItdkHDE8xxkvCKNHWXoVpLu2wHU5+TWU1N2tRVo
 z1LW49cEwaH0E41eBz/NmN8Ijkq2h0ujCwUK0x4HedtabV7TancdmAVbtWAdqN1OjbwmdAh586u
 14uv4SW/4DvXfng=
X-Google-Smtp-Source: AGHT+IHcJJLP+KzlcyvxtT0i8AA8UiWNxBn5r5x//q3t0Y6Q6kpBEIRfyL+eqZBUK/ITuZhMhwTSsA==
X-Received: by 2002:a17:906:c152:b0:ab3:84ac:4dbc with SMTP id
 a640c23a62f3a-abc0cd04752mr1583037666b.0.1740423199543; 
 Mon, 24 Feb 2025 10:53:19 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2fceb04997dsm6832582a91.14.2025.02.24.10.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:53:13 -0800 (PST)
Date: Mon, 24 Feb 2025 15:53:02 -0300
MIME-Version: 1.0
Message-Id: <20250224-conversions-pause-v3-1-5e3989d37f1d@suse.com>
References: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
In-Reply-To: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2189; i=rbm@suse.com;
 h=from:subject:message-id; bh=eMRsVX9hQDmUi+gleQxEf7BOAI+fWcaMDiVh3U7cmrY=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnvMARWkMkAwFmWAaKMHQ7lKK+YEDnRYWIaE7EJ
 E2EwvL2Q0uJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7zAEQAKCRDJC4p8Y4ZY
 pocSD/9q3pfgydo5KRVlzPau+GDn4i6dgwtdern8olOQFOlExdd/bYnMpZD8Te+fKkQencZB0mu
 ouCTQkQQgaace1rQWSwH9ZVVC7HN/zH4Jb3o7CGsil0axkUYdeeYbPx2qA6xst6wUQnhjJnac79
 jFGb1UJhe6h+ui9WIZb875Ld/U4v8GKwWqYKoXxoGcy7K4rXyhUi8rbh4Py2dMN3MeRLPdG5bwC
 m5r5Sqh9PsFCu29QoPnZaux75u/qSfoj1gQMhclBUQwbS+03wWyCxtU4WWNc8OsFJ/GGW9eN6Mn
 A0fFyOyvOU1mR4xbKk8qzDafE/+XQi0+BjAAjFER/dhV8Z92CunpkYU4nGRHN6eiYcp1ysJBKn4
 v9akLB127qPCNthsHAHKqWsFq61Rch7kHPNETgfaTjXdQUT/l21LrqRpTshtsqFXu7tA/yH/7Rg
 mfAYxWJm873U4py4t1+hCRREYUtzoEce/hW0IckHdc9PlrrV2gXxeoPuU3nT779zNFaMQ245Ky/
 dck48jOA6485GJeCRiasqmdONqIrTkLmiqNVj8AiVhRg3RWwofh6hOa3l0uipcPv+FjfaVhJ22p
 pol2gtIyB3OT9kCaAkld0y2XM+MKuW70zwx/Cqd5L0AkdR4ZVJHSy2bZ97QbYou3X4N6YckGRnw
 49iBDDTII2MDWtA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/5] syscalls/pause01: Clean up
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRpZHkgdXAgYW5kIGFk
ZCBhIGRlc2NyaXB0aW9uLgoKU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJi
bUBzdXNlLmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BhdXNlL3BhdXNlMDEu
YyB8IDQxICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
NSBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL3BhdXNlL3BhdXNlMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvcGF1c2UvcGF1c2UwMS5jCmluZGV4IGM4ODI0OGRhMGQ5OTYxYzU0MTRhNjk0YTkxY2YxYWVm
NDBmZjI2M2EuLmQ4MzAwMTZhNjhiNzdkYWFkNDg1MWQ3ZjdkNjQzNmMwOTIyZGUwMDIgMTAwNjQ0
Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2UwMS5jCisrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2UwMS5jCkBAIC0xLDEwICsxLDE0IEBA
CiAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgogLyoKICAqIENv
cHlyaWdodCAoYykgMjAxNiBMaW51eCBUZXN0IFByb2plY3QKKyAqIENvcHlyaWdodCAoYykgMjAy
NSBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgogICovCi0jaW5jbHVkZSA8ZXJy
bm8uaD4KLSNpbmNsdWRlIDxzaWduYWwuaD4KLSNpbmNsdWRlIDxzdGRsaWIuaD4KKworLypcCisg
KiBWZXJpZnkgdGhhdCwgcGF1c2UoKSByZXR1cm5zIC0xIGFuZCBzZXRzIGVycm5vIHRvIEVJTlRS
IGFmdGVyIHJlY2VpcHQgb2YgYQorICogc2lnbmFsIHdoaWNoIGlzIGNhdWdodCBieSB0aGUgY2Fs
bGluZyBwcm9jZXNzLgorICovCisKICNpbmNsdWRlICJ0c3RfdGVzdC5oIgogCiBzdGF0aWMgdm9p
ZCBzaWdfaGFuZGxlcihpbnQgc2lnIExUUF9BVFRSSUJVVEVfVU5VU0VEKQpAQCAtMTQsNDMgKzE4
LDI4IEBAIHN0YXRpYyB2b2lkIHNpZ19oYW5kbGVyKGludCBzaWcgTFRQX0FUVFJJQlVURV9VTlVT
RUQpCiBzdGF0aWMgdm9pZCBkb19jaGlsZCh2b2lkKQogewogCVNBRkVfU0lHTkFMKFNJR0lOVCwg
c2lnX2hhbmRsZXIpOwotCiAJVFNUX0NIRUNLUE9JTlRfV0FLRSgwKTsKLQotCVRFU1QocGF1c2Uo
KSk7Ci0JaWYgKFRTVF9SRVQgIT0gLTEpCi0JCXRzdF9yZXMoVEZBSUwsICJwYXVzZSgpIHN1Y2Nl
ZWRlZCB1bmV4cGVjdGVkbHkiKTsKLQllbHNlIGlmIChUU1RfRVJSID09IEVJTlRSKQotCQl0c3Rf
cmVzKFRQQVNTLCAicGF1c2UoKSBpbnRlcnJ1cHRlZCB3aXRoIEVJTlRSIik7Ci0JZWxzZQotCQl0
c3RfcmVzKFRGQUlMIHwgVFRFUlJOTywgInBhdXNlKCkgdW5leHBlY3RlZCBlcnJubyIpOwotCi0J
VFNUX0NIRUNLUE9JTlRfV0FLRSgwKTsKLQlleGl0KDApOworCVRTVF9FWFBfRkFJTChwYXVzZSgp
LCBFSU5UUik7CisJdHN0X3JlcyhUUEFTUywgIlByb2Nlc3MgcmVzdW1lZCBmcm9tIHBhdXNlKCki
KTsKIH0KIAotc3RhdGljIHZvaWQgZG9fdGVzdCh2b2lkKQorc3RhdGljIHZvaWQgcnVuKHZvaWQp
CiB7CiAJaW50IHBpZCwgc3RhdHVzOwogCiAJcGlkID0gU0FGRV9GT1JLKCk7Ci0JaWYgKHBpZCA9
PSAwKQorCWlmICghcGlkKSB7CiAJCWRvX2NoaWxkKCk7CisJCWV4aXQoMCk7CisJfQogCiAJVFNU
X0NIRUNLUE9JTlRfV0FJVCgwKTsKIAlUU1RfUFJPQ0VTU19TVEFURV9XQUlUKHBpZCwgJ1MnLCAw
KTsKLQlraWxsKHBpZCwgU0lHSU5UKTsKLQotCS8qCi0JICogVFNUX0NIRUNLUE9JTlRfV0FJVCBo
YXMgYnVpbHQtaW4gdGltZW91dCwgaWYgcGF1c2UoKSBkb2Vzbid0IHJldHVybiwKLQkgKiB0aGlz
IGNoZWNrcG9pbnQgY2FsbCB3aWxsIHJlbGlhYmx5IGVuZCB0aGUgdGVzdC4KLQkgKi8KLQlUU1Rf
Q0hFQ0tQT0lOVF9XQUlUKDApOwotCVNBRkVfV0FJVCgmc3RhdHVzKTsKKwlTQUZFX0tJTEwocGlk
LCBTSUdJTlQpOwogfQogCiBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7CiAJLmZvcmtz
X2NoaWxkID0gMSwKIAkubmVlZHNfY2hlY2twb2ludHMgPSAxLAotCS50ZXN0X2FsbCA9IGRvX3Rl
c3QsCisJLnRlc3RfYWxsID0gcnVuLAogfTsKCi0tIAoyLjQ4LjEKCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
