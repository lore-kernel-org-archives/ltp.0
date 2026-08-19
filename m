Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C83C5DF6D
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 03:48:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A1583CD563
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 05:48:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB5713CCA83
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 05:48:22 +0200 (CEST)
Received: from mail-qk2-x07.google.com (mail-qk2-x07.google.com
 [IPv6:2607:f8b0:4864:34::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F1E1D10008F5
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 05:48:21 +0200 (CEST)
Received: by mail-qk2-x07.google.com with SMTP id
 af79cd13be357-936bdbd99f9so14288385a.1
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 20:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787111300; x=1787716100; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4q3DGjAFRJPWwO28zYgp5VxqQ+bL0aQFA1vjRdTEd8s=;
 b=m+/+fk3MGbiyw/LGN9ZkelHaGamJz6WSSBiJJak0keKlVN4/f6Tdn+XgM30HFBuNtT
 rVw7KWMQBSDmbShl6wYHkVLPlF9ri6Eq8KAUWmZTGosc9+xbmyOBSplrjUM6bFYxMinX
 YN+XzliZ1KJ/cqOdamxqSsb275uN815TzRtZ5hTbGH0UOFNhV7drd8QpUqXAQRVlOxTH
 LLtrmEqW0vzr0hrIPh/wVsWCcjcHBKKn7hz1phcg/sCBPnZTQwNM5qnwaxlCmh4V+YDt
 xcNlzwvJdqcpOrFOZewPUMFAJgkaF0fdjoXk2KYOJ0qsIu4FcdBUerTZQDpG5qn1Y4nA
 k66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111300; x=1787716100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4q3DGjAFRJPWwO28zYgp5VxqQ+bL0aQFA1vjRdTEd8s=;
 b=ovNkY6lKOuK9x7d/DTL6qV4Zpc13q3TlnFfhiZoT2Rdp41mA1/alOEZGD1AfHcgf00
 ehgV74ZuCN9hMM1VZMM+4ffKyGOpxtTrSvRlLQmZN9T7LMmFCdHBaDBd4hGjRkGmeJPb
 E/R6/TF+6BibjtPw2eUZpJ9dQ1LHmhtixkI4fhB6k5Te3KuNlilH8RDezqdH5URyGSfc
 ESiqL1zkqbvbNi2X77+6JhUvdoPkC1Ajk07VL5gwtqSWmzsir3Y9hSE3PWUZEi3vEDyN
 /cPQ0KBjpXu64jQ1/EiX4VzP5MjJDi1x9DKfvlWSzkHwU4RHSaNU8K7/nTIvj+q983AC
 glHg==
X-Gm-Message-State: AOJu0YzTxBEGxeBiecbNDsTeshDeXtoDRt9Mzr69n3ltqfsosTS38BqG
 MyzY2TR+ufqyuP4DHsDktDxGOxdvSfUuJE2BKBPtKo8XSOuc4xxn41W6
X-Gm-Gg: AR+sD139n+d69hP3N787dZzQ8dgLaEh2L73f9qmTu5cbbVUO3oawCAwfOQzFlCSAvZ7
 hz14/ctjI4RNdQHEGAdZ2LgrKzooYBfwSvNb3i026ETapCPLkVEHeiG5ehGhjOHpk1LdEWGq/bl
 x5owkfcA7PuSVN80JGaQQ4mZYs6vFLZXgIlFFXC5kpOZmsT68xMDEYDnFE94gaEc9M2UpplZAWn
 zVe9yToMzn/88kxoBNviQh0Ls5eLiiuT0Ki4tFV5QshY9ofPJV1H+syacv3KRUpSM0tLDmIx/1c
 7itS+YWZCODiYbu1x/jOiZGbiZyjTnORNwQW017LPNt44cjWC0VdYQxMZWwcZwb414P/eW1HKe8
 a1aUOpS19hdYDlzKtwzjrb02XQcG59nATSjhVdFZtE+3sEK6XCxfM24kzNtZwGx61e+baJlP+Q7
 OOh483szRjQs3UVTbMKikW1R9HglBb5WNQsDLg28TrNEL6NzZ/zQLdCrPwGG7qjXY/bqtIRJcWz
 +Tcys8dkFC95c4QHkpdykJEtupZoA3TDqDMVtpjUv8VYboPmhYJm8egzdF9gK2eTQF/n31w90fj
 +JsoxeL9QAAj
X-Received: by 2002:a05:620a:2601:b0:930:a28f:765a with SMTP id
 af79cd13be357-9371e442f8fmr206649785a.42.1787111300503; 
 Tue, 18 Aug 2026 20:48:20 -0700 (PDT)
Received: from
 runnervmzvulz.nffxvtgvxe4e3eqtaidkon1qmg.bx.internal.cloudapp.net
 ([40.76.117.225]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93720595cddsm45402085a.41.2026.08.18.20.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:48:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 19 Aug 2026 03:48:19 +0000
Message-ID: <20260819034819.8622-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819031716.26527-1-wegao@suse.com>
References: <20260819031716.26527-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03: Fix 32-bit compat mode failure by adjusting
 comparisons for compat mode truncation
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

Hi Wei,

On Aug 19, 2026, Wei Gao wrote:
> shmctl03: Fix 32-bit compat mode failure by adjusting comparisons for compat mode truncation

> #define TST_ASSERT_ULONG(path, val, ...) \
> 	tst_assert_ulong(__FILE__, __LINE__, path, val, (0, ##__VA_ARGS__))

Could this avoid the comma expression? When a flag is supplied, its left-hand
operand triggers -Wunused-value, so all three new compat-mode assertions emit
compiler warnings and builds using -Werror fail. Making the flags argument
explicit and passing 0 at no-flag call sites, or dispatching separate two- and
three-argument macro forms, would avoid the warning.

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
