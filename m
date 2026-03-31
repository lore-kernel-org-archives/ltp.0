Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40C8FF60EF
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 09:31:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6669F3E2F7B
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 11:31:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45BFC3CCB89
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 11:31:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 823826008C2
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 11:31:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E2C694D271;
 Tue, 31 Mar 2026 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774949471;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3WsJA8+bTKmb5eksX8qbdN42atnD4D/wBQqlX95Fk+4=;
 b=XFn+thVEgJU7UtXtQplw52qt4knYIlr0NFlPqMy4b2/9MPu+rqiEmi28gGL4oRluqjr0nJ
 +M2ot3/PpqKVnlFWpg0NKmUcUVuqNvepOhArhnrh0k94FCtC4rSLX/P7F5EEgY7+AFmzy6
 jJG/STcgPeK7MIyZQDj9qqFJQ7cB6Ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774949471;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3WsJA8+bTKmb5eksX8qbdN42atnD4D/wBQqlX95Fk+4=;
 b=um2z5NGpKLC4EpC72hTP314uIEhN0jKclHLJSL3NyGjTYHbrahF/Yp8Xbz7g892G3jGcJ5
 +n2eOU8F+ihutEBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774949471;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3WsJA8+bTKmb5eksX8qbdN42atnD4D/wBQqlX95Fk+4=;
 b=XFn+thVEgJU7UtXtQplw52qt4knYIlr0NFlPqMy4b2/9MPu+rqiEmi28gGL4oRluqjr0nJ
 +M2ot3/PpqKVnlFWpg0NKmUcUVuqNvepOhArhnrh0k94FCtC4rSLX/P7F5EEgY7+AFmzy6
 jJG/STcgPeK7MIyZQDj9qqFJQ7cB6Ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774949471;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3WsJA8+bTKmb5eksX8qbdN42atnD4D/wBQqlX95Fk+4=;
 b=um2z5NGpKLC4EpC72hTP314uIEhN0jKclHLJSL3NyGjTYHbrahF/Yp8Xbz7g892G3jGcJ5
 +n2eOU8F+ihutEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B85524A0A2;
 Tue, 31 Mar 2026 09:31:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ryM+K1+Uy2lHXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 31 Mar 2026 09:31:11 +0000
Date: Tue, 31 Mar 2026 11:31:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20260331093110.GA37783@pevik>
References: <20260331072051.GA5254@pevik>
 <CAASaF6xPzR3KWCd=aUTPWVgzfyi1SkftgQ8HG_kvphY2fWMe_g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xPzR3KWCd=aUTPWVgzfyi1SkftgQ8HG_kvphY2fWMe_g@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] linux-git: using whole sha1 hash
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUdWUsIE1hciAzMSwgMjAyNiBhdCA5OjIx4oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIGFsbCwKCj4gPiBhbnl0aGluZyBhZ2FpbnN0IHN0YXJ0aW5n
IHRvIHVzZSB3aG9sZSBzaGExIGhhc2ggaW4gbGludXgtZ2l0IHRhZz8gaS5lLiA0MCBjaGFycy4K
PiA+IEl0IGNhbiBiZSBzaG9ydGVuIGJ5IHRoZSBkb2MvY29uZi5weSBzY3JpcHQgKHVzZSB3aG9s
ZSBoYXNoIGZvciBVUkwsIGJ1dCBzaG9ydGVuCj4gPiB0aGUgdmlzaWJsZSBwYXJ0IG9mIDxhPiB0
YWcpLgoKPiBJbiBtZXRkYXRhLCBjb21taXQgbWVzc2FnZXMgb3IgZXZlcnl3aGVyZT8KCkluIG1l
dGFkYXRhLgoKSW5zdGVhZCBvZjoKCS50YWdzID0gKGNvbnN0IHN0cnVjdCB0c3RfdGFnW10pIHsK
CQl7ImxpbnV4LWdpdCIsICIwOTFkMGQ1NWIyODYifSwKCQkuLi4KCkhhdmU6CgkudGFncyA9IChj
b25zdCBzdHJ1Y3QgdHN0X3RhZ1tdKSB7CgkJeyJsaW51eC1naXQiLCAiMDkxZDBkNTViMjg2Yzkz
NDAyMDFiNGVkNDQ3MGJlODdmYzU2ODIyOCJ9LAoKS2luZCByZWdhcmRzLApQZXRyCgo+ID4gV2Ug
bm9ybWFsbHkgdXNlIG9ubHkgMTIgY2hhcnMgMDkxZDBkNTViMjg2LCBidXQgc29tZSB1c2VycyBk
dXJpbmcgcmV3cml0ZSB1c2VkCj4gPiBbMV0gcmVhbGx5IHNtYWxsIGhhc2ggKDcgY2hhcnMpIGZy
b20gb3JpZ2luYWwgdGVzdC4KCj4gPiBLaW5kIHJlZ2FyZHMsCj4gPiBQZXRyCgo+ID4gWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI2MDMzMTAxNTUzOC41MzMyNi0xLWx1ZmVpQHVu
aW9udGVjaC5jb20vCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
