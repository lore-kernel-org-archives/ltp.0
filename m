Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5955DC10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 14:26:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2D863CDD51
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 16:26:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FBDE3CDB74
 for <ltp@lists.linux.it>; Tue,  7 May 2024 16:25:57 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EFB831BED0B0
 for <ltp@lists.linux.it>; Tue,  7 May 2024 16:25:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F16D20B57;
 Tue,  7 May 2024 14:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715091956;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KvrsaO6hJnBIHRFyiGa7ysYV5QNf1YxgHTQWTTriE6U=;
 b=AdQTakYg1+tkGdeZYiV8n4sqCEMrtv8e4ewsBxWXMa30ohzCl5FYJ8YLIWMI//KmSNAdAp
 B0uV17YDkzZQ+ULguU3Emji1qqzg9O2jgYY3oVwy5vHKWQKJ9KCY9+Q+Jfh8R9FgaZUhEQ
 J5MUaKgHAxZnUKfl5jIvjDBNadfL+7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715091956;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KvrsaO6hJnBIHRFyiGa7ysYV5QNf1YxgHTQWTTriE6U=;
 b=z5iZD0H2bo70Hl+zp9eWPw7c6U7E2eYdj6hRz4azZS3b6mBlvSaALeX4xewH9DSvpXpht+
 9Q0jPaFtWy40RODQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715091956;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KvrsaO6hJnBIHRFyiGa7ysYV5QNf1YxgHTQWTTriE6U=;
 b=AdQTakYg1+tkGdeZYiV8n4sqCEMrtv8e4ewsBxWXMa30ohzCl5FYJ8YLIWMI//KmSNAdAp
 B0uV17YDkzZQ+ULguU3Emji1qqzg9O2jgYY3oVwy5vHKWQKJ9KCY9+Q+Jfh8R9FgaZUhEQ
 J5MUaKgHAxZnUKfl5jIvjDBNadfL+7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715091956;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KvrsaO6hJnBIHRFyiGa7ysYV5QNf1YxgHTQWTTriE6U=;
 b=z5iZD0H2bo70Hl+zp9eWPw7c6U7E2eYdj6hRz4azZS3b6mBlvSaALeX4xewH9DSvpXpht+
 9Q0jPaFtWy40RODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E799B13A2D;
 Tue,  7 May 2024 14:25:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mRKLN/M5OmZ3PgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 May 2024 14:25:55 +0000
Date: Tue, 7 May 2024 16:25:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240507142546.GB138935@pevik>
References: <20240430122208.13043-1-mdoucha@suse.cz>
 <20240430122208.13043-2-mdoucha@suse.cz>
 <20240506194156.GA38981@pevik>
 <cd8f5fb9-606b-4543-8a3e-02079d2ea630@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cd8f5fb9-606b-4543-8a3e-02079d2ea630@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/9] KVM: Disable EBP register use in 32bit code
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

...
> Could you review and merge the trivial patches (4, 5, 6, 7) so that I don't
> need to resubmit everything?

I could even rebase 9th (missing kvm_svm04) to merge it before. Please let me
know if change order was actually needed only for kvm_svm04 (it does not look
like from the commit message).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
