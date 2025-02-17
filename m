Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFD8C021AA
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 22:01:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 540173C9C10
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 23:01:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 527B93C993B
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 23:01:25 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C6C7B233323
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 23:01:24 +0100 (CET)
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220e83d65e5so72543195ad.1
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739829682; x=1740434482;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=m7ali0KYU724+ZdRUJb/m/sUBmtpJ+nMNpBrmLzyb54=;
 b=j9F1AVsjMJ5RxjSQ3/t3mCfnuHEgsyn4kbTdrC4iH2wDLoLunMfaZbUK1AnCp//DqF
 KdQmL6qUxBPYAvy+SFOKnXBnHOpbO8KtYGPK/3tCK+iItnoJu83tO13BtWpvwf2r45Hh
 mv0Y0GtVEtTd5H0Kf7N9xNbpMep/ZB+Ctq6taV9JHOMW2joRlzZ/LlAKhis4ptg8875D
 ohmGDyyeRBG60FdIM9E8wN1j54ng+8XtSR1bZ4HajnSeo4zZMnoldSlgHs0Isyp+Vwzo
 FIiTdWML1qtQ6WdKHgXQBwYzJZrDGdsJj+ijwbX6xfxi8JKdhBWm6jqp48joTA+nFvdi
 fLQw==
X-Gm-Message-State: AOJu0YzYMzjnE1t9Gut0MQZ8v2n/+oc81+KUGrSsgloA82AuJrMvfVkw
 wvTliOR4Gf4LJGLhUTfe7nakRAMMfNUVrt8/fRWLeYQPMka9/ZvLgAEKcV2A
X-Gm-Gg: ASbGncug82+hqz6AAOriMQSGBpaks/u9Cfu6RjWJnZ1hIzRhHmT61agPIF3LVlkAAnW
 /Gj8ihA2g7fwfGYuHAPdCKnUBIgQRZaH0ryfcsOMeyr1xB6nfCW+c8No1nKTQBlKVd+Ra4zQp8/
 Cm7dqe9D2m0ZJacyXKdMIP9xUBCMsPo3Bo9TXgMcL+K89/KuRrHuhpNNvOHr1xtfnUc4WG/VFy8
 0O2xX7VT5oBXA2zQcVKmZT6PdUr5DV1jHeZZJ+l0vQaCo7B73lX9N11n5TzPuBpIy2JMi6TYfxQ
 AhVIC9838JVU88WwHDv+jCHPj+fe+Y1g
X-Google-Smtp-Source: AGHT+IE77UoNnaIwl9M7Ll9jcdlkx5M889UyM9uRjh3ROebXRX7ET6FTHSzA2dksggbr30TYGEEqfQ==
X-Received: by 2002:a17:902:e843:b0:220:f869:1e6e with SMTP id
 d9443c01a7336-221040ac24dmr185519405ad.38.1739829682264; 
 Mon, 17 Feb 2025 14:01:22 -0800 (PST)
Received: from mail.marliere.net (marliere.net. [24.199.118.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556f97dsm76301685ad.172.2025.02.17.14.01.21
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 14:01:21 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1739829680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m7ali0KYU724+ZdRUJb/m/sUBmtpJ+nMNpBrmLzyb54=;
 b=fLHoxP6YNSIpB4F/ZazQpMtncvfVADZd5VabQJaMbSqa9l/XmWJMp1pmzGFaOYCAj6S67H
 WXecnTQKvggq2xMLw/RTq1Kwjzfx3y2/572/lKm87s317CbW+js0gC9uaEa28curoE9Gzp
 IzmzsZLFHd8PpJ+//mVoJBe7rVVTeIeaC0hJgf8fT6+C0cKvTOVbp3JEBsULaGlmgSC7Q9
 hJ7qU6LQpruZx5YaTOvRT0c52Tm2qZqZSLylBC+9irZLQQxkInzdMA7KENQqKQ9dirS8jk
 EGWap2lF7Bp4l/Lw59/5r1JiYC+VcGHo+Nf/reTLHEsfZmNXXIxslWfZetdIgQ==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 17 Feb 2025 19:01:14 -0300
Message-Id: <20250217-conversions-pause-v1-0-be8be41cb154@marliere.net>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKqxs2cC/x2MwQ6CQAwFf4X07Cawoqi/Yjx0l4f04EJaJSaEf
 7d4nGRmVjKowOhWraRYxGQqDs2hojxyeSJI70yxjqc6Nl3IU1mgu2Zh5o8htOnatwnH4dKdybt
 ZMcj3/7w/nBO7lJRLHvfTi+0NpW37ATnvXhN8AAAA
X-Change-ID: 20250217-conversions-pause-4b9d4be3f876
To: Linux Test Project <ltp@lists.linux.it>
X-Developer-Signature: v=1; a=openpgp-sha256; l=655; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=5ay74GFGU4xdru42bz5sAM9u3s3DxzzHXVpovFS+9U8=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBns7GsKdQ7t7P+dS2xKyFP+tuiBt3qHV9lbyDxn
 hky0/kAKPOJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7OxrAAKCRDJC4p8Y4ZY
 puUFD/4ifY6PqAsWUQa6aJbrJemD4CPqwp6Tqf5/+VuJSOfDlm1EtoRbyWxJ5K9hjDpcACnsppg
 wYZ6wCABxiXt/iP5JL1xX9JTW0aG+Lx+HMhXDLrQn0xShdKTQvmR/6VYRsGHr4v92aUBZG/VkId
 OpM8VrrqzbF/scqZhR8aLPIOVngNv3CdGL1Op9RbQrN6jh2+LnGpAu1g9+6IAqi5U+e8lnEeu24
 KyKjTUJLpxWXAelr7zUSxpJEOL7Z84EuWSK7cQiI1IZqDQQjDZdjID35Gt4v+Sq0ylTXJEZB1Co
 prQ+CQgQmgpBqbo8szhmJNZK4RHIz2v9VvbtHP7cJu+bx1ubAnnMxTCzH8ySsO96Dn22eK56q3F
 nGFSD2la1bHHCqtdCudJcvuQycdxNSpNgLt3y9rWscStLw3B7rZa1FAHQzvkqGGUleFnSwn+NvD
 aoMs7v5as8WQCvE+me6a579EOmtrr71PJJIXm24IMlFjhjAStCDC6StPNQEEsvHcVYVutmgnhis
 MsnyaF85yukTcv2gJG0Mftd8jm/G9IQk8KMPxDqw16ls8GM31A+s2Flu+gS1Pr9AXnDCQKyBE6g
 PwSaS3BGELQAQutc+0nskdCNHel21hREW3N091PNfoEdGObi3p477L1/nThYxRQWSrxKv15s+dH
 cb0pPolA94GucEA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] syscalls/pause: Refactor tests
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

QSBjb3VwbGUgb2Ygc21hbGwgY2xlYW51cHMsIHBsZWFzZSBjb25zaWRlciBwdWxsaW5nIDopCgpU
aGFua3MsCi0JUmljYXJkby4KClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxy
aWNhcmRvQG1hcmxpZXJlLm5ldD4KLS0tClJpY2FyZG8gQi4gTWFybGnDqHJlICgyKToKICAgICAg
c3lzY2FsbHMvcGF1c2UwMjogUmVmYWN0b3IgaW50byBuZXcgQVBJCiAgICAgIHN5c2NhbGxzL3Bh
dXNlMDM6IFJlZmFjdG9yIGludG8gbmV3IEFQSQoKIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
cGF1c2UvcGF1c2UwMi5jIHwgMTU5ICsrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wYXVzZS9wYXVzZTAzLmMgfCAxMTQgKysrKystLS0tLS0t
LS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDY2IGluc2VydGlvbnMoKyksIDIwNyBkZWxldGlv
bnMoLSkKLS0tCmJhc2UtY29tbWl0OiA0NTliM2NkZjE1N2Y5ZDZiZTUxZjNhNjEwZGZmMzg1NWY1
ZTlmZjM2CmNoYW5nZS1pZDogMjAyNTAyMTctY29udmVyc2lvbnMtcGF1c2UtNGI5ZDRiZTNmODc2
CgpCZXN0IHJlZ2FyZHMsCi0tIApSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmljYXJkb0BtYXJsaWVy
ZS5uZXQ+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
