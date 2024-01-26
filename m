Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D46AC47DDF
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 14:26:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2DF63D0C00
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 15:26:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 578FD3D060A
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 15:26:39 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 544BB1A027CD
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 15:26:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1330022021;
 Fri, 26 Jan 2024 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706279198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w3wUPxybFz72tKe9iQJpaCBpkDuTWvSWQMj4JZ8JPrI=;
 b=xsJQM2jYJ3NUo2eRILnWwnjlPsJcks4f6A0xwc6pD40inMma2GJCA894Cx3DfThB7IMffA
 TUkWOEYc3tS8KAkApvKq0+pU8dZUfwjffuQWgJA7nI/FK8WwqYKNaoNifjfgh8+Z/XlNXK
 rinxPgV4np080H4sNwJKtNFqV+aKPxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706279198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w3wUPxybFz72tKe9iQJpaCBpkDuTWvSWQMj4JZ8JPrI=;
 b=EM4xXcIC70JXfhGM1OX7U19+0XkHfYLwgtVQF+9yoa2+jO5OAvoAcpJu724KlUHp2ugbnu
 tuqMYM75KzBvjACA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706279198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w3wUPxybFz72tKe9iQJpaCBpkDuTWvSWQMj4JZ8JPrI=;
 b=xsJQM2jYJ3NUo2eRILnWwnjlPsJcks4f6A0xwc6pD40inMma2GJCA894Cx3DfThB7IMffA
 TUkWOEYc3tS8KAkApvKq0+pU8dZUfwjffuQWgJA7nI/FK8WwqYKNaoNifjfgh8+Z/XlNXK
 rinxPgV4np080H4sNwJKtNFqV+aKPxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706279198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w3wUPxybFz72tKe9iQJpaCBpkDuTWvSWQMj4JZ8JPrI=;
 b=EM4xXcIC70JXfhGM1OX7U19+0XkHfYLwgtVQF+9yoa2+jO5OAvoAcpJu724KlUHp2ugbnu
 tuqMYM75KzBvjACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E164213A22;
 Fri, 26 Jan 2024 14:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DSd/Mx3Bs2U3cAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Jan 2024 14:26:37 +0000
Date: Fri, 26 Jan 2024 15:26:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZbPBK987UtWigLlz@yuki>
References: <20240126121603.500470-1-pvorel@suse.cz>
 <34c177e9-394a-4338-a61d-816185a49f3c@suse.cz>
 <ZbO-Pl9S7KH2cKkb@yuki>
 <21f249c0-5140-4b12-bd3f-2537260a382e@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <21f249c0-5140-4b12-bd3f-2537260a382e@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.85 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.05)[59.32%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] splice07: Whitelist /dev/zero on pipe write
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> In that case it makes sense to treat /dev/zero and /proc/self/maps as 
> unconditionally expected success for splice() to writable pipe.

I suppose so. And ideally we should write a separate test just for that
after the release.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
