Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6734FC021AA
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 13:26:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1AED3C9CB3
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 14:26:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D29E53C9C61
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 14:26:04 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9A557208F84
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 14:26:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 00A6F1F396;
 Tue, 18 Feb 2025 13:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739885162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B9k2xnHsrfVVVzMhUL/vQQ+lJE6R0L/3yjWUErZ1WS0=;
 b=iidFaT7ijp/e11kd0Y7QuqlkXJv9EKA2tqTw63ZPUCUjVtlNp4H5/ErsCnLNvvFw+bge3+
 lr3GKrHLE7AQ8rsmvLGAiGegPiapPt5OTWG6gkUmxlugBnKoeH1Zny29D1FKCALZOA3jL/
 VnWRnoCsA3DSls+1kB9QHeaWvZ5qxnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739885162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B9k2xnHsrfVVVzMhUL/vQQ+lJE6R0L/3yjWUErZ1WS0=;
 b=uBPP3/9IQva2kZ1PIxF5WOBxj4hDPFQvCEdpECw3QEY0o/sZd0Oh93WE4gcIHBWiW2+7PI
 A1jZUQqVfpbwPpBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iidFaT7i;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="uBPP3/9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739885162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B9k2xnHsrfVVVzMhUL/vQQ+lJE6R0L/3yjWUErZ1WS0=;
 b=iidFaT7ijp/e11kd0Y7QuqlkXJv9EKA2tqTw63ZPUCUjVtlNp4H5/ErsCnLNvvFw+bge3+
 lr3GKrHLE7AQ8rsmvLGAiGegPiapPt5OTWG6gkUmxlugBnKoeH1Zny29D1FKCALZOA3jL/
 VnWRnoCsA3DSls+1kB9QHeaWvZ5qxnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739885162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B9k2xnHsrfVVVzMhUL/vQQ+lJE6R0L/3yjWUErZ1WS0=;
 b=uBPP3/9IQva2kZ1PIxF5WOBxj4hDPFQvCEdpECw3QEY0o/sZd0Oh93WE4gcIHBWiW2+7PI
 A1jZUQqVfpbwPpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94DD413A1D;
 Tue, 18 Feb 2025 13:26:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qMSHImmKtGfiSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Feb 2025 13:26:01 +0000
Date: Tue, 18 Feb 2025 14:26:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250218132600.GA2452309@pevik>
References: <20250218121553.2470592-1-pvorel@suse.cz>
 <74a3b1f1-922f-4f5b-9265-879ca926dd05@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <74a3b1f1-922f-4f5b-9265-879ca926dd05@suse.com>
X-Rspamd-Queue-Id: 00A6F1F396
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[python.org:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/conf.py: Replace all titles
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

Hi Andrea,

> > +++ b/doc/conf.py
> > @@ -455,12 +455,8 @@ def generate_test_catalog(_):
> >           if desc:
> >               desc_text = []
> >               for line in desc:
> > -                if line.startswith("[Description]"):
> > -                    desc_text.append("**Description**")
> > -                elif line.startswith("[Algorithm]"):
> > -                    desc_text.append("**Algorithm**")
> > -                else:
> > -                    desc_text.append(line)
> > +                line = re.sub(r'^\[([A-Za-z][\w\W]+)\]', r'**\1**', line)

> The idea is good, but the implementation can be optimized. We can
> "re.compile()" the regex __before__ reading all the lines, then we can use
> the compiled object to substitute the string. In this way we won't compile
> the regexp for each line and the string processing will be faster.

Thanks for improving my python fu! I knew about re.compile(), I just wasn't able
to find an example where it is combined with re.sub().

Kind regards,
Petr

> https://docs.python.org/3/library/re.html#re.compile
> https://docs.python.org/3/library/re.html#re.Pattern.sub

> > +                desc_text.append(line)
> >               text.extend([
> >                   '\n'.join(desc_text),
> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
