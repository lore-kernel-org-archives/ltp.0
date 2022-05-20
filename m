Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ABBC433EF
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 09:01:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77B553C4DB3
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 11:01:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EF433C4DB3
 for <ltp@lists.linux.it>; Fri, 20 May 2022 11:01:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 66DAC1A00E5F
 for <ltp@lists.linux.it>; Fri, 20 May 2022 11:01:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5464F1F975;
 Fri, 20 May 2022 09:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653037295;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oPpnZEsfzlD4fI8bOAJJ8+Xz1+jvkt/4rpAZz6gu1aE=;
 b=gUMs73dxri2CzQ823WOvsyawTHIeh3+mihFXqLkvkdX82kN9hpJAuSqElFGQKa0WaPStPa
 aPJRFCYWFbyI2RxhJS/oHqOJafFdW0Ga/C5xUCPn9ocbkduAhzHJcuM/LyzO3fblwO2Wg6
 jylmJYTBzF1JQCv5pSlPwa8b7Uv3lL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653037295;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oPpnZEsfzlD4fI8bOAJJ8+Xz1+jvkt/4rpAZz6gu1aE=;
 b=fo4e/seIQAC36g/PwYfa4U3xE4rord2NvbCPY/tw+vz8YJ7SiePEl5f77yWr6mTOegX4K5
 +zFpLLBI3qkFdZDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3694F13A5F;
 Fri, 20 May 2022 09:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h3bDC+9Yh2KOYQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 20 May 2022 09:01:35 +0000
Date: Fri, 20 May 2022 11:01:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YodY7QOisdpaI3KK@pevik>
References: <20220519121056.1181-1-mdoucha@suse.cz>
 <20220519121056.1181-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220519121056.1181-2-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] pty04: Fix cleanup
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin, Li, Cyril,

> If pty04 gets executed with -i0 argument, the sk file descriptor will
> stay zero and cleanup() will close stdin, which can result in the parent
> shell logging out. Initialize global file descriptors to -1 and only
> clean up those that were left open by the test.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks a lot. As and obvious fix I'm going to merge it later today.

BTW C API would deserve (after the release) TBROK on -i0, which is already
implemented in shell API:
df01 1 TBROK: Number of iterations (-i) must be > 0

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
