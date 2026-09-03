Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCADCC624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 13:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788441567; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=pxO+cLgxT+pju84uB8/qmHZwxUJcqYcWvW5NqgMguznlKFqeC0W2BIrt+EI9L085ZJ7vZ
 NGlYWWZ/OEYzq0I4yi7NQISnRMV5dE4hrIPnQIVYpLVpEAreAQNlomsu+KGXl6/Dokl884F
 GVvmm5TXSnEd3b/DRTq//FTFnwX+la0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BCD93EB09F
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:19:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDE843E2253
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:19:07 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 569361400DB7
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:19:07 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-495590dde14so26735195e9.0
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788441547; x=1789046347; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=LYECEh0dVviw5+mJwF0QicMSSCJXcmmzAfiSOVcGCsgJvEFVvqKK+n6SstjeWgEbXE
 DGqlHX+SJSZe1ImkP8ghnB5xFwajOMHdmUi0eKsIHRKUISsYn7r3Tt4JwQv0X+vS61dG
 ZXU96CmdiHCYXXOMIdHAgw76YuOIs/Utg7t3oNzxYKnlHdZRkb0kpOsEPZ0QFD1tBWg8
 wUUuJwfEaH5x9xXO3vOmiT44B92k/vlxMXAovIRHYp2bVmQ6wqyxwUrqwxvhv6yF8CTb
 ZH4ZsMgcZ6x/t51S7UTUBGK5y363j9cS5q6GQu+06wzSSna2DgdcT1NQB7LSFQGlf+np
 zmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788441547; x=1789046347;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=BDyUDIxMbHwQH4kaRGXsfECOOUTzylqqOvXmEGd31FWrVcUtXaCeEUDLmk1viUJ76r
 d779/uNapp0ZeCdU5oBPeNYU5yLaOCeWT5W2Ak0FF+lC/9EAiWPU7HQhsRjipUTY3M76
 L/wmZe5TuXgNusYVbEKpoCOmc51S0p3xoSkThUFW7DdWmhmnr1tPUPTPIPqRWT6EVSRQ
 bfckd43ADqFaDPit93dPrrVfzBYHz3nSvlcT1lyswFsuXf1Npr4ckoqu2kDEZJ6WCL/C
 eUQnldzDAFtgDzrRQAOta6IWy5pH208mG8rVLSPRDV1G94b7hMeWVAsEwsW6kksZQnrg
 4vAg==
X-Gm-Message-State: AFuF++klscHPXxbOG8xg+LGZaBoWSPr8v6MZI1+lrDFTNwb7dn6BXWcl
 CDXvUo0O4itz3N9Jwia+C0nRuEfcStyDHYbyyEalowPEcV1WKTP2prZqbfVvE/GxtCu/Jh63b2L
 O/3K5YbCGaw==
X-Gm-Gg: AYBFou3Vp3ELnubTPqE0+jV134uBpxeEIFEhcSJM2Ivp+LS0zHh0YC0lkZX22qlbMkS
 Ztn4uIHVKEe7Z+c+2GB+cJMc50Mk3ki/3N4iUTsUQGcksqjk1EysoE8TfS8fKahLigJzwFuKgqd
 FnnWs5D3rISOS35CH5lYY7mX7+K+fS+rc0pr6T4CMHUTs4gPLd060nV11Xo3M++r0DlhJmIYir6
 cjv/7HGkn1iVGhRavJ6abGtAA968+XisMLj7hoj4P1Vor9fDGT0io7Qo1Mp4AXBXTSvXDVQWpoK
 1rmJqUuO0BnHgjdKJPVS0T7ASi2B1XJM2wutZVNolTNlGyOVmh7YwPmYqgsv3PJQLQK9qbPw2CU
 yfjviD498poQ+/iZMIwFEEvZ0hSWr/wwDqj+qotFASrl8yhMzOEbYyj/X+FN3CXt/cfnN4Yx46t
 Z0K4pz9XtfcSYlj2zWRFFEZX32VwI9E9Z66utAgEI5jnSHjCi/azq8USXqIOk4fxcEVT7jgsFVE
 xZqtkfY9QsF0FoOrfYlnVQ=
X-Received: by 2002:a05:600c:4f54:b0:49c:cee0:e7c0 with SMTP id
 5b1f17b1804b1-49ce584ca20mr196659695e9.16.1788441546544; 
 Thu, 03 Sep 2026 06:19:06 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6024a8sm70397925e9.6.2026.09.03.06.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:19:06 -0700 (PDT)
Message-ID: <6a9973ca.1fb8f4c1.54226.f016@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260831163310.137399-1-avinesh.kumar@suse.com>
Date: Thu, 03 Sep 2026 13:19:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] openposix: timer_*/speculative: Don't pass a
 stack pointer as timerid
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
