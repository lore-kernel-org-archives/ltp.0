Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DF5C88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 13:27:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D0A63E7702
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 15:27:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D65C3E69D6
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 15:27:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7BA6260087A
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 15:27:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C404D1FD86;
 Wed, 16 Sep 2026 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789565220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4FXNUo7zt4dOjTn9gjSYmESDxs5zJe0B4vJpjrNQwTs=;
 b=tgLw84ssG4rvj/psIPZiaD2PZS7wgvkpOmmqtzEefsMmhr+GDqlqtlCVwV6pvMk3pLiYHA
 ekRL5dYGH05cNT+SVqxIaXoew20ezvui4pHAizUtfRVviRza4uKasG0B4jUqKr2u8i+63P
 5PLa99gGAgImniq6eBUtUhZ6UuTEa8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789565220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4FXNUo7zt4dOjTn9gjSYmESDxs5zJe0B4vJpjrNQwTs=;
 b=1yktaDiyRkIj1CaVag2qwCG7Mi8Wlw/JS6dEia7prN+/7IUew0BvjtUbAJFsnqlMNqbW2v
 CmeoN5SYd+m0q0DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="t//LHDAP";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hLgNNXUf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789565215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4FXNUo7zt4dOjTn9gjSYmESDxs5zJe0B4vJpjrNQwTs=;
 b=t//LHDAPCBIGmD6Vs2/EaPvgYaokoP32GURYPMRu6tT3qkUn/Ppz8CB07gsBhIFVORjJPE
 Nh2t3Vu3eiYE8VRe2VmcXMhu0cFs/lNyxmAvV962EZDOYqLSHN2sf7iivB91rcozpFbWGz
 yV4nttwaADcLkCD9/mqR54iYpMw06Wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789565215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4FXNUo7zt4dOjTn9gjSYmESDxs5zJe0B4vJpjrNQwTs=;
 b=hLgNNXUfbJ+vLGx12D/1pBOxP6l3B0u6meLRS6VTq0Sr3ilqC/fPv7JXG+E05t3mrX9/EY
 fmpOCOgvBVNoJYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9F5F1374A;
 Wed, 16 Sep 2026 13:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1ws8HB6ZqmpYHQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 13:26:54 +0000
Date: Wed, 16 Sep 2026 15:26:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260916132644.GA1749034@pevik>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-15-43b78b15ef9f@suse.com>
 <aqP1cvo1QzWvwDVf@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aqP1cvo1QzWvwDVf@yuki.lan>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C404D1FD86
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 15/33] keyctl23: Test KEYCTL_RESTRICT_KEYRING
 builtin_trusted
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

Hi Cyril,

...
> > +	if (TST_RET == 0)
> > +		tst_res(TPASS, "KEYCTL_RESTRICT_KEYRING builtin_trusted passed");
> > +	else if (TST_RET == -1 && TST_ERR == EEXIST)
> > +		tst_res(TPASS, "KEYCTL_RESTRICT_KEYRING builtin_trusted already active");
> > +	else
> > +		tst_res(TFAIL | TTERRNO, "KEYCTL_RESTRICT_KEYRING builtin_trusted failed");
> > +
> > +	TST_EXP_FAIL(keyctl(KEYCTL_LINK, user_key, ring_builtin, 0, 0),
> > +		     EOPNOTSUPP,
> > +		     "KEYCTL_LINK of non-asymmetric key on builtin_trusted restricted keyring");

> Hmm, we have this pattern in the tests more than once. The second
> iteration is a test on it's own.

> One easy solution to this is to run the test with two iterations in the
> default run. I have a patch that adds the -i default value to the
> tst_test structure I proposed for the runtest generator, if we wire that
> in we can just set .iterations = 2 in the tst_test struct and be done
> with it:

> Subject: [PATCH 08/13] lib: tst_test: Move the iterations to struct tst_test
...

+1, I'll add it to the v3 patchset.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
