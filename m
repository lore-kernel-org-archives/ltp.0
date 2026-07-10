Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6B9C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 07:05:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEFF43E275E
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 09:05:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EA243E26BB
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:05:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 90E13600A3D
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:05:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 008EE76648;
 Fri, 10 Jul 2026 07:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783667113;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tIMoIFwOvhh1RhWY5dJZI5uiFqf2khRg0yLRAb7LVI=;
 b=tPLasUfRqpn2sjHwhYHpxncidlc6VjpHTIroF+aC0gSDDo+hbmEIEBwlzaiNRP9LHLxOYH
 yh8HEtcUDsX9QwTVIbsryEA7Yk3Ix32JPHDBBD9pphspKjc8QaHHkuBnyY58dZO1IQO1yL
 RXwNH7XzGmpMfRw5fp5Z1ZwtjgRoMx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783667113;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tIMoIFwOvhh1RhWY5dJZI5uiFqf2khRg0yLRAb7LVI=;
 b=82mBEBAl3nquszY4qxWdobsqMnA/ixtI1sEXTihSaQdosw6uI2V/ZCg9ELCWpvFJSssNrV
 BkQkqdhtXW1dCyAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783667113;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tIMoIFwOvhh1RhWY5dJZI5uiFqf2khRg0yLRAb7LVI=;
 b=tPLasUfRqpn2sjHwhYHpxncidlc6VjpHTIroF+aC0gSDDo+hbmEIEBwlzaiNRP9LHLxOYH
 yh8HEtcUDsX9QwTVIbsryEA7Yk3Ix32JPHDBBD9pphspKjc8QaHHkuBnyY58dZO1IQO1yL
 RXwNH7XzGmpMfRw5fp5Z1ZwtjgRoMx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783667113;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tIMoIFwOvhh1RhWY5dJZI5uiFqf2khRg0yLRAb7LVI=;
 b=82mBEBAl3nquszY4qxWdobsqMnA/ixtI1sEXTihSaQdosw6uI2V/ZCg9ELCWpvFJSssNrV
 BkQkqdhtXW1dCyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2817779BD;
 Fri, 10 Jul 2026 07:05:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SyWMJ6iZUGphEQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 07:05:12 +0000
Date: Fri, 10 Jul 2026 09:05:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260710070511.GB1157094@pevik>
References: <20260709085353.345957-1-chrubis@suse.cz>
 <20260709085353.345957-8-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260709085353.345957-8-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 7/9] SAFE_MACROS: Add SAFE_POLL()
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

Hi Cyril,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

nit: it introduced 3 more formatting issues:
tst_safe_macros.c:834: CHECK: Alignment should match open parenthesis
tst_safe_macros.c:841: CHECK: Alignment should match open parenthesis
tst_safe_macros.c:844: CHECK: Alignment should match open parenthesis

We can disable PARENTHESIS_ALIGNMENT if we don't care about this formatting.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
