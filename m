Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5A2C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 14:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743085747; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=E7TB0N7z3mA3LuEWX+NUcoBMjwCBvRDfJ8YF3cqC2iY=;
 b=JQUJZj5/E7HixrOE4aoQe0zHg+As9Oo8d1a4E3SHmBRJk8wWk2JjhGClAvMmQGoJ/g1fq
 RO7TFjVw9NFW1rpeN0GLwC8obmFXbFagX4V3sXEh5AL1sTH+HJnLmTYe2B5ykeuet4TnsXo
 tFBKCP/X4k9OGwOu/GwtajXDonJ+fXQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4C293C9FBA
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 15:29:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2D423C726B
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 15:28:44 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D8A01600C60
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 15:28:43 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so851682f8f.1
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743085723; x=1743690523; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OZaEIZJQyBGgAtJ/uhdsXT8K+4YKpJHyJbO/YvhCgTY=;
 b=Wvny2luzuZse+U5Y2ZY9Npw7wpQhp23XJuYR/b1KPB9Us2HQFjCBxdlu2+++dNlLa3
 Q8nlYQPNI4M06Zhe3WWjvltuWfk5H9i0XGmHwRmNv0wgNMJB5Ud6XMn6t0XiRNlpUc5+
 eJVCGrLBgNML3EmD39T3ug3CfQoh39z7Hq4ztzPw6d2ICC491Ux1w42S++EVX0J8N3QM
 MTncbn1Vrlyd6XvCoRsvbBXFuQGhTmkcasFc0s1T/NOkMmOGUsitF5dA5UAcIw67ZjEA
 pn5nHs+TZu0blTKG4fr+k5zPEwTieME4tOCaib2BC3HiK8LA0O5VeDK64z/0PsWQpiZt
 zgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743085723; x=1743690523;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OZaEIZJQyBGgAtJ/uhdsXT8K+4YKpJHyJbO/YvhCgTY=;
 b=j9rG2dMvlTzdO/qXKgzj5HFLnDLECvI7TF1O2Az9tXfiLCRLtAcjNyuI16AQiVzoOD
 2iGXFBNN+odrw4979uKkJryMvV2NuBV9zSPWOwF57KHmD45ejTuYodHzFJYwZuOZUCmn
 6ti8z+QrV3FxL94BbrIu1QAZNJ1yB6Wf8wX7yrJnRKESUAwJw1oTEbULx8/uKe37uHTg
 B9/KS+VbSq3t943TeaPtn3NdDDqtosTHLzIk1IgJsS46LMfOSfMwnBk8KAiiicoRmEdZ
 8ETYwygeA4R8AmAHrqsGxGf9RetyejXQpkwWyDzZRvJk0kzJ0FSvLuUztHy0mXYkwZfO
 XkDw==
X-Gm-Message-State: AOJu0Yz4kQl16o6vSXarGMmtnXk9bNlkB3mnPy8uX/T1EyvkvizmLbHF
 M7olbj0oBQG2yLflawR/Y0jHMbwnP0SXGKtCJqUZ+Dzulk5YjZVMbohOCsl3V2D4jjvIjOow/GJ
 w
X-Gm-Gg: ASbGncv4Dh5dTBF4Oks8kXXdwpLK/ybTF/zkYYKhQKpRy9G9qN9nk9QLzmAiRKO65Ug
 iHTLYB0tXs2llS94KB589dhVNR7wrAUI72sHTd8FJUOYzVl5AvChUebx8xOgrqNPSAwGYgkO3KG
 WTGATQ96kjE2aotz0BMUOO1r9CNaqOQCPRGcnNjfRIKDYNCPXziCQIzLHiBOEiOn8/qzVA4r2T0
 0ZFqfpX+8zxR1F2fV5nXab3ZNKkNEadPRMi2JYVgti6F34cqW6SPVAJ94C72192WXD5mACNw+sh
 XCc+ZUNPNwJ4SUsI418ntUUP1EwM5PfvLg==
X-Google-Smtp-Source: AGHT+IHP+g7E+TE/TPjOk7BfUlDaOgyUIcvuWEfOykyRgHBFVMClbIYhvEPxhAapJf6IgzanYm7uRA==
X-Received: by 2002:a05:6000:40e1:b0:391:41c9:7a8d with SMTP id
 ffacd0b85a97d-39ad1773b64mr3333283f8f.54.1743085723216; 
 Thu, 27 Mar 2025 07:28:43 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7390615302csm14204331b3a.128.2025.03.27.07.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 07:28:42 -0700 (PDT)
Date: Thu, 27 Mar 2025 11:28:23 -0300
Message-Id: <20250327-conversions-modify_ldt-v2-0-2907d4d3f6c0@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIdg5WcC/4WOTQ7CIBBGr2JYi4GpIrryHqYxFAZLYsEwldg0v
 bu0F3D5kvf9zIwwByR23c0sYwkUUqwA+x2zvYlP5MFVZiDgJBo4cptiwbxqxIfkgp8eLzdyLVU
 DF4DGK2Q1/M7ow3crvreVO0PIu2yi7de6wdCIeRX7QGPK03agyFX/u1UkF1w75TR4Kc5K3+hDe
 LBpYO2yLD+jNvlL1AAAAA==
X-Change-ID: 20250324-conversions-modify_ldt-816329223f6e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=rbm@suse.com;
 h=from:subject:message-id; bh=CfgvL6vkSdptOGDxHQ5ZpSOGxlgxPA2/Y7RdzKzzK3w=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn5WCXMX/O/8Mydi+UsnYjQ6nld6IJtNt//P7sy
 klkd5/vULWJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+VglwAKCRDJC4p8Y4ZY
 prfXD/9bjgmzwSmp53lpNlcwzbmAua/EsRPlioDYnpPzIkn1Fe8KvzJAzZyq+GSFLGx/lx129Xd
 yA5AHKpTC5HOHrL7ZyX2vezrgu1cDvxhdoti5W7cVGNmisctIoUYxpPJ/VpC4jnmtUuz2PPJ1Bq
 FWQi7SUwj+tOojXa7FSKpWFfBtTD2/r52MIkmiAzhHom9LFXniA7z4Gy+sSNMvda4j6sVqXlNQ7
 jAyGtAzFj4isOY0Uv2HRsS413xnLy0M87RNBO9ozyWon5CHACF0X4LeIAUVIo0njzssFsAcBsmU
 1kQ58AINb5PCqdMqwAdXq4ZbmPs3z3nDsIqxfZSoQNkU4SOtScVUZVBJyDs2Gh3UAwx/blXtcJJ
 0uEoS1ZEbB4whLx1Qfr8Hu0Ug7JKzFuG7jKVBbcI8Z/skNxz0ZthoVOUenGl2AFDeh9Nf4FhXKX
 GnU8+kvsIRoB2JXW0rImvsoNZPp4/Th75PkDvw2UtJLGUpX4ogYR6U4HjeAxjJTolBXJZIuQlgf
 brzaxx8qsCUpwBJj0PA0lzJ2AwkC3v+sQ7tEVsldrQiB5d95wu2KPYawiQsDNFS5yAY3jTQjDfq
 JyiRbvSblSePAsIzfr74ZL5ERWFsdG+X1pv0IG1HBVe4QNiwajbqRx/BAhxGlUwHg1Bwh0KXIoQ
 mWvkj2RGVpVa2BA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/6] syscalls/modify_ldt: Refactor into new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: rbm@suse.com
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tCkNo
YW5nZXMgaW4gdjI6Ci0gQWxzbyByZWZhY3RvcmVkIHNldF90aHJlYWRfYXJlYTAxCi0gTWVyZ2Vk
IHNpbXBsZSB0ZXN0cyAoaW5jbHVkaW5nIHRoZSBleGlzdGluZyBtb2RpZnlfbGR0MDMpIGludG8K
bW9kaWZ5X2xkdDAxIGluc3RlYWQgb2Ygc3BsaXR0aW5nIGl0Ci0gQWRkZWQgU0FGRV9NT0RJRllf
TERUKCkgbWFjcm8KLSBSZW1vdmVkIGNoZWNrIHRvIGFzbS9sZHQuaCBpbiBjb25maWd1cmUuYWMK
LSBVc2VkIHRzdF9zeXNjYWxsKCkgaW5zdGVhZCBvZiBzeXNjYWxsKCkgaW4gbW9kaWZ5X2xkdCgp
IEAgbGFwaS9sZHQuaAotIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAy
NTAzMjQtY29udmVyc2lvbnMtbW9kaWZ5X2xkdC12MS0wLThkNmQ4MmYxMDc2OEBzdXNlLmNvbQoK
LS0tClJpY2FyZG8gQi4gTWFybGnDqHJlICg2KToKICAgICAgc3lzY2FsbHMvbW9kaWZ5X2xkdDog
QWRkIGxhcGkvbGR0LmgKICAgICAgc3lzY2FsbHMvbW9kaWZ5X2xkdDAzOiBSZWZhY3RvciBpbnRv
IG5ldyBBUEkKICAgICAgc3lzY2FsbHMvbW9kaWZ5X2xkdDAyOiBSZWZhY3RvciBpbnRvIG5ldyBB
UEkKICAgICAgc3lzY2FsbHMvbW9kaWZ5X2xkdDAxOiBSZWZhY3RvciBpbnRvIG5ldyBBUEkKICAg
ICAgc3lzY2FsbHMvbW9kaWZ5X2xkdDAzOiBNZXJnZSBpbnRvIG1vZGlmeV9sZHQwMQogICAgICBz
eXNjYWxscy9zZXRfdGhyZWFkX2FyZWEwMTogUmVmYWN0b3IgaW50byBuZXcgQVBJCgogY29uZmln
dXJlLmFjICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgLQogaW5j
bHVkZS9sYXBpL2xkdC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNjEgKysr
KysKIHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jICAgICAgICAgICAgICAgICAgICAgIHwg
IDM1ICstLQogdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNy0xNzA1My5jICAgICAgICAgICAgICAgICAg
ICAgfCAgMTAgKy0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMDUuYyAgICAg
ICAgICAgIHwgICA1ICstCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQvLmdp
dGlnbm9yZSAgICB8ICAgNSArLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0
L2NvbW1vbi5oICAgICAgfCAgMzAgKysrCiAuLi4va2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQv
bW9kaWZ5X2xkdDAxLmMgICAgICB8IDI1OCArKysrLS0tLS0tLS0tLS0tLS0tLS0KIC4uLi9rZXJu
ZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0MDIuYyAgICAgIHwgMjIyICsrKystLS0t
LS0tLS0tLS0tLQogLi4uL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0L21vZGlmeV9sZHQwMy5j
ICAgICAgfCAxMDUgLS0tLS0tLS0tCiAuLi4vc3lzY2FsbHMvc2V0X3RocmVhZF9hcmVhL3NldF90
aHJlYWRfYXJlYS5oICAgICB8ICAzMSAtLS0KIC4uLi9zeXNjYWxscy9zZXRfdGhyZWFkX2FyZWEv
c2V0X3RocmVhZF9hcmVhMDEuYyAgIHwgMTIwICsrKy0tLS0tLS0KIDEyIGZpbGVzIGNoYW5nZWQs
IDIzNiBpbnNlcnRpb25zKCspLCA2NDcgZGVsZXRpb25zKC0pCi0tLQpiYXNlLWNvbW1pdDogZTNh
ZWY1NjlmMGQwZTcwNzliZGI2NDY5NjVhZmFmNDE5MDM1ZWFhNQpjaGFuZ2UtaWQ6IDIwMjUwMzI0
LWNvbnZlcnNpb25zLW1vZGlmeV9sZHQtODE2MzI5MjIzZjZlCgpCZXN0IHJlZ2FyZHMsCi0tIApS
aWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
