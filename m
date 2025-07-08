Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86A5C8303C
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 09:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751968073; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=tSTXiCDFR/c9ZiV535+ee7HpbX9at1Yg2njiaT6hKSA=;
 b=p6j+uzfRTz+cL57SGAlSNQg3l8D3rC7lOLTQXPgUkW13bO0xvKzXvvIT+XezN94lrDw/W
 U1btMQ34IKu4aPlIFXJG6qkDtggoY6ZWANozgZWFIbHh4igXt0WqpglCYY7A9jsIsV8Fl6L
 wlOoqbm3CvCNOs79WzSD/r9qe2c+c+4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4128E3CA2F7
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 11:47:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DB2D3C65DA
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 11:47:31 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3B70D1EFF67B
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 11:47:30 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453608ed113so45338935e9.0
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751968049; x=1752572849; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w1AqYA5aExbQLp6U7tf4+F7PcLSJvO/NaSG9p1lc6zg=;
 b=csxDkfsYrVenCwO2ak0QcA1vYsaIJeRRSdtHoBoE8a4rLapYBQUT9ZQ82xzDTrj2Nz
 P79Z2VUS1MTepjDxtb22z0zkpTPomFRsprDwVlWigNM19sDUBhk4RTr3Ij8WZtrc0IBO
 dMnwhIQHPjE/TjqNjUJT0v6qnyPj+8+4pQK9acgOA2ydO0pWWtUB2MfCFFc4pO/TSFb7
 rs3JomyYX5im0+rM5Dh5gmaTRg1GQYPcQd/bMqTCU1X5Sa2gcZ4QTzdj55LnUIEl/gg4
 EiIuR78jG8qOjnTp6exJlNkKpg+9qaE3HgbrlNyLOi9QozJOGc+WqKeUWgD7gBLcZxyR
 lZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751968049; x=1752572849;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w1AqYA5aExbQLp6U7tf4+F7PcLSJvO/NaSG9p1lc6zg=;
 b=RwbCNrv3d4wJwgGLHSGWw1gwGDRslXswLYaBIAQrSpNM3w+Osjrsffyt4o7RwTGxKI
 h3lBI37Afgg5nYso2tlJoBNq+Ez2nOKr6RGv+OTwOGsRuFZUh5Nrc9vKX/U23zGXuONv
 oh8U9dO7Z/rGEiW06RH5IkWeTivux+v659SXr37cTS2eKEZbNnIiUIcxUJeXfK6a0dGs
 DFnYSoFGU8vL2QZZKRMOYLWtHWfTZVhEhzWBdYqtxKVuCd9L8Fci4uPPoB6SUlKD720x
 ESrGfIbW7ZTRx0v2xETdsMISA4GEEBtfC7jS4EDTWk7M1YEmW1yXv4iWl2knZHXparwR
 hM6g==
X-Gm-Message-State: AOJu0YzFR9xsHVWj4aIea5s60T8RWU5sAns4EJ19ZSaR40m6dRYvqwmD
 TKkvyFb7D2NpSv/JuNl6pEUyPu9GZBxPFmX/DYPW8edBbpLpAgfpoSwHX20q0VQwzUQ=
X-Gm-Gg: ASbGnctxO9njkCQqObXM6nILEMDfdvFwh3/oimjZUABndA2VEN2Q98StYrXVT8DYq2l
 EAohA6OXHS9CQ4nrRojApbPnt3w2NRRM4/PvXu0oYsr1qR9FDWKNbfqgQv7jb0BfNt1q/N67H01
 NusIiPuwc4u0RuZCeb2gtEOgbiqQ9wOLf3f0IUP6qAK+YlMgBLla2/zOgr5TWFvXjwHz5pe1gaY
 vtVyHST3BZxz0vSOD0Y4zQfuvPijCjVMPaBr7XkWv9fiq7P5RWp6SykDEn7aC9Q1UUCoMym6936
 g99j9Ry80VF7TpPVUa5ir1d4IKYj4AXCFuUwyXwf+27UsUqbq9NmlDSyusyQ
X-Google-Smtp-Source: AGHT+IGueitIrDq8KallWNaFzSsiYNGbo0osP0bA9sH9FSxDPYYvWYf4MtJhBoX2J1kMsrShG7pkRg==
X-Received: by 2002:a05:6000:2dc7:b0:3a4:ed62:c7e1 with SMTP id
 ffacd0b85a97d-3b4964f4d29mr14508722f8f.12.1751968049553; 
 Tue, 08 Jul 2025 02:47:29 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-4a9b085b297sm47092431cf.23.2025.07.08.02.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 02:47:28 -0700 (PDT)
Date: Tue, 08 Jul 2025 06:47:20 -0300
Message-Id: <20250708-conversions-munmap-v6-0-e6b02f57ac29@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACjpbGgC/4XNwW7DIBAE0F+JOJdqzRqwc+p/VD0seF1zsB1Bg
 lpF/vdCTpYVNceRZt7cReIYOInz6S4i55DCupRg3k7CT7R8swxDyUKB0mABpV+XzLHWkpxvy0w
 Xic6Q6kciZTpRhpfIY/h5oJ9fJTtKLF2kxU+VmildOdbiFNJ1jb+P89zU+r8/uZEgEQbu1KB7g
 PYj3RK/+3UW9SarvdA+FVQRHHkkIGoa6w4C7gX7VMAigEGl0ZLx3XAQ2tdCW4XeWqcQO63hIOj
 Xgi7CqCyy7wxrGHfCtm1/5WYICdQBAAA=
X-Change-ID: 20250703-conversions-munmap-3b6a29faa268
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=rbm@suse.com;
 h=from:subject:message-id; bh=NRtofQdR6v9hoX4TGLgh/gocsEVQaEBS9lsAOvt1F5E=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBobOkr6Z9wleRwE7Kqx85bfmx0wrmARdViktxc1
 mYrk5tSAsWJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGzpKwAKCRDJC4p8Y4ZY
 ppJpD/94Sf7qXhnxge73Ux112vuCjC1bT5kv5hLyBC7UDBr6f3QFreVWKDV1pYutON6NQ37EHzF
 oWG5Y7sS5TCZv+aYp5A3NLEODJAeHsGUUt7wDzPo/xJKDHoT6Wlvg3pleQI9b3xNRe6iBKt0YKh
 18SmRx6xrA17qask/PoGl8LdBaVga+eibE904ZSR5yzdr3q6RdIQfdZhuu1QTSzsQZ4LcUiEVy7
 FSzfcvm9uqQ7mL/WstMVI1HHEtwEhtrO2z35kGLqCVIxA0x3B+XBT65hkh9B9ysUdOpZ7hlLm+v
 FBBvhHXgT5kJt1ewF84FluV7MlTlD67PNAHXHKI9Nfq1YlTUlO4vDsbss78JLNmjqeHtW/qSW+a
 rOH76+HmVSZgapvMn+ihEFs+0/EiOLYiCLwAH5Vx8VxuqaqqmV2dd6yorKnAEV5rvZkc6mbRZOi
 dJjvKv044ZtklnWqpT2R+pbksU1PfHnkcNPT5cH52h+ftDOLtkyyaXg2qNi/jQjLkwbjOeMpiQa
 SWYwlrlkxLw4wdpc5CI+xtY6UC8tA+OLg1UcNjVWG3sBdAWZbF7LCklSRDCQ/k8Mv1SPVOxQO9z
 ihcz6SKKoTuXFaNm7b2PZ3R72Odt+KWRJmC6hiOSXlGQujhj55zxXSSOG6LeaZdbKKjHLeHntPW
 rw5FUL0sf19xg+Q==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/3] syscalls: munmap: Convert to new API
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
YW5nZXMgaW4gdjY6Ci0gbXVubWFwMDE6IFNpbXBsaWZpZWQgY2xlYW51cCB1bm1hcCBsb2dpYyAo
c3VnZ2VzdGVkIGJ5IEFuZHJlYSkKLSBMaW5rIHRvIHY1OiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9yLzIwMjUwNzA3LWNvbnZlcnNpb25zLW11bm1hcC12NS0wLWYyNzNlYzg2ZTUwZkBzdXNlLmNv
bQoKQ2hhbmdlcyBpbiB2NToKLSBtdW5tYXAwMTogRml4ZWQgY2xlYW51cCB1bm1hcCBsb2dpYwot
IExpbmsgdG8gdjQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA3MDctY29udmVyc2lv
bnMtbXVubWFwLXY0LTAtMDk3N2IyMzM4NTUwQHN1c2UuY29tCgpDaGFuZ2VzIGluIHY0OgotIG11
bm1hcDAxOiBTZXQgbWFwX2FkZHIgdG8gTlVMTCBhZnRlciB1bm1hcHBpbmcKLSBMaW5rIHRvIHYz
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNzA3LWNvbnZlcnNpb25zLW11bm1hcC12
My0wLTA2MzI1MzdhNmM4ZEBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2MzoKLSBTdG9wcGVkIHVzaW5n
ICJtYXBwZWQiIHZhcmlhYmxlCi0gU2ltcGxpZmllZCBjbGVhbnVwKCkgaW4gbXVubWFwMDEKLSBS
ZW1vdmVkIHVubmVjZXNzYXJ5IGNvbW1lbnRzCi0gTGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDI1MDcwNC1jb252ZXJzaW9ucy1tdW5tYXAtdjItMC1iYWMzYTBhYTExN2JA
c3VzZS5jb20KCkNoYW5nZXMgaW4gdjI6Ci0gbXVubWFwMDM6IFVzZSBzdGF0aWMgdmFyaWFibGVz
IGZvciBzcGVjaWZpYyB0ZXN0IGNhc2VzCi0gbXVubWFwMDE6IFVzZSBmb3JrKCkgaW5zdGVhZCBv
ZiBzaWduYWxzCi0gT3ZlcmFsbCBjb21tZW50IGNsZWFudXAKLSBMaW5rIHRvIHYxOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNzAzLWNvbnZlcnNpb25zLW11bm1hcC12MS0wLTMwZGU4
MmQ1OTAwNEBzdXNlLmNvbQoKLS0tClJpY2FyZG8gQi4gTWFybGnDqHJlICgzKToKICAgICAgc3lz
Y2FsbHM6IG11bm1hcDAxOiBDb252ZXJ0IHRvIG5ldyBBUEkKICAgICAgc3lzY2FsbHM6IG11bm1h
cDAyOiBNYWtlIGl0IGEgdmFyaWFudCBvZiBtdW5tYXAwMQogICAgICBzeXNjYWxsczogbXVubWFw
MDM6IENvbnZlcnQgdG8gbmV3IEFQSQoKIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDEgLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvLmdp
dGlnbm9yZSB8ICAgMSAtCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAw
MS5jIHwgMjc5ICsrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvbXVubWFwL211bm1hcDAyLmMgfCAyNTIgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDMuYyB8IDE2OSArKysr
Ky0tLS0tLS0tLS0tLQogNSBmaWxlcyBjaGFuZ2VkLCAxMTcgaW5zZXJ0aW9ucygrKSwgNTg1IGRl
bGV0aW9ucygtKQotLS0KYmFzZS1jb21taXQ6IDE2Y2Q2N2VmMWY4NWU2YjE0YzE4MmZhNDk2MzJh
NTAxNDU2MGVkZmEKY2hhbmdlLWlkOiAyMDI1MDcwMy1jb252ZXJzaW9ucy1tdW5tYXAtM2I2YTI5
ZmFhMjY4CgpCZXN0IHJlZ2FyZHMsCi0tIApSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2Uu
Y29tPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
