Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94850C48297
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 11:19:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 097823CC667
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 12:19:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 434C53C12A7
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 12:18:54 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BF8A91009BFA
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 12:18:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD8B51FB6F;
 Tue,  6 Feb 2024 11:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707218332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lvbiYdBYQs8JTED4xEboDISu7bSuBmdrfzEWLInFc1g=;
 b=nRTbJE5tVjYbx9Bg3aIhEekJXj6+fdWueucfMMLRKPAZPBDHlqct6bKgg7w6BVAOlKNWIQ
 TYQLP53QU0xfo37Nuc+D8NGNY3bZ3LGc53jqNBn6MEN7wzmtGkb7wqNMlzCIlJ6px4ogVI
 AQwoTSdXGsa9uaRTlqxLbjnKoCotXas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707218332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lvbiYdBYQs8JTED4xEboDISu7bSuBmdrfzEWLInFc1g=;
 b=rqEWjH2YakNYP1zUfxOfZBFSpI+rr7IIcal8lWKAQO/VhMbTYPqwDBSugJ0jGN2wFmYZ3P
 sf2Ki49BplSs0xBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707218330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lvbiYdBYQs8JTED4xEboDISu7bSuBmdrfzEWLInFc1g=;
 b=VxpGKboWhJBfBNEe/nkxqyf9YOMeaCx0V9pbgQVzfAzk9bii6mJ052YNXUfAzvpujSE0Da
 CjrjgonWCCewxRakfVuxDAkH4wqcnvDp8n1NxR5+L/2BbwRkRkzxgv+glo3DMn6JFi3GT4
 KT6xpr0tqrzit3dE8kzjJgIaVDhjZ/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707218330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lvbiYdBYQs8JTED4xEboDISu7bSuBmdrfzEWLInFc1g=;
 b=CoPWArUWNshj0Wh4IMsMDkGCHvGovwRws2L67ouLoBZwVianpWAT7Hgy8QRplYeXoktWJm
 5UpBIyPYToqYRZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1EA4132DD;
 Tue,  6 Feb 2024 11:18:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LJe8KZoVwmVhEQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 06 Feb 2024 11:18:50 +0000
Date: Tue, 6 Feb 2024 12:18:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240206111849.GD270992@pevik>
References: <20240203051901.3000-1-xuyang2018.jy@fujitsu.com>
 <20240203051901.3000-2-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240203051901.3000-2-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.49 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.99)[87.01%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,fujitsu.com:email,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] settimeofday02:Simplify test using TST_ macros
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

Hi Yang Xu,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM

nit: subject could be "settimeofday02: Simplify test using TST_ macros"
(missing space behind : - readability)

nit: git metadata as you as author have \ escapes:
Yang Xu \(Fujitsu\) <xuyang2018.jy@fujitsu.com>

It looks like you had it long time ago:
https://patchwork.ozlabs.org/project/ltp/list/?submitter=81371&state=*

Could you fix it as it breaks also credit counting before next release?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
