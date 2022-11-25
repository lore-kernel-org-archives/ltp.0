Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982D8C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 14:06:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC1423CC902
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 15:06:43 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC4A73CC891
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:06:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4C4711A01146
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:06:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 961611FD81;
 Fri, 25 Nov 2022 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669385193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S4ZtrTrNrWepuOhzTTyIBsu/NmQjXQ2e7RdF1PGLOpU=;
 b=N+CDR+GQ6KZdcx6e4XOkYs6L14eT/zQWrm0tNgAOZRY5ON+BnNpzAW1Pr2ZF1JtFPi4g7k
 TMJGw/B4mnvHUzNThQYAIsAJ6tAVHSu4XgOoGBJp6F3BFZ/+/jOxODrO3nw1uc7193OS86
 otrKyhmdqfBCvbgFm0ETxp1zyj80UWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669385193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S4ZtrTrNrWepuOhzTTyIBsu/NmQjXQ2e7RdF1PGLOpU=;
 b=EMRS0rj9Rw2qUkMZwZmX/g71ouRezQEXEXbZwPH7qIOByibPRoe5zyNXAlQOspNpr82mW7
 GsNPkCzjRzz0lKDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20AFE1361C;
 Fri, 25 Nov 2022 14:06:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ppO7BOnLgGO7YAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Nov 2022 14:06:33 +0000
Date: Fri, 25 Nov 2022 15:06:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: David Hildenbrand <david@redhat.com>
Message-ID: <Y4DL5928NpuPI2Q6@pevik>
References: <20221125122546.99144-1-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221125122546.99144-1-david@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] execl(),
 execlp() and execle() require proper termination of argument list
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

Hi David,

thanks for fixing this!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
