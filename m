Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46E2C88E75
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 14:40:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B25EC3E8CD2
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 16:40:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 315D33E48AE
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 16:40:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CF0931A003EC
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 16:40:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4ACD21A6F;
 Tue, 15 Sep 2026 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789483220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UxlD/riU83gQn43Y+qBT+2EEb+ZcruPt5eDxY0jDlm4=;
 b=YnjsFh7Tcq8n7S3+SszaALiO4kBqljvg6J75DAaSEqUF2vf8SFe69Qmi90XZZELqNGy9cs
 iMVk8lgtAqrhvZ6KFAQSa+f8pldOBsk9RV7pf9CPM1M/hX21Hsnyl0UVoCVnlb6juUZ35a
 37SWOJayn1QjXdhur/tnTUS9HUsN1bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789483220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UxlD/riU83gQn43Y+qBT+2EEb+ZcruPt5eDxY0jDlm4=;
 b=Z4r1qyWzHnGlFEmMmqi1zSfBdadpHFXu4rqjWuQw2JMUImhjvKKgJCmZm5q40dLWFtETAL
 HD8OjHggwI7lhYBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PA2ILXDd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=X5erWWuZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789483216;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UxlD/riU83gQn43Y+qBT+2EEb+ZcruPt5eDxY0jDlm4=;
 b=PA2ILXDdkWg+9lOhGQoQg5bx/6ER1D381Ol/k9mDKbIKV3JLwb4bk9rNZXLaUGRWBGdj2B
 YCNgecJ8qr1hgsbT0bAZdw+POtpdfAq8lK9mbLgBJARzlRwhanYfeF7x6/fR8Tq14uQw1T
 3ofK2VrCpyw0JHNGlq/BXWUDc3iwsig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789483216;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UxlD/riU83gQn43Y+qBT+2EEb+ZcruPt5eDxY0jDlm4=;
 b=X5erWWuZILdzb2Xu6KV/rzDe4dbnq7+HFkLCUC5KadiOJpFUJd69sz9HhcLtnkjnRGAFqi
 PuHW1DtJmPPnE5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E72C13432;
 Tue, 15 Sep 2026 14:40:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kKYNDdBYqWr6QgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 15 Sep 2026 14:40:16 +0000
Date: Tue, 15 Sep 2026 16:40:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260915144014.GA1722246@pevik>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-4-43b78b15ef9f@suse.com>
 <aqO3RPWN_VlpnkRq@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aqO3RPWN_VlpnkRq@yuki.lan>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C4ACD21A6F
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 04/33] keyctl12: Test KEYCTL_DESCRIBE with too
 small buffer
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > +static void run(void)
> > +{
> > +	size_t i;
> > +
> > +	memset(buf, 0xAA, sizeof(buf));
> > +	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)buf,
> > +				    desc_len - 1, 0), desc_len);
> > +	if (!TST_PASS)
> > +		return;
> > +
> > +	for (i = 0; i < sizeof(buf); i++) {
> > +		if (buf[i] != (char)0xAA) {
> > +			tst_res(TFAIL,
> > +				"too small buffer was written to at offset %zu",
> > +				i);
> > +			return;
> > +		}
> > +	}

> It may make sense to loop this with:

> 	for (buf_len = 0; buf_len < desc_len; buf_len++) {
> 		...
> 	}

> It should be fast and would increase the coverage..

I suppose you want to check the actual key description in case it's longer than
buffer size.

desc_len is 12, sizeof(buf) is 64 therefore it's safe but I'll change it in v3
so that it works in case of a longer key in the future.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
