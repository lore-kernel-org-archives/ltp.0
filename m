Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0EBC433F5
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 08:24:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5176E3C8FC2
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 09:24:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D74683C0E12
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 09:24:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE3391A001B7
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 09:24:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05DC721637;
 Fri, 17 Dec 2021 08:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639729463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h0o3meLhJrcC0jCdp9eMXCRyfUqVpCnixhOvjAEyUiI=;
 b=HSDq2qA/71Oy4+GsG9NPPbLnvowqFklAjpUCS/nNLhELTOLojI+OTWk1MGH15IwaJcJWVf
 /jxHk7+1Fiq88PWYbItiAlVoSJavtCNorBynWW/8MFYHPatelyyDxbE7PV7IeR6Mj8B5lO
 W4jPBxCCkta6s/7sqztTU+UFYU7SvyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639729463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h0o3meLhJrcC0jCdp9eMXCRyfUqVpCnixhOvjAEyUiI=;
 b=ek9EQkom6/6iA3NxcGv0cWI4v1W9tT1b9AyES2xmIm56mgdKmEaKS4l4BeIC7MrtR/qAxu
 efpf2+RE5KW9ZHDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9E0A13C72;
 Fri, 17 Dec 2021 08:24:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id K0eRMzZJvGFucgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Dec 2021 08:24:22 +0000
Date: Fri, 17 Dec 2021 09:24:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YbxJNQ5L3oItCKS7@pevik>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639552849-2251-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639552849-2251-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] zram/zram03: Convert into new api
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

Hi Xu,

nit: checkpatch.pl reports:
zram03.c:28: WARNING: please, no space before tabs
zram03.c:29: WARNING: please, no space before tabs
zram03.c:30: WARNING: please, no space before tabs
zram03.c:39: WARNING: Missing a blank line after declarations
zram03.c:97: WARNING: Prefer using '"%s...", __func__' to using 'reset', this function's name, in a string
zram03.c:104: WARNING: Missing a blank line after declarations

At least "no space before tabs" and "Missing a blank line" are easily to be
fixed.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
