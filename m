Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D4DC83F03
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751568005; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=xbJuOA+p6y4Vv3T/CduURUgmvzOsUhJoSXwXPCcNLEg=;
 b=K+xvi5QDwxn+eHmzfWF70fzqFPBpKlWvlBDFe8ku87GyAFqzjXpKKLnyQDX15FKYIoD40
 WTR4Ug+WeTk/ie4txmHrG+HZpsZLYgshQXs2kFmPLCDYEJBrcaecnR0ljuc3EuLLzLx5OIo
 rVv+nVxK60PLrXqi9NSshsMdQomXHv4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECF4B3C9B29
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 20:40:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FC513C9881
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 20:39:41 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 50F3A600879
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 20:39:41 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso67613f8f.1
 for <ltp@lists.linux.it>; Thu, 03 Jul 2025 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751567980; x=1752172780; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wo30/+FnjElYYScBCAKHCs9JaoRqrIK+vKt60ewzfq4=;
 b=eLwRqKuu+z8ExzFlP/MtUqn/qc7kweoRCt9/blRFJOMJ1gafyETBhahef+sCoNs6cK
 FHThZSGV/D64p74XDoEsF02OW7cIQIPt3U5bHD6Vn/UXJ1GkoelAgQngfyrrfZvgUlRH
 9yU8mgzzLKTKl2lUQo85o1C8QfBFldp9woTpMQNS3HgCE1W5vE9QuBOeQOSzRlsjwA3G
 4yeEgCXHd3PM92AF4vg0IRwaDB6Sjqo6prMEudY6uAZpIgOZJhaqYRh6wgc6+lH8XD3L
 7w2vKCtvYbwQFDJ7cWl25OhT8UTrjBLpN3nBorz28fY8N9HeG8Jm9Nl8BmYBD/gxB9Ra
 fP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751567980; x=1752172780;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wo30/+FnjElYYScBCAKHCs9JaoRqrIK+vKt60ewzfq4=;
 b=BqT/ReVZZ9xLtPtpYe5frCoIN62tX+NbtoZHdXWXQ6BaggCokqijEuou9cFQDfyr8e
 s+lnzoPNta3N5EQleAEkaEMaEzhCJ3B81P8gzHfthitqnuhKXlxxiE8jPmF4KkRh3BYf
 Fn/BQv70ghoG82UAvx5eWOgflA/8Dm0DUiAQ5swXYx380JYFbpDkqY1TCChhrHhCeuSx
 W4y350955gC7zvKBGejYPW+FO2/ETf/aZvPlyku5MS/WLGU3wu/qz3lqKR0L0vpb0plU
 5dFYcgZuFzlq/9c58UJ2rWRIqzoIUKvRYGs7DuREyTsSLknv7wGmUj7pLXspRcrPzc7F
 tMpA==
X-Gm-Message-State: AOJu0YxhE0ca0NuKGrk0/nvK3fSrRPIJjxntxP6yarVJoJzOXxrVRROx
 gXdp4x+s2AJrVO9B7kMhq5XDjQ9+zVRl9Nh7bBOO80OczkePkTzDjgC3AiKtUpgDLDO0KN06WSu
 r/QlO
X-Gm-Gg: ASbGnctRB6cBQFklk3sNBrcQZMg2+gyX0mGyGMEFIj0A9Owk/K+kpy7qPqPGggznAxr
 H57dXt5QG2yAfRvTzhwIII6XPLrQLGKLj03wkidS7ZWrdLt4/u4IGDlVQjoBW5Jujb2tHZhodTc
 vyKXiweBsCLYZoHZxHZn1B0gYSOEun7nRRgI4z93/EV6+wEgbZt9MphJFIm+yNwd7fO3ka+hcjG
 oBYQTrrlNuvQGLVeAzL3U9KkispJTP/kZkOuAUoaBiYarq13GahMTDvIXoOSYoEfWXy5o3gvo1V
 wtO3/fxLoBYPpEVLMh3/gJovhZOUduFgf0ryGoy1pKap84rigA==
X-Google-Smtp-Source: AGHT+IHGcUgVIMps3z7E2pmVIQz5QdjBnKe0Slym7uTRqwCkipphk6lBMWXHlu7kWMByQDpSSW2j1A==
X-Received: by 2002:a05:6000:4287:b0:3a5:67d5:a400 with SMTP id
 ffacd0b85a97d-3b1ff9f58fdmr6794048f8f.33.1751567979776; 
 Thu, 03 Jul 2025 11:39:39 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-4a994aa8c11sm1780061cf.77.2025.07.03.11.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 11:39:39 -0700 (PDT)
Date: Thu, 03 Jul 2025 15:39:16 -0300
Message-Id: <20250703-conversions-munmap-v1-0-30de82d59004@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFTOZmgC/x3MywqDQAyF4VeRrBuYjmgvr1K6yExjzWKiJK0Ux
 Hd37PKDc/4VnE3Y4d6sYLyIy6QV51MDeSR9M8qrGmKIXbiEFvOkC9sxcyxfLTRjm3qKt4Eo9le
 ox9l4kN8/+nhWJ3LGZKR5PFKF/MMG27YD7y8ULn0AAAA=
X-Change-ID: 20250703-conversions-munmap-3b6a29faa268
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=800; i=rbm@suse.com;
 h=from:subject:message-id; bh=fUFJmEG8lbPRI6x2OQP+sBSAr5G9J+pNnol+LVkjnGY=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoZs5nB4YHiExsaPdwtkIkgVL/FIc1nvpGgqjWY
 DxLE3CkmWqJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGbOZwAKCRDJC4p8Y4ZY
 plNDEACO0+4e7AcLvE/JMbGS6uozuccC1xyaRQipjxPmpMEyIifgT+xzpHU2u1ex+wjlW6MWwQr
 ISEoYV04AJd8Z17HrjEhjX5CO32g8e/qjtaTcfKSK7PyE2QjS2qqzCYrKpxHeLB3ZgG1lW5jQ5k
 KL9vo72gaGyjMFfWuifeFuEeWIsxlGYiPYshLRMBvmxGlz8mVXolGvpbdD7kgDq1WccR2imeBk0
 Hmql/stOSODjZfHbkT7H6fBt7R8n0n+vozs+NxqH6GwauJKrbHQbJ4Pkpew7ZP8Kb4kvJDNckE5
 Tp52Gjp0Mkmesb+cWxsAEMGlnMixmb9gtXEGG7oMUFXJZxKBQYj1aPD5ftUlIM2l8AgcX6EkEZ3
 81u4wuH6nX43TeAO5261ImM0PocGXzEHZe/jL0IoYexc6yaoJbcC/ZHMAMgGn8svbVh6sIf1HMt
 q2g14jy7lK62R8fryvPxF2LJu7DBsjytL0+ZWZbCWL+87P4+gMEIWINUP00eZEz9gpMJOwArh0k
 PcUP2YQ8EZIoVQfUwSjsczglfdwt1h5QGnr3bWC5HNv8tqLZoU8JUafLbqDgjmSm2Lbra3gAIS0
 UoN2p7UKVJsuD8OacMTmkR9JyOXjXB0TQjjud7XlaNojQY5bdwR+2do8BNHqDU0jI7S8ND7BCFp
 soHaDfX2cnF/PEg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] syscalls: munmap: Convert to new API
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

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tClJp
Y2FyZG8gQi4gTWFybGnDqHJlICgzKToKICAgICAgc3lzY2FsbHM6IG11bm1hcDAxOiBDb252ZXJ0
IHRvIG5ldyBBUEkKICAgICAgc3lzY2FsbHM6IG11bm1hcDAyOiBNYWtlIGl0IGEgdmFyaWFudCBv
ZiBtdW5tYXAwMQogICAgICBzeXNjYWxsczogbXVubWFwMDM6IENvbnZlcnQgdG8gbmV3IEFQSQoK
IHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgLQogdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvLmdpdGlnbm9yZSB8ICAgMSAtCiB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwMS5jIHwgMjY5ICsrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDAy
LmMgfCAyNTIgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbXVubWFwL211bm1hcDAzLmMgfCAxNjIgKysrKystLS0tLS0tLS0tLS0KIDUgZmlsZXMg
Y2hhbmdlZCwgMTIyIGluc2VydGlvbnMoKyksIDU2MyBkZWxldGlvbnMoLSkKLS0tCmJhc2UtY29t
bWl0OiAxNmNkNjdlZjFmODVlNmIxNGMxODJmYTQ5NjMyYTUwMTQ1NjBlZGZhCmNoYW5nZS1pZDog
MjAyNTA3MDMtY29udmVyc2lvbnMtbXVubWFwLTNiNmEyOWZhYTI2OAoKQmVzdCByZWdhcmRzLAot
LSAKUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
