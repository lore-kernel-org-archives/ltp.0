Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA6CC77B7F
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 16:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751042933; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7AyeEuq16aGpR+U618pEdP+kQLNgbEc2upxOVpZIorE=;
 b=NNgIiVsk8OKXn3M+coL7rh6rmyU+oExoaLa4fYLIihcKanoRLhOBos+24u+Vr28RffAwf
 4So5yr0xnbKlcRHbueJztcyMaFoEIzaqP15gSvE+Ppa7EMGF8OxDN4rVBexjVkS4tJ9198S
 VSIk4N++0HHZ6/aZyWwpIF3GtzYJ/7M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 023893C9265
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 18:48:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 674273C8E34
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 18:48:06 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9C480600ABE
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 18:48:05 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so20690f8f.2
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751042885; x=1751647685; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IGgrsM1hu/sOrUDv15LqjeyKy5PWhvARvX6e08IsBAs=;
 b=bLI+1fjiIxWzGTWoqG241peRC0nIqDSLj2ZhzM8ZLGjhqwDHPS4nzQMp5ll4oa+T5D
 fFX646GxA/11cuD5QFPBwJUUOxOVntYIwCkCgh1sIvcgSYDuOKMiKe8h9DR2IViuXCCV
 n8a9lt4NCT33R7uWSK/OZ4jZDTi6AOFPJqf1zkdzhyBkZcRuITnvqvLpwICjHXkd0XX/
 sxIgbyP6TjArkssPZ7yvdOJX6AjmeIEJcxQ3sTJn2+Vb8yyyS5SjTZrK/6t1D5eDDxLX
 MmInSobn8K64WSQXic039teWHUYturEwvebHguWWrST60ZDQIyWkaLAAopGXXwC/B80f
 0tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751042885; x=1751647685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IGgrsM1hu/sOrUDv15LqjeyKy5PWhvARvX6e08IsBAs=;
 b=cQwbgdpccmV+ZoFpigIeQhqdVA4omoAxM0V90v7AsYIYUtWmGUgPH+EnHYXwux9Yjc
 eHb/2/Ex+OBhcj1asrwoq36bGUuFGL6HSXfMgiPcsEdVrG9ffrydsj2g0dj8OOSecABG
 2oV/eSQ9yBlO/Q9/uof0WUfiULOUnaSo1FzBLa1mg2x56JUbxrDhN6iqfytw5XLO5mLz
 3wKWMb/NMMe1F4Vpr3HWu5jeBOOtxXL8Hsk5GEYoEHmpVbxRVBjTEWBbQOxTousj56Sv
 yNlb9n1rbeVjT+mesvAxrmRcRhyb0XooPKY5x1NE1TgPjG3+FVD9bgP17hOtTGpNGsE4
 Z9kw==
X-Gm-Message-State: AOJu0YyAHnNnKIdKNV1ZEchsiuwjdtCQTTlSSjJa5AGPkTQfKZZOkHVe
 dwwSCqiOpeyf75bqUpvquClWME3cqf1p0Bu3np6a76amow/cMmn1QlVjbuEnXkInDGnPBHR42kg
 OCdPY
X-Gm-Gg: ASbGnctrALukko3Z9QMnoN9z67tnu1FAM7rYN8/f8q9aCHrC9YOJjcbc5HuwIQUFst3
 2lIFlaNmusn408gDqUCSOd2aoPM808UtH6MhEQpXS4j3Dtl2IRGfNOiKbnAI/wcEuJbQDx88mmO
 v4KPf8D2uT/oswzks9jSNJrz4UmueL/R+zdtpvNd/SclmKK+CN90uqSbuW1SJ//QlTLJVXYgwCV
 a7IxxESpDVTj1qhH33jFvBzO9zfrR8oS2qcNsWVrBMR0dJG49+QRQk3dky9fvClwsi2gUdStbQH
 VsJ+xUwlsXCCa4vkauWscwG06sBziXsvufjmZ9OoWlbA6rqWGw==
X-Google-Smtp-Source: AGHT+IF2TqfT6AaM0ngVkncIUVH/dmBvZ9XoO5qvbcubBRaf4X8oY0z+IXAYB8yU6arOut1KIvroAw==
X-Received: by 2002:adf:8909:0:b0:3a5:2e9c:edb with SMTP id
 ffacd0b85a97d-3a8fe79ba7dmr2737866f8f.47.1751042884966; 
 Fri, 27 Jun 2025 09:48:04 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 af79cd13be357-7d443201b67sm159254485a.61.2025.06.27.09.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 09:48:04 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:47:56 -0300
MIME-Version: 1.0
Message-Id: <20250627-conversions-shmt-v1-1-52449291b036@suse.com>
References: <20250627-conversions-shmt-v1-0-52449291b036@suse.com>
In-Reply-To: <20250627-conversions-shmt-v1-0-52449291b036@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831; i=rbm@suse.com;
 h=from:subject:message-id; bh=8P1XFQSMsLOEWxKeM3lzOSbsnY64KoLTJSdRxw3fVK0=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoXss91RNY+3x9ogP0QCIVf4N7OmnWXI2oJuCrE
 KPgNykGjzCJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaF7LPQAKCRDJC4p8Y4ZY
 piiJD/9KinJiaz1ZabaHZSGqNrXhAvhcpM2RHls7IXyl9/QBh1AJjEnQOunqVQ/+aRwW9N78fEd
 b5ZfIXPVt4iMhWtZwKFsfT78soeIBi3Wl0xVghWvUqbqnMo11Ujlh1o/t/2Pgb1GGglRXEpHGdz
 F1Iy6ow++tQKjRloqPuvE+EBYWfnxDDw8xEUYWdQXPcHJgobpkM2ZAODCCsXncpRCGBvw2/rRtY
 7zcsa8DkF3R7fAN5xa9I4o0oEJVtwWQnOFtCeemeJ7xF/6xiBlA94bh6UjGYf4VHDem6LVB3S5Q
 +SDzonUqiZIXMI6QgvZ5VAbUURqjdGv1ZVlvVq8svXXz3dU4DGleV08yRUc2up0nJER28MpvcM7
 scQR6ydDxSh0V9XPtw6n8ljOSnaPbfEsfIPZC8wA8GZVb6uxuyEwyXj5aX1kV3gV+v5wUKzBOVN
 mPI44HkL+sV0avSE7XKrBPFVaG7nP8tB7OP/pQQ9PMriQeFva09k6/mhWckP9oSJ4yh6Q/zgt3m
 rVgJIFWWrWRKvjU7JWdQDOyIau1KubwkSeWcTCYl3IHwL7kh9zNj8Hjtrk5hDcQ9kq+EY66+NcK
 CaBRZFDTSjsYwg7IhW3kUx3hcYAGiDY6pKSNmcn9rkRuX/wvjWgI/kiyUwrEuTyAnBlf3oKKL0O
 ZVReMfIElj9CCzg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/9] mem: shmt02: Make sure memory is no longer
 accessible after child exits
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoZSB0ZXN0IGRlc2Ny
aXB0aW9uIHN0YXRlczogIlZlcmlmeSB0aGF0IHRoZSBzaGFyZWQgbWVtb3J5IHNlZ21lbnQgaXMK
YWNjZXNzaWJsZSBhcyBsb25nIGFzIHRoZSBwcm9jZXNzIGlzIHN0aWxsIGFsaXZlIi4gTWFrZSBz
dXJlIHRvIHZlcmlmeSB0aGF0CnRoZSBzZWdtZW50IGlzIG5vdCBhY2Nlc3NpYmxlIGFmdGVyIHRo
ZSBjaGlsZCBwcm9jZXNzIGV4aXRzLgoKRml4ZXM6IDFlODUxNjc5MDA2MyAoIm1lbTogQ29udmVy
dCBzaG10MDIgdG8gbmV3IEFQSSIpClN1Z2dlc3RlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5k
cmVhLmNlcnZlc2F0b0BzdXNlLmRlPgpTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hy
ZSA8cmJtQHN1c2UuY29tPgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDAyLmMg
fCAyNCArKysrKysrKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21l
bS9zaG10L3NobXQwMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vc2htdC9zaG10MDIuYwppbmRl
eCAxNmQ5OWFjN2E3ODFjNDJjYzI4MmRkODFhZjg4OTUwOTdiNDA0NDM1Li4zN2UwN2EzZDZkY2U0
YjI4MTYwOTNkM2E2MzNhYzliZGEyNzlmYzUwIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVs
L21lbS9zaG10L3NobXQwMi5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDAy
LmMKQEAgLTI3LDIxICsyNywyNSBAQCBzdGF0aWMgdm9pZCBydW4odm9pZCkKIAogCWtleSA9IEdF
VElQQ0tFWSgpOwogCi0Jc2htaWQgPSBTQUZFX1NITUdFVChrZXksIFNITVNJWkUsIElQQ19DUkVB
VCB8IDA2NjYpOwotCi0JY3AgPSBTQUZFX1NITUFUKHNobWlkLCBOVUxMLCAwKTsKLQltZW1jcHko
Y3AsIHRzdF9yYW5kX2RhdGEsIFNITVNJWkUpOwotCi0JU0FGRV9TSE1DVEwoc2htaWQsIElQQ19S
TUlELCBOVUxMKTsKLQotCWlmIChtZW1jbXAoY3AsIHRzdF9yYW5kX2RhdGEsIFNITVNJWkUpICE9
IDApIHsKLQkJdHN0X3JlcyhURkFJTCwgIkNvcGllZCBkYXRhIGNoYW5nZWQgYWZ0ZXIgSVBDX1JN
SUQiKTsKKwlpZiAoIVNBRkVfRk9SSygpKSB7CisJCXNobWlkID0gU0FGRV9TSE1HRVQoa2V5LCBT
SE1TSVpFLCBJUENfQ1JFQVQgfCAwNjY2KTsKKwkJY3AgPSBTQUZFX1NITUFUKHNobWlkLCBOVUxM
LCAwKTsKKwkJbWVtY3B5KGNwLCB0c3RfcmFuZF9kYXRhLCBTSE1TSVpFKTsKKwkJU0FGRV9TSE1D
VEwoc2htaWQsIElQQ19STUlELCBOVUxMKTsKKwkJVFNUX0VYUF9FUV9MSShtZW1jbXAoY3AsIHRz
dF9yYW5kX2RhdGEsIFNITVNJWkUpLCAwKTsKKwkJVFNUX0NIRUNLUE9JTlRfV0FLRSgwKTsKIAkJ
cmV0dXJuOwogCX0KIAotCXRzdF9yZXMoVFBBU1MsICJDb3BpZWQgZGF0YSBoYXMgYmVlbiByZWFk
IGJhY2siKTsKKwlUU1RfQ0hFQ0tQT0lOVF9XQUlUKDApOworCXNobWlkID0gU0FGRV9TSE1HRVQo
a2V5LCBTSE1TSVpFLCBJUENfQ1JFQVQgfCAwNjY2KTsKKwljcCA9IFNBRkVfU0hNQVQoc2htaWQs
IE5VTEwsIDApOworCVRTVF9FWFBfRVhQUihtZW1jbXAoY3AsIHRzdF9yYW5kX2RhdGEsIFNITVNJ
WkUpIDwgMCk7CisJU0FGRV9TSE1DVEwoc2htaWQsIElQQ19STUlELCBOVUxMKTsKIH0KIAogc3Rh
dGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewogCS50ZXN0X2FsbCA9IHJ1biwKKwkubmVlZHNf
Y2hlY2twb2ludHMgPSAxLAorCS5mb3Jrc19jaGlsZCA9IDEsCiB9OwoKLS0gCjIuNTAuMAoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
