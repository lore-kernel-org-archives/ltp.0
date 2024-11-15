Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0D2D68BCF
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 18:58:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B2A03D7906
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 19:58:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B5903D78CA
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 19:58:30 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9F63F1BBFB2D
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 19:58:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DFA7B1F445;
 Fri, 15 Nov 2024 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731697108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KW56ssqdM2w5ZD0aqxZ9kfo+jJJKYD0HrOHpeXQQV/o=;
 b=psLbdEZFwdClYU9kCZmLwaTNgbj+pov8vL5CUTxqh+U+71dx81AyQs2cSVjlQff06PMKve
 Y1FCeT/pt62GIsiG2eDI/6KeyARMItA2HvpjuxuQSMevXd/9yakFVB0FyrjajO0SjtSQQg
 5YmAbNyV/zKM6SSVTwMALY1OK3TrOk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731697108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KW56ssqdM2w5ZD0aqxZ9kfo+jJJKYD0HrOHpeXQQV/o=;
 b=wlKPgTMofP0WY75afgopiTLDuZvOkpNF4PndZcThieJrjR0IWDVVGfAF+Ie4cKlPT10ELQ
 qNVFITXOE1o83BDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731697107;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KW56ssqdM2w5ZD0aqxZ9kfo+jJJKYD0HrOHpeXQQV/o=;
 b=iHmEMcLeTHz5lPplwd3eT6kqrcAqZyOBrPnnwotAENhoWrXcT1dXweEfIg+NCHlP4mXIf+
 FPddQZ9VCbQINAj+ZmAIycA59jTv1F00q/ZQFEPm8AeMz0ffv0K4qnZBs/lHJ2z97G5qfo
 0GQH28lyBUGuPmnGQkYgSqsimk79FSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731697107;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KW56ssqdM2w5ZD0aqxZ9kfo+jJJKYD0HrOHpeXQQV/o=;
 b=wSC/X5JtYP7pMbsd8UHM0uY2AuVGIQlcKxv2HZRYRAnVBH2BhQNOmc7ZRGvXtUANjawi87
 C02WBX2YWUaUR4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9534134B8;
 Fri, 15 Nov 2024 18:58:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rTpcK9OZN2eheQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 Nov 2024 18:58:27 +0000
Date: Fri, 15 Nov 2024 19:58:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20241115185819.GA1754587@pevik>
References: <20241115154434.39461-1-mdoucha@suse.cz>
 <f92ebef0-5861-4a7c-8503-b4edbc18d7d7@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f92ebef0-5861-4a7c-8503-b4edbc18d7d7@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Revert "pkey01: Adding test for
 PKEY_DISABLE_EXECUTE"
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

Hi Li, Martin,

> Sorry, I forgot to CC Li in the patch.

> On 15. 11. 24 16:44, Martin Doucha wrote:
> > This reverts commit d2b8a476c29d52c484b387454082bbc906b0b4f8.

> > Remove the PKEY_DISABLE_EXECUTE subtest. The function_size() code
> > is broken in a way that I cannot easily fix. The function tries
> > to calculate the size of a function by finding the first RET
> > instruction. However, in 32bit LTP builds, the code gets compiled
> > to this:

> > 0804b690 <function_size>:
> >   804b690:       8b 4c 24 04             mov    0x4(%esp),%ecx
> >   804b694:       0f b6 01                movzbl (%ecx),%eax
> >   804b697:       83 c0 3e                add    $0x3e,%eax
> >   804b69a:       3c 01                   cmp    $0x1,%al
> >   804b69c:       76 1a                   jbe    804b6b8 <function_size+0x28>
> >   804b69e:       89 c8                   mov    %ecx,%eax
> >   804b6a0:       83 c0 01                add    $0x1,%eax
> >   804b6a3:       0f b6 10                movzbl (%eax),%edx
> >   804b6a6:       83 c2 3e                add    $0x3e,%edx
> >   804b6a9:       80 fa 01                cmp    $0x1,%dl
> >   804b6ac:       77 f2                   ja     804b6a0 <function_size+0x10>
> >   804b6ae:       29 c8                   sub    %ecx,%eax
> >   804b6b0:       83 c0 10                add    $0x10,%eax
> >   804b6b3:       c3                      ret
> >   804b6b4:       8d 74 26 00             lea    0x0(%esi,%eiz,1),%esi
> >   804b6b8:       b8 10 00 00 00          mov    $0x10,%eax
> >   804b6bd:       c3                      ret
> >   804b6be:       66 90                   xchg   %ax,%ax

> > If you look closely enough, you'll notice a C2 byte in add $0x3e,%edx
> > instruction on address 804b6a6. The function will assume this byte is
> > a RET instruction, return a size that's 22 bytes too short and then
> > the code execution inside the executable buffer will run past the end
> > of buffer, resulting in a segfault.

Martin, thanks a lot for debugging!

Acked-by: Petr Vorel <pvorel@suse.cz>

Other option would be to disable this test only for 32bit (keep it for 64bit).
Li, any change you could have look into it?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
