Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3864C32772
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 09:23:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65B263C8854
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 11:23:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A4A23C8854
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:23:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C17AE60071D
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:23:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 160981FDA3;
 Tue, 23 Aug 2022 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661246588;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4WOJNe8PDRAt1oS0OmuBTQ+hEcTtkSKOJBpLX5pugeM=;
 b=SIT7ec6TgFv0PxFyTFUrBpDH/xeV9R/KF0gp9vcAMyYSw6FpPSHvbY8RgED8Ni+lDNK3Vo
 IuMXEyWq5X+r7UVzHLbC65c7RqK3H7d3kyEzVwumRTadUPSm2ojpjeeNZMz1cpEzPYAo1p
 DuZtUsINr65x8YITAWtjY2ufJjC3G7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661246588;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4WOJNe8PDRAt1oS0OmuBTQ+hEcTtkSKOJBpLX5pugeM=;
 b=eThgcVwWzYOi3pTtACRD+KmgkWDU9hC6CxjpJ+uEd/59BRPxAbG2+t4eMQRvHgNl1KkS+m
 uoz0jk9Z1b1NVMBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D60A913AB7;
 Tue, 23 Aug 2022 09:23:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0mX/MHucBGPxcAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 23 Aug 2022 09:23:07 +0000
Date: Tue, 23 Aug 2022 11:23:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Tudor Cretu <tudor.cretu@arm.com>
Message-ID: <YwSceg1dz3pPCkk5@pevik>
References: <20220822113919.196953-1-tudor.cretu@arm.com>
 <20220822113919.196953-3-tudor.cretu@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220822113919.196953-3-tudor.cretu@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] syscalls/mprotect01: Invoke the syscall
 directly instead of the libc wrapper
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

Hi,

this one also merged, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
