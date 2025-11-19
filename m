Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB15CF34C4
	for <ltp@archiver.kernel.org>; Wed, 19 Nov 2025 14:57:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 417B13CFF38
	for <ltp@archiver.kernel.org>; Wed, 19 Nov 2025 15:57:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8CF23CFE83
 for <ltp@lists.linux.it>; Wed, 19 Nov 2025 15:57:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3A2BE200B7B
 for <ltp@lists.linux.it>; Wed, 19 Nov 2025 15:57:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D61C92054F;
 Wed, 19 Nov 2025 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763564239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHZPJnwotOyV+OgdjKupwIIkD/97t2Pdnbz4x3Rpcsw=;
 b=UZM8SADdUqLpJDViR6QWtMdwlG2iVaGuu0W5nQnJiBkPjglkPT3Erm/sx0AK4W+x9AU1nv
 vI3RQcP+A+ifMq7iQvqO/eprbp0J4ISN1nkMvGaHyr9dW/+RLSgXRM7YxPzA1kd0ifftIX
 Zfw2KXQ+/1nXn4Gp7OKBuWcxhK2mfpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763564239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHZPJnwotOyV+OgdjKupwIIkD/97t2Pdnbz4x3Rpcsw=;
 b=/q5U7BEKLtx7FttIJwcSMgb3HRRgTzj+XfZo7ilTqG1I+JrAE4iuUm49iIshxBQoo1Lfir
 dYvZoFohJETXMnAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763564238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHZPJnwotOyV+OgdjKupwIIkD/97t2Pdnbz4x3Rpcsw=;
 b=fkiGi7mKWkoBXU1UViintg/QTp9Vgp6TFtTRWyVo/RjtjeQ14TtM2h51iTNSL1GsZPqMvE
 TV6c5Xu2CUj4+qdIqlAfIyeRlGKrHmgGn9xjxkGmGRV0PhMdGQcowfRMGwny3lrQYP9Ai7
 aDy+PR9SMAd9f23vQtjf9deNGVn8G1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763564238;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHZPJnwotOyV+OgdjKupwIIkD/97t2Pdnbz4x3Rpcsw=;
 b=DsMI82/kUBlPPsOABnbW4f4Vgl/ZIIbZ8c1I3OEAQO3TEdfNp7O1W/OwF+gAYWHeq8U4md
 3Hg2H4QQq7rhKBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1C473EA61;
 Wed, 19 Nov 2025 14:57:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LEzDLs7aHWncEAAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 19 Nov 2025 14:57:18 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it, Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 Nov 2025 15:57:18 +0100
Message-ID: <12781063.O9o76ZdvQC@thinkpad>
In-Reply-To: <20251118143607.45308-2-pvorel@suse.cz>
References: <20251118143607.45308-1-pvorel@suse.cz>
 <20251118143607.45308-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 CTE_CASE(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FROM_HAS_DN(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] swapon03: Remove fork in setup
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Reviewed-by: Avinesh Kumar <akumar@suse.de>
for both patches.

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
