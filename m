Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0553C369B2
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744661405; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=HVESQFRbknfJpWjrpLiz1QIbtzhD2LAKr4RAN27638g=;
 b=N9yt2R+Tj5imX7nAdnZheIjJ697MavQv7mjOEXaZyRkOyEAyOR7NteVnETV1yu30Bv8yq
 Vr5v5qjE/aSK2fkXLc4bGdc0dKBZTxjHmk7VJiaZB4DXCBGEi+pPy1vfbanxhpx40+gU+xh
 oFEXQSV563KmGzSUvFpoNo5747qtzfA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A3A13CB826
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 22:10:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D4B83CABE1
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 22:09:43 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 634B31400C41
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 22:09:42 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so4613824f8f.0
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 13:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744661381; x=1745266181; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p8URz50T36IiTIgExNdHmS8ANPjYAHwj3Nxcih8us1k=;
 b=FgqMJn8SGd05b0n1eIWF+3DijFKjhEjdaFNeicq19nm7G3Ic6XztiOrqGhx+mIzX+e
 0EYbwZWcnF1QHxSGYVyZKVc8eTCvnuhfzvpXKwVgyqQ0OWHN+PhOP53S7h22ERKWCPi8
 8swFS4P5UaY8GpFALZw6nEuRLhrmQw0u1Xxyjf40PlhRWBKt+xUS5yFIePZ2LuOgU6CW
 wPpvTP20w57zDt4Ylpt/5fWw/CLHDbMPZYDYVUV++uSEDmSjhOxHftDumpnJn/yAOk0B
 Is9vAC34CT8/N8Oo1zcgCylyOQsSRn17FagaHGwFefQlBimIyG87UpF/iv/3s7/94qsr
 3q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744661381; x=1745266181;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p8URz50T36IiTIgExNdHmS8ANPjYAHwj3Nxcih8us1k=;
 b=jxbX0/B5dzYdoxRFSScNnBFdK8J51IGJ8y0FOYbF+mUk9xe6mOpfhQ4Y++cDLfUv4O
 KqKV6zzUB/fqDDXjqgGKp4kRp074j07QibMIQovfQz9hOoEDbhDDZTuG/cQ7eCNoUB4V
 fTREG+J2fHdGOfoU4jZFVY1tFWXBhknvkTt/UNmqPbSaJp8bzuYIFMTQQ2lMSLFjRaNE
 cyq3zEcXsvq4QkzU0G7NbA3hFUeTdavidyMJ4uCOfejMZyhYwzxIjNurMUwfkaU4oOpD
 gIajeZNWCOBkMUGU+XIxGRKnYKW781NAOeHmW//SSQt3B6Tqug0JFzn1JdiYQmGMb/oE
 0dPg==
X-Gm-Message-State: AOJu0YzbQ44PHbbNitoesLLPuIZa9nMoT7scJMngfmx2RTENmdOtFF5R
 xX6wOjSbqCpB19cBY843PXlRBY1CzifLAHX6YNFjI3s5XD5ii4ibW0KrKSrjb8imkUsTrRfjAsa
 +
X-Gm-Gg: ASbGncum1Ke91jAGXAPIoYhDQiDCmkI1vuS3NgYaACkwYckV9Nb9wkvnKq+kY4wwldv
 IYp8G8MWl/Lo3cgE1jylpcgCF+AL9taBJpGM9vckDVq9INBLPjUQq6rdgXgVuQOyZK7xHeXlUby
 Q1/bKgMtNvoqt5fCtphgxVn2pDHvxmAK3UIDatMKbZMdPeOl/YxaOZBtHt/67WWrOVcpmqTWnWL
 0i6cEPDN3///i4kVjX8Mg95zxkQCY2sFHHWYZdov2AoGjpDlP5IvyvgVCy/PKEObOlJCSZRSQm8
 i3Ykm1wArig7u9ppzFs+I78lJvEIcA==
X-Google-Smtp-Source: AGHT+IEBCyscbdxvUnEX7ssltEO/Gt6ypRds2CfsaHMEkBocrc3VwFBCz4ts7gjrlX9z35eRgM1cgA==
X-Received: by 2002:a5d:588a:0:b0:39a:c9b3:e1d7 with SMTP id
 ffacd0b85a97d-39ea634bf9amr9617449f8f.29.1744661381428; 
 Mon, 14 Apr 2025 13:09:41 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b02a2d3a4f5sm8058644a12.51.2025.04.14.13.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 13:09:40 -0700 (PDT)
Date: Mon, 14 Apr 2025 17:09:31 -0300
Message-Id: <20250414-conversions-mknod-v3-0-e08e7463bfaa@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHtr/WcC/32Nyw7CIBQFf6VhLQboA+vK/zAueNxaYgqGW4mm6
 b8LXXVhXE4yZ85CEKIDJOdqIRGSQxd8hvpQETMqfwfqbGYimGhZzXtqgk8Qi4Z0evhgqbEnoxs
 mrWgsybtnhMG9t+b1llkrBKqj8mYspUnhDLGIo8M5xM/2nXjR/90kTjkdmg5kV1spGLvgC+Fow
 kTKSxK7gOC/AiIHTG+E1BZazeQusK7rF0bIu9ULAQAA
X-Change-ID: 20250319-conversions-mknod-cd8cb407d24d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037; i=rbm@suse.com;
 h=from:subject:message-id; bh=WbLL7s2suK0dm5eDZ3Ziq1FF6CBqSMObSWrN5yYv9u8=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn/WuAcuvg2CBVUeo18WC4f2v/AJTZWTJ7pvx1c
 4Ae7BKE+GWJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ/1rgAAKCRDJC4p8Y4ZY
 puqID/4ui0XyeXV/0rXLlEShOAoLGDTNJTVLRBAAkn8pLBN8Ey8acYkEMiVVVuZVWJNQ3xzLxgL
 JQ4WgqMUIAaZhIOErSUMIGxUz2/ZX+0FdrYYH3KLQjgLuRUX+yxjWd+cPuV4itmOBT1ImhBvDQu
 DxV4E5IxYm27pyqHxt3lafSnnNMEgDiMRSX6AhlbzlJtMClvswaO+7NEfvTGcxnf0ZMaGkXnu9W
 SyJ3Ej0pOoKfxi+cR2xD0CdBhm+loW69GTcTm2SR/H+Q9NNC71n+Rv7xOOtYmmyDLfANyZHNf0B
 ElyBrp4iP5puNWmAgDgv/1gWUWrD862G3M/XwbL6gr+k0CQb/Hcl/046mBTIY3GaNDuJu4m+4PA
 MH18b9D9oBIp4x5vYtiF19/PvejZ2VZW8VYvgmdK720a0D+T7o1HakpNETJt6KV7ncnW9per7zu
 NGNgFin9iugy04e/WbtoYe121xZQb50JRtu2W7zadesdZw94OaMnD+Y8hP0EgcRpc4h73V7z6XP
 RVtZqyi0bD5AB4omTMJIo5LjuYZociGYSQpaT5ZXJD26kC0ffjt49kiOo323vFYP6ajKnfj7YLu
 Euqw5VSbYaLJAJ6GGwKdzGsoDMoMfFC4IL5sG5e9n343ZQyPxQ7FlVLEDjdGaKa58pFabCHDE8K
 ZcZCgEboXDGeuKA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/8] syscalls/mknod: Refactor all tests
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

SWYgbmVlZGVkLCB5b3UgY2FuIGZpbmQgdGhpcyBzZXJpZXMgYXZhaWxhYmxlIGhlcmU6CgpodHRw
czovL2dpdC5tYXJsaWVyZS5uZXQvbHRwL2x0cC8KCmBnaXQgY2xvbmUgLS1icmFuY2ggY29udmVy
c2lvbnMvbWtub2QgLS1zaW5nbGUtYnJhbmNoIGh0dHBzOi8vZ2l0Lm1hcmxpZXJlLm5ldC9sdHAv
bHRwL2AKClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+
Ci0tLQpDaGFuZ2VzIGluIHYzOgotIG1rbm9kMDM6CglGaXhlZCB0ZXN0IGRlc2NyaXB0aW9uIGFs
aWdubWVudAoJUmVtb3ZlZCBhbiBvdXRkYXRlZCBjb21tZW50IChDVkUpCglNYWRlIGZ1bmN0aW9u
cyBzdGF0aWMKCU1vdmVkIHNldGdpZCgpIGFuZCBzZXRyZXVpZCgpIGNhbGxzIHRvIHNldHVwKCkK
CVJlbmFtZSBUU1RfRElSIGFuZCBUU1RfTk9ERSB0byBURU1QXyoKLSBBbHNvIHJlZmFjdG9yZWQg
cmVtYWluaW5nIG1rbm9kIHRlc3RzCi0gTGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvci8yMDI1MDMyMS1jb252ZXJzaW9ucy1ta25vZC12Mi0xLWM5YzI3YmRlNWIwN0BzdXNlLmNv
bQoKQ2hhbmdlcyBpbiB2MjoKLSBNYWRlIHVzZSBvZiBUU1RfRVhQX0VRX0xJCi0gTW92ZWQgdGVz
dCB0bXAgZGlyZWN0b3J5IGNyZWF0aW9uIGludG8gc2V0dXAoKQotIFJlbW92ZWQgbm93IHVubmVl
ZGVkIG9yaWdfdWlkCi0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1
MDMxOS1jb252ZXJzaW9ucy1ta25vZC12MS0xLWY0NmU3NjNkNzIwMEBzdXNlLmNvbQoKLS0tClJp
Y2FyZG8gQi4gTWFybGnDqHJlICg4KToKICAgICAgc3lzY2FsbHMvbWtub2QwMTogRml4IGNoZWNr
cGF0Y2gucGwgd2FybmluZ3MKICAgICAgc3lzY2FsbHMvbWtub2QwMjogVXNlIHJlbGF0aXZlIHBh
dGggdG8gYXZvaWQgdXNlIG9mIFNBRkVfQ0hESVIKICAgICAgc3lzY2FsbHMvbWtub2QwMzogQ29u
dmVydCB0byBuZXcgQVBJCiAgICAgIHN5c2NhbGxzL21rbm9kMDQ6IENvbnZlcnQgdG8gbmV3IEFQ
SQogICAgICBzeXNjYWxscy9ta25vZDA1OiBDb252ZXJ0IHRvIG5ldyBBUEkKICAgICAgc3lzY2Fs
bHMvbWtub2QwNjogQ29udmVydCB0byBuZXcgQVBJCiAgICAgIHN5c2NhbGxzL21rbm9kMDc6IENv
bnZlcnQgdG8gbmV3IEFQSQogICAgICBzeXNjYWxscy9ta25vZDA4OiBDb252ZXJ0IHRvIG5ldyBB
UEkKCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDEuYyB8ICAgNSArLQog
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ta25vZC9ta25vZDAyLmMgfCAgIDQgKy0KIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbWtub2QvbWtub2QwMy5jIHwgMzE0ICsrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDQu
YyB8IDMxOSArKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvbWtub2QvbWtub2QwNS5jIHwgMjg1ICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDYuYyB8IDMwMSArKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9kL21r
bm9kMDcuYyB8IDIwOSArKysrKystLS0tLS0tLS0tLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9ta25vZC9ta25vZDA4LmMgfCAzMTIgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
IDggZmlsZXMgY2hhbmdlZCwgMjYxIGluc2VydGlvbnMoKyksIDE0ODggZGVsZXRpb25zKC0pCi0t
LQpiYXNlLWNvbW1pdDogZTBmZjBkYTU4MjY3OTU5ZTRhMTNmZjdiNzAzODEwNjk3NmVkMjRhYgpj
aGFuZ2UtaWQ6IDIwMjUwMzE5LWNvbnZlcnNpb25zLW1rbm9kLWNkOGNiNDA3ZDI0ZAoKQmVzdCBy
ZWdhcmRzLAotLSAKUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
