Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D867BC433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 09:49:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E2463CA5CD
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 11:49:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF6693CA45E
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 11:49:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 154311A009B9
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 11:49:22 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 651B91F748;
 Thu, 14 Apr 2022 09:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649929762;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mviSDyf20YO1w7DBdgaiqd/gZaGN+GBvMuyOnRtHn18=;
 b=M12r8xMK/T/zTegiE22XkRHLJwd2cGQTB/M+unpeOXOHjgnDXlHeZ48Px5Vk2kcgKcg0bL
 YYA1dN8a1Hx+hFIkCt5SnJrxiqgAQHz5Zi3F9NK6FJHRsPQTcY7pCFoiKaX5WcFGU1Yc5i
 uBol6toZ3xTGcI/8wl00EeTrCdJgFv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649929762;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mviSDyf20YO1w7DBdgaiqd/gZaGN+GBvMuyOnRtHn18=;
 b=0SBK5+VWgGtfsf9Wgd4kDKLJ0rpmq3BkSnoZHDmkiEoitsASynmh7cV0Dd4TcuPvKQufI6
 DnNqMWufjRauemDg==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F1250A3B87;
 Thu, 14 Apr 2022 09:49:21 +0000 (UTC)
References: <20220216073831.20148-1-tangmeng@uniontech.com>
 <20220216073831.20148-2-tangmeng@uniontech.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: tangmeng <tangmeng@uniontech.com>
Date: Thu, 14 Apr 2022 10:47:08 +0100
In-reply-to: <20220216073831.20148-2-tangmeng@uniontech.com>
Message-ID: <87v8vcxae6.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/fchmod_04: Convert to new API
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

Hi,

tangmeng <tangmeng@uniontech.com> writes:

> Signed-off-by: tangmeng <tangmeng@uniontech.com>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
