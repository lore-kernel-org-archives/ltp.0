Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C43C021AA
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 18:08:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49F4B3C06D0
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 19:08:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69E293C1AC0
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 19:07:52 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DA1E51401235
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 19:07:51 +0100 (CET)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso148382315ad.0
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 10:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739902069; x=1740506869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:dkim-signature:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zcvL87qOyI1EPY8HxhqwwYiQbRO6OP5Fmw6bfRQRiBo=;
 b=vBQblqrc64H8LVappZT1yCOQsNujOAIVp4y7E2PCWhlbThAFBnKmmTTfuIfp6a9/bs
 khtHk8r6+3yKdtJy4Ge3XOih4R7CR3wI7cKArycfpeRquWtZqhPhaCDcqTRdj2XvyiKJ
 VLm8IbOSCPg/e88R97ajFPaMQXIA15U+ahmzWgqaCEIzeau+ClFDP2mDHPMuCGvw5eXS
 r11jG4YQivqlQa+eOxnFQLVjA7saJCgVOpjmxhy5ijvZtq8Ce6p4kGCSfVL/z64dGPCE
 PrFWm4FUaWcY4BgErkZOF1pKfd83oQgsWmy2YJvMOnP21ljKtOxI12s0OTFgyynlZtKW
 8TzQ==
X-Gm-Message-State: AOJu0Yw+U3OdP5cIh/ujctmdl1d+FDmrEkPvA0J5C2udssRqqHYvZqxF
 zrBEEsaUuh40m0mr0HCh5sBNKG7f21habV1dX1B5HcUJ8FqEPqDzVmAhGaF9cC8=
X-Gm-Gg: ASbGncs0gowR58RkM6/LXIBik0WX3wH2KdcI1VLTvtfpjCXjrXvwrMGaWrMPsUmaoPL
 qxGT71wljpPuKjcnAEMb1bkcuz8pXMQzkaOdOvlIokt6n1R+uFOTCZaU0tZc88xMh9XH4UPIwF6
 l/N7KpFBpdpWjrDy74G9nmEM/INaWGTNTNCq7q/eRhPIz4SsbZet3l9ZRUOWYM2sdgeBm/oxL4+
 eijgewP/X8w20BO6mDinTr0zShVSWTrg0rTD/KxN4DG7O5eFbxUYYG4vn53kERpVNv7OQ7jV0YD
 eoFEvW9ozg==
X-Google-Smtp-Source: AGHT+IHZRLOsSk+wHJoZpn1MO0Y/XEmOXuXUhTqNJWlOviCokSA/HtGvcFYeYBhLXh1f2QBgQ0ewMA==
X-Received: by 2002:a05:6a21:62c2:b0:1eb:7da4:305e with SMTP id
 adf61e73a8af0-1ee8cc4b948mr26852585637.39.1739902069364; 
 Tue, 18 Feb 2025 10:07:49 -0800 (PST)
Received: from mail.marliere.net ([2604:a880:4:1d0::7f5:6000])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-add7cc42dc5sm6593441a12.57.2025.02.18.10.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 10:07:48 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1739902068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcvL87qOyI1EPY8HxhqwwYiQbRO6OP5Fmw6bfRQRiBo=;
 b=g6+lWDyWPSxiW7sX5EQOwZzd1/jSKUdaW/x/sU+AC+/LL3HmuU74nbLiROisFrsS7ItAiA
 oAgtRJoxXEZQdWBaKJXBZmsYaY0ZK4fVUClvEy280chXzEDobrFCMNzKrs5dvaRNjAUR3P
 Q5w33X0qqKLs7f4yPZ7e+BGY40zjXdvWyqhu4+TS+Rr+BQQHfrnL/guiFFcrF1tOftrLFw
 kaqRPqNaOGaOxhvrv7gRvflWk/zKMTBnxl8WQaAHTJB5TddfODDn3Er5GJ2wEB/oe3EC9U
 nHpxWZK0jViROAiq3Hd7LnU3Cvu6IzLpDVO/m89I4vpRyQNQpKNmOCdYuC9RNA==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 18 Feb 2025 15:07:17 -0300
MIME-Version: 1.0
Message-Id: <20250218-conversions-pause-v2-1-8c72960fe1ec@suse.com>
References: <20250218-conversions-pause-v2-0-8c72960fe1ec@suse.com>
In-Reply-To: <20250218-conversions-pause-v2-0-8c72960fe1ec@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2064; i=rbm@suse.com;
 h=from:subject:message-id; bh=Un6Hugz3WRIBv+gjOv1PWkTySlS5K4H5Wj+Yx/zbuOM=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBntMxs6kOjV1wEFcLYvBy2kIO0HjENyZYXUxp3o
 7bam6hqIXSJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7TMbAAKCRDJC4p8Y4ZY
 pgWWD/wO6XNSbpfrHWkVOBQuPrp+3kSGXkLcp024LjlolTa3pN97Ujz94wIqFOW0pbdGd+Slp/R
 C08LA7gJeaekUdybW3DsPDKe35VOpVT8JDkvD3TGu7r2I8msiJz+0a06KL26biFe7FiRCpwPsB8
 uviznWyKU9OA5R9CpXMbRWZPVLuRzPEclIrUcqj6xv/pfpqfBPyLk7aopuohe4eHKFH0iPtzHl8
 xRTLw1hLWYvp1rVF1V0BEXgaBlfI0eNXvhy7kIwzFgL8rjX/CL5WDyZGp2Q/bo7rNPVey5rWVy/
 gqewUy0yIguST8PHronLQj6pCj85sfJTWYNeAuKlKYJ4fsxjFb4VVqAjjGWgjUAb6148bYis5jl
 OsysH8dzRBBbSSorWk2bf7vgtpEQI5SsDhSjGQe5udeeLR20EJaBzqVDdqRZ+f6qZtZmB+ramV2
 YRGYlB0lhMW9+nds2DOzVmUG5DTtTDTJuahpXBphaDu7SQYAXgSDzyo/JqbakOd3Ebt5D87dzlw
 7Vl1AulIYNiLIguXP9+BUodl92MYpW5io9XiayIJhGjFPCxV9tpqjD8oO+RPyBctORaLkACHK9o
 7m894yWEtUyxF6VOLL9gmIFAGGiiC83Zi+n+10jdk7fZBuNcCwARYKxUvXyl1Jab14bQzdHPEFT
 y7bteFEH5t82RVQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] syscalls/pause01: Clean up
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
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRpZHkgdXAgYW5kIGFk
ZCBhIGRlc2NyaXB0aW9uLgoKU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJi
bUBzdXNlLmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BhdXNlL3BhdXNlMDEu
YyB8IDM0ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
NCBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL3BhdXNlL3BhdXNlMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvcGF1c2UvcGF1c2UwMS5jCmluZGV4IGM4ODI0OGRhMGQ5OTYxYzU0MTRhNjk0YTkxY2YxYWVm
NDBmZjI2M2EuLmFkY2UwZGRjZjJlMDYzOTQwN2I0ZTIxZGUwYTFiZTdiMzBlZmFhMDEgMTAwNjQ0
Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2UwMS5jCisrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2UwMS5jCkBAIC0xLDEwICsxLDE0IEBA
CiAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgogLyoKICAqIENv
cHlyaWdodCAoYykgMjAxNiBMaW51eCBUZXN0IFByb2plY3QKKyAqIENvcHlyaWdodCAoYykgMjAy
NSBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgogICovCi0jaW5jbHVkZSA8ZXJy
bm8uaD4KLSNpbmNsdWRlIDxzaWduYWwuaD4KLSNpbmNsdWRlIDxzdGRsaWIuaD4KKworLypcCisg
KiBWZXJpZnkgdGhhdCwgcGF1c2UoKSByZXR1cm5zIC0xIGFuZCBzZXRzIGVycm5vIHRvIEVJTlRS
IGFmdGVyIHJlY2VpcHQgb2YgYQorICogc2lnbmFsIHdoaWNoIGlzIGNhdWdodCBieSB0aGUgY2Fs
bGluZyBwcm9jZXNzLgorICovCisKICNpbmNsdWRlICJ0c3RfdGVzdC5oIgogCiBzdGF0aWMgdm9p
ZCBzaWdfaGFuZGxlcihpbnQgc2lnIExUUF9BVFRSSUJVVEVfVU5VU0VEKQpAQCAtMTQsMzIgKzE4
LDIyIEBAIHN0YXRpYyB2b2lkIHNpZ19oYW5kbGVyKGludCBzaWcgTFRQX0FUVFJJQlVURV9VTlVT
RUQpCiBzdGF0aWMgdm9pZCBkb19jaGlsZCh2b2lkKQogewogCVNBRkVfU0lHTkFMKFNJR0lOVCwg
c2lnX2hhbmRsZXIpOwotCisJVFNUX0VYUF9GQUlMKHBhdXNlKCksIEVJTlRSKTsKIAlUU1RfQ0hF
Q0tQT0lOVF9XQUtFKDApOwotCi0JVEVTVChwYXVzZSgpKTsKLQlpZiAoVFNUX1JFVCAhPSAtMSkK
LQkJdHN0X3JlcyhURkFJTCwgInBhdXNlKCkgc3VjY2VlZGVkIHVuZXhwZWN0ZWRseSIpOwotCWVs
c2UgaWYgKFRTVF9FUlIgPT0gRUlOVFIpCi0JCXRzdF9yZXMoVFBBU1MsICJwYXVzZSgpIGludGVy
cnVwdGVkIHdpdGggRUlOVFIiKTsKLQllbHNlCi0JCXRzdF9yZXMoVEZBSUwgfCBUVEVSUk5PLCAi
cGF1c2UoKSB1bmV4cGVjdGVkIGVycm5vIik7Ci0KLQlUU1RfQ0hFQ0tQT0lOVF9XQUtFKDApOwot
CWV4aXQoMCk7CiB9CiAKLXN0YXRpYyB2b2lkIGRvX3Rlc3Qodm9pZCkKK3N0YXRpYyB2b2lkIHJ1
bih2b2lkKQogewogCWludCBwaWQsIHN0YXR1czsKIAogCXBpZCA9IFNBRkVfRk9SSygpOwotCWlm
IChwaWQgPT0gMCkKKwlpZiAoIXBpZCkgewogCQlkb19jaGlsZCgpOworCQlleGl0KDApOworCX0K
IAotCVRTVF9DSEVDS1BPSU5UX1dBSVQoMCk7CiAJVFNUX1BST0NFU1NfU1RBVEVfV0FJVChwaWQs
ICdTJywgMCk7Ci0Ja2lsbChwaWQsIFNJR0lOVCk7CisJU0FGRV9LSUxMKHBpZCwgU0lHSU5UKTsK
IAogCS8qCiAJICogVFNUX0NIRUNLUE9JTlRfV0FJVCBoYXMgYnVpbHQtaW4gdGltZW91dCwgaWYg
cGF1c2UoKSBkb2Vzbid0IHJldHVybiwKQEAgLTUyLDUgKzQ2LDUgQEAgc3RhdGljIHZvaWQgZG9f
dGVzdCh2b2lkKQogc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewogCS5mb3Jrc19jaGls
ZCA9IDEsCiAJLm5lZWRzX2NoZWNrcG9pbnRzID0gMSwKLQkudGVzdF9hbGwgPSBkb190ZXN0LAor
CS50ZXN0X2FsbCA9IHJ1biwKIH07CgotLSAKMi40OC4xCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
