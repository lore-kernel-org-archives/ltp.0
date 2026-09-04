Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ADAC61DD6
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:20:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D081D3E9760
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:20:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 763AE3C84C5
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:20:18 +0200 (CEST)
Received: from mail-oo2-x05.google.com (mail-oo2-x05.google.com
 [IPv6:2607:f8b0:4864:31::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1440420006F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:20:18 +0200 (CEST)
Received: by mail-oo2-x05.google.com with SMTP id
 46e09a7af769-7f4e6693089so338780a34.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788524416; x=1789129216; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QSN1hfAmqxjfiBvICnwtoAQF/L763lf9EQ0NE7BaP3E=;
 b=GN7YKG9gjttoNURUxKcpylN2YB6YzyvJKWyR4boVcOViDD9unGtRBRqnbyZFClFD7g
 r2u805FfK8Y0ST8k3Zy+3VflIkDQ8hScXutOKhbL5mMrYEYQ4mfqlDPYtqJScwL3oQv0
 5RzpTRQtpaTohmyLRmENvyUsEyNTgfd/YwBceoGbNr89ldpAwoJVP/MY+hvPAwQb6XSn
 0ojsgCS2uaPEZ79NhYz5ADniINqYUhShyBCtjdQXzWHptajZGvjwDo3q+xsagEUfmDUh
 xhydXOf1YTOwP2ygq19U5fLbamZJe5bBkZCvNfGAQOZYnasOJob1cgPtPDmgyNH/wUI6
 hwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788524416; x=1789129216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QSN1hfAmqxjfiBvICnwtoAQF/L763lf9EQ0NE7BaP3E=;
 b=fsZzAFo24w2gfw2nLMrVhyjsY7x3clws9lv2uxkzm0TRG4R7cCK+WjLBPlGYmJVIV/
 eIAXuvNGa1yKH1gvvzmiAVDPuhL0mqElKB3IQVnPy5Yn1FXmxrwYghJrrhfWBCZmAfZd
 xfku8j1nkEx+zjCykwNdQ2He1gOMaqCcGz8L7fiYn30/eWMauSgj/RLafrRCIFdsq9D7
 CU7/TlL+JXNrxzV6nKEucW95Y8r52myNlokOVUugK833ZnIKSkvvMVvLk1OMO0xzDGbv
 CHsKkriFeMAyJkljiDXwgTxtsdXvdsQbazeAmAmGOAMEazI3Tt60K3I1sDV9Qrh/iTmU
 P51g==
X-Gm-Message-State: AFuF++nf1uhMj+svEkY5Y8OI16lEkkCxohRq5fO/iT9hPfo6nb1DcDM0
 txeosqHy2l39TYAOZFIheJVBcTk+zS70ree/eCGcbtGr6y+wIH93+TxwkV18TB67rG4=
X-Gm-Gg: AYBFou3RZJ79SR6Q4IQzf2kEtSdmRmayOD4KfLhvqqc0gHt3J5QAYpKJI3HV/vahezE
 8aWyjh3fCO0ZoOkEfO7dFnUFtlh6kVxCG5510nE5cu6gH+0daZpxybAM1RDkCq1iOnUnT243N6T
 blEV4XK+7/ljbfP34PRyhfF8EFtTj/Nt8ylV/ce/wDVhirxooTnr3ta+pIHFer0UC2H7Diya/uG
 W0TvOFoRiXfkW04iPBE4m04yWK52xsHEixxgRsADtf7mcwhOooh0UGnbFYl0YfcV8skLjVKXXx3
 hEnK1Mc8DUytivyH5IzaLHisvrRfRWPdXQeTK4h/2k7ts7xRui6fORSRomppC7nFxb6TdfVen3f
 7YCA2FmsYSHzgOrMMYby2jpTHhbJ4Nalubuc6Ubk8bexeXKuYI+4t32nfjkd0JK21EGzlvB9XeL
 FopPBctMc6JpEnkMquiss10joPsz+S+Ho8EdeAfrV5/JxuytIml/PfxHxMkBoiXTlwu+uenpF9n
 yiLhYt765v7H8EYC+QLRoe0DomC4M+B8EU7L868dgH4tSuJtS7W4UyeXUT4ve2ZAry7REpho0ab
 FA==
X-Received: by 2002:a4a:e916:0:b0:6aa:cce3:ab61 with SMTP id
 006d021491bc7-6b6fb0ee5fbmr4962367eaf.9.1788524416516; 
 Fri, 04 Sep 2026 05:20:16 -0700 (PDT)
Received: from
 runnervmejwal.5hgwdkdzwbtu1adlnb4fab40uf.ex.internal.cloudapp.net
 ([172.183.95.148]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6dbedc6fasm2905785eaf.3.2026.09.04.05.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:20:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri,  4 Sep 2026 12:20:12 +0000
Message-ID: <20260904122012.9088-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-coredump-v7-1-a32b7ca1acea@suse.com>
References: <20260904-coredump-v7-1-a32b7ca1acea@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] coredump01: New core_pattern specifiers test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Fri, 4 Sep 2026, Andrea Cervesato wrote:
> coredump01: New core_pattern specifiers test

--- [PATCH 1/2] ---

> static void run(unsigned int n)
> {
> 	if (n)
> 		verify_pipe_pattern();
> 	else
> 		verify_file_pattern();
> }
>
> static struct tst_test test = {
> 	.test = run,
> 	.tcnt = 2,

This manually dispatches separate functions for the two test cases. Use a
single struct tcase array and a generic .test callback, with
.tcnt = ARRAY_SIZE(tcases), as required for multi-case tests.

--- [PATCH 2/2] ---

> 		} else if (ph[i].p_type == PT_LOAD) {
> 			have_load = 1;
> 		}

This only proves that a PT_LOAD header exists, not that its data is present.
A short dump_emit() after the headers and notes leaves WCOREDUMP set, so a
truncated core can pass every check here. Validate p_offset + p_filesz against
core_len with overflow-safe arithmetic for every file-backed segment.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
