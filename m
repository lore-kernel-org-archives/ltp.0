Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EF2C021AA
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 12:59:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 344673C9C26
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 13:59:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9ED133C4C99
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 13:59:41 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C90FC2814DC
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 13:59:40 +0100 (CET)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fc0d44a876so6156266a91.3
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 04:59:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797178; x=1740401978;
 h=to:content-transfer-encoding:mime-version:message-id:date:subject
 :dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXIs+Gtl7+obfh1TnXK/elF1UhOD6bWzJUXgxTEb/Xw=;
 b=mp2tNy/K+gJrtvrWe1nK/JzpbX/D6c7K9TVwoGarS+c4Gj52QNHvQ8Kq208ozuHdtV
 u2zQSSKyyXUz6WKRhyuscy2xmmCtL6087yuAZ05bhrYwBJ+4xz9OK5NaaHBDX2SO3gMl
 vpK/jQgfEGBcTvKHFimkOQM8tnim5JRP2cyGVHlMWgjMg/2DpAdBG+ua7WL9HFG0mjQN
 ehmmHd0zEzisq01TdIjKa6I8RDU3DUumEEffXaeW3UOEkNAtOwVcv3AQWkvnR27u/XUU
 LcGo92T8hC4+gvNfMVh7JnqaF8rRuRI6kpbVok6WaHIELPz9pxxnF2VacSP6Vc4EzI6Y
 Kscw==
X-Gm-Message-State: AOJu0YydLzrY5/ID8xh9eXADtcP3iFHBzfw1xjAPr3IT7XgZG2LSE/j3
 iHZMHAIo52jKpoF09WyXlaR6tM0jgI1edjpmL0w42gg9pcXVNk9f8RhZkg==
X-Gm-Gg: ASbGncuB+MyKgPEC9cRVUH6IGGFp99n9qsIeSp3YTGKW6tJBQivrlw+QHHF1arM3GUB
 YEnmJBiPMrzux4BZmlzwf4xtS36EuPOfTrhUvP2tUY4k35Harg2t5zHPLZ+IoIpDXzCNkfKPpEc
 0ZFuvPkNWFIhqDN3xlfe5t/QQ1Jc+dK1N1HvgxKGohG8jnvYp5tnZpWXOe+/Nb5zkms+CiP1iN2
 IXBFept3SETwtgbDz9nRKWOE8air3k5LGS5VP/b4CHDWQX+oz6Bp+uLAP44Rt8SxoTLQak3WDRi
 n8hJrJKJXN2jAD6iH3ddKc6LSy3hLA+h
X-Google-Smtp-Source: AGHT+IFxVa3597Jt81wE3TX5yz81ndHBe4KNtGehHVJvMPm0QIXcMNzJDuXbZ3t/m+Xgv/ynJioviw==
X-Received: by 2002:a17:90b:3d0e:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-2fc40f105d0mr14602893a91.9.1739797178266; 
 Mon, 17 Feb 2025 04:59:38 -0800 (PST)
Received: from mail.marliere.net (marliere.net. [24.199.118.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad7c62sm7785529a91.29.2025.02.17.04.59.37
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:59:37 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1739797176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FXIs+Gtl7+obfh1TnXK/elF1UhOD6bWzJUXgxTEb/Xw=;
 b=Bv7QoCXTizwkTmNYVx8d0JpN88E2DtYsW9RPb5riU8/Wg2mHwQ0jave2xHbdOyG/I6W7Vt
 uyi9QP7brD9tbWk71fyUd6z7V/x10ojd+++iNZXwYhtNJjJfoDJfMSPQTuBmfQiw1ccwwL
 ZHUiodd6gN0g0lhm/llI3eutXL/z0VUYxLvpwQKAHvSHIiO7g2csxoI+Y/RlOlsAqUsGFY
 6zey17hl41saYdQbZowUDLJ9xfoPn3hKMXpUKJiynhOgDRJQfyczKzGzzclKucio6qBIVI
 xKs1Dc9Baphk3wR8FVHyuaSVTE9tVboOQ8fwB+Z+Otio6S8BfngL771F0cYa6w==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 17 Feb 2025 09:59:25 -0300
Message-Id: <20250217-clear_descriptions-v1-0-90e8229d52b4@marliere.net>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK0ys2cC/x3MUQqDQAyE4atInrsQF4pLr1JKWdexBtqtJCIF8
 e7GPn4w829kUIHRrdlIsYrJtzraS0NlyvWFIIObIscrx7YL5Y2szwFWVObF1xY4jYmZ0XGK5Md
 ZMcrvH70/3H02hF5zLdOZ+mRboLTvB3SiAXR9AAAA
X-Change-ID: 20250217-clear_descriptions-08f8000e7082
To: Linux Test Project <ltp@lists.linux.it>
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=uZJgS2KiAIO7fKZq7mszyZLK5L3uvSzdurDHDRv/YQE=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnszK0v6R25uJWStL6C/FJhN2LpkaU6Ln5/eiZC
 jXDWd38wmqJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7MytAAKCRDJC4p8Y4ZY
 prgaD/4qX/e58k8615s5OzIwwv6UAR/BHk55tTm+tzZ7bUyIeSNqEqtuOf79L/7JNNTKoqiPtW3
 iNfpO2Tjh1dGviy7EttqZWdo5bpe5EQHZ44PW6f8Akf/U1aEiSvXOXQX147WYTIqqSYdUKlPsSA
 ingNDm0OPFhkqLFO50JfE0pResP0J/OWq+Eqc61PHuXJXqebhijIaZSpFMtwGQIEHIENArVbjQM
 c8RwKjLPkkco45Ne85XGhvymidY3ypxeDSj4X50KCcQ2x101vzS72mIbNfdvuMDRk8k4P1oyWQb
 m8bZEiu+IZ/IdCN1ug3BoacWZ1j8XDqlp4LlX9OeoresLXXHTwPhYsixZI/rzJETYPERFNoTdIi
 B9VvIJqqZAtEwyxOX/pfQIxHe+g0EGblcCGpoWSRByqHke2xB34jVXE/HB9MEX3+b2tAbCc/eNq
 TUrCLAaGBIpPVOdmGGnorz+y0rQ8WDN+xQJ0ASvK6HwVXUMNHyHiGzfmeoPZWTVs+JN2kxOec3n
 Jj/XpS3edlCRXjvEtD0b8GViCVgMSNh2n9m7O3unLKmQvK8hz4oR8Jhh/YFSW/QquDZS+uXKBFU
 DDRq2J8upZeZk+eTBQstGEoBhf2k42DLz+lw6cF+VWYud9iQMpIFXuzfxqaIWBIN07b627qismG
 AgmkzlTVwtsmFPg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Clean [Description] leftovers
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksIHBsZWFzZSBjb25zaWRlciBwdWxsaW5nIHRoaXMgc21hbGwgY2xlYW51cCBzZXJpZXMuCgpU
aGFuayB5b3UsCi0JUmljYXJkby4KClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJl
IDxyaWNhcmRvQG1hcmxpZXJlLm5ldD4KLS0tClJpY2FyZG8gQi4gTWFybGnDqHJlICgyKToKICAg
ICAgZG9jOiBSZW1vdmUgW0Rlc2NyaXB0aW9uXSB0aXRsZQogICAgICBzeXNjYWxscy9mb3JrMDE6
IEltcHJvdmUgdGVzdCBkZXNjcmlwdGlvbgoKIHRlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIv
aHVnZW1tYXAvaHVnZW1tYXAxNy5jIHwgMiAtLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRs
Yi9odWdlbW1hcC9odWdlbW1hcDE5LmMgfCAyIC0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2ZvcmsvZm9yazAxLmMgICAgICAgICAgICB8IDYgKystLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2ZvcmsvZm9yazAzLmMgICAgICAgICAgICB8IDIgLS0KIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZm9yay9mb3JrMDQuYyAgICAgICAgICAgIHwgMiAtLQogdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9mb3JrL2ZvcmtfcHJvY3MuYyAgICAgICAgfCAyIC0tCiB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2dldGV1aWQvZ2V0ZXVpZDAxLmMgICAgICB8IDIgLS0KIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZ2V0ZXVpZC9nZXRldWlkMDIuYyAgICAgIHwgMiAtLQogOCBmaWxlcyBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQotLS0KYmFzZS1jb21taXQ6
IGEzZTI3ZGYzNGQ2Y2I0OTQ3N2M5YmQ2ZjliYmFhMWNlNGRlMTU1ZjkKY2hhbmdlLWlkOiAyMDI1
MDIxNy1jbGVhcl9kZXNjcmlwdGlvbnMtMDhmODAwMGU3MDgyCgpCZXN0IHJlZ2FyZHMsCi0tIApS
aWNhcmRvIEIuIE1hcmxpw6hyZSA8cmljYXJkb0BtYXJsaWVyZS5uZXQ+CgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
