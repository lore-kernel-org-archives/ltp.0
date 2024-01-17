Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E8CC47258
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 11:41:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6A783CE311
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 12:41:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DCDC3C88E1
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 12:41:31 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8A8601A011D2
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 12:41:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67494219C0;
 Wed, 17 Jan 2024 11:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705491689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRCAKU2+WVEjq/rMIG0ZxWfU6EOa5Tn9ysb0LkbOQ3Y=;
 b=nb+x5ADFDKbN6cGu1+cwz32eSJ3XfO9AFp2Xi+PYLAeRmTzdnKgG37KdHT8/U54KyBQYEx
 yKubWaYwrFxEf9CR7VLtFdfRbRpNZcXU5DRe4BvcZDxN7xCRlc6GJJPitx5HR51/5nZ35y
 qt66TezuoiQZ4m3xA5lULNpiaGRwlL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705491689;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRCAKU2+WVEjq/rMIG0ZxWfU6EOa5Tn9ysb0LkbOQ3Y=;
 b=9kBpCvq+jtxUc12IskNTuLT3jJ5KjbhSNTpxVSo0ezx3LfcO0gqYbGSPtq+/1eqXtZdujs
 lYd0lirZl4zZ3pCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705491689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRCAKU2+WVEjq/rMIG0ZxWfU6EOa5Tn9ysb0LkbOQ3Y=;
 b=nb+x5ADFDKbN6cGu1+cwz32eSJ3XfO9AFp2Xi+PYLAeRmTzdnKgG37KdHT8/U54KyBQYEx
 yKubWaYwrFxEf9CR7VLtFdfRbRpNZcXU5DRe4BvcZDxN7xCRlc6GJJPitx5HR51/5nZ35y
 qt66TezuoiQZ4m3xA5lULNpiaGRwlL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705491689;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRCAKU2+WVEjq/rMIG0ZxWfU6EOa5Tn9ysb0LkbOQ3Y=;
 b=9kBpCvq+jtxUc12IskNTuLT3jJ5KjbhSNTpxVSo0ezx3LfcO0gqYbGSPtq+/1eqXtZdujs
 lYd0lirZl4zZ3pCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DB4013751;
 Wed, 17 Jan 2024 11:41:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5CNsEem8p2VwSQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jan 2024 11:41:29 +0000
Date: Wed, 17 Jan 2024 12:41:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zae88oHNozj41lU9@yuki>
References: <20240117101801.12536-1-chrubis@suse.cz>
 <20240117110744.GA2692706@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240117110744.GA2692706@pevik>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nb+x5ADF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9kBpCvq+
X-Spamd-Result: default: False [0.12 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.07)[62.28%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 67494219C0
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: TST_EXP_FAIL: Fix the *_ARR_() macros
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
> I'm sorry, I haven't noticed the problem. tst_test_macros.h is getting quite
> complex, maybe we should add some comments into the header.

Pushed, thanks.

I guess that ideal fix would be comparing the output from the newlib
TST_EXP_* tescases with expected output. That would actually catch most
of the bugs introduced in there.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
