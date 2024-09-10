Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBCAECE564
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 08:53:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C1AA3C1AB7
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 10:53:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CA813C19E4
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 10:53:37 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AAC40601BC2
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 10:53:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9FF331F454;
 Tue, 10 Sep 2024 08:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725958415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PV2dOSb46kZgUBOi9U7Hz+GwB+iwnUXZig2FOXMOZ8Y=;
 b=Gbxsk1KLCtA1dwZq8Sc+cwuiBHlWt09ZVCYrgRtvTQRX7rbT1ALrw4CQnod92gd1ceGFqb
 jIcwGNdEY4u44VpejDDJTXhXW+qazYuWodD5vH9CYjI4GSYK6zbGDO65rP8uVSnJM+DP7G
 MsaSwz00sv3eYhYnTNgVTB3q9uquqZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725958415;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PV2dOSb46kZgUBOi9U7Hz+GwB+iwnUXZig2FOXMOZ8Y=;
 b=p7zWhdRyxZeQtA6bs9ljBMzeEzbYIhNOM0LhyyVXSKmRZ/5OCwhw+vGGNO840s9r8mbrOP
 JqLpfLI1QZ4jVBAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725958415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PV2dOSb46kZgUBOi9U7Hz+GwB+iwnUXZig2FOXMOZ8Y=;
 b=Gbxsk1KLCtA1dwZq8Sc+cwuiBHlWt09ZVCYrgRtvTQRX7rbT1ALrw4CQnod92gd1ceGFqb
 jIcwGNdEY4u44VpejDDJTXhXW+qazYuWodD5vH9CYjI4GSYK6zbGDO65rP8uVSnJM+DP7G
 MsaSwz00sv3eYhYnTNgVTB3q9uquqZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725958415;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PV2dOSb46kZgUBOi9U7Hz+GwB+iwnUXZig2FOXMOZ8Y=;
 b=p7zWhdRyxZeQtA6bs9ljBMzeEzbYIhNOM0LhyyVXSKmRZ/5OCwhw+vGGNO840s9r8mbrOP
 JqLpfLI1QZ4jVBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9029C132CB;
 Tue, 10 Sep 2024 08:53:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zt9NIg8J4GaqQgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 10 Sep 2024 08:53:35 +0000
Date: Tue, 10 Sep 2024 10:52:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZuAIzfQCWY-6d2SR@yuki.lan>
References: <20240910071019.551379-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240910071019.551379-1-liwang@redhat.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
Subject: Re: [LTP] [PATCH] tmpdir: rename tst_tmpdir_mkpath to
 tst_tmpdir_genpath
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> When I reviewed the rename15 patch I felt confused a while on
> function like tst_tmpdir_mkpath (reminds me of: mkdir).
> 
> Because the name could be misleading since it suggests that a
> file or directory is being created, when in fact it is simply
> constructing a path inside a temporary directory without
> actually creating any files.

Good catch, this is indeed confusing.

> To make the function's purpose clearer, the name should reflect
> that it is only constructing or generating a path, not creating
> any files or directories.
> 
> So I think either 'tst_tmpdir_genpath' or 'tst_tmpdir_buildpath'
> would be concise and clear options.

Maybe tst_tmpdir_getpath()?

But I agree that any of these three is better than the original. Naming
API functions is hard...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
