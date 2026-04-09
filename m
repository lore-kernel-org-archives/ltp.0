Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBD5F31E22
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775744189; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=UgzqoOlfz9adx7ymkwMuen5LbGJr2sCdms6REnnktLk=;
 b=lh014eqP9/azBxLzAFPjAmd/5ZgjnEn2SavOqvkrz67FXfqtN7I3UvVEJfiQfnKHl8mdN
 mQShXsQ8vu2YUKcxqJ01y0E0pZm/Th9VCkE4PmRhcPsuyoALRrODHEmH6nv/9g5H3kP+7Te
 giktM4Uof1WgHusGligbtntb9tgWyaI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DDCA3E12A4
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 16:16:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 179F13E12A4
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 16:16:04 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4D26160B021
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 16:16:04 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso10445155e9.3
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775744164; x=1776348964; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HBv+qCTh+2X4ROkVKDG2xjeAQDFOfbKTujIuyiPSUS4=;
 b=cKSwYX3OEv/T5Lai0RyL/W460Onpk9fDSwfnRpxNTFamdBJ1A8DIrSTc5nEpbA1CHd
 H4JOSEGNbvJ265fjuVDpMqFn/cRnd2R2lJl7M8/zRYk3sPkxQ7zYW6F+eQd14riuFEJx
 eVUnrctJle2rqPHjqC5oEmqcBvl3cHcygpCBEZ2V8LM43wzOq32oRr9p+BIu7DexFfGQ
 HnxH3tTrCALb4E8p3K8f3vVefM2ipZ21UNQiNDXsl9S/THk8Pgt9ZwkLQaBSzeje+S4z
 5sEGrOyvnyNGSIrIrnqg0u/eCIz0sx84Bw76k7pfc0KJ8mOoB0MKwn6n9AFZ1MCRZ5v5
 tyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775744164; x=1776348964;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBv+qCTh+2X4ROkVKDG2xjeAQDFOfbKTujIuyiPSUS4=;
 b=EUuJqhN79inhjjw4lRHVQyiFDZ8JRmkdXQjDFnktZHyOysjq6eSAC3cvIL7Mb8ekGa
 j5SmaFAJpB86Hn2SF45vpdoWuHQY7an8pxw//L64iHlSpCfwc/6f2WQc8VxizvWhTMLl
 vOZpOnfOTN7ZZv/KiPdlLhozfZcC0a5B+1Kn1AabQyhHQwq4rV/TOvf7ABgWymQueXH1
 OnLEDzbHJbmPhob6zMrws4pzm+vAoA71x+xdYrwbw+FLCnYnexdpKLH9o51Tg4o0jTiO
 A4lIoX0H5BoIQX/KA41BKsstyZGPaMAdPtTr2yINLCnZqt+fPWZsC5XbWbzf+a87y/kc
 7mYw==
X-Gm-Message-State: AOJu0YxXyPtWUpJklZf9o+iVNkPegna2hPcFRZguiPNIaDM2IXYOeKEd
 slDl/AHr/c/qkAtk6Tbh+hBHg9GJCTmlVedaCxtddo6XueHrfIae4arNXjbhnvVG4lFrfumKCcz
 Qo8MxzoITqg==
X-Gm-Gg: AeBDiesZwlcX4jnGlEdhH8k+BEri+/7rCEZHoXI9iZHbrFpH/Il5ITY+acIGMcRhlf5
 g6Qso+ikmyTjDuUa75mvIYbBzTpD3Pt3nzHF4QvZ8iGv7KkhtUeNqLLmpeUBC0WZYGXxG+U48K+
 pkKNjV5yUfZLX+xhGPNfuEX9pBTTlI5JagFk0eNrdqIDF5ov2aGqwRq/ixy/rdDhmF0Fp8mIVuB
 9ClPEMjjdaDwm6Pcj/UsTgMQYIb6IbMrpLdnZF5gNpKgdS0W27ndUj9xrlYpaMJqAWI0hPyfb2X
 i/gsq6sc+VFaUZFYtKzk7Y08xRmPFsiKQI4MM+SNeFPb0j9x0VDtvVB5FaJA2dFN+veavT99N3a
 SzmMjOF1cxGevjOa7L8sFC5uLfeA8mGRZDZPgpo9VNtsLFCUwj2oi0KpwAFGdi3TMSbomN8fDri
 fuXDqb97coTisMXxQLi/7IiN82RwYk0pPOFYcQkniEJ8d0IIG5k16DNmQqStAOpcUc1mRE+zFuW
 aQ1xbCV/Wk/yNU99rEGNyg6N8HVIGQ4SGnR+2zMQi+BWoWuWb7J8c0as2rz026Y/1S0uj4Qo4w=
X-Received: by 2002:a05:600c:1553:b0:488:acbc:b2e with SMTP id
 5b1f17b1804b1-488acbc0ca8mr243006905e9.17.1775744163110; 
 Thu, 09 Apr 2026 07:16:03 -0700 (PDT)
Received: from p200300ff0f085301c60b3f6236adb066.dip0.t-ipconnect.de
 (p200300ff0f08530146115d0b2dc6d03f.dip0.t-ipconnect.de.
 [2003:ff:f08:5301:4611:5d0b:2dc6:d03f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd21b604sm76738395e9.10.2026.04.09.07.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:15:59 -0700 (PDT)
Message-ID: <69d7b49f.050a0220.28f87d.4332@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <20260401210338.485029-2-rbranco@suse.de>
Date: Thu, 09 Apr 2026 14:15:58 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] userfaultfd: Add new test using
 UFFDIO_CONTINUE
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,

there must be something wrong with the patches you sent. I see v4 (last one
was v2) and patch #2 in a set of 2 patches (but only one is available).

Can you send the correct verion please? I will set the v3 as broken because
LTP is not compiling with that one.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
