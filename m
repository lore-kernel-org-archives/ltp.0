Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6423AC2BD09
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 12:31:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF4AC3D0F87
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 14:31:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90AC43CD84E
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 14:31:37 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C9F421400196
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 14:31:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB86421A68;
 Mon, 24 Jun 2024 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719232295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1keOtDKRdp06YlsB+b1qYeFGxAQDRqIqDXH4EUB4xik=;
 b=EdVNdUk+uLInojMRq6qnekot0+/kaO7F1AdxqUG+LCxI9oq14mufoZH/jJ3fDffkKz7mlC
 impwPQrXu6i9jsy0FozJgZHyvYN2falDfn0wu9XAy2Y3y9tud6VnHp71Q9LG4n4K/7JZx6
 15xbULQ9ZZS+5RbIAy9eRX5REPDVVNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719232295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1keOtDKRdp06YlsB+b1qYeFGxAQDRqIqDXH4EUB4xik=;
 b=NgT7CiuHmUnKHkhBSFZi7wm5YDWGcOyrbdcFZQMjIDD8JvFY6l0w+WV/6b+WQ+q41GkQmp
 aT7MnAp8Vv6QASCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719232294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1keOtDKRdp06YlsB+b1qYeFGxAQDRqIqDXH4EUB4xik=;
 b=HyE3BAZY0jSfgWGAZArHUlkqE4hGZgiQZt2AKsxrzD+dmpn1jqvyw02TgAkcp10kvKkgts
 gOclCn+Q17yGgWz+XTXhKzW3S7C3aFEIY8WW5YcHleE8s6L2doqe+21TKag6RtWAfAMzLw
 LLKBcLIFcj1A4ksUasi3Y71T+juglYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719232294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1keOtDKRdp06YlsB+b1qYeFGxAQDRqIqDXH4EUB4xik=;
 b=lVkqsT8nELQQ9NpWh5D2MPRdQFWgMRC5MFjytiiMs1AsYK2SIgoPelVybf5ebnAHf9jsZW
 8bp6+zrOY76rApCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BE571384C;
 Mon, 24 Jun 2024 12:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A8XsJCZneWZrYgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 24 Jun 2024 12:31:34 +0000
Date: Mon, 24 Jun 2024 14:31:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZnlnHOGlHDOyhImb@yuki>
References: <20240419110230.191809-1-pvorel@suse.cz>
 <CAEemH2eZNO=P5c_igqNKSva-q37y7GSK=d44wUHd=Ua=DTUNDw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eZNO=P5c_igqNKSva-q37y7GSK=d44wUHd=Ua=DTUNDw@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] libs: Remove 'libltp' prefix from libs source
 directories
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
> > I know renaming files is not optimal. But history will be kept, when
> > browsing with gitk or git gui.
> >
> > Improvement: less typing when cd to the directory.
> >

I do not have a strong opinion on this, feel free to push the change
with my:

Acked-by: Cyril Hrubis <chrubis@suse.cz>

> +1 I agree with this, and I always have a question, why
> we have additional libs/ parallel with lib/, is there any root
> difference between them? or just a historical issue?

The idea is exactly how it was described by Peter, these are usually
libraries used only by a few tests e.g. functions to deal with swap or
linux input, while lib/ has functions that are used by most of
the tests with more generic functionalities.

Apart from small speedup it makes things a bit easier to navigate, at
least I think so. Or do you think that this would be better with all the
files in a single directory?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
