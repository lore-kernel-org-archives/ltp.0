Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDF2C36010
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 19:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743190421; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=qqKKmttUb4nTKQ2XoEV3fxkVm47K99Y6EqV+Y1JP7pQ=;
 b=RCl9Chb02yQGvcstbxpAdYSOyUDpv+20BsA31BwyQTxPdFwzJP2fE5hOQqPkOWQLMSOuK
 yBkRirKSMko5kGe0i6XcST5K/RDH+Qb/YhzR0rQ9fYcMrbBrlwirRAL1kT+VoNRKqWmNhJu
 kjkDXk/W7NPf30jJuxe3L9fBDJVjQ/U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D2DB3CA49C
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 20:33:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 472BD3C9CFD
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 20:33:19 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6B21F2000E6
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 20:33:18 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso1508745f8f.2
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743190397; x=1743795197; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HyEmb9xuSUjW+lh0SGqly4wZS4D1B+f8OqeUeSmsOpg=;
 b=V76Ypwl0OZp12uGkOYhUKKfld5l4gaHOLsQIUqH4Vyh9SnuIjQ3kGH77d8wR3wtrdk
 4NHXhsWMAoMj/eEZaCgKUYH3GQsUKMmGp1Rk/9UmhUfCa9ebDG72vinlsSbdvO6Z8AaE
 nJxFDdIlNuOd6NjKkINLT3CejzjQDyC4Z5ysoHC4tUU5VH+jIOe+/gVcIWHogjiedX/d
 p2jC1qnZVRy0befx4/PYFEqA8w5uqVkNw9who/i5GtAqcqFROoF4zt5jKbW8h3+wgAmi
 Y/+sLQansI7j87FBoslxY2BVFEYLnacmShAa99GmThL70/N7+TusVwQ5qJt8+MMRL0Al
 AIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743190397; x=1743795197;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HyEmb9xuSUjW+lh0SGqly4wZS4D1B+f8OqeUeSmsOpg=;
 b=NjBN5OmEvi2KoFZ4/YE9xo8ftYIXCtV4QqAmbLX4JuO3wH+D6kacYuSgNbh/jO+49Y
 agKv0M8119nqgbUc3Pl5C4y1nNBGUrtgUZjBhNgLUKCgMkDaeq8s4Cx9bgbf4OKMl1dP
 tFSlyZyfv9l5b3wHsFiMj9hmINLTU9c0gODBiVsFaGT4BfFf7qNmmBdmwW2KZ+kbAvik
 3qW4Ss2NrUU9Lu5lehVVSOzU9I5BYclxCdR2jR0hfC88SDYKiSej9p5gl+j0NS4kCgJD
 izfWw9jDBWg/w2U6+WeCQGcYnUssiEX8ynnObEf8HWTfAYJ0C9FneaNWkfXjaAQwsUgj
 WMgg==
X-Gm-Message-State: AOJu0YydsSojU7gnlOermqhZ34cIti2F1MxtW4ACUEg0542khwBwzW1+
 oa0WIbphKOuGosCbfL7jtbG86GTOcq/5DDqxivafSdqOI14vWQifmGXfEWz8/LX5dJxMsey/OF2
 5
X-Gm-Gg: ASbGnct/klK7fouMr6vsZXXunuApYk4Pt3sbKGzviOnUa6IjDTfbHCN0zV/brfKddXV
 uUpjfHx1juLy0y9A23Ojg5nDPBPwNoJLG1ifQX9/sqi7lggDAM5k2Z6JCKN4wkfjjDqsQuLDXK5
 o/c6FLghKVeAXse2z4InV/r3Uosfp+3BOcVZubws55Qhqqq8guuovCZR2TrGorOd8hum7Yfa2vf
 7HLzHVfI+6MWGTQQG4jnYZWDozNMlKnCteMTen9tn7YpPzqJ3kUXWHUo9dyIUP1xiAua40zHKXq
 oYz99+pYrReD1p9mwGp4Nytt4dDboT7rog==
X-Google-Smtp-Source: AGHT+IEamacviP4yjt25qADJ4Kn+PsDOq7eNxdbaNYLLf+x6GKcQcKx3SqHTVVCXFUMC9QPs629OuA==
X-Received: by 2002:a05:6000:1869:b0:38f:4d40:358 with SMTP id
 ffacd0b85a97d-39c120c7d01mr294325f8f.9.1743190397521; 
 Fri, 28 Mar 2025 12:33:17 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-739710641a2sm2193796b3a.89.2025.03.28.12.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 12:33:16 -0700 (PDT)
Date: Fri, 28 Mar 2025 16:33:11 -0300
Message-Id: <20250328-conversions-modify_ldt-v4-0-a5ee7b8d82aa@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHf55mcC/4XO0WrDIBQG4FcpXs+iR2vMrvYeo4xEj4uwxOFJZ
 aXk3au9CoWyyx/+8/3nxghzRGLvhxvLWCLFtNSg3w7MTcPyjTz6mhkIOAkFmru0FMytRnxOPob
 r149fuZVGQQ+ggkFWj38zhvj3gD/PNY8DIR/zsLipcfNAK+ZWnCKtKV8fDxTZ6v9uFckFt954C
 0GKztgPuhAeXZpZmyqwV7qXClQFetF57evXTjwpaq/Yl4qqSjCjQZSul1rvlG3b7sgsEZhgAQA
 A
X-Change-ID: 20250324-conversions-modify_ldt-816329223f6e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=rbm@suse.com;
 h=from:subject:message-id; bh=MWG/G1ZFWAMItvQRed5KlfwdFzCzOt2g4JrzTYucl0E=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn5vl5XAVPk7kUEXfwvqDmHQ/k2z3kdjyWc0N4P
 l5lfF8spraJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+b5eQAKCRDJC4p8Y4ZY
 pqT9D/0ejJ5DMST3V6hZYFpNEApRgVHivQ8sMN6drA9cs9LEYXpukR6bFC96PVpAMsnSUBs4Ika
 QEFlbXw6n1RnQpg1q4RmfPuhiS6yyMxs4ch9sAbLWdPqM0ZsTNHYm04lche8jG1p7eMM23XMjU4
 hp3Q/d8NRgmHgMccCMFoFjzDeLe0/lSuZ5g6P1JV1gCDLnqWwn3il/+6Vs0lobAVEKZ7JIORCj1
 MHmka52X8p2OQUhU41KIUuPF1YSez8YKeULhVDy5cImBS7QTQxY4ZdzzjwNEY3ivgPRC1QB9aZj
 TyX6oi/KWe8lwiuRbixjtJzkkEHXm8Co3tbdqfxCWutc6DOFmbv3YOAp1r5x7jQ0PmQISkE6Kzo
 6tFJXhfbDByk0cnpkN4KnQyF1216YW8+JdFAHrLNqN2nWhtW17fVavPTmJS7bsHm1woqlhoaWEY
 KvqmJZiw4KRnCF34Z/WPQjr85p0Ewo6x4m+ppdtH3/b/Ytm7VFUkL5r9dRKhSEXWZfidyd1CFZ1
 qpfZmx3L9Gilf/pQJu9OWQrlbucToJTD0YEOH19k223rIV5hMWtP0hlgawwb2r2mdiYjW3+I8MK
 /o35zpZkVIhrduGADUq+0TJMhzyVUb/agrhptoTNuNvaeBU/2mzCpXnd/foXU5VauyJRtCqwsOb
 sbbSgmnlPTxe6sg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/3] syscalls/modify_ldt: Refactor into new API
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
YW5nZXMgaW4gdjQ6Ci0gUmUtYWRkZWQgdGhlIGFzbS9sZHQuaCBpbmNsdWRlIGRpcmVjdGl2ZQot
IExpbmsgdG8gdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAzMjgtY29udmVyc2lv
bnMtbW9kaWZ5X2xkdC12My0wLWY2YjZlZTFjOTE0NEBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2MzoK
LSBEcm9wcGVkIHRoZSBzZXRfdGhyZWFkX2FyZWEwMSBwYXRjaCBmb3IgYSBsYXRlciBzZXJpZXMK
LSBTcXVhc2hlZCBtb2RpZnlfbGR0MDMgY29tbWl0IGludG8gbW9kaWZ5X2xkdDAxCi0gUmVuYW1l
ZCBzdHJ1Y3QgdHN0X2Nhc2UgdG8gdGNhc2UKLSBSZW1vdmVkIGZhbGxiYWNrIGRlZmluaXRpb24g
b2Ygc3RydWN0IHVzZXJfZGVzYwotIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3IvMjAyNTAzMjctY29udmVyc2lvbnMtbW9kaWZ5X2xkdC12Mi0wLTI5MDdkNGQzZjZjMEBzdXNl
LmNvbQoKQ2hhbmdlcyBpbiB2MjoKLSBBbHNvIHJlZmFjdG9yZWQgc2V0X3RocmVhZF9hcmVhMDEK
LSBNZXJnZWQgc2ltcGxlIHRlc3RzIChpbmNsdWRpbmcgdGhlIGV4aXN0aW5nIG1vZGlmeV9sZHQw
MykgaW50bwptb2RpZnlfbGR0MDEgaW5zdGVhZCBvZiBzcGxpdHRpbmcgaXQKLSBBZGRlZCBTQUZF
X01PRElGWV9MRFQoKSBtYWNybwotIFJlbW92ZWQgY2hlY2sgdG8gYXNtL2xkdC5oIGluIGNvbmZp
Z3VyZS5hYwotIFVzZWQgdHN0X3N5c2NhbGwoKSBpbnN0ZWFkIG9mIHN5c2NhbGwoKSBpbiBtb2Rp
ZnlfbGR0KCkgQCBsYXBpL2xkdC5oCi0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvci8yMDI1MDMyNC1jb252ZXJzaW9ucy1tb2RpZnlfbGR0LXYxLTAtOGQ2ZDgyZjEwNzY4QHN1
c2UuY29tCgotLS0KUmljYXJkbyBCLiBNYXJsacOocmUgKDMpOgogICAgICBzeXNjYWxscy9tb2Rp
ZnlfbGR0OiBBZGQgbGFwaS9sZHQuaAogICAgICBzeXNjYWxscy9tb2RpZnlfbGR0MDI6IFJlZmFj
dG9yIGludG8gbmV3IEFQSQogICAgICBzeXNjYWxscy9tb2RpZnlfbGR0MDE6IFJlZmFjdG9yIGlu
dG8gbmV3IEFQSQoKIGNvbmZpZ3VyZS5hYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAxIC0KIGluY2x1ZGUvbGFwaS9sZHQuaCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDM4ICsrKwogdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMgICAgICAg
ICAgICAgICAgICAgICAgfCAgMzUgKy0tCiB0ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE3LTE3MDUzLmMg
ICAgICAgICAgICAgICAgICAgICB8ICAxMCArLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
b3JrL2ZvcmswNS5jICAgICAgICAgICAgfCAgIDUgKy0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvbW9kaWZ5X2xkdC8uZ2l0aWdub3JlICAgIHwgICA1ICstCiB0ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL21vZGlmeV9sZHQvY29tbW9uLmggICAgICB8ICAzMCArKysKIC4uLi9rZXJuZWwvc3lz
Y2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0MDEuYyAgICAgIHwgMjU4ICsrKystLS0tLS0tLS0t
LS0tLS0tLQogLi4uL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0L21vZGlmeV9sZHQwMi5jICAg
ICAgfCAyMjIgKysrKy0tLS0tLS0tLS0tLS0tCiAuLi4va2VybmVsL3N5c2NhbGxzL21vZGlmeV9s
ZHQvbW9kaWZ5X2xkdDAzLmMgICAgICB8IDEwNSAtLS0tLS0tLS0KIDEwIGZpbGVzIGNoYW5nZWQs
IDE3OCBpbnNlcnRpb25zKCspLCA1MzEgZGVsZXRpb25zKC0pCi0tLQpiYXNlLWNvbW1pdDogNzUz
YmQxMzQ3MmQ0YmU0NGViNzBmZjE4M2IwMDdmZTljNWZmZmEwNwpjaGFuZ2UtaWQ6IDIwMjUwMzI0
LWNvbnZlcnNpb25zLW1vZGlmeV9sZHQtODE2MzI5MjIzZjZlCgpCZXN0IHJlZ2FyZHMsCi0tIApS
aWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
