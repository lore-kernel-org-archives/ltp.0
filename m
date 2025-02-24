Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB03FC021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740423270; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9d1i1btG2VOUq6Y8Shh6n5D3tC53cmtHA/qmPi/Vy54=;
 b=ouvLyWgGB+TR/baSSIyAGwFpFjGCkJ7/vMJidG9kAv7uv0IZCsUwdd/Dyli+ZfuWvrl3+
 2LSvwxmTMSdb/cXZPgty3xNgEVwaw8e5d/3s6t12pNjUSuGfyH6i3PM/SobVXlVRA7kAKJK
 vAsdGqeeRGMMLBw9CjQdiyUm1JfiOjI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 393D43C9A37
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 19:54:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FE943C9A39
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:53:23 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D617E230B3E
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:53:22 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso48323545e9.1
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 10:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740423202; x=1741028002; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HzhIAhVih/OwMNduuxpQpu9a0YBrIrE+bk5GUpw495k=;
 b=MkE1gJZdBZXsD+PwaOTLWzysgmDBsuvph6JkmLByACooNS9uk2rbFn5uqqqPHAR6Kg
 HLymEEyt9mQyZH7HNqCQzZS87Bfrb2gPurCsrSTPYVb6ohDE4kYssrBzVxPXBQM09QV6
 uzm/z0Cna0N2GdJP/b8H2jWnAbwbZVZK/4LRz0lWziAQnZOn/wfKEvV+69FiavfOX19a
 T7bw+1gbrjd/uUISYpnqGHBvN6dU9jAYx72n+Har9w9ggcJ0wBfuIxpq+ir/y+qTYmf+
 5SZ2cAy4WbCiMoO3plpf2DfQamxTlRfksG5F7y0Wr7MBsTO1mxCMyQxhGlSaJB07EOSr
 kdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740423202; x=1741028002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HzhIAhVih/OwMNduuxpQpu9a0YBrIrE+bk5GUpw495k=;
 b=XJ7zzxKKkojqYLay5js/WS1nEXVI+YOBBYYlc9Dfp0b4zQrRwD6nXC2bH3ckBmGSW8
 Kd8+GTdyHpOW/sUnVWonMMCgQkWgdh3cJIA66ukg5kLMYVuLVJ8aOK+DYXH9EtUAGLBv
 IAwwwYdDzHdYLuetQwph34nDuxdzcoCrJAVic+K14UclIPIecUL5bMQkSucAX5ALMhSB
 qa3fZ7R/6CIEmF1o8ajkQdffxvs0kNoZJNhHN9/+4RyvV1ImjLxyubKGSLwOFR27LTpq
 alII+znnNTE407JzjVEv1pes65DJMceSgByZnJo0DjlRlyrjLnw7G1XjxTEuJwrUyxSx
 Bg5Q==
X-Gm-Message-State: AOJu0YwAennViGwEtaLqAVfr6o5h1Gra6Py1H1r57gBxzRE6Cx/mK792
 gjyeUt78el2IcaUuvyhjpdYBokIyyFBakuJMsxm0a+7Gk1ZFKpAC/2U7VKUTO3k=
X-Gm-Gg: ASbGncv543pt5PLa2fU3eLhwJ2JBRT6ZalTnaFprHO5PYDaZPjagYLS8qBRjhKD620K
 ZTvxxbaEg8kSakzw9Rwa0fvvk4F6aTAAC1RYWiAeqt1pfJ6yvomzT7gsprrpbZfDUo0lbMYF4BJ
 ivHkEqXqlTGefUhDGS287RqMOn72yDX4VB2HRaxLassi2oA9YbkMxge9Nsli/8WhvPgGTZEqJbJ
 Kb3lPYL7gV5w9JEwdavkmR3AA6yA6up7v+u9JycPpLhmu1dSFJ0Gk4NArGSLuH4UR3W0rrJJDDW
 zgov8Ef2N9tH5wA=
X-Google-Smtp-Source: AGHT+IF/xk/URp3G8txJDwq7BlFLS62yU4TYAu7XtEP4wGyHiYow9djcb9fJuCDJTjtdeV28x1L4lw==
X-Received: by 2002:a5d:66c5:0:b0:38d:d5af:29b4 with SMTP id
 ffacd0b85a97d-390cc63be56mr125482f8f.45.1740423202205; 
 Mon, 24 Feb 2025 10:53:22 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73268821c54sm17778061b3a.146.2025.02.24.10.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:53:21 -0800 (PST)
Date: Mon, 24 Feb 2025 15:53:03 -0300
MIME-Version: 1.0
Message-Id: <20250224-conversions-pause-v3-2-5e3989d37f1d@suse.com>
References: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
In-Reply-To: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=rbm@suse.com;
 h=from:subject:message-id; bh=0fB1zNNZNZs+LuLIzm2pCuH0sG03LK7K4rGItHwscqQ=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnvMAReS7pjYId4V5c+abWwVcSzP0Wp9vwHjWZ1
 Ckfhlx0gtiJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7zAEQAKCRDJC4p8Y4ZY
 pg2ED/97TeH+vtWZphDGHkR8lJdxVM7VqLFNMrpC10wMBIH3PTdy5cWiiXHNpr1Xh4KOWrAIOHb
 jr50EOESY9IrONkVXJ1bScwvjS9NqicrGGR6DoIBlRw7R+Xj7jIs2uqB8DiPNMUzYDjMuNxVlcB
 cLY0u0oRViY2w+68x7aWwQ050jZsMUzBMb4aSifVKp7eFHdJ3xN1wMc5osOBYdDTHlrMYWkrCF/
 xh+4+x+TqzUkuyK4KXfLzL2Bs35JNPoVnv+SDUEg4poAQh4PqbjXauHqoUy0rJ9ems1fcXdtYvV
 OuadgcLYtQ2Vavf7qTjopYZ8Oj6v3vnlPlrPwtO4GeN7WoxHHXnyq5knt8rl/KxTOR4B6bSJ2hd
 3tcpawzAgtIptFKHy7NLZuBhlrbxGkt+SnbsX6qtCV/5MXGtI4/VYRMNCT8UMavKuDNkuqhg3DI
 1etwuZuCC2/ythNwZdlRLiJ+bSTg0CM9NToLzUXC63NsHQwsLpBh+ZZgFPctzqRGf1xzSzZpLOc
 +RsR/XHQ7sJkJpadEQhvixDqc39hL1VqzQXoOulaU8WdhBYneFM7DFpAkn4aoGEUiX/JF6rU2p4
 xvFMa9ajHB3Utsre5hCIsFmQSjBWIBU4jI/K+eiKW/+OpvUsb3hJt7n/4cyBU0M3Akx2THvvIIv
 9ccskoOzBx7Nb6w==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/5] syscalls/pause01: Extend test to other signals
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCkN1cnJlbnRseSwgdGhl
IHRlc3Qgb25seSBjb3ZlcnMgU0lHSU5ULiBBZGQgbW9yZSB0byB0aGUgbWl4IGJ5CnBhcmFtZXRy
aXppbmcgdGhlIG1haW4gdGVzdCBmdW5jdGlvbi4KClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4g
TWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9w
YXVzZS9wYXVzZTAxLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BhdXNlL3BhdXNlMDEuYyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2UwMS5jCmluZGV4IGQ4MzAwMTZhNjhiNzdkYWFkNDg1
MWQ3ZjdkNjQzNmMwOTIyZGUwMDIuLjFjMWIwNDAzOGRlMTFkYzUyZGViODQxYWQ1OWQ1YTQ4MjM0
NTI2MmEgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2Uw
MS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2UwMS5jCkBAIC0x
MSwzNSArMTEsNTAgQEAKIAogI2luY2x1ZGUgInRzdF90ZXN0LmgiCiAKLXN0YXRpYyB2b2lkIHNp
Z19oYW5kbGVyKGludCBzaWcgTFRQX0FUVFJJQlVURV9VTlVTRUQpCitzdGF0aWMgdm9pZCBzaWdf
aGFuZGxlcihpbnQgc2lnbmFsIExUUF9BVFRSSUJVVEVfVU5VU0VEKQogewogfQogCi1zdGF0aWMg
dm9pZCBkb19jaGlsZCh2b2lkKQorc3RhdGljIHZvaWQgZG9fY2hpbGQoaW50IHNpZ25hbCkKIHsK
LQlTQUZFX1NJR05BTChTSUdJTlQsIHNpZ19oYW5kbGVyKTsKKwlTQUZFX1NJR05BTChzaWduYWws
IHNpZ19oYW5kbGVyKTsKIAlUU1RfQ0hFQ0tQT0lOVF9XQUtFKDApOwogCVRTVF9FWFBfRkFJTChw
YXVzZSgpLCBFSU5UUik7CiAJdHN0X3JlcyhUUEFTUywgIlByb2Nlc3MgcmVzdW1lZCBmcm9tIHBh
dXNlKCkiKTsKIH0KIAotc3RhdGljIHZvaWQgcnVuKHZvaWQpCitzdGF0aWMgdm9pZCBydW4oaW50
IHNpZ25hbCkKIHsKLQlpbnQgcGlkLCBzdGF0dXM7CisJaW50IHBpZDsKIAogCXBpZCA9IFNBRkVf
Rk9SSygpOwogCWlmICghcGlkKSB7Ci0JCWRvX2NoaWxkKCk7CisJCWRvX2NoaWxkKHNpZ25hbCk7
CiAJCWV4aXQoMCk7CiAJfQogCiAJVFNUX0NIRUNLUE9JTlRfV0FJVCgwKTsKIAlUU1RfUFJPQ0VT
U19TVEFURV9XQUlUKHBpZCwgJ1MnLCAwKTsKLQlTQUZFX0tJTEwocGlkLCBTSUdJTlQpOworCVNB
RkVfS0lMTChwaWQsIHNpZ25hbCk7Cit9CisKK3N0YXRpYyB2b2lkIHJ1bl9hbGwodm9pZCkKK3sK
KwlydW4oU0lHSFVQKTsKKwlydW4oU0lHSU5UKTsKKwlydW4oU0lHUVVJVCk7CisJcnVuKFNJR0lM
TCk7CisJcnVuKFNJR1RSQVApOworCXJ1bihTSUdBQlJUKTsKKwlydW4oU0lHRlBFKTsKKwlydW4o
U0lHU0VHVik7CisJcnVuKFNJR1BJUEUpOworCXJ1bihTSUdBTFJNKTsKKwlydW4oU0lHVEVSTSk7
CiB9CiAKIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKIAkuZm9ya3NfY2hpbGQgPSAx
LAogCS5uZWVkc19jaGVja3BvaW50cyA9IDEsCi0JLnRlc3RfYWxsID0gcnVuLAorCS50ZXN0X2Fs
bCA9IHJ1bl9hbGwsCiB9OwoKLS0gCjIuNDguMQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
