Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC38DC54E41
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 17:27:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 275D63D0CAB
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 18:27:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2E5C3D0B8D
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 18:26:44 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dbrendel@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F3F7620098A
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 18:26:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709659602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=0l3GaMQ+etBsX8YeXP6TUAp0EwDioxP5V9rqEXPJ+cU=;
 b=ZWCU9exF2o6DbDnlV/7vm0UYZfd5jd70qq7vx5ikEpRE/UyxsGjUdfkI46o6qsi9/CIxvD
 hIurDZiR2e2s5EcdHZAn6V06KiIFukB5+HLBunvuvzQQTfvfZvFidYXsRWFPlzpX5xauzn
 tY8MlQvxXZi9JJsuHSIzr8ImhdW1Tzc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-pbSgMD7GNi2pWTp-qJGvKQ-1; Tue, 05 Mar 2024 12:26:40 -0500
X-MC-Unique: pbSgMD7GNi2pWTp-qJGvKQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-564902d757bso3975311a12.1
 for <ltp@lists.linux.it>; Tue, 05 Mar 2024 09:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709659599; x=1710264399;
 h=content-transfer-encoding:to:autocrypt:subject:from
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0l3GaMQ+etBsX8YeXP6TUAp0EwDioxP5V9rqEXPJ+cU=;
 b=ll0CDfQpiR3n36nfqHOzvG5Zt96e4Fc1kitcCOz/OG9NYvaTww0p2GqFSlLX018jvE
 9ae3W9tFKesinmGE2UZv0H3nLuEep6qAc0o0la3a98+Z5S3R0rE/gaMGAp5AHMW87Dfk
 sD/GKO/MXeDZW29/QLVfr1gwVmYm1N0y9bfiXMQDVT45Dw22NN4FOR3efKsPFoBDkKNi
 PkMe46j8S2MW+1C2PqiFziFthrfvHoHSCDpakrWqWqLo4gPhld6Ix+uo5aNgMzQkFHVI
 MiTxu/pNK0oRz+TnMFYtGGGtez0/l9o6j9e9b8Itl5HFbluou5Eq9YiMVCQ8Qg7uHkJK
 4NYA==
X-Gm-Message-State: AOJu0YxKXpFO+SByD+2fOKqTSm1M2oEgdj8YRmyKCbQ6eqJblWsaLrWg
 AiPGuOxf/zmkvTkobCrqqjYUf/nCEdW3Y7ohCv5zDhG1EQFBICQUHA1oF7JV9k+I0ug++EZ1QjY
 xS5UnyKCWulThRhhHol0bqDj0vu91u37e0hBHPKcaQS7rtrQXqvLU9Y25k9MJTA1vPhbFoq4aWX
 KTtWds6z4rIvW2Hq0jR6e/QUqFtUzJ/GQD
X-Received: by 2002:a05:6402:5c2:b0:567:6a66:d103 with SMTP id
 n2-20020a05640205c200b005676a66d103mr3779434edx.0.1709659599359; 
 Tue, 05 Mar 2024 09:26:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH64bpV+yditFhk2P3iNHRhwikdzCyW+T5uy/4jPNKs2oDV6LuXlbfjDVCtiB5RT1yG3QMGvg==
X-Received: by 2002:a05:6402:5c2:b0:567:6a66:d103 with SMTP id
 n2-20020a05640205c200b005676a66d103mr3779412edx.0.1709659598902; 
 Tue, 05 Mar 2024 09:26:38 -0800 (PST)
Received: from ?IPV6:2a01:599:41b:652e:910f:1701:7713:77dc?
 ([2a01:599:41b:652e:910f:1701:7713:77dc])
 by smtp.gmail.com with ESMTPSA id
 cs4-20020a0564020c4400b00566a4dec01fsm5892625edb.11.2024.03.05.09.26.37
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 09:26:38 -0800 (PST)
Message-ID: <6dfa210d-1c9a-4888-9408-eccc3068cd2a@redhat.com>
Date: Tue, 5 Mar 2024 18:26:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dennis Brendel <dbrendel@redhat.com>
Autocrypt: addr=dbrendel@redhat.com; keydata=
 xsFNBGVTKdEBEADsKurPrgCiPT/4CJkRYKYtdcIpQyku2yrFAmwwn0uvK134wSpSB7u5iCr1
 T8cRnvXKbbcUEzrjExBZ6JCiDwCpUkB2LFQk8b8VGr19FD7/vXErnLNgyidz2MVqEJt+qq09
 9B1C+z9YvVAyyp98NiryDkmYy/+ToTl6V/YP8rGAp5OWiI5lWjd+/1o3LxIbvvV7qdL9agtW
 Zdm7nwHsda2cTe8VI6pGcFBK+GkUEeFGhKquTFytc8WvqVSYjnfwRO2a9sSkHRvA7iTOwpB9
 BArl0VFhUkeamCrxj9OtTUTBolJaTRX3OkqKMOlJ9c3MXgpcHBUka5NfFUrhdL7cU2DSkZ06
 qgBQ1z2H3y7ZhWecZYnMgDqF/DfZoUc41KSglUi7Nh2cLqBJ+EiZGsK55COIU2Ht4vB40key
 oZoabB4vOhIqO1vTArTCAILx8JB2NqAEoYb85lXBm22lqfz3rthigErS6wC6ceDHCAtnGX/K
 Fx5gdykncFX3YOI6tf2I5YJ8jl/PrLqrwuWldZdvx75ml/zVS68HTr4NfOogt4WC4RmZIoSj
 jvdAg4EdLICRZh0gU++UwISVLcVKs4ox/hxwROFfYIl7QDIreVBhDBuB/QBDKvaJqOXO9uNo
 LmuNrMxjtTlKzOU7XNJ1kdV/BzgE1/fQOnXmFMPf1t+UVciMBQARAQABzSREZW5uaXMgQnJl
 bmRlbCA8ZGJyZW5kZWxAcmVkaGF0LmNvbT7CwY0EEwEIADcWIQRHu2uJHgJiD5qIRsd/bjhD
 VXLGLAUCZVMp0QUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEH9uOENVcsYsoi8QAJHl
 f6ZT+8P+j7kyMfpfHy7QWZJcrwFFc9esVD3egAJg7/P6aizzAzhgiLCX6ZCy0aHz9Mn6WoLU
 55zQ6fgcC1L6rgKZwZizk1sNg8cNXURvHXU0hsInlbkR+krNh2RkR5W6wAsAC/IfrcxsA4rk
 8uCGv3GQgUDI7D/+XgAvCGy5Yd5hOgYmX/xrMLmbHOPxvGwyKKzf7esYayTc97UVlUswuQ7o
 KsymvGg1HIt6LeqP9JpAAeYx3AtRC7o9vN/pJlq6SjbER0HJwykDBWRE3T1vNEXOogrm+OBe
 XRFbIQf82feZCeIcAX5azMnhOErcZn5fcnxTkA44eZpnglwvrsNv37W38c7Eop7LEqOYQYtt
 1gnH+syXoHs9rmF1fKOo08ISX//wjFXhZIywaRWDIuV0lUuQnovq7SpM67+kDJNWM/yMubpG
 KzlRP2QagiiaeOHG715FBggi222fQgpp3gRU1H0trPWz0EszRvW11PV0+i5XlNmr6ysOXEOI
 bGY4sZfiAGxv1gnkhjHijBcXYWG+tyLR4BddbxhGGHmc9RhA5PlzdDx/spd9a3z67MW0nd/p
 FlosHk17rJa+ewykegBiQpacJ66/REPidSpixV01w8IE8LAtGmNXC2zAOJ5Ih4PYva4I3CrD
 bvIkMdE8dvs7ipYAVe7Uf89/9CPw99dEzsFNBGVTKdIBEADGCzSnIyBjLNh5OZmSlSfVY6S8
 Asknz3WNeuPWJcZ75pQ46haPOBPy4cWjCnwMitUfi+kz2s9sf5V3T9RXN4NhXW6A0K0RPOgy
 O+OjU3CgAC61KjspLWUPzXJcWfmr53l+aqkOymXC/teAG3fn2rLrE/WwmLBCpygiKwess5TO
 T8pGVVg76CrknvmEz4KHhnm4EXpuQBw0GRhL+Gx3HgEJcotHwZBhKRidLJzLw3HwFaxv426k
 3f0DOmZu9qeghI7G0UJAwisISnFf2PuqBoARh029O/XxvK906sIP6V8OKNQOp5pCGyonNLu8
 qTRIsF6aYUSLc0BgIexqy0kTxU2GyZ6wfqNUqG6gySQsmv+Lz/TIeVSx5EBbHqtMf2UsNWKt
 fSIT/kOwHnBiii6fjt/5wWMsHOAZW3lDlNDTWpMKT9SR+JRQCglSBBCoVNfSxulxWzIWZCDx
 ILJvPea12SnILAb5bjygyl4oAdB8qxiKuAm0sIPjGblpOtbPG81YgED4N1/lEu9FO7uL5Lft
 spixYjsrlfReIqCMiLw6HViVkdtW/W7EFZ7nkJNGOlIousj/NTlfxzNna5j8g2//CoGZq1bi
 4rMSGPAqVfJ75eD3szevVk05sWV+B1dB13z5Ri5Us9qgqT3XnnV12ZX3L15XU0+fJB6JteR9
 Xi11+/7teQARAQABwsF8BBgBCAAmFiEER7triR4CYg+aiEbHf244Q1VyxiwFAmVTKdMFCQWj
 moACGwwACgkQf244Q1VyxiwaJhAAnz1Ft1vDVWU9tord8xJD9MnROcfZckN+CW7piHoNERR1
 ymAYnlFHT+d1gb7VbmoaEeZCYC38+pG88haHZVCa61TQ55cMbiuS1C55KeaE3b0eWov/Ph4L
 uTtPbCg2xeXhi+6JZV5PEi0f9SKrsS1loYtIdY1cLFRZZ92mwk0boGdBqIc+3z1tov9sxZZ5
 Q5VCZPoxu0SRN2u8CvI1yFlRaqxu2cm/HTubVL7q0pJRbzKvDEkgqy/FxgPvy7+Eb+G91JsE
 tH/8/coBhxMnwUxzufKfMEjHhYQJmRXvfLATWATpNnf9D0P2AKu6rZNHsymHMFOZSTmyQAhT
 LbpsH5Qv9tIcpqe/e1S96fU60GavydnlstqR1acgssXX2UNokvHI+3cEAh3V1qfA9tHU51lY
 dmBh/ef4CJPN0vmel0EKiQOPKrkXvpO61J97WHj5UP3aDq2x6zwpoHjg1dPSdcJNJAWbHvaS
 wefE5r2VzlLqOfrLiDraphzMxu7aoCUfrytbAvI3g+2LMAv0D33VSZG2HKHpJ4WwDNz6Hwxv
 lAIPj1Y9t8clM/osqYlW7tBNasa0jdGXdMVSYLgLd5Ua30LDeio1DjTD6Q3V0l9L/FpWpsic
 IA0iwRnpCsh/zpt5/4n2zXe7CtE8pUw13VCLgOXtco44RgS4QbN+mY18JG2QoTo=
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] munlockall: add test case that verifies memory has
 been unlocked
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Changes to v1:

- use a docparse comment
- use tabs for indentation
- report broken test and exit if any preparation/confirmation fails
  by using tst_brk(TBROK, ...)
- fix further violations reported by `make check`

I did not yet replace munlockall01.c because I am not familiar with
that (legacy?) syntax and why uclinux needs special handling.

---
 .../kernel/syscalls/munlockall/munlockall02.c | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 testcases/kernel/syscalls/munlockall/munlockall02.c

diff --git a/testcases/kernel/syscalls/munlockall/munlockall02.c b/testcases/kernel/syscalls/munlockall/munlockall02.c
new file mode 100644
index 000000000..06f781d86
--- /dev/null
+++ b/testcases/kernel/syscalls/munlockall/munlockall02.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright Red Hat
+ * Author: Dennis Brendel <dbrendel@redhat.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that munlockall(2) unlocks all previously locked memory
+ */
+
+#include <sys/mman.h>
+
+#include "tst_test.h"
+
+static void verify_munlockall(void)
+{
+	size_t size = 0;
+
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
+
+	if (size != 0UL)
+		tst_brk(TBROK, "Locked memory after init should be 0 but is "
+			       "%ld", size);
+
+	if (mlockall(MCL_CURRENT | MCL_FUTURE) != 0)
+		tst_brk(TBROK, "Could not lock memory using mlockall()");
+
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
+
+	if (size == 0UL)
+		tst_brk(TBROK, "Locked memory after mlockall() should be "
+			       "greater than 0, but is %ld", size);
+
+	if (munlockall() != 0)
+		tst_brk(TBROK, "Could not unlock memory using munlockall()");
+
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
+
+	if (size != 0UL) {
+		tst_res(TFAIL, "Locked memory after munlockall() should be 0 "
+			       "but is %ld", size);
+	} else {
+		tst_res(TPASS, "Test passed");
+	}
+}
+
+static struct tst_test test = {
+	.test_all = verify_munlockall,
+};
-- 
2.44.0



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
