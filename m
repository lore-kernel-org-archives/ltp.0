Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA2CC61CE8
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 07:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749714542; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=RkPwuMhOp3i9D7SbzbsCA5CqpiTuHExfwBzl0g2bSow=;
 b=T9cLPhKD06AIcXX9uLO8GC4lnCqEZJ31M7N89yE+zdWcuZ2hzCGDDfueYnP8Ccjd1DtT4
 4m251PePc+fC2hPKqvaGsfGAUQb9GBdR0ldbL0qvaYwcOhwa2bueQ4YOD6Qo7gZHhAneCkM
 N/136CpsUgLq15wE1oCCnonIHcVBjpc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4237B3CB304
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 09:49:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 665063CA59D
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 09:48:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BF8FB10002AC
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 09:48:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749714519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0dpk3oEpAQg8dp0Zjg69cTiXZsN3U2j6d/INaU0nepw=;
 b=gUAjxZ5nxl3PEH9amBAb/NVDSu7aMDnNAlzhRMxZ16uaqJgWuOJFBXjnN+1vwoXGbrkdJS
 BVUzuceO3GGJHcsuhwK35URPW/JaikH/LNlYuvgn/yg0II6iGWgiDpsR6OLEYRSbj1cgwS
 GrrRRiUFyg8MmuEWGZ3xDZYa+8UqQVQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-JQVd-RITOyCTJNAOfPyqEQ-1; Thu, 12 Jun 2025 03:48:37 -0400
X-MC-Unique: JQVd-RITOyCTJNAOfPyqEQ-1
X-Mimecast-MFC-AGG-ID: JQVd-RITOyCTJNAOfPyqEQ_1749714516
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31171a736b2so1059023a91.1
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 00:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749714516; x=1750319316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0dpk3oEpAQg8dp0Zjg69cTiXZsN3U2j6d/INaU0nepw=;
 b=Ciy1KiUSui4Ck0n0947LH8Npt3AY1BiUvN7Iy7otmxtSlhABmYlNa6ImFrro1j8Ser
 xCCBhtP20ymFPzXM6DIGLjLXtEWFrMv3GM4nvFX9c92qWCbmDdLn8JgSRHOQMk1x/TME
 XLA2k4QlqznVoPadpvs0PJgE90uJ1MIs5pw0ujDtd7sfkGW9Jbe+4q8+giIs25nH1tcc
 MbOvIDhR+bA6JkS21zNw6QrbNmqfxv7enK7BxLJ6AQo0whcVcT1yt0M06t9wHmfkFZ78
 6XHDE6ssqP5lppWoGdsAhFw+55+SKCvzFUB+NKE4VrN4pm94vt9WkENl3cy++x+YDKjy
 HlXQ==
X-Gm-Message-State: AOJu0YxIVSeaEHXWjroXvjv8B8Pfgialkr3PYjBV5Ri8lQ8/i/pXQl7e
 7ModOymksJpMOx30fUwADWE6Ec3Ae6Lwzgaz4hqewlBSzvRzN/GFmWPTt/ukjtIkjMQe1I1bRPb
 tNrfVrFDIgcuOPSU2iVxnHos2pj2f5c6g5eRaSIho7ghAvKEP3+SWMd8mzimJf5oO8BfU8jiMWD
 6njuGATv9YJEc4sIwrwDgum4SFV+Q=
X-Gm-Gg: ASbGncv0tSgXxhqBhJu7VEXbF6SSmsBeBafRo3Ou71UIgkEhQhj6vTmcj/6Hk5Xb2ms
 7ALzQuLJM2GhPbYZRB8TffKkp0eSLclU+Ifco0+xnXGQC3NmIVvsVJvL7ENzROgu0aAQuJO0hC5
 MWPmo9
X-Received: by 2002:a17:90b:3508:b0:312:eaea:afa1 with SMTP id
 98e67ed59e1d1-313c08cfd2emr2465303a91.29.1749714516515; 
 Thu, 12 Jun 2025 00:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2y8fVYRzMqICQGMqVvaQL2FMOUE5lVd3FYmDUTxcX4imcJaxRmrtVNUa5ObHWsmCgULcUxU0lOKIbM9/D96E=
X-Received: by 2002:a17:90b:3508:b0:312:eaea:afa1 with SMTP id
 98e67ed59e1d1-313c08cfd2emr2465284a91.29.1749714516212; Thu, 12 Jun 2025
 00:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250609124506.1454420-1-pvorel@suse.cz>
 <20250609124506.1454420-4-pvorel@suse.cz>
In-Reply-To: <20250609124506.1454420-4-pvorel@suse.cz>
Date: Thu, 12 Jun 2025 15:48:23 +0800
X-Gm-Features: AX0GCFvXu0pgojPp-AJk8EXTl_1i-vO0Cig4s-scVils1Rv_Z2_0yd9Md-kLsAs
Message-ID: <CAEemH2coV_yJM5Kg5JN9FVqx6b=_CLTLzhCtCfCwqHnP-_j=yA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MBYeIlpCvQh7O0sJKWDIfG7h2UnC_YGXML_KQo9j_0g_1749714516
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 3/4] shell lib: Add basic support for test setup
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PM Petr Vorel <pvorel@suse.cz> wrote:


> --- /dev/null
> +++ b/testcases/lib/tst_run.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2025 Cyril Hrubis <chrubis@suse.cz>
> +# Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
> +
> +. tst_env.sh
> +
> +if [ -n "$TST_CLEANUP" ]; then
> +       trap $TST_CLEANUP EXIT
> +fi
> +
> +if [ -n "$TST_SETUP" ]; then
> +    $TST_SETUP
> +fi
> +
>

Here maybe better to have a check before the tst_test:

if ! declare -F tst_test > /dev/null; then
    tst_brk TBROK "tst_test() function is not defined"
fi


> +tst_test
> --
> 2.49.0
>

Sorry, I should have pointed this out at the first review, but
the idea came to my mind a little bit delayed :).

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
