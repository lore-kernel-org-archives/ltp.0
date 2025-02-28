Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3F0C19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 11:37:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFBC73C9DDB
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 12:37:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF5B23C2B1B
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 12:37:31 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3D9D71BDC5AA
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 12:37:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EFB2921167;
 Fri, 28 Feb 2025 11:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740742650;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7xEwD9+hx3IHA4J094pHQbwdiM5blf3jvTcWVd6NZ0=;
 b=VPeJhCimn4L5ULO6vw5CMGAJPgCgXif2XibvxHM7Rn8EFQ4wnNAHCvQXqXvpNoZMMjTm55
 +Zm3Yc90Vjf3WjE81TRpIJvgkQDS0c0kLLKbBP+ePr4lrlz23tUyJWRR4C4AiUVcZtTKB6
 /idUdHBkaQoPPxNg+OlEEk69pfSn8Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740742650;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7xEwD9+hx3IHA4J094pHQbwdiM5blf3jvTcWVd6NZ0=;
 b=20Z1Ro4IZUsCj51nqR8rmE2k40HZZEie0L56nc5ru5cGbrmwheZvuXfHV/Ds3xsLift5Z8
 2AXmE0NymnIdPXBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ff6MtxGT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HbHXvYg2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740742649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7xEwD9+hx3IHA4J094pHQbwdiM5blf3jvTcWVd6NZ0=;
 b=ff6MtxGTD3k1029LUgqX0hyx/XhWEJGS7FVXlMU+yLRPP15GN40H1o8ogznHeAutwatkfZ
 5d82LDCFUErjnl4GhyH4b6ux7wTcO8xmpLBxny1FlKPK98C4zpZKell3EB6HM2Mo0ypelZ
 heNgRNlIvnLs1NeCikzwQN/5FDwhohs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740742649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7xEwD9+hx3IHA4J094pHQbwdiM5blf3jvTcWVd6NZ0=;
 b=HbHXvYg2fuHaBwQp2ue+WcHnndZUpKPooW3RFmtjpVz/lL4OeGgFqyeCTt7esq9hmvCjs9
 MFvwQbInlr6ez1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 049D71344A;
 Fri, 28 Feb 2025 11:37:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id stMgO/ifwWeweQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Feb 2025 11:37:28 +0000
Date: Fri, 28 Feb 2025 12:37:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwan@redhat.com>
Message-ID: <20250228113723.GA3222454@pevik>
References: <31878632-52fe-4aed-8018-8e30ebeae52d@suse.com>
 <20250224030743.1567840-1-chwen@redhat.com>
 <CAAA2g-1m5Hfq9nygiCnFFwt6Axgxjj3dO=2Ei_-cgSw3dT60Bg@mail.gmail.com>
 <CAEemH2cpdqSViHfDcRfFqsWtz4kkrkhU4DymfXW+5REPEMvYTw@mail.gmail.com>
 <54cd690b-dd2a-4285-8d53-5aef05be3d6c@suse.com>
 <CAEemH2fPRiZOOY4UUfQQVLe6+8N8PtK3FON6pB=jpgbK_HQdfQ@mail.gmail.com>
 <CAEemH2e6XYnVwx3t+_Qn_pw5-RSnp1YRxLuEJ+EBFkF8ir3ybQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e6XYnVwx3t+_Qn_pw5-RSnp1YRxLuEJ+EBFkF8ir3ybQ@mail.gmail.com>
X-Rspamd-Queue-Id: EFB2921167
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add test case to cover the setting resource
 limit64 for process
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
Cc: Charles Shi <cheshi@redhat.com>, ltp@lists.linux.it,
 Irene Diez <idiez@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Li Wang <liwan@redhat.com> wrote:


> > P.s. the patch caused a compiling error on Alpine I haven't figured out
> > reason:).

> > https://github.com/linux-test-project/ltp/actions/runs/13580985467/job/37966850497


> Well, we have to enable _LARGEFILE64_SOURCE macro to tells glibc
> to expose 64-bit structures, see:

> $ cat /usr/include/bits/resource.h
> ...
> #ifdef __USE_LARGEFILE64
> struct rlimit64
>   {
>     /* The current (soft) limit.  */
>     rlim64_t rlim_cur;
>     /* The hard limit.  */
>     rlim64_t rlim_max;
>  };
> #endif
> ...

> Sent a patch to resolve it:
>   https://lists.linux.it/pipermail/ltp/2025-February/042497.html

FYI patch already merged.

Kind regards,
Petr

> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
