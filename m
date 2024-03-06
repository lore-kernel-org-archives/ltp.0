Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1522AC5475B
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 10:41:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84EA33CE9E7
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 11:41:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17D913C3320
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 11:41:13 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EA0476022BE
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 11:41:12 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15BB63EE04;
 Wed,  6 Mar 2024 10:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709721672;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N97QMu5QhL1fG2hSSSkrRhYMBZt+nJb+YDcQ5nYJXFA=;
 b=KDaQ5nIdUe4sZ04VInEGlY+M+MA8TcLiPBHrO1vh6R7eN4jdWGN+xB6gd8wqdHAz/VEkNY
 DOAJQhQaNzZZjLJ8mO1TGkFscctO4UzXHq6ANlIaWnvlwoJEgFiF0GWMNDdkb6IXpJMc4+
 03zWhbKR2tyHDHu4h0suXYhU/cNXBKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709721672;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N97QMu5QhL1fG2hSSSkrRhYMBZt+nJb+YDcQ5nYJXFA=;
 b=2ZvAMYkKe45qK1bdOOrECBSR7sFdgbmcUeVXo/CGkI9ZOYLMez6NhjXar0B9fOMODDutZZ
 Zm/H3xdALUpsuzBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709721672;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N97QMu5QhL1fG2hSSSkrRhYMBZt+nJb+YDcQ5nYJXFA=;
 b=KDaQ5nIdUe4sZ04VInEGlY+M+MA8TcLiPBHrO1vh6R7eN4jdWGN+xB6gd8wqdHAz/VEkNY
 DOAJQhQaNzZZjLJ8mO1TGkFscctO4UzXHq6ANlIaWnvlwoJEgFiF0GWMNDdkb6IXpJMc4+
 03zWhbKR2tyHDHu4h0suXYhU/cNXBKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709721672;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N97QMu5QhL1fG2hSSSkrRhYMBZt+nJb+YDcQ5nYJXFA=;
 b=2ZvAMYkKe45qK1bdOOrECBSR7sFdgbmcUeVXo/CGkI9ZOYLMez6NhjXar0B9fOMODDutZZ
 Zm/H3xdALUpsuzBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E98911377D;
 Wed,  6 Mar 2024 10:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id EiS3N0dI6GWzNgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 06 Mar 2024 10:41:11 +0000
Date: Wed, 6 Mar 2024 11:41:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240306104110.GC558578@pevik>
References: <20240306085254.534940-1-dbrendel@redhat.com>
 <CAEemH2fi7pQUX2WVWqz1-px5reA3mcGjAHm=A3j3xnOVqF9vDg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fi7pQUX2WVWqz1-px5reA3mcGjAHm=A3j3xnOVqF9vDg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.64 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.34)[76.15%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] munlockall: add test case that verifies memory
 has been unlocked
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

Hi Dennis, Li,

> Hi Dennis,

> Good to see your patch soon, nice work!

> Next time remember to commit the patch with Signed-off-by.
>   `git commit -sm  xxxx`

+1 (planning to add that before merge).

Also these comments "Changes compared to v2:" should be below "---",
that way we can read them but they will not endup in the git commit message when
we apply the patch.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
