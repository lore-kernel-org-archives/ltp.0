Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9451FC433EF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 14:18:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F7DF3C6C81
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 15:18:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DA573C5AF0
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 15:18:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E4AF920039E
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 15:18:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2DB3A1FD58
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 14:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638281921;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MUR3v1XuYhA+v/zQM+S/QyOFX3mEfn4F9QKXs2UQ3dg=;
 b=IRhQeQLpVPhRWc25m4P4CHP+bxEZyqjbd1ggsDn6p+nqpaqP2KkSBsZkZl6TgKbikT9Ur5
 /ZZ9kNdi5rKMijYStpKuw9kdKJg05v1/PInS7vo1ff3Coby1SP2qM6SteZETTApS9U8M55
 WiHcWhHE9Zhplq/GDDJR9hVY489HINU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638281921;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MUR3v1XuYhA+v/zQM+S/QyOFX3mEfn4F9QKXs2UQ3dg=;
 b=NpBNJsRqq1MRlDUlLhsepjZeekq6292WRG0nTCAsk/DZJP6/lWAbY/HoTQyW4d6keUB0Xu
 yqriBESnzVjTtDBQ==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id EEC23A3B88;
 Tue, 30 Nov 2021 14:18:40 +0000 (UTC)
References: <20211130105027.1071-1-chrubis@suse.cz>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Nov 2021 14:18:16 +0000
In-reply-to: <20211130105027.1071-1-chrubis@suse.cz>
Message-ID: <87ee6xloas.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Two small fixes for LTP-003
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

Pushed, Thanks!

Cyril Hrubis <chrubis@suse.cz> writes:

> This fixes false possitives for tst_fuzzy_sync.h
>
> Cyril Hrubis (2):
>   include/tst_fuzzy_sync.h: Add inline to static fucntions
>   sparse: Do not report static inline functions
>
>  include/tst_fuzzy_sync.h  | 14 +++++++-------
>  tools/sparse/sparse-ltp.c |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> -- 
> 2.32.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
