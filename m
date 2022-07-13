Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DAAC433EF
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 05:33:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F8253CA31A
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 07:33:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1B7A3CA2C4
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 07:33:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E332914001E0
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 07:33:01 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 29356220B4
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 05:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657690380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WvSsplfY0A3wu61CRsnBwe6VT6adyw/6OnJueXif99I=;
 b=1e7Oa806+nOtCLormA1u2pFMXw4Yj/JDOboVp+kJam4hkkoOE7S9Vv7BYzdsnuTbYE9YAx
 K/HOFZpnA0OzYeyEu3vnuL1MS2BOeHSlHAyeys4yuAcjXHi8xI8ZLOcmwrUXn1DHtMNGz3
 0y+MA7lJqnqowX0K1demScrOxRAJXpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657690380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WvSsplfY0A3wu61CRsnBwe6VT6adyw/6OnJueXif99I=;
 b=N5JNJZnYGphWPl0zrA6BnVglvvkGZu8CNrnr3wk/HRp7gL/+Z3i+r6ZEXTqktHmpsdO9g6
 OzaOJ+4ugnma7rBg==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id EC9742C141;
 Wed, 13 Jul 2022 05:32:59 +0000 (UTC)
References: <20220712153417.14551-1-akumar@suse.de>
 <20220712153417.14551-2-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Wed, 13 Jul 2022 06:30:54 +0100
In-reply-to: <20220712153417.14551-2-akumar@suse.de>
Message-ID: <87y1wxmvas.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/9] Rewrite rename01.c using new LTP API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Avinesh Kumar <akumar@suse.de> writes:

> +static inline void swap(const char **a, const char **b)
> +{
> +	const char *tmp__ = *a;
> +	*a = *b;
> +	*b = tmp__;
> +}

We don't need the trailing underscores, but I can fix this up before
merging so no need to resubmit.

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
