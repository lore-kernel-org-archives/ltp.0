Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ED7C83F1A
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752533445; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=gmM4Bey7ME+u+qqYx0/7f9p6WmOC1rEZHXlOVVfBiq8=;
 b=GMF2H0e3VEMrrp0LZRokhMibbv94Mb+Fem+8JZpznn/QeAWev1F/xqwDy6cAgfj9k8iWP
 7CSFkqNFBDuy3SZ7ULuGrg3xiEmSA58b6jbSnVaa+dageutzltDpcaPc0/LJ0w7twetHK30
 93nuvzLWrgTfxf/hQN80xqR4lyOBIVU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B826D3CBE65
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 00:50:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 945FE3CB864
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 00:50:24 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E80A2600477
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 00:50:22 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45600581226so27606095e9.1
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752533422; x=1753138222; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IneboDTsrybfVTylLMt5Ra0TK2dcKjEfedhzNcH6ZkQ=;
 b=KkzgtXwrlEzJ6OcGBiCaOt/fqBK8qj5JPZ8DKw4uo273z3nVZag9RvgGlTC0iqpgyE
 dvdA3wKYZeetMYiojWQ7lkog9pwBqEsXpLRFcqg6TMJvNZDLrrakLgasTLZBRdgfACpB
 MVzkQmcddYsDutDYFMA/An7llMhYnE5+mjyxx0vUFuj79jsl3Tt9t9bcqIz340Vs7+A7
 nQeNu4sKQNkGlbIkXJj+WHJbDc4GF91xtse2x2b/CmeQZLHhJROv3S9kzBC+lhYWhAf/
 0nH2tZG4AeWVtGDwoEOadMaA2ItUXdcNze/qU9EpKqzjxIVbIyzj5nnjeWfWF1lGxdeZ
 n+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752533422; x=1753138222;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IneboDTsrybfVTylLMt5Ra0TK2dcKjEfedhzNcH6ZkQ=;
 b=rg1q/IhYd/xpG67QJKAmmBz2GBb0L5n/FktTSpAzmycoSMT+GU+bDAQH+GeRV6zFLo
 IcSaBN/bv25h+OGZ3oDhX2i70LeXP7VoCzzkqcRFRK58ytdkyTML2uSLQVgq2N0aYZPC
 7rKrBQj6teshQbJ88TT0eZqDyt35hq04iC+gUI+kNzr9gSKRKhnEVq5hHrbXtMamxdow
 QDLMs28PjMnRu8LF6axUqMJOT0YrJRktUhA3nWdnUQ6q+zxkskOIgMsJmjWwabC/eJSl
 Q9ESCVMZ23Sxqgoymzoafyd6MVa135pALG192UkEHGCnCq1DvrNTKkGO19uBsk892vV+
 iy/Q==
X-Gm-Message-State: AOJu0YwTd1ow4QFmXNiJJpGjlUp0HnrsQPnX2I9gqNDhZ4qptX/fxdOs
 NaeSXapPfI2VZJtZwWuAIadoUfcv8dP8ZJPO3QXRsyqcY++BAfE8gnrALy73ccrMAzx1G6Frj+G
 XQCg7
X-Gm-Gg: ASbGnctKW1gMbWvEu4D06Px8hzH359VKGVAfjizC1R4xVYU8fsrjSuTgC3e6ML7A/2r
 j8sVNCwhtwPtjMdmHgvhj5iS3w9a5lsJUdl05Yya1zWT8bKoBqM0b5yfSmjxGhkp8nnxeowoCcD
 Vy9C2PpMqUeT485ilzZyX3EDIw1WCV2D75gnMY/s7iR3wdoec19fy7NfDf75ffKw/k7wNn8eCvL
 4CTVJjJNKGpb7HOzvwFUkPuAoYSUEPV4akQIfL5bBWKLj08bY55FztZmxVcPwP3zbAPfK/zywH7
 hCf/WF6ZdOXMqxOMVBjX3xbPSjd0P763d+ETdnRkH7ymSnbQnRJBT3CGT+mMi7SdpHF4RUiTUOn
 xwUz5Z0O0fvn3UzRa8KVp
X-Google-Smtp-Source: AGHT+IFcTyZL9yScY04qnMihUHDaeCslChSHD3jOiPbNi+0QCszK7tGDob/D2omzg12H5J1XmFHVbw==
X-Received: by 2002:a05:6000:2386:b0:3a4:f7af:db9c with SMTP id
 ffacd0b85a97d-3b60a1c6b8fmr251817f8f.59.1752533421916; 
 Mon, 14 Jul 2025 15:50:21 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23de43313d3sm106067485ad.144.2025.07.14.15.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 15:50:21 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:50:04 -0300
MIME-Version: 1.0
Message-Id: <20250714-new-munmap04-v6-1-f043e764e475@suse.com>
X-B4-Tracking: v=1; b=H4sIAJuJdWgC/33POW7DMBAF0KsYrMOA++Iq9whScBlFLEQZpC07M
 HT3kK4EAkn5gXn/Y56oQklQ0fn0RAW2VNOaW1BvJxRml78Bp9gyYoRJoonAGe54ueXFXVpw0gb
 HiANCAmrkUmBKj1fd51fL3lXAvrgc5l6yuHqF0g/nVK9r+XnNbrSf/7GwUUyxgskqyo0nln3UW
 4X3sC6oD2zsP8uaFVwFQ2IrEGqw/Gj1YHmzwGGKzoCOzA9WHK0ZrGjWGDFpLai2ng5WHiwlg5X
 93+gVl1QzD/Zg933/BdYNar2wAQAA
X-Change-ID: 20250704-new-munmap04-a59ca20ae00c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4538; i=rbm@suse.com;
 h=from:subject:message-id; bh=T7tUH5cNIfa6hDXc2Do/iV16/3hFIR875vH+4r6n2Jw=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBodYmqr1KMxKUcz863GEYXiBSdg0dgpxeVq6kAH
 VPjVtts0BKJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaHWJqgAKCRDJC4p8Y4ZY
 piD/EACjd471SCc7cZ8Ukfkdk4rQ2Q4eXnom8hwDHeJGHQEwtRvNmYnSFoBV50+urerxO17kV/9
 A0VXKyTTvHy4V88q0s8rhopm+5GVWQ8o+WjXmROKZU4bTv8yq6Yn25h47KW83ojc3fUWiO3IdBM
 tkSKcdtKCoihMIGaQ11njW/mjPeWikAVdknrFBO42i+kOlC1WIMGj6hKgXi19GM2TVWi3i+wEoY
 MLh8eTII/jK6RTJsmIFiTYhMkG4wUp4SIDrpAKIvDajEy0DZJd06ZKU9PnLIkcYw0Ptf5t31z51
 z7WO2hgcRLzGN649e6UVMbou3SYh45v99wzuTROcbQvjpx8Wq4/U5U4YLecyUiy1FM0c9BBQG1R
 nMX8yNVUtpfg4Yfum/gZOnZgHIX2zE0/oEdYl+3ddxGpbN3Q9FDGvJ/FBeZw6aXc0DLo3vdHPzz
 w6t9JkHq7Fm4Be6tHZrCv9B7fUgfpNFGlUInN8JbDvsszqrUIJSyW+zSnpkrxHLge1yp7XDRvdy
 Z2yRXadDIANSxP9wLhu95vlPRjIQj5FQu63mcjV04pMapXRIYm3XbUpwXpeZQIDGEoanw3Ha5hY
 lgH7CDsNUUxWMzGEKKbgGE8xvNTGf+OKgvE3O0rRntQveS+euaY0MWOiKX3bLICHnTMVoO9Yo+p
 9HUB6I40HE+EoiQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] syscalls: munmap: Add munmap04 to check ENOMEM
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoZSBFUlJPUlMgc2Vj
dGlvbiBvZiB0aGUgbW1hcCgyKSBtYW5wYWdlIHNheXM6CgpFTk9NRU06IFRoZSBwcm9jZXNzJ3Mg
bWF4aW11bSBudW1iZXIgb2YgbWFwcGluZ3Mgd291bGQgaGF2ZSBiZWVuIGV4Y2VlZGVkLgpUaGlz
IGVycm9yIGNhbiBhbHNvIG9jY3VyIGZvciBtdW5tYXAoKSwgd2hlbiB1bm1hcHBpbmcgYSByZWdp
b24gaW4gdGhlCm1pZGRsZSBvZiBhbiBleGlzdGluZyBtYXBwaW5nLCBzaW5jZSB0aGlzIHJlc3Vs
dHMgaW4gdHdvIHNtYWxsZXIgbWFwcGluZ3MKb24gZWl0aGVyIHNpZGUgb2YgdGhlIHJlZ2lvbiBi
ZWluZyB1bm1hcHBlZC4KCkFkZCBhIG5ldyB0ZXN0IG11bm1hcDA0IHRvIGFkZHJlc3MgdGhpcyBz
Y2VuYXJpby4KClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5j
b20+Ci0tLQpDaGFuZ2VzIGluIHY2OgotIFJlLWFkZGVkIG1pc3NpbmcgdHN0X3Rlc3QubmVlZHNf
cm9vdAotIExpbmsgdG8gdjU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA3MTAtbmV3
LW11bm1hcDA0LXY1LTEtNmRiNjM1MTcyYmU5QHN1c2UuY29tCgpDaGFuZ2VzIGluIHY1OgotIERy
b3BwZWQgYXJndW1lbnQgcGFyc2luZyBpbiBmYXZvciBvZiB0c3RfdGVzdC5zYXZlX3Jlc3RvcmUK
LSBMaW5rIHRvIHY0OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNzA4LW5ldy1tdW5t
YXAwNC12NC0xLTg4NGY3NzQxNzliMUBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2NDoKLSBSZWJhc2Vk
IGFmdGVyIG11bm1hcCBjb252ZXJzaW9uIHRvIG5ldyBBUEkKLSBMaW5rIHRvIHYzOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNzA3LW5ldy1tdW5tYXAwNC12My0xLWUzZWZkYThlN2Qy
YkBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2MzoKLSBBZGRlZCBtaXNzaW5nIGluY2x1ZGUgdG8gImxh
cGkvbW1hcC5oIgotIE1hZGUgbWF4X21hcF9jb3VudCBhIHRlc3Qgb3B0aW9uCi0gS2VlcCB0aGUg
bWFwcGVkIHJlZ2lvbnMgaW4gdGhlIGhlYXAKLSBSZXF1aXJlZCBtaW4uIGtlcm5lbCB2NC4xNwot
IExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA3MDQtbmV3LW11bm1h
cDA0LXYyLTEtNDM2YzgwZGY5NjQ2QHN1c2UuY29tCgpDaGFuZ2VzIGluIHYyOgotIENvcnJlY3Rl
ZCB0aGUgY29tbWl0IG1lc3NhZ2UKLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9yLzIwMjUwNzA0LW5ldy1tdW5tYXAwNC12MS0xLTZlZjk2MTM4YjA5MkBzdXNlLmNvbQotLS0K
IHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArCiB0ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC8uZ2l0aWdub3JlIHwgIDEgKwogdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYyB8IDc1ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDc3IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9ydW50ZXN0L3N5c2NhbGxzIGIvcnVudGVzdC9zeXNjYWxscwppbmRleCA5YzgwYmNjYjA5
MTE0ZDhiOTczMGZkZWUwNWUzZTI4ZjVjYzQ0YWZjLi4wMTEyNjg3OWQyZDY3OWJkNTI5ZWUzNjU3
ZjY1ODU5ODcyODkwMGYxIDEwMDY0NAotLS0gYS9ydW50ZXN0L3N5c2NhbGxzCisrKyBiL3J1bnRl
c3Qvc3lzY2FsbHMKQEAgLTk1MCw2ICs5NTAsNyBAQCBtdW5sb2NrYWxsMDEgbXVubG9ja2FsbDAx
CiAKIG11bm1hcDAxIG11bm1hcDAxCiBtdW5tYXAwMyBtdW5tYXAwMworbXVubWFwMDQgbXVubWFw
MDQKIAogbmFub3NsZWVwMDEgbmFub3NsZWVwMDEKIG5hbm9zbGVlcDAyIG5hbm9zbGVlcDAyCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC8uZ2l0aWdub3JlIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvLmdpdGlnbm9yZQppbmRleCBhYTZlMTRh
NjcwZTg1ZGQxN2Y5NjViNGE0NjU5OTdhMDIxZjhiNGFjLi43YWRlODYzOTBhMzRjZDZmYmJmNjUz
MDM4NWU4OTFlMDFlMmI5MTM3IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L211bm1hcC8uZ2l0aWdub3JlCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFw
Ly5naXRpZ25vcmUKQEAgLTEsMiArMSwzIEBACiAvbXVubWFwMDEKIC9tdW5tYXAwMworL211bm1h
cDA0CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAw
NC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYwpuZXcgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwLi5lMDQ2ZDE3YTc1ZjhmNzVjNWIxMWQ1NjljMzNkYTQxZDdhZGM3ZDA5Ci0tLSAvZGV2L251
bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYwpAQCAt
MCwwICsxLDc1IEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRl
cgorLyoKKyAqIENvcHlyaWdodCAoYykgMjAyNSBTVVNFIExMQyBSaWNhcmRvIEIuIE1hcmxpw6hy
ZSA8cmJtQHN1c2UuY29tPgorICovCisKKy8qXAorICogVmVyaWZ5IHRoYXQgbXVubWFwKCkgZmFp
bHMgd2l0aCBFTk9NRU0gYWZ0ZXIgcGFydGlhbGx5IHVubWFwcGluZyBhbgorICogZXhpc3Rpbmcg
bWFwLCB3aGlsZSBoYXZpbmcgdGhlIG1heGltdW0gYW1vdW50IG9mIG1hcHMgYWxyZWFkeSBhbGxv
Y2F0ZWQuCisgKi8KKworI2luY2x1ZGUgInRzdF90ZXN0LmgiCisjaW5jbHVkZSAibGFwaS9tbWFw
LmgiCisKKyNkZWZpbmUgUEFEIDIgLyogYXZvaWQgYWRqYWNlbnQgbWFwcGluZyBtZXJnZXMgKi8K
KyNkZWZpbmUgTUVNU0laRSAzCisjZGVmaW5lIE1BUF9NQVhfQ09VTlQgNjU1MzAKKworc3RhdGlj
IHVpbnRwdHJfdCBiYXNlID0gMHgxMDAwMDAwMDBVTDsKK3N0YXRpYyBzaXplX3QgcGFnZV9zejsK
K3N0YXRpYyB1bnNpZ25lZCBsb25nIHZtYV9zaXplOworc3RhdGljIGludCBtYXBfY291bnQ7Citz
dGF0aWMgdm9pZCAqKm1hcHM7CisKK3N0YXRpYyB2b2lkIHJ1bih2b2lkKQoreworCVRTVF9FWFBf
RkFJTChtdW5tYXAobWFwc1syXSArIHBhZ2Vfc3osIHBhZ2Vfc3opLCBFTk9NRU0pOworfQorCitz
dGF0aWMgdm9pZCBzZXR1cCh2b2lkKQoreworCXBhZ2Vfc3ogPSBTQUZFX1NZU0NPTkYoX1NDX1BB
R0VTSVpFKTsKKwl2bWFfc2l6ZSA9IE1FTVNJWkUgKiBwYWdlX3N6OworCisJbWFwcyA9IFNBRkVf
TUFMTE9DKE1BUF9NQVhfQ09VTlQgKiBzaXplb2YoY2hhciAqKSk7CisJZm9yIChpbnQgaSA9IDA7
IGkgPCBNQVBfTUFYX0NPVU5UOyBpKyspCisJCW1hcHNbaV0gPSBOVUxMOworCisJd2hpbGUgKDEp
IHsKKwkJdm9pZCAqcCA9IG1tYXAoKHZvaWQgKikoYmFzZSArIFBBRCAqIHZtYV9zaXplICogbWFw
X2NvdW50KSwKKwkJCSAgICAgdm1hX3NpemUsIFBST1RfTk9ORSwKKwkJCSAgICAgTUFQX1BSSVZB
VEUgfCBNQVBfQU5PTllNT1VTIHwgTUFQX0ZJWEVEX05PUkVQTEFDRSwKKwkJCSAgICAgLTEsIDAp
OworCQlpZiAocCA9PSBNQVBfRkFJTEVEKQorCQkJYnJlYWs7CisJCW1hcHNbbWFwX2NvdW50Kytd
ID0gcDsKKwl9CisKKwlpZiAobWFwX2NvdW50ID09IE1BUF9NQVhfQ09VTlQpCisJCXRzdF9icmso
VEJST0ssICJNYXBwZWQgYWxsICVkIHJlZ2lvbnMsIGV4cGVjdGVkIGxlc3MiLAorCQkJbWFwX2Nv
dW50KTsKKworCXRzdF9yZXMoVElORk8sICJNYXBwZWQgJWQgcmVnaW9ucyIsIG1hcF9jb3VudCk7
Cit9CisKK3N0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKK3sKKwlmb3IgKGludCBpID0gMDsgaSA8
IG1hcF9jb3VudDsgaSsrKSB7CisJCWlmIChtYXBzW2ldID09IE5VTEwpCisJCQlicmVhazsKKwkJ
U0FGRV9NVU5NQVAoKHZvaWQgKikobWFwc1tpXSksIHZtYV9zaXplKTsKKwl9CisJZnJlZShtYXBz
KTsKK30KKworc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0geworCS50ZXN0X2FsbCA9IHJ1
biwKKwkuc2V0dXAgPSBzZXR1cCwKKwkuY2xlYW51cCA9IGNsZWFudXAsCisJLm5lZWRzX3Jvb3Qg
PSAxLAorCS5taW5fa3ZlciA9ICI0LjE3IiwKKwkuc2F2ZV9yZXN0b3JlID0gKGNvbnN0IHN0cnVj
dCB0c3RfcGF0aF92YWxbXSl7CisJCXsgIi9wcm9jL3N5cy92bS9tYXhfbWFwX2NvdW50IiwgVFNU
X1RPX1NUUihNQVBfTUFYX0NPVU5UKSwgVFNUX1NSX1NLSVAgfSwKKwkJe30sCisJfSwKK307Cgot
LS0KYmFzZS1jb21taXQ6IDBjNzM0NmNiMDk3NDQwOTAyNTY4ODU2NTI3YmU3MTYyZjU5NTA0OTcK
Y2hhbmdlLWlkOiAyMDI1MDcwNC1uZXctbXVubWFwMDQtYTU5Y2EyMGFlMDBjCgpCZXN0IHJlZ2Fy
ZHMsCi0tIApSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
