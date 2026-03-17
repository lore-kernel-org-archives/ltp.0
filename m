Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C3FF3382D
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 09:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773740568; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lQG73MYABBaSikJ1EfbLDUvGaQopB8iAN6c9zqW3LAU=;
 b=fkSImM5aKRtToZpwSJUe27qMkVAfcL0YSBPEMYK5xJVnN9rJZLQAvKTJP04XJKWCy4y0R
 9N8ki+d8r3u8tjwKfjy29pB9Aw9Mub5lcKIlgj0NLivnDW7/VC7gF42ikJWL0kiRSCDEMPp
 ob8eYgYwQKJ+qCO7B96B5U7CT68EM6Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 233D73E2B6C
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 10:42:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE2613CDD00
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 10:42:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 364B91000D41
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 10:42:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773740540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cCJXQ6fo2eN9G62CX/Wxcpyyq9S7p6dEqzNdicl8gxA=;
 b=KEwE848bynPcjI4Rjxk+/OxlrJKG2PTtA9jPQRu6dARRf/gzMsglfdq/+vdg5DSCAGFPjQ
 ccwO72PTW9nTdf+MKwShx2RWhKRd73vIqgI2pGFr4PfZuYuzx8N/PBgm7YcNJlTWAuZnKK
 jfFdjTMzH2casrpeLnKq+I93BUivBQc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-zwMPzVx4N7qbQ-xazjnjtA-1; Tue, 17 Mar 2026 05:42:19 -0400
X-MC-Unique: zwMPzVx4N7qbQ-xazjnjtA-1
X-Mimecast-MFC-AGG-ID: zwMPzVx4N7qbQ-xazjnjtA_1773740538
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b06b68783dso692655ad.3
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 02:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773740536; x=1774345336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cCJXQ6fo2eN9G62CX/Wxcpyyq9S7p6dEqzNdicl8gxA=;
 b=geurtcNhn+W/OSb74lNbHkZgKVJbnvhzywb4HiMAqBoWQhRXmNmZc7WxndwcUIsnUN
 nuxJiwd1uKBMI7LA+PYUd5ntdrx60G0eo9b8m+8h3qWA6p/ChP9M7m6O66ADflXR7xX/
 DxilwtUipeEmow83uFgVOQiYHCGlXwspky9vyR6lUojJOCOfylJ9mgE5NOVKQpiakKQw
 B02Lk6dPQSRfk7K7vQ9XX6pZFisx+h6sMpzqX2GpyiVWqifo+fKgGT9ZaZWCWgnLLGMO
 tuiZe3zoHsfj1MePgxXjR7gsFa0O4rzr62nGChea/g4CMpJBpAxFm8bKZNCQN+uHlr1U
 Jfug==
X-Gm-Message-State: AOJu0YwEJlb1N3lAnTdyIK5ig1p/2rMm+OY9PjPL5XznrlsMtlrwxaQu
 KI1ZonwMggweImbOGPhuDrUB5SF9pa1Pi3HsIAgv8xG67VZyPd0U1upEUzvha8hGrpBOGLdhRps
 +KEF/iYBSqLCr1jkNMM5r2dvEG+ZRmUsau4RWJWFVg7XWZi0wtiX4V0kd6x1D
X-Gm-Gg: ATEYQzy40NqDBqDe8rE2d8WZFxHxdPqNivoyC3rDo0r8wz5+QQILap5qCeTAldN5kD5
 +tCdYPNR4ryDT7rRkKF/tEKvntAYhoN4kch+5HTp0uitMOOEKRFZtDQ2Gjj5HNa9qv1TlwL5+Yr
 2mUm4Gh4R4RccHMci00ueb1d5pr6eRJkYYitRjDGWLPOARQBiVqF2FTa/71ElCZWxtJSI3mHbNe
 jIUoUt51d4Wx8ph790RVrVpbp+FgkPSO0KtSL0R/iGDOlD4k2oZM9gm0lt3ADOTQXB/8G4wJpqe
 df45fGnj0DtwQ0jPNnOC/FSk7R9mVTZYy4xroZ9Cy28Y8MvmVLl5iuMIp8j+7UapgWaifR84x0z
 qFqK2DIj3alkfG+A2KA==
X-Received: by 2002:a17:902:da8e:b0:2b0:5661:e10c with SMTP id
 d9443c01a7336-2b05661eacdmr76588615ad.37.1773740536272; 
 Tue, 17 Mar 2026 02:42:16 -0700 (PDT)
X-Received: by 2002:a17:902:da8e:b0:2b0:5661:e10c with SMTP id
 d9443c01a7336-2b05661eacdmr76588485ad.37.1773740535914; 
 Tue, 17 Mar 2026 02:42:15 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece81dc18sm137688045ad.69.2026.03.17.02.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 02:42:15 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:42:13 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <abkh9aPkKAewapRr@redhat.com>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-6-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260313142600.243939-6-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4qiIdICsvb1cJ-el-PkFVgI52qQhWSqrQleyfZf6uec_1773740538
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] [WIP,RFC] tst_run.sh: Run setup() only once
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 13, 2026 at 03:25:59PM +0100, Petr Vorel wrote:
> Both C API and tst_test.sh shell API run test only once.
> Fix shell loader API also to run setup only once.
> This reuses functionality added in the previous commit.
> 
> Fixes: 8202494493 ("shell lib: Add basic support for test setup")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: this is still not working on iterations (-i2), because
> static int iterations is from tst_test.c is not propagated to
> tst_run_shell.c. I wonder if I should set the value as environment
> variable or add it into struct context.

Passing the current iteration as env variable is feasible.

Since LTP export an similar variable 'TST_ITERATIONS' in tst_test.sh,
maybe define another env var for current loop, e.g. TST_ITERATION
(or TST_CURRENT_LOOP), pass to tst_run.sh?

Something like:

1. Create tst_get_cur_iteration(void) function in LTP core API

2. Export current loop in tst_run_shell.c before running run_shell_tcnt()

  static void run_shell_tcnt(unsigned int n)
  {
    ...
    char iter_buf[32];
    
    snprintf(iter_buf, sizeof(iter_buf), "%u", tst_get_cur_iteration());
    
    if (setenv("TST_ITERATION", iter_buf, 1))
    	tst_brk(TBROK | TERRNO, "setenv(TST_ITERATION) failed");
    
    tst_run_script(shell_filename, params);
  }

3. Reuse it in tst_run.sh to run setup once globally

  [ "$1" == "1" ] && [ "${TST_ITERATION:-1}" == "1" ] && $TST_SETUP


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
