Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EE910ED656
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 10:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774608821; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=useV2qYL3SCPGgRNry6QLGm2I5w40nrzk/zNBPDpFB8=;
 b=OrqrZ1/Xj3f80Bb6SBiU/cIWHnixnZfN9iVzA3NEr5zkNomHCn5Yp5wjuJXCKc5ixe9uQ
 LSlnnSk47NdMuR/RTco9BZy6+Wl93JfswFYTW9rv1+VQJBrjZZz73PKUTFt5+iQqunSOzcZ
 KY6QkZPt+h0H9UMuKqEvcmxIRlPM8XQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DBC73CE6A4
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 11:53:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5412D3C572D
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 11:53:17 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E01F7200DB2
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 11:53:11 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43b3d9d0695so1365754f8f.0
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774608791; x=1775213591; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HDaKONMuUi9VAwORZMwmyvGogeFCmPYSuTYTEwKnBZY=;
 b=fxJwREKsQcxkK/Ep6Dg06/rHdzycFJtsmwu1r6aQne9CVDbIPAkBwdLVEm5JjtB2Vb
 Y/Dz8B6hwjqgdk7L9K1gAUeh4K1qo4HSM9GQ54po13ISi5NBGfhn0vq025zalELn11Vg
 xqta+eyQHKv7D/B7V5RiBXnXREAw4AgY5atAbNvWWXiXy8iFwUwIkAPeA+deRf19iQwd
 1AQk8DaL7t0xmP/95J0p3as+Z8JB0JioiElVOYKLrDEC6wmq1Fb3ZqFlEvVsdYCNSaJo
 z4cZ1z2wMzPrxcVabAQcLRuCzGbkNE2QSI2wwHqkyhP4j04BzrcCEF3H9aoNbVnx/odx
 CPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774608791; x=1775213591;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDaKONMuUi9VAwORZMwmyvGogeFCmPYSuTYTEwKnBZY=;
 b=jxtRlEAtVO3vzlVltgv8M4ApvYH/V1o0uYZhWy8a0hmEXsKYyrMfwg8/072oH0sEwE
 QyTQcLSh7hRhaHxfFGXveEnjr2DI+zU2I8uZ4+DoVXhItUnk2VbB/P8HfJgCq5zyZwrT
 awYcxd91Ds6DAMeVg5IK1SXsa+AKsQm636A9UmP/3reaKadOpmUr1Q5xFY3JuD8FfrR4
 37CmqFWwChWPmpcTGN27iQyqpTce+Cg73kyBr8F0KHhU8dpQr+Jfl2t2sbDcDC556gQ1
 dQROx8uI10Luiw45tcnPgpOpWWW6jcysJoqW0kUsM5/bCXWDZZx9dM2mtWE0xTaZcgZ8
 OCxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4DCLmTzd3lNEh0rO4DvznXqRKoPUox7v7sX2olvM5XTf29eduxvFvfgTNKgJhsJwPQno=@lists.linux.it
X-Gm-Message-State: AOJu0Yyyysy2L1hof1rouxWHFApSZx8en6pca3f2ez6By0NpKdW5Ld1I
 6moZ2rMZzXdBl959UsLsEinLjiUhYahFimpAenVlNZrAMCssF/14DQ6apHx7xa0uITc=
X-Gm-Gg: ATEYQzyT++7o9O7A/m0Fv4TzToEdsVgZEWkZFJL8XUMVYoLuyObOcqsN3gty6bYlIdW
 6kZ3ScHXrtWsUZGhJeXCx5jWDdYilGZV5rIgCztnVUbbKEKZlX7qL3zgUfuw7y78u6bWI9Bqv3w
 Yakz1TxowYCVVAXGoDLM869ZIqcsZ0m5WTFaO8nhBlPv5LIhorAgkXdBui+Fm7r9eukHFkZ50NT
 Q+rvNvs41QlLfHkICypyme8nc2ASjWT3Uh4hwj0yTeUYSHNOyFT2ntTFE3/dnUwmMfwJlksf3XJ
 3DKDNWMAd/fDcG9BcqKjidA4ZdWsYmoaT/9A/FAOzdCmMDi1zG/09CtJf5NK3s7ob8M+AzmWPQ5
 6FbEXN5KMqHIfzhNbTWCjK+l6rroC81mzdoE15S/SCMYs1TCUWs61xZf5RPC69lMijyqFMPVy1u
 EkNGC7lXzB7ObJDZfpnykOLQ7UBwwbcOptf0Xeqna5J/ifeFNTwgdeF2gPCM4N3HURpqtzQHP0E
 evZ5JDEYbx6xsohqki1/3iBBsW/vjNvh1u7/Re1zmL+kEGauI3MuXKeN0eNTQIj/6TFheY0PoiM
 Vw==
X-Received: by 2002:a05:6000:61e:b0:43b:9d69:439 with SMTP id
 ffacd0b85a97d-43b9ea97e29mr3208477f8f.4.1774608791176; 
 Fri, 27 Mar 2026 03:53:11 -0700 (PDT)
Received: from p200300ef2f4fc90094f4c5ce75c4603f.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9192e3f9sm15225889f8f.7.2026.03.27.03.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 03:53:10 -0700 (PDT)
Message-ID: <69c66196.5d0a0220.2a94f1.b1f7@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <20260316130320.138328-1-japo@linux.ibm.com>
Date: Fri, 27 Mar 2026 10:53:09 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] editorconfig: add consistent formatting
 rules for LTP
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> # C/Assembly source files, headers, and shell files use tabs
> [{*.{c,h,S,sh},ver_linux}]
> indent_style = tab
> indent_size = 4

LTP follows Linux kernel coding style, which uses 8-character-wide tabs.
This should be indent_size = 8.

> # Python and Perl: default to tabs (most test files use tabs, checkpatch.pl which we modify)
> [*.{py,pl}]
> indent_style = tab
> indent_size = 8

Not 100% sure about this.

The Python test files in the tree (e.g. pm_sched_domain.py, pm_ilb_test.py)
all use 4-space indentation, not tabs. The default for *.py should be
indent_style = space / indent_size = 4. Perl (checkpatch.pl) does use tabs,
so it should get its own section.

Also kirk uses 4 tabs indentation. So I guess we need to invert the two rules
at this point.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
