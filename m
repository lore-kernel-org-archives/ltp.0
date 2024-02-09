Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41439C4828F
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 10:27:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 495E03CC91B
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 11:27:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 698B33C044A
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 11:26:51 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 54C6F600780
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 11:26:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A88FA21FB1;
 Fri,  9 Feb 2024 10:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707474408;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6SA0XKqHeMQTkS3skrLIewIz5NlOHBvAYZdNWIXtm/E=;
 b=Lm9adA0S1i65SrYFy8ewv+lAnfc5H/goDwFnq0Yg6+OhTZRJI80B/ISKY/4ae9sjsXO5tu
 xKpbbg40cSd3GgYFp9ySCj26oXEQCGRk9FHG24vZqSHk0BF/8qHFqVByLKJuJCNsd2mJLz
 1k6WznM+07l7JI211z0JEChl+5jmzVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707474408;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6SA0XKqHeMQTkS3skrLIewIz5NlOHBvAYZdNWIXtm/E=;
 b=4Atug/mc+EbbL4HmyOqIhTU+XQZsyPHBmOBwArcOdSGqIY1RKoSbkJA96jBW+pnM92iDUM
 xAd7My/YylpdVaDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707474408;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6SA0XKqHeMQTkS3skrLIewIz5NlOHBvAYZdNWIXtm/E=;
 b=Lm9adA0S1i65SrYFy8ewv+lAnfc5H/goDwFnq0Yg6+OhTZRJI80B/ISKY/4ae9sjsXO5tu
 xKpbbg40cSd3GgYFp9ySCj26oXEQCGRk9FHG24vZqSHk0BF/8qHFqVByLKJuJCNsd2mJLz
 1k6WznM+07l7JI211z0JEChl+5jmzVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707474408;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6SA0XKqHeMQTkS3skrLIewIz5NlOHBvAYZdNWIXtm/E=;
 b=4Atug/mc+EbbL4HmyOqIhTU+XQZsyPHBmOBwArcOdSGqIY1RKoSbkJA96jBW+pnM92iDUM
 xAd7My/YylpdVaDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7834A1326D;
 Fri,  9 Feb 2024 10:26:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pMDCGej9xWVpJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 Feb 2024 10:26:48 +0000
Date: Fri, 9 Feb 2024 11:26:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240209102646.GA268361@pevik>
References: <20231203235117.29677-1-wegao@suse.com>
 <20240209012657.10797-1-wegao@suse.com>
 <22457a5f-586c-4aaf-bc61-0b18fe5f28db@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <22457a5f-586c-4aaf-bc61-0b18fe5f28db@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.56 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-1.26)[89.74%];
 ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Futex_waitv: Convert 32bit timespec struct to
 64bit version for 32bit compatibility mode
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

Hi Wei, Andrea,

merged (with some Suggested-by: tags), thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
