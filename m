Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17CBC3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 11:25:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 205533D1C2B
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 13:25:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C8673C4D11
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 13:25:28 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C8D8D6002B7
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 13:25:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 337FE1FBCD;
 Wed, 24 Jul 2024 11:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721820326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2lLELRAQzeXwLE4U/4tNHKIjnpJgAUGrNdaDLfaP/wk=;
 b=YVvQ6uXnCVr6wZ6s92/jfj0RxPTWgIzWBvrHdkDSZDWdz9aLeEYqyStfRFg5Wspplij+q4
 LUvooEx362PyfuV2cFDlRQTGm3z/FqqzD80f2XTpABmKy1l3JigONy1J+4Z/LakQlkqykD
 doiB+g7w9jp4emu1CWZlNTkgZAwPNSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721820326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2lLELRAQzeXwLE4U/4tNHKIjnpJgAUGrNdaDLfaP/wk=;
 b=sMloB/dlCyE4SVpqr+l7Hf7pZIGjTuH91g4ybpWHKwwr5ncb425YOxerAKaA1e8tiGkr9S
 JITqEkZFS9UtioCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721820326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2lLELRAQzeXwLE4U/4tNHKIjnpJgAUGrNdaDLfaP/wk=;
 b=YVvQ6uXnCVr6wZ6s92/jfj0RxPTWgIzWBvrHdkDSZDWdz9aLeEYqyStfRFg5Wspplij+q4
 LUvooEx362PyfuV2cFDlRQTGm3z/FqqzD80f2XTpABmKy1l3JigONy1J+4Z/LakQlkqykD
 doiB+g7w9jp4emu1CWZlNTkgZAwPNSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721820326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2lLELRAQzeXwLE4U/4tNHKIjnpJgAUGrNdaDLfaP/wk=;
 b=sMloB/dlCyE4SVpqr+l7Hf7pZIGjTuH91g4ybpWHKwwr5ncb425YOxerAKaA1e8tiGkr9S
 JITqEkZFS9UtioCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1567A1324F;
 Wed, 24 Jul 2024 11:25:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QPh3A6bkoGYYdAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jul 2024 11:25:26 +0000
Date: Wed, 24 Jul 2024 13:25:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZqDkjOCm2VqO2Vq_@yuki>
References: <20240723-mseal-v2-0-5aa872d611bc@suse.com>
 <20240723-mseal-v2-1-5aa872d611bc@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240723-mseal-v2-1-5aa872d611bc@suse.com>
X-Spamd-Result: default: False [-3.60 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Add mseal() syscall declaration
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
This patch obviously does not apply after I've merged cachestat. I guess
that the easiest solution is to have a one patch that adds all these
fallbacks for all new syscalls you are working on pushed first,
otherwise there will be conflicts for each patchset.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
