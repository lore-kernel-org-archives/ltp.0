Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C335C6FA8E
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 10:04:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1B393CB9FB
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 11:04:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0A613CB9CA
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 11:03:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2F4291A010EF
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 11:03:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5701D1FE6E;
 Thu,  2 Mar 2023 10:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677751438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DndrlAaC3VyVpuNDmSs4hTD/HksSVvLjqS3dVROU6JQ=;
 b=hDO+hVrJ6Da2cdvw77t6JRT6m0juWhJaxXXXRbw++DldGw/PvW25LSVIbEyFNpF1DVlYeL
 k2PRq6GJS3gXCfUXJRxsL8C/WRIeDsc2tIokN/3KtNoHPNGxWW8YdV+xe958LBqxr6fFm2
 ZsqeoemzZh9hCyhsY6P+eQY6kiKAV58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677751438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DndrlAaC3VyVpuNDmSs4hTD/HksSVvLjqS3dVROU6JQ=;
 b=vs8rDqfg57K/ymp212fjlPculu4XbKUedQc6GKl4FHRCWgqOs+od1MIo+WmEWNWeW5nn08
 Pg3JEcpQtvJ9DwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10E5C13349;
 Thu,  2 Mar 2023 10:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bUjlAY50AGT2TQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 02 Mar 2023 10:03:58 +0000
Date: Thu, 2 Mar 2023 11:03:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZAB0jOFczVIeDsRL@pevik>
References: <20230228032745.16595-1-wegao@suse.com>
 <20230302014519.31512-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230302014519.31512-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] fsconfig03: SKIP check return value for old
 kernel
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
Cc: kernel-qa@suse.de, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

...
> +	} else {
> +		for (size_t i = 0; i < 5000; i++)
> +			fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0);
Why calling fsconfig() without any check for old kernels? It really looks
strange we don't care about the result. That would deserve an explanation in the
commit message.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
