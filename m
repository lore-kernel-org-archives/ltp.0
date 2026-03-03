Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFA9EB365A
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 02:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772505965; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gM8NRimZm1FM8zlQeiAeMoNStTfFhfiQc7uWzI6g1zM=;
 b=gaKW4ROgP71XEghyvaXIdX39X2+hvKPha0ipEejbyuTne77zkgbJQKxkdsEvL2SH0XK+s
 hoTZSE1MdNklImynf71cG6tBoi4HP9E+8t9Y+j4XX3fuC4OmAq9yTlV368vyY94cVr5z/HL
 h4zQXQH+Z6Yb0LmVfY+/zBPcFO0kOUw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99D113D86E3
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 03:46:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9FD93CB27C
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 03:45:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1D2EB200351
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 03:45:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772505938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZPCfaj81UUApkKpMPmcXx1tNCajhmui+YwFMENc/9o=;
 b=Xhcj6JgWa/Ob1524hReuG5yB5rlLv6Itbfhu4ub0LgYU9nDOOQP0NAGZVdNmzz4i1mcbPG
 6DZEWdx5Z19imdYWIqUrW/5jpQXmrubAfwxzGzW4USNS4XT8MZ5innQBW3j7r0RYY+sz1P
 cymzb18Oij1x48/2UOcAEVALIVQo3xQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-MHNxoO7MMYWDXKq6ve1uFA-1; Mon, 02 Mar 2026 21:45:36 -0500
X-MC-Unique: MHNxoO7MMYWDXKq6ve1uFA-1
X-Mimecast-MFC-AGG-ID: MHNxoO7MMYWDXKq6ve1uFA_1772505936
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a90510a6d1so36180515ad.0
 for <ltp@lists.linux.it>; Mon, 02 Mar 2026 18:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772505936; x=1773110736;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JZPCfaj81UUApkKpMPmcXx1tNCajhmui+YwFMENc/9o=;
 b=BUfLMicgSgIak4Uagu8E3Fy8XztM4/zpX+YbtI/kuMsWf3vd6qJaNoyxvatQjehhi6
 wq7+w17jU06B2Ls9u/W9MFwzqjn2YHFQZd2MGU7QI5pXNL6Yn5LDkcheID+jWZ3ZsCMT
 0YCMeqV5foE7MGKzvIOPrm8q1sVSK6706z5MOcdvZGDKObV6ha3Rw3Ui09eu+EEJiLhm
 fhhyYHUMtR9wLg8tMzfxzTu8uqra+fcJWTLumO5IftDjhb3l9c+QGHVw27HUlUVorR1Q
 glteWNB7UypU6gUXKaQWk+FjGbKCrer4QDMVVKw4A9Hnm51Wxw15zNcfaqyILasmD/so
 XylQ==
X-Gm-Message-State: AOJu0YzWmOmFfh0uhgi7esIWswduct/7iqNLwTW+ByRVXmflz0dgTHgg
 eZldMX6+KSTSAN8OBqlkHe6EGGGHUdVi7sAG6rqI6v7r1RbClJfF24l1i+bBQUL95U2Onc+M73v
 OB/SQVPnuUpFzURcML3r9vsEnjoS1JJe6JwqYYLDu7dideoJsf4tP
X-Gm-Gg: ATEYQzynNqmfg7TQHgbBIkpn6DczkvePqknA/sXqGoYPoAqvBctmImlCrevLJXg1nAw
 +jUsY+eqfi4r46GaIWFiJkIKFfLhXCsHtaRHkc4Z6nu/bV9FU3CrgfkcxlLWzLSQcNh8F26raxW
 TonrMaEungOZhqX535JBCTJfb9FQnlrlnAETNHRxgNjc8i5G5M2c0mPpbcDQYsMeXMxUDnYzUQF
 Ds4gxNw7rnXkO9UI6uLGYiSRXtVSCoWLRipnShFAo5IG5P1aplLvxujXYUWuUrlcqeB29CZQoD0
 770wAuWZNLuRgjHaKjBNhhHOr1df1Wes1FwROJCzKR6iwOxgl/wp9d/WJrNEJuOc2SO8aM7tqoS
 enT++iOrAuCgAEZqK
X-Received: by 2002:a17:903:380b:b0:2ae:5628:a180 with SMTP id
 d9443c01a7336-2ae60dc150amr6086935ad.25.1772505935880; 
 Mon, 02 Mar 2026 18:45:35 -0800 (PST)
X-Received: by 2002:a17:903:380b:b0:2ae:5628:a180 with SMTP id
 d9443c01a7336-2ae60dc150amr6086815ad.25.1772505935433; 
 Mon, 02 Mar 2026 18:45:35 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb69ef1csm162640015ad.53.2026.03.02.18.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 18:45:34 -0800 (PST)
Date: Tue, 3 Mar 2026 10:45:31 +0800
To: andrea.cervesato@suse.com
Message-ID: <aaZLS0XUd5z-0HmM@redhat.com>
References: <20260301012808.15588-1-liwang@redhat.com>
 <69a5a89c.050a0220.1f2f98.0f58@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <69a5a89c.050a0220.1f2f98.0f58@mx.google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TmwUNjPhQtmZhW9Dygvzs0_W_7mOYpjZQiiVR4Qh-tY_1772505936
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Extend -D flag to support multiple debug
 levels
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
Cc: Li Wang via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Mar 02, 2026 at 03:11:24PM +0000, Andrea Cervesato via ltp wrote:
> Maybe we should also apply the same approach to the LTP_ENABLE_DEBUG
> environment variables, otherwise we might support only 0/1 while using
> it.
> 
> WDYT?

Sounds reasonable, LTP_ENABLE_DEBUG now should support '0, 1 or 2' and
drop the 'y' option.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
