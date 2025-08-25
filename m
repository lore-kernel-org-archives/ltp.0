Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF017CA0FE7
	for <ltp@archiver.kernel.org>; Mon, 25 Aug 2025 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756127904; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=10SABW3mKPyXWLwy8aoHkhpueBgt2JBsnbZ92lCDMPQ=;
 b=Qwri43zDiEhJJSC9Eyih6dW1DUgE0hfZyd+VoU4v84fBq4sH9wNNuA2gy020ci6yKoDoB
 Jb39DFb2WEeMpBPlKLdVUVVSni28TKdTCYxzKeFo9B2IFDw7pUARWuMRANa44NHKhkMWmVy
 7gBv7NTYwweXM0EbOyJVj+YQG2MDfHE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BEB73CD09A
	for <ltp@archiver.kernel.org>; Mon, 25 Aug 2025 15:18:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF9703C018D
 for <ltp@lists.linux.it>; Mon, 25 Aug 2025 15:17:39 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0637C1000246
 for <ltp@lists.linux.it>; Mon, 25 Aug 2025 15:17:37 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3c7aa4ce823so1091995f8f.0
 for <ltp@lists.linux.it>; Mon, 25 Aug 2025 06:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756127856; x=1756732656; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vJe/QX6F8ZkMyjW+/b5+xU6KoItfWciFd+tjjJvBS64=;
 b=BU6d3rubtihSH0GChTEGA7KMQt1nEXKRp2pYDb9USSHVV6LEZ/B+bn+Nd5DYekdlLs
 Cd+ueGDvTHKIQ2veDekgfE3GdrAnfod7oypAYqHYB7pVnk0tWZEpHPgEMY9kiC4ZA1ua
 OUqJjGpDf7MghBD5IMKtC35OBGnvupzI+n+Vhx62AjKJPyptinYC6VKjqOHK0+9ts6M4
 77SHjLZVRg5KYv9AUU/tXa+ivnrZypgLfr8unFeOAUjdFDR7pdbSf1USe7DO2S7T8taa
 A/8y3qT4u6UCH3mIqHsXVLHl8e95fgMHaJfVCHBfp7KcN7DqpwROAYs3jWs8CticKJF5
 c16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756127856; x=1756732656;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vJe/QX6F8ZkMyjW+/b5+xU6KoItfWciFd+tjjJvBS64=;
 b=rlkbV3L6I/Qseo9AAc1jy/zuvbKI5lXELLE/0O1SwS00/TlKbfGcJyA2cL8BX6nuLV
 t2k+dKLIrc1OaPqJv6JwShUyxs6Tj9rs4hxzvn9xx+idoh3qIb9LxbUuCxpaM2Q16viT
 mG94HEK10hUb4X56TdSH75SVzVN4mPe/SqApVfqsMfhJ8xicJIgGnc14lB5+Dv4o22Ko
 KkHIzG8vYh8y5RlrExFMnjTuiSjswHExcWiU2Y8fpzzmgYks5ecH4qEwDX/7Dx2VeAAE
 kqY05VE5KzzU0RagvwQLn77/yf4n2kuxWQ2+NWZRBDekDnBjK8fpDtG9ByLrGFxV0v6G
 Kdtw==
X-Gm-Message-State: AOJu0Yy8sfV5XPYto1GpAtg3fYLQ9XJHm2UoSZHythRFzHp9F3k9IRgc
 F0bs3cLRoTCzpAwQskOI4ikJxBOsOKgUv+E45c1sK9pZzFQm89tH9G7wldAx6veDuQ8=
X-Gm-Gg: ASbGncvqpR7HBZr47waeDLgv0mpo9SpivWz/JvUy5pS5Z2gvTLya9sz/3V6jLGTp7Nl
 e/D6zvGerEnj3P3KRu3emCA6DTKx0QKKYRpMB2xxzGiHrrkN6J87U0VDxTw1ulxuVlkJYJqIfD9
 OHF8bj4sK/qmp0muMdCa/aM5pPtMqNqh4tdVOwfFKWWdEjb92NffMGZBfo0wPvJ2F+wBMCBuzFf
 e/WOuCnH6ZPxLwdmD/FAmhplKD2v/rSI7E/vjJR7IkhXx2DcwHr/qUW6wDTc7zj4UAcpv9AScJe
 aycSnYhosbSsREHGNSv2f9iEYU+ofizHGN5wHjF19z6wCaOOK/VAgSOYP0PxIV9C2vTbNXXopL+
 K2yhBe/EfyyI=
X-Google-Smtp-Source: AGHT+IFvJ634A7m38+fBUl2ZNhKaDhHJH+HnhSPW64+7NSmb1ztSSzo/51I4YAOZEaN+I/Pa9ZlwaQ==
X-Received: by 2002:a5d:5f4b:0:b0:3c3:5406:12ac with SMTP id
 ffacd0b85a97d-3c5dcff709bmr8669369f8f.60.1756127856273; 
 Mon, 25 Aug 2025 06:17:36 -0700 (PDT)
Received: from localhost ([177.94.120.255])
 by smtp.gmail.com with UTF8SMTPSA id
 a1e0cc1a2514c-8923731e051sm1455325241.2.2025.08.25.06.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 06:17:35 -0700 (PDT)
Date: Mon, 25 Aug 2025 10:17:30 -0300
Message-Id: <20250825-conversions-lchown-v3-0-2d261b3de236@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGpirGgC/32NwQ7CIBAFf6XhLIZSsdWT/2E8LHSxJAqGrahp+
 u9CL3owHieZN29ihNEhsX01sYjJkQs+Q7OqmBnAn5G7PjOTQirRCslN8Alj0YhfzBAenne9Nqp
 rbC10x/LwFtG65xI9njJrIOQ6gjdDSV2BRoxFHByNIb6W81QX/e9PqrngYFrodQNW1f2B7oRrE
 66s3CT5KXRi+7Mgc6HZKLUTFi0AfhXmeX4DS4vTrQ4BAAA=
X-Change-ID: 20250702-conversions-lchown-8dbc583f10b8
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1542; i=rbm@suse.com;
 h=from:subject:message-id; bh=pcT17HO3eFmKdlXNSb1zRLP8GY9UqQMy50WYIum73Hc=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBorGJs/QXRDTi5JwsBeqJQBrBJMw3jvDDZZsKzO
 wn0SZIApamJAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaKxibBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKa+PA/+LLnp9A/lTrBo7fHbzW1ZBprYUk7G+V7
 INN1EB4vltuBE6wxlyqF3Dc5+7yCk0E02idc0QsgM3QmlMN7vKKIAc1UAj8w+4yYqpRwIfUROH0
 LY9kzisPF2WGsjv5Ck/mo2qAySPL/+ORMAX29r2zX15ec4uW+/I0C+E6icMEfXqcYgK4cN2ZLvk
 20p9uUDnzRwp7lWBxa7BMmcPdeolSp4PIKoE/2KZ4vrFGM959RN6b5BnOnqdvAkknKJ17j60IXP
 fAPu05H+ynXQ+xFRv9Qi1KlZRvlD1Mr/raSgQzjfeMP0rFj01N2U4asZrdqOJOJFT3IKjqqRcHJ
 32L1WW9xDMTPO8EcOOUfqDTMvJDcNY9XxYuRd0IFNQhS3a5daiadAR79tGuI+2VDORq/FLuvdfi
 ThW+hqcGR0k/0WCmqjcgPiVDklo/CokzRiAGjg8jVcxuwFNkrBVV8M63SpFjfB3dxUlGqf+5B0q
 nKpWbr+vrZPfHsYFhfedLm2Clm5SZrX5X+2x7FDWd7oRcJelxOSF2MGEoowyNUB+I7QbD6YOVGD
 UHMRp9PC95FA2XCdlyv5NwY+fQqXwP9DYv3EnYG/Wt7GDMtdFZtCWxYTTWIEdcQ/Ru7D6Cl4Phs
 sNPYp6gL4Q8F0KnvpGJ/A2dpYcUqk11lpGmkWss14K72puHCNOBM=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] syscalls: lchown: Convert to new API
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
YW5nZXMgaW4gdjM6Ci0gUHJvcGVybHkgdXNlZCBidWZmZXIgZ3VhcmRzCi0gUmViYXNlZAotIExp
bmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA4MDYtY29udmVyc2lvbnMt
bGNob3duLXYyLTAtMzQ1NTkwZmVmYWFlQHN1c2UuY29tCgpDaGFuZ2VzIGluIHYyOgotIEpvaW4g
dGVzdF9jYXNlX3Qgc3RydWN0cyBhbmQgYXJyYXlzIGRlZmluaXRpb25zCi0gU2ltcGxpZnkgb3Zl
cmFsbCBieSByZW1vdmluZyB1bm5lZWRlZCBjb21tZW50cwotIFVzZSBvY3RhbCBwZXJtaXNzaW9u
IG1vZGVzCi0gVXNlIFNBRkVfVE9VQ0ggd2hlbiBwb3NzaWJsZQotIGxjaG93bjAxOiBSZW1vdmVk
IHVubmVlZGVkIHVzZSBvZiBnZXRldWlkKCkgYW5kIGdldGVnaWQoKQotIGxjaG93bjAyOiBNZXJn
ZWQgYWxsIHNldHVwIGludG8gYSBzaW5nbGUgZnVuY3Rpb24KLSBsY2hvd24wMzogQWRkZWQgdGVz
dCBkZXNjcmlwdGlvbnMgYW5kIHVzZWQgc25wcmludGYoKSBpbnN0ZWFkIG9mIHN0cmNweSgpCi0g
TGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDcwMi1jb252ZXJzaW9u
cy1sY2hvd24tdjEtMC1hYzdhZGIzYWY1MWRAc3VzZS5jb20KCi0tLQpSaWNhcmRvIEIuIE1hcmxp
w6hyZSAoNCk6CiAgICAgIGxpYjogQWRkIFNBRkVfTENIT1dOCiAgICAgIHN5c2NhbGxzOiBsY2hv
d24wMTogQ29udmVydCB0byBuZXcgQVBJCiAgICAgIHN5c2NhbGxzOiBsY2hvd24wMjogQ29udmVy
dCB0byBuZXcgQVBJCiAgICAgIHN5c2NhbGxzOiBsY2hvd24wMzogQ29udmVydCB0byBuZXcgQVBJ
CgogaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5oICAgICAgICAgICAgICAgICAgICB8ICAgMyArCiBp
bmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oICAgICAgICAgICAgICAgICAgIHwgICAzICsKIGxpYi9z
YWZlX21hY3Jvcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTkgKysKIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbGNob3duL01ha2VmaWxlICAgfCAgIDUgLQogdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9sY2hvd24vbGNob3duMDEuYyB8IDE5MSArKysrLS0tLS0tLS0tLS0tCiB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xjaG93bi9sY2hvd24wMi5jIHwgMzQzICsrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGNob3duL2xj
aG93bjAzLmMgfCAxNzUgKysrKy0tLS0tLS0tLS0KIDcgZmlsZXMgY2hhbmdlZCwgMTg1IGluc2Vy
dGlvbnMoKyksIDU1NCBkZWxldGlvbnMoLSkKLS0tCmJhc2UtY29tbWl0OiBiZTk3ZDI3NDRlN2Zk
OGIxM2ZhOWY3OWMwMmEyOTFmZGEzNDJjNDliCmNoYW5nZS1pZDogMjAyNTA3MDItY29udmVyc2lv
bnMtbGNob3duLThkYmM1ODNmMTBiOAoKQmVzdCByZWdhcmRzLAotLSAKUmljYXJkbyBCLiBNYXJs
acOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
