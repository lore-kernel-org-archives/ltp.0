Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC80CA0FF0
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 21:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756501353; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=2ig5a8xR+9dQXFYBoemFeuaky+slwUAYbuE3owOhi8w=;
 b=JeOphfyMhB6/Nf2SKO6pE/8V+BNvtwIsu4l9JPqRiRRFFcUVhk1zwWrY1FbjQaArp20YC
 c0pUrReGnK1YCBleqtC4SMhAQGY98K9OHmBp7jjql2T9H2wZc7uHN8fQQYVf5UHU6TUWXsG
 Zek18vd5bRkgl9SF5trRVvSm9T8Q0ss=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C0A13CCFBB
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 23:02:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F001A3C859A
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 23:02:11 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1CA4B20004A
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 23:02:11 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3cd59c5a953so1650248f8f.0
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 14:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756501330; x=1757106130; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l37B8UzLd9OVqJZhoA68LNVBm2V+t2do37RG2BUEV0g=;
 b=PCHYvtvJPoZwwqVFc3NTnZ5MRv+0ncR8ptzbbC7dQYPhKywy9YOiJI1LkHtXaOtwwp
 R0WNrFvb2h87TRCTYuElsqfc3Lv5zGFvlDLBRJfdRaFhgmbe2IXN61cyGb+tNUzL9x+z
 CiMC57NDtVtBocwbbhwxXUrstl1vMgZWWaew1NBKP1/YAf4digcbsjLRZ7c1G/SvF2/I
 BfE3Ajv2XJVV1ANvBkvGT9sPll3/G/Mpz2qzqKTPkKG8ZLyKiClfk0Q4n0JowBCCRKBM
 CizJlPJsNrJuKLhowCcwIDQ2ABpKcXYMeot0g/gdWtKz3MnDez/yxyxIghtKDKW5idUM
 UZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756501330; x=1757106130;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l37B8UzLd9OVqJZhoA68LNVBm2V+t2do37RG2BUEV0g=;
 b=eSqdfDhN4/SM9hmc9iK6CsCIGF+yi6HtQvgjBUmiBbffN4wMsjSgiVHsGj/RqwumrQ
 dt90igp5vwal0REe3PinEy01YOPiSpeZr7SU8ALxafthjVosnux7Dj3FdlES56avnxmz
 Ljasr4+pXYv8cHRJMKpqYIEp/hXwiJ8DURvJT6OBt1xhFvSwlZtu12e2IEnTm1B7LCRA
 +1wZdo9OCZ7pwG0FPcLrbpM/8tiH696F80xwUBEXViVSlkzENGVWueRmrtql95CN5tzJ
 IhiVyf2sGV9kf+4Q5uaHRzI6CARi8rBSEjXH7N6xXO3m9ITi83z0gGKdsrpDtQkutCeg
 9btw==
X-Gm-Message-State: AOJu0YzvQX/7HeWsqnOkZGPmnBzmCOuKlMz0kpnex/BHHxeNtG5AZrU6
 yAEYmAEiQa3ny1GN/xX6R4CSeQDOOTUAASOVcN5cIE4VDuff4uveSspCWy89vcBxojaE5fnpPqw
 M0cXeKfZQeQ==
X-Gm-Gg: ASbGncuQ3NjO1Gbr/MMdsgZS9f3DSiaMfrxLDedHcf8yh4/71SR7R0d0E8ZHw3RyznM
 hbm3G/sEiTTN0pOoQP/5+97ddN6ng3JEuPJpRodRpdQlpQjRORl5qUxExCgoAemjuubGf2GRKmB
 tc7QyKJRgBPiJkkiRn/e1j3JusDAaMLhE000ZhiUJuxeHgjcwpDbh3/9e4PV5Qt72CQMYGJdewz
 I+KnY/DQex7o2GqNkXVlY9/eBO3YigOlXjcLqXfsgojfyvBYRLey14mLVq2AdfRBK1u9t4LyrpS
 bmlNBieEdcAusSx72dj0jFZqiE6heZOqo1ELgLQSncaNcWsTJKKehWKghhV2VHlcbQLTOpSzhhq
 fkCQEfItmKQ==
X-Google-Smtp-Source: AGHT+IFVRK4nmksfmxtKd2Lo/865cTdbs0Yj0LPxP8MpsdQ4GiKZlmuMLEbjk8X93RYYSu1EWasHUA==
X-Received: by 2002:a05:6000:188f:b0:3c4:edee:bcf9 with SMTP id
 ffacd0b85a97d-3d1dc5a209amr8809f8f.9.1756501330200; 
 Fri, 29 Aug 2025 14:02:10 -0700 (PDT)
Received: from localhost ([177.94.120.255])
 by smtp.gmail.com with UTF8SMTPSA id
 00721157ae682-721ce5e4431sm9566297b3.60.2025.08.29.14.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 14:02:09 -0700 (PDT)
Date: Fri, 29 Aug 2025 18:01:59 -0300
Message-Id: <20250829-conversions-lchown-v5-0-7c3f25cd1de4@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEcVsmgC/33NwU4DIRQF0F9pWIuBxzClrvwP4+IBD4fEgoGKm
 mb+XejGSTNxeZN7z72ySiVSZU+HKyvUYo059aAfDswtmN6IR98zAwFaHAVwl1OjMmqVv7slfyV
 uvHXaqCCFNawPPwqF+H1DX157tliJ24LJLYM6Y71QGcUl1ksuP7fzJkf9358mueDojuitwqClf
 66flR5dPrNx0+BPMGLeFaALatL6JAIFRLoT1EYAvSuoLoCHWVrlCdR8J0xbwewKUxdm4f0JhZx
 0UBthXddfcsTXsZIBAAA=
X-Change-ID: 20250702-conversions-lchown-8dbc583f10b8
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003; i=rbm@suse.com;
 h=from:subject:message-id; bh=jJEjts3Ni5TWDjiot/BOj+uuSLmCEi4jVVt7hMZabXQ=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBoshVOutF8SMl3XfpEVEIiIUN8mZhOIc+6D4zAL
 shkTHmj1S6JAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaLIVThsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKbkrQ//Yc7E1ZipiuSJhge/QLypyWNZuLKeGR7
 3gZpzoMPbxoN1BKXqjLrbbwNqJDjvB+ocSovwKJ3ot7aVUlHghJZG2Z6sNw9cUdD6Xbkxj8xJxC
 KLTKLwL0YIY/RpSErVZoqRsWRv+lBYt/OdR6MQl13PZZdZRP530JZVq9KfG37dPCzZyyDOimeEk
 lEnuFUE8lJDdu8Wj6ftISWWrUy/1OFJ0YPXTn28nyeLGy5/KAF1aa/UQUnR5u69xFkjgHCTXLgZ
 TYEbQQRpbbkUExAIYy6Z9weMk3Z7h3PkBKqT5B4v3CndTQ2bJOmFFT9SxUMkOPiuOw/G897y4M7
 RYlqnpyaFqJMf+KqXntamgLdT9Rr26jjWhyrsZYvkcnWPpW12HZehOZ9S5FK94vnWxXXt3Hl0zm
 7eWIhPv9nTUKq2ToEpMBbZkOGaYsKHPOEgVbh4z/1btRY2fxO/5OEB2z4/iZRQNPjRm8SXVrdor
 RsHVlTexmlwIgQd7e6J6X3Oj1of8EtSlIqpRM0RnT4i/Sl6AI//lQC+utWnbncK1J28c7cvZ4ln
 9+/D+K9osTsTq/qeNoPvoDZzDgRao7YexiObZUFRbK5EFkm+RUgLkkd4gf1Ari7QbLXkZR1uHjf
 C/aBY80HgPKLjJBbFOBt7U8VGfgSDBIWrj350gjr6eA5ldSNao2o=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/4] syscalls: lchown: Convert to new API
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
YW5nZXMgaW4gdjU6Ci0gbGNob3duMDE6IHJlY292ZXIgb3JpZ2luYWwgdGVzdCBpbnRlbnQKLSBs
Y2hvd24wMjogc2ltcGxpZmllZCB0ZXN0IGRlc2NyaXB0aW9uIGluZm8gcHJpbnQKLSBMaW5rIHRv
IHY0OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwODI4LWNvbnZlcnNpb25zLWxjaG93
bi12NC0wLTYwZGQ5YTAxNDVmM0BzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2NDoKLSBNZXJnZWQgbGNo
b3duMDMgaW50byBsY2hvd24wMgotIExpbmsgdG8gdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3IvMjAyNTA4MjUtY29udmVyc2lvbnMtbGNob3duLXYzLTAtMmQyNjFiM2RlMjM2QHN1c2UuY29t
CgpDaGFuZ2VzIGluIHYzOgotIFByb3Blcmx5IHVzZWQgYnVmZmVyIGd1YXJkcwotIFJlYmFzZWQK
LSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwODA2LWNvbnZlcnNp
b25zLWxjaG93bi12Mi0wLTM0NTU5MGZlZmFhZUBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2MjoKLSBK
b2luIHRlc3RfY2FzZV90IHN0cnVjdHMgYW5kIGFycmF5cyBkZWZpbml0aW9ucwotIFNpbXBsaWZ5
IG92ZXJhbGwgYnkgcmVtb3ZpbmcgdW5uZWVkZWQgY29tbWVudHMKLSBVc2Ugb2N0YWwgcGVybWlz
c2lvbiBtb2RlcwotIFVzZSBTQUZFX1RPVUNIIHdoZW4gcG9zc2libGUKLSBsY2hvd24wMTogUmVt
b3ZlZCB1bm5lZWRlZCB1c2Ugb2YgZ2V0ZXVpZCgpIGFuZCBnZXRlZ2lkKCkKLSBsY2hvd24wMjog
TWVyZ2VkIGFsbCBzZXR1cCBpbnRvIGEgc2luZ2xlIGZ1bmN0aW9uCi0gbGNob3duMDM6IEFkZGVk
IHRlc3QgZGVzY3JpcHRpb25zIGFuZCB1c2VkIHNucHJpbnRmKCkgaW5zdGVhZCBvZiBzdHJjcHko
KQotIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA3MDItY29udmVy
c2lvbnMtbGNob3duLXYxLTAtYWM3YWRiM2FmNTFkQHN1c2UuY29tCgotLS0KUmljYXJkbyBCLiBN
YXJsacOocmUgKDQpOgogICAgICBsaWI6IEFkZCBTQUZFX0xDSE9XTgogICAgICBzeXNjYWxsczog
bGNob3duMDE6IENvbnZlcnQgdG8gbmV3IEFQSQogICAgICBzeXNjYWxsczogbGNob3duMDI6IENv
bnZlcnQgdG8gbmV3IEFQSQogICAgICBzeXNjYWxsczogbGNob3duMDM6IE1lcmdlIGludG8gbGNo
b3duMDIKCiBpbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmggICAgICAgICAgICAgICAgICAgIHwgICAz
ICsKIGluY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmggICAgICAgICAgICAgICAgICAgfCAgIDMgKwog
bGliL3NhZmVfbWFjcm9zLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxOSArKwogcnVu
dGVzdC9zeXNjYWxscyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiAtCiB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2xjaG93bi8uZ2l0aWdub3JlIHwgICAyIC0KIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbGNob3duL01ha2VmaWxlICAgfCAgIDUgLQogdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9sY2hvd24vbGNob3duMDEuYyB8IDE5NSArKysrLS0tLS0tLS0tLS0KIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbGNob3duL2xjaG93bjAyLmMgfCAzNTcgKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sY2hvd24vbGNob3du
MDMuYyB8IDE1MyAtLS0tLS0tLS0tLS0KIDkgZmlsZXMgY2hhbmdlZCwgMTYwIGluc2VydGlvbnMo
KyksIDU3OSBkZWxldGlvbnMoLSkKLS0tCmJhc2UtY29tbWl0OiBmOGM3YjZjMjJkYjkwZGI4ZTYy
ZDU5Y2I4NjlmNmQ2MjJkNDUwMDNmCmNoYW5nZS1pZDogMjAyNTA3MDItY29udmVyc2lvbnMtbGNo
b3duLThkYmM1ODNmMTBiOAoKQmVzdCByZWdhcmRzLAotLSAKUmljYXJkbyBCLiBNYXJsacOocmUg
PHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
