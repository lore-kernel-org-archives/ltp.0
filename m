Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8097CC46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 16:31:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC3B43CF98A
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 17:31:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C5623CF965
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 17:30:47 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D93B11A0C261
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 17:30:46 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 050521F871;
 Tue, 30 Jan 2024 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706632246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Is8Pd0KM8RytMdC+vDDKSJcZXZV2IB8YpYcpObQor9I=;
 b=jSGMOHQfSkTTGqFC7aQPbBdUabymzw8fhKw+KrNQttFc73EGTelDuFPR/0LoXGNxPaTHVh
 3GWvzL7QzcbAoTgCjLur0In53oHMAi2G+hDYo3/hjKC7FsjKCnXH9Nn4BZQk8SlqykhzJi
 UM9Qv4HVC+mZuQ540NimicXyfn+yKQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706632246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Is8Pd0KM8RytMdC+vDDKSJcZXZV2IB8YpYcpObQor9I=;
 b=qn9otYl1L27syeKn2XkpXuyDu/QomVTmMgm53TZD0YvgEYFJYc16eT/HvSaaD+bLog/CKP
 6Yo3v/OlNYTTHgCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706632246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Is8Pd0KM8RytMdC+vDDKSJcZXZV2IB8YpYcpObQor9I=;
 b=jSGMOHQfSkTTGqFC7aQPbBdUabymzw8fhKw+KrNQttFc73EGTelDuFPR/0LoXGNxPaTHVh
 3GWvzL7QzcbAoTgCjLur0In53oHMAi2G+hDYo3/hjKC7FsjKCnXH9Nn4BZQk8SlqykhzJi
 UM9Qv4HVC+mZuQ540NimicXyfn+yKQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706632246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Is8Pd0KM8RytMdC+vDDKSJcZXZV2IB8YpYcpObQor9I=;
 b=qn9otYl1L27syeKn2XkpXuyDu/QomVTmMgm53TZD0YvgEYFJYc16eT/HvSaaD+bLog/CKP
 6Yo3v/OlNYTTHgCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CE25613462;
 Tue, 30 Jan 2024 16:30:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 1K9yLTUkuWWqWAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 16:30:45 +0000
Date: Tue, 30 Jan 2024 17:30:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240130163042.GA791887@pevik>
References: <20240117173006.31521-1-mdoucha@suse.cz>
 <20240117173006.31521-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240117173006.31521-2-mdoucha@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.82 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.32)[75.60%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add test for ASLRn't bug
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

Hi Martin,

> +	if (!hpsize) {
> +		tst_res(TCONF, "Hugepage support appears to be missing");
> +	} else if (libsize < hpsize) {
> +		tst_res(TCONF, "The largest dynamic library is smaller than "
> +			"hugepage size");
> +		tst_res(TCONF, "Please use LD_PRELOAD to add larger library");
very tiny detail: I overlook these 2 TCONF. I understand that your original
version is readable, but I found little confusing:

aslr01.c:161: TCONF: The largest dynamic library is smaller than hugepage size
aslr01.c:162: TCONF: Please use LD_PRELOAD to add larger library
...
Summary:
passed   1
failed   0
broken   0
skipped  2

If you don't mind, I'll join it before merge to a single line:

	if (!hpsize) {
		tst_res(TCONF, "Hugepage support appears to be missing");
	} else if (libsize < hpsize) {
		tst_res(TCONF, "The largest dynamic library is smaller than hugepage size, "
				"please use LD_PRELOAD to add larger library");
	}

aslr01.c:161: TCONF: The largest dynamic library is smaller than hugepage size, please use LD_PRELOAD to add larger library

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
