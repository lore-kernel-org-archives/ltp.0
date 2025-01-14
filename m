Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54D9C02183
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 09:26:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDEAD3C7A02
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 10:26:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7C613C79E5
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 10:25:47 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C77C410060B5
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 10:25:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 452C221133;
 Tue, 14 Jan 2025 09:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736846745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9xyyXVRiiO3Sw3B9irOMnquvQhr0ZFmlMspFDD1pZ4=;
 b=KtBliMCyXltJoTHiLDxylh/6NQTOA9OuZ6+43f8raO2PjqBc/YGYbcIt36Tt+bvvKMZm0q
 axw7cH/JpHPbY+HfN/Mr2vx5pnbUbK2yt5b0WTirLDJbXxFRYiXoRNjVFdNg1VwPYm8vhs
 gWbAXkKYk6jk9VGfPSVWW6uEgHZSWoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736846745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9xyyXVRiiO3Sw3B9irOMnquvQhr0ZFmlMspFDD1pZ4=;
 b=2gucZ5iulOh/EYYSCL6gjXUw3jdXdmIreazWR5UhgQSaaRLkEX5fDrKIFrMO+ZD+Rq++qM
 4C7pN/XszgTypHBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KtBliMCy;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2gucZ5iu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736846745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9xyyXVRiiO3Sw3B9irOMnquvQhr0ZFmlMspFDD1pZ4=;
 b=KtBliMCyXltJoTHiLDxylh/6NQTOA9OuZ6+43f8raO2PjqBc/YGYbcIt36Tt+bvvKMZm0q
 axw7cH/JpHPbY+HfN/Mr2vx5pnbUbK2yt5b0WTirLDJbXxFRYiXoRNjVFdNg1VwPYm8vhs
 gWbAXkKYk6jk9VGfPSVWW6uEgHZSWoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736846745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9xyyXVRiiO3Sw3B9irOMnquvQhr0ZFmlMspFDD1pZ4=;
 b=2gucZ5iulOh/EYYSCL6gjXUw3jdXdmIreazWR5UhgQSaaRLkEX5fDrKIFrMO+ZD+Rq++qM
 4C7pN/XszgTypHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35649139CB;
 Tue, 14 Jan 2025 09:25:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dNEWDJkthmfydgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 14 Jan 2025 09:25:45 +0000
Date: Tue, 14 Jan 2025 10:25:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z4YtjzSzZGO2i8dX@yuki.lan>
References: <20241217061636.16366-1-wegao@suse.com>
 <20250113081622.28942-1-wegao@suse.com>
 <20250113081622.28942-2-wegao@suse.com> <Z4U5C3tHhDQ_pQTv@yuki.lan>
 <20250113214010.GA512384@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250113214010.GA512384@pevik>
X-Rspamd-Queue-Id: 452C221133
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] ptrace05: Refactor the test using new LTP
 API
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
> > diff --git a/lib/tests/tst_strsig.c b/lib/tests/tst_strsig.c
> > index 9a5ca80aa..ed5be3f00 100644
> > --- a/lib/tests/tst_strsig.c
> > +++ b/lib/tests/tst_strsig.c
> > @@ -29,6 +29,7 @@ int TST_TOTAL = 1;
> 
> >  int main(void)
> >  {
> > +       fprintf(stderr, "0 = %s\n", tst_strsig(0));
> >         fprintf(stderr, "SIGKILL = %s\n", tst_strsig(SIGKILL));
> >         fprintf(stderr, "SIGALRM = %s\n", tst_strsig(SIGALRM));
> >         return 0;
> > diff --git a/lib/tst_res.c b/lib/tst_res.c
> > index 7c66d2f6c..90403bc67 100644
> > --- a/lib/tst_res.c
> > +++ b/lib/tst_res.c
> > @@ -141,11 +141,14 @@ struct pair {
> >  #define PAIR(def) [def] = {.name = #def, .val = def},
> >  #define STRPAIR(key, value) [key] = {.name = value, .val = key},
> 
> > -#define PAIR_LOOKUP(pair_arr, idx) do {                       \
> > -       if (idx < 0 || (size_t)idx >= ARRAY_SIZE(pair_arr) || \
> > -           pair_arr[idx].name == NULL)                       \
> > -               return "???";                                 \
> > -       return pair_arr[idx].name;                            \
> > +#define PAIR_LOOKUP(pair_arr, idx) do {                                    \
> > +       static char par_str_buf__[16];                                     \
> > +       if (idx < 0 || (size_t)idx >= ARRAY_SIZE(pair_arr) ||              \
> > +           pair_arr[idx].name == NULL) {                                  \
> > +               snprintf(par_str_buf__, sizeof(par_str_buf__), "%i", idx); \
> > +               return par_str_buf__;                                      \
> > +       }                                                                  \
> > +       return pair_arr[idx].name;                                         \
> >  } while (0)
> 
> For this library change:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> This makes sense. Could you please for speedup merge this library change,
> so that Wei can base v6 on it?

Pushed, thanks for the review.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
