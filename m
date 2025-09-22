Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159F1CAC592
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758538209; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=jJ36/av+MJtdvqs93nnkaKzHnHqwzXMhiCdXUIm2nFg=;
 b=LGL7IAr+ave4frAL6wCoBqSp8Mn4lwFfP0OC8OSG4q9ft2JhghV+U5/Gf3eEYIwriTLQl
 xfMVO75CuLPooTG1RwodZjt41IUO3vkR5rQFqepWOap5TuBfD8MPqxsga+2I/kj7+Rq82Y/
 kZQ+RVlu6CnIfgFLnCS9ikx84GLaj0Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82E673CDE5B
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 12:50:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78B763CDE3A
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 12:49:47 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9E2F91A0014E
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 12:49:46 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45e03730f83so17538235e9.0
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 03:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758538186; x=1759142986; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8dEP2Yc65WNUP2jqEHzGwKdppW7PsOTKwKAnnstimOc=;
 b=CKfNfJu/r0M/zrZHaxJT075479NS/yu7WWER4hiqcdqhQghM+NanO8fa/WcYup3U4f
 j4hRv+EJ53SGR+pteSnR4ZcSZUjGnGBBwVbvJ2ZvZun8YIIm1/dr1D9ZWDfvogemKoTk
 0rzP3xII83lY/QvBCMP6KvxHxtE2zvoMjS7k9gwNFCmfzLnQBQtErJbUvfsFsfSxIJoE
 ViA12O+HmMOCYe4BGr8+umUkIdcqE77VaD442i1HJJokYavPj03Bb7RNgtTQKaBm8Hpq
 HOGNZxpN9SLifgafgdcvvYj0/IO7tm0xe1l1iYwegt7osHY0jbwdi7c9U6JzkTUBiW1e
 fSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758538186; x=1759142986;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8dEP2Yc65WNUP2jqEHzGwKdppW7PsOTKwKAnnstimOc=;
 b=uo+Rc5h7FFGG04D5tl42CZ4jEdf9EpkIkasVdDj57dCIWSGbRH/Y3EJNIGbwoGQfLZ
 LLESESPqYjOGmYAxg1iZ+luy2UtirGwodcjTTi9sTUmnvDhLX7oR33g0R2CaW4KbskbD
 ZwJLIyPKI9zE06LTL23+fnm3aFlYovXlwaiBPw9J8n2TtLBnPvf3w1Uejzce5o8ocrWc
 LY+d3w4U/3PwGtAeStIrSBgMwdFpFQ/JQerHedkvAqQOLMndPg2bbxggg+vlYIZVdvRe
 mpqhX7sWVG3BNKpDW8+uBQ4xeA0ZvdhGIYPtg0oN430r6Nu84QGSmZzE3p2phSRMW6+D
 bMFg==
X-Gm-Message-State: AOJu0Ywa7RyfIi4J0TBQSwO8GqHGZQMoj/nlgfwWaaEQWq0kbHILod0O
 MY2SYCmAk+3OmiMTW58e9VStqNsKbf/49Lt1CnS7y2AJ+YH5Jndbvt/xRoavkbuwg8bpo5tAYjj
 SKgxL
X-Gm-Gg: ASbGnct6VE6U5WOIqQafg9Anr/+gQXkGc1YwM6xqTISGCf2UrdTHiROO2PjW0H2OJj0
 PoflWF8KA6lXqKmKbtqG3nE1tpR4ZiuiZxNmtlGCQ7AovyCcFXfoyWzqKFoT4UXsncYimBTh4Jd
 647T0xvplqjt2mRv27uzPFOmtl3wYw/iTMRyXJPhLcd6owfYLhavWdq8qOZ7V49FthmCBtjIi0R
 RPp/DQgkjfB6UJ8lL0/Zijl7vk8tdyWpwlt2dQWunYE75CskVW+8KtqeGKK4mRARNuH/BeRXfDf
 Oz2gOw+tZhYvk2T0i47l5EizRHcfn5FLt8TZ0Q6+eGqF8FBbtWB3NQ7NTxMT49SxNwyQW9I89WH
 5ueitB8L8Ei0v6puD1cF4
X-Google-Smtp-Source: AGHT+IHgrdEQOk4xYrt0+/tOPBrdaYkbafqGjcMULXUqxYTeKAqIea/rbfOHPGTHIJErr0/jsQbRBg==
X-Received: by 2002:a5d:5f87:0:b0:3e4:5717:368e with SMTP id
 ffacd0b85a97d-3ee7c552b21mr12165820f8f.2.1758538186005; 
 Mon, 22 Sep 2025 03:49:46 -0700 (PDT)
Received: from localhost ([177.94.120.255])
 by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-4bd9b0c128bsm70122271cf.0.2025.09.22.03.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 03:49:45 -0700 (PDT)
Date: Mon, 22 Sep 2025 07:49:04 -0300
Message-Id: <20250922-fixes-pthread_rwlock_rdlock-v2-0-21802b93c2e0@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKAp0WgC/x3M7QrCMAyF4VsZ+W2hxvl5KyIjbaMNajeSocLYv
 a/z1+GBwzuBsQobXJoJlD9i0pcK3DQQM5UHO0nVgB73/ozo7vJjc8OYlSl1+n318dlpWsdRPOy
 O20QnH1qohUH5f6+B6606kLELSiXmtfkmG1lhnhdZgsZghgAAAA==
X-Change-ID: 20250922-fixes-pthread_rwlock_rdlock-ac6371da80b4
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=rbm@suse.com;
 h=from:subject:message-id; bh=qIzIsb5FvBK5QdO3oB0oMTtPyBlps60wdgDnTpRGZXE=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBo0SnFtX831w0KBwpikpOnTZP0C7caucAibJv1C
 0WXkqeyCSaJAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaNEpxRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKZeJA//TLk1Z4ybLd65GoH4uGdmQR3W4oT/qFI
 19xA5bqzP0MuAwizrdAhPyX3TBpwbC6CngE5h1DrD0IyFyU3DxzEHXOzz3Io4a0ljEOGG67PxSu
 ELH/T/8ToFkc/uz+kLI3jOGThlK75DSQEof+cbAySNoUlA+a7etzgHoufqnaC+zQZcgg0+7SvLi
 p+GU7FDUZhyP+Tpl962kxKmPyxKYC5W35u6SGhqxmBW+A1IWpLT0JSzmIEWZJd92G9OYD1DSsVe
 djB0OxUVeoDNpVw+RzXfjVK6O10ZKHVUOkE248vtmJyt8ju2VVv6ZcyxabmPZPCr5c9yAvTIkKS
 vZ/grocbLxOyRMtHXiIOxU9fgkayUECJtAGnInKq+j8iwZ25YKXECPGkACOhSEo5xbUzDnre4ec
 1VeVjh72cQSeKI6PSmLbmuiRKo/pSs+gbikCDw6s5QAOk9MCq3HzXDIP8g5pgEY+/84ewSmmYzN
 NJb0ABbcfSfWwalEBZ+RgsgMbWXsrLrXhjXbCndi7Ho99tywpGDGQJzvxjBYZqysBszr0K8IRy6
 CLKwzvQnAK0CqlZQyd35eGnUyCE5ykAhpSJBxb9FqPBWdhT3IlYXYoXynSjlK7eAO9KA676tYPf
 QapF0Q3710YMmOOe2e8zRRFNygw0LRt1eJ1NuG7QvVq9/gd0L4fI=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Update pthread_rwlock_rdlock 2nd assertion and
 add GLIBC workaround
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

Ci0tLQpDaGFuZ2VzIGluIHYyOgotIFNwbGl0IGludG8gdHdvIHBhdGNoZXMgKEN5cmlsKQotIENv
cnJlY3Qgd29yZGluZyAoQ3lyaWwpCi0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsLzIwMjUwNTIwLWZpeGVzLXB0aHJlYWRfcndsb2NrX3JkbG9jay12MS0xLTQwMmVlNDUx
MTRjY0BzdXNlLmNvbQoKU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBz
dXNlLmNvbT4KCi0tLQpSaWNhcmRvIEIuIE1hcmxpw6hyZSAoMik6CiAgICAgIG9wZW5fcG9zaXg6
IHB0aHJlYWRfcndsb2NrX3JkbG9jazogVXBkYXRlIHNlY29uZCBhc3NlcnRpb24KICAgICAgb3Bl
bl9wb3NpeDogcHRocmVhZF9yd2xvY2tfcmRsb2NrOiBBZGQgR0xJQkMgd29ya2Fyb3VuZAoKIC4u
Li9pbnRlcmZhY2VzL3B0aHJlYWRfcndsb2NrX3JkbG9jay8yLTEuYyAgICAgICAgICB8IDIxICsr
KysrKysrKysrKysrLS0tLS0tLQogLi4uL2ludGVyZmFjZXMvcHRocmVhZF9yd2xvY2tfcmRsb2Nr
LzItMi5jICAgICAgICAgIHwgMjEgKysrKysrKysrKysrKystLS0tLS0tCiAuLi4vaW50ZXJmYWNl
cy9wdGhyZWFkX3J3bG9ja19yZGxvY2svMi0zLmMgICAgICAgICAgfCAxMyArKysrKysrLS0tLS0t
CiAuLi4vaW50ZXJmYWNlcy9wdGhyZWFkX3J3bG9ja19yZGxvY2svYXNzZXJ0aW9ucy54bWwgfCAx
NSArKysrKysrKy0tLS0tLS0KIDQgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKSwgMjcg
ZGVsZXRpb25zKC0pCi0tLQpiYXNlLWNvbW1pdDogYmE2MDVjYzk1NTdlYzg2MjAwZjQ3ZWZlMzY2
ODBhMWRhOGNkNzc1NwpjaGFuZ2UtaWQ6IDIwMjUwOTIyLWZpeGVzLXB0aHJlYWRfcndsb2NrX3Jk
bG9jay1hYzYzNzFkYTgwYjQKCkJlc3QgcmVnYXJkcywKLS0gClJpY2FyZG8gQi4gTWFybGnDqHJl
IDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
