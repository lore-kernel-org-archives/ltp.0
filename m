Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97274C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 13:41:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49CCE3E5CAE
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 15:41:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 654723E248E
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 15:40:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 040C3600953
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 15:40:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 80DA075BA6;
 Wed,  8 Jul 2026 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783518043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3hNK74G0q62Od3wBWmi+jJGEtM4yL4+4uHli5LFz24w=;
 b=Homwf8WIGe86/uKupMRtmXpLVyPkHHC3MTWJbvjQSyxcGBMoPpUqEdqfIsMsS/QWkEuHgo
 IcCjPP5gHiEmjXyESXRiMw8o3KCDrGHlAbp2skgPsg+3IGkqRMdQ8BeNFaYaWg3t74QcG2
 9j9yxn+1tA31OnnCMRLKM2M+lvXy8sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783518043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3hNK74G0q62Od3wBWmi+jJGEtM4yL4+4uHli5LFz24w=;
 b=aGR96Slw+K5q5TwWVLToDFrZwiFcSsG/cfY8W3uYKsJx+zfBSL5PRFhoC5nbNtDlls0TOp
 VjAqVXJlQ8rWVlAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783518043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3hNK74G0q62Od3wBWmi+jJGEtM4yL4+4uHli5LFz24w=;
 b=Homwf8WIGe86/uKupMRtmXpLVyPkHHC3MTWJbvjQSyxcGBMoPpUqEdqfIsMsS/QWkEuHgo
 IcCjPP5gHiEmjXyESXRiMw8o3KCDrGHlAbp2skgPsg+3IGkqRMdQ8BeNFaYaWg3t74QcG2
 9j9yxn+1tA31OnnCMRLKM2M+lvXy8sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783518043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3hNK74G0q62Od3wBWmi+jJGEtM4yL4+4uHli5LFz24w=;
 b=aGR96Slw+K5q5TwWVLToDFrZwiFcSsG/cfY8W3uYKsJx+zfBSL5PRFhoC5nbNtDlls0TOp
 VjAqVXJlQ8rWVlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D2B1779AE;
 Wed,  8 Jul 2026 13:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gczOFFtTTmpYUQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 08 Jul 2026 13:40:43 +0000
Date: Wed, 8 Jul 2026 15:40:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260708134037.GB125128@pevik>
References: <20260708091154.999385-1-avinesh.kumar@suse.com>
 <20260708091154.999385-5-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260708091154.999385-5-avinesh.kumar@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] syscalls/cachestat01: Use SAFE_FSYNC()
 instead of fsync()
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

Hi Avinesh,

thanks for the cleanup, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
