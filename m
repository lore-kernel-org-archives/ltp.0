Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E610CD98F2
	for <ltp@archiver.kernel.org>; Sun, 21 Jun 2026 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782054625; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=wROf6KVL5scSQky1GHcbhC95UavbB+Oi4YMDfzWVHJI=;
 b=pKAEvkR/eri70vJDUGLGPe5tulBzjlH0mYxBuczUA8J35PWQsB2HVv9CVmR5LupDspjCo
 KVive70Ei9BPGIwHaZAmq6I5aG/ycJAMdGvRBfTfmx4q7t7NiuZmRFkG4S3ddSNv/ynFRid
 SpmU2GByb0IIkAklqx5PIZRz+QCG5XE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4E8B3E544B
	for <ltp@archiver.kernel.org>; Sun, 21 Jun 2026 17:10:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C50663E2F58
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 17:10:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D37E960049F
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 17:09:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782054598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XqI30EB2shRD4KlBpDWe2DioPqeAh5x5PcKb8U+3Xxs=;
 b=WfE6y7EGBoq1N1UpJ/A4mfWRIAnemFKuvikjKqOPEcOqES5itngqbciQGcECePxujbyUDo
 DNiCB7JqKyUqj7n00Kz+yMHSdtQr0ir3S2Kf+bfG+UJC4WPBPcgj/7Kz9+K0057ZeQJ+02
 D2CJ738bpEdu+b+XGWBCtgmYeF/tssA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-hecqOU7MNTOptn3f_EG0ig-1; Sun, 21 Jun 2026 11:09:56 -0400
X-MC-Unique: hecqOU7MNTOptn3f_EG0ig-1
X-Mimecast-MFC-AGG-ID: hecqOU7MNTOptn3f_EG0ig_1782054595
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-460129ef947so2548353f8f.1
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 08:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782054595; x=1782659395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqI30EB2shRD4KlBpDWe2DioPqeAh5x5PcKb8U+3Xxs=;
 b=nVhn8wWewfpO4b8geHhBn3EkWzc2+RrUKKcHaeZpO2z17DfbfHP/vnXhzCP8c0/07+
 PVOvC61/7w2myAPuBhDN3iYswuiE1VX/6Cfm/s0AtoioRSBtN+TDofHwsmYR3dIiwmaZ
 xR+yQv8f4ESp4YLfdjElKl6RBXqD/5wsA7Wh2QWpX9Rk0ptoAyS7Vrgzqi2WUMqdbFL7
 te9nmhsVA9ht0xQbeCPM43G5DA2jxg7G94nw9EjQvfW+KPjUa+D/BNbELVuDWRxPFmwn
 POMAt1BoL80Sv4mGi2eqyNLoCsFBAJ/YSkXaVg827aI3ZTZVU/U4ijHdaNTtv+o7zdOV
 YBMg==
X-Gm-Message-State: AOJu0YyDFK0sd6KwiM5WFWVcHhEDa2WFmOk04P/6YQw56g3ACgBGHC7Q
 20g8ByuoMzid4Gfy0iYlErhONjqupuWGAqFBCDD5SsbNMrJHZbQ4mHuAjxPdO+Q9LNoLTkgcvHg
 nGcxzDB/Gm3WeoeYzFAt2ywTzhBH268vkI2MCIkrbQK6pcMQWbgilR/o4n/1T6hQNhoYrB+Ee9Z
 8JTlklbLCs62kL/ZO6/kji5WNOqoE682QOE5an
X-Gm-Gg: AfdE7cmETHZ2ciD3iTjKw3+tFkhmdV7FxDU8oPQkc2UvYxH9L49mCAPE6oX24yQQiQe
 zb9frmrM8hdTlVg/Nn5PxgzIh7ETtYwpR7kRCuM5ihI9/367SPv0S6/ffu06LLt5NYccUL4qnOw
 emC29p8y4R80BTts2Q4ucjmSg1SmM1f1noFPu3muv/cZWs1lQUYCPSjSKITWbVL+4Xl9xH0YMqF
 Zoac6Zr4d3+CoDpFqHhST2koM+k1dfVWIqaXw/LtVFr3RY1pPmU4C5MUTnZnnGWxmRT5H7+hDYp
 C5RDtmK0aCJLppohepmPBgPVUkiyZIMfkimldcl3tKevoEEhBJ2sFCXDC7sn50/jPjqIilMgg+S
 uQIm1V5ltkfoXsPd7+kX78pnHkJz8zsH1bAdY1G/wijWhbbn5yi7KRISfsQ==
X-Received: by 2002:adf:ec47:0:b0:45e:a0ab:8bcb with SMTP id
 ffacd0b85a97d-46506950bedmr15229439f8f.15.1782054594939; 
 Sun, 21 Jun 2026 08:09:54 -0700 (PDT)
X-Received: by 2002:adf:ec47:0:b0:45e:a0ab:8bcb with SMTP id
 ffacd0b85a97d-46506950bedmr15229406f8f.15.1782054594447; 
 Sun, 21 Jun 2026 08:09:54 -0700 (PDT)
Received: from fedora.redhat.com (85.64.227.60.dynamic.barak-online.net.
 [85.64.227.60]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666788302sm15380926f8f.20.2026.06.21.08.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 08:09:53 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 21 Jun 2026 18:09:49 +0300
Message-ID: <20260621150951.66407-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: REQ9Z-3tjh0BiHOLTyDP0QUPzyRnK52MfyHIIp_XVj4_1782054595
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v16 0/2] futex: Add EFAULT coverage for wake and
 cmp_requeue
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ZnV0ZXhfd2FpdDA2IGFuZCBmdXRleF93YWl0MDcgd2VyZSBhbHJlYWR5IG1lcmdlZC4gVGhpcyBz
ZXJpZXMKY29udGFpbnMgdGhlIHR3byByZW1haW5pbmcgcGF0Y2hlcy4KClBhdGNoIDEvMiAoZnV0
ZXhfd2FrZTA1KSBpcyB2MTYg4oCUIHVwZGF0ZWQgYmFzZWQgb24gcmV2aWV3IGZlZWRiYWNrCnRv
IGFkZCBhIGtlcm5lbC1zcGFjZSBhZGRyZXNzIHRlc3QgY2FzZSBhbmQgY2xhcmlmeSB0aGUgY29t
bWVudApleHBsYWluaW5nIHRoZSBkaWZmZXJlbnQgY29kZSBwYXRocyBpbiBnZXRfZnV0ZXhfa2V5
KCkuCgpQYXRjaCAyLzIgKGZ1dGV4X2NtcF9yZXF1ZXVlMDMpIOKAlCB1cGRhdGVkIHRvIGFsc28g
Y292ZXIgUFJPVF9OT05FCm9uIHVhZGRyMiwgYW5kIGhhcyBub3QgeWV0IHJlY2VpdmVkIGEgaHVt
YW4gcmV2aWV3LiBXb3VsZCBhcHByZWNpYXRlCmEgcmV2aWV3IG9mIHRoaXMgcGF0Y2ggYXMgd2Vs
bC4KCkdpdEh1YiBQUjogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAv
cHVsbC8xMzAxCgpNaWNoYWVsIE1lbmFzaGVyb3YgKDIpOgogIGZ1dGV4X3dha2UwNTogQWRkIEVG
QVVMVCBlcnJvciBjb3ZlcmFnZSB0ZXN0CiAgZnV0ZXhfY21wX3JlcXVldWUwMzogQWRkIEVGQVVM
VCBlcnJvciBjb3ZlcmFnZSB0ZXN0CgogcnVudGVzdC9zeXNjYWxscyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAyICsKIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnV0ZXgvLmdp
dGlnbm9yZSAgICB8ICAgMiArCiAuLi4vc3lzY2FsbHMvZnV0ZXgvZnV0ZXhfY21wX3JlcXVldWUw
My5jICAgICAgfCAxMDggKysrKysrKysrKysrKysrKysrCiAuLi4va2VybmVsL3N5c2NhbGxzL2Z1
dGV4L2Z1dGV4X3dha2UwNS5jICAgICAgfCAxMDAgKysrKysrKysrKysrKysrKwogNCBmaWxlcyBj
aGFuZ2VkLCAyMTIgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZnV0ZXgvZnV0ZXhfY21wX3JlcXVldWUwMy5jCiBjcmVhdGUgbW9kZSAx
MDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mdXRleC9mdXRleF93YWtlMDUuYwoKLS0g
CjIuNTQuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
