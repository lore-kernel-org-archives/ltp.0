Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEE6C27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 13:54:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB0D73D0EBC
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 15:54:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 409303CE037
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 15:54:02 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AE8A560672D
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 15:54:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A84F121AFE;
 Fri, 21 Jun 2024 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718978040;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aVijDtl6oHojZAWbqXoz3ibMEqM4X7SwnVqBfzU+mfg=;
 b=2RG62RXZc7JPwG/97ZF9aQf4DZIhTyc9G7C3uzwGNWdyoPZqI/UC0X+EI2VBFFRd3uZjkI
 ZiXAk5JOwKsPg9pWGVi9PisThvuSrzy59izVei+/cop5KaS+Bb13O4kBmfhOtwQ4nHxiXo
 i7bw0OfCtjUMiZDKd2n7MSR3+c+UP0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718978040;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aVijDtl6oHojZAWbqXoz3ibMEqM4X7SwnVqBfzU+mfg=;
 b=DM8/Xc5jPMKKIrKY5gW4t3D8CJnFE8SjJiBNrSNzM9ANUtyRFBXX6Rax7LkZNe2Q5EppIz
 5BJFvEuaL39PApDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2RG62RXZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="DM8/Xc5j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718978040;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aVijDtl6oHojZAWbqXoz3ibMEqM4X7SwnVqBfzU+mfg=;
 b=2RG62RXZc7JPwG/97ZF9aQf4DZIhTyc9G7C3uzwGNWdyoPZqI/UC0X+EI2VBFFRd3uZjkI
 ZiXAk5JOwKsPg9pWGVi9PisThvuSrzy59izVei+/cop5KaS+Bb13O4kBmfhOtwQ4nHxiXo
 i7bw0OfCtjUMiZDKd2n7MSR3+c+UP0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718978040;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aVijDtl6oHojZAWbqXoz3ibMEqM4X7SwnVqBfzU+mfg=;
 b=DM8/Xc5jPMKKIrKY5gW4t3D8CJnFE8SjJiBNrSNzM9ANUtyRFBXX6Rax7LkZNe2Q5EppIz
 5BJFvEuaL39PApDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7948313AAA;
 Fri, 21 Jun 2024 13:54:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uHbwG/iFdWaTHQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jun 2024 13:54:00 +0000
Date: Fri, 21 Jun 2024 15:53:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240621135358.GB694629@pevik>
References: <20240527222947.374475-1-pvorel@suse.cz>
 <37603272-8ea2-4828-96df-4b6381cc26ad@suse.com>
 <ZldFa-3CXXbVKmVW@yuki> <20240620053618.GD537887@pevik>
 <CAEemH2cnB0QAAz1CqZPdRWm5R8GP4sqqA9mw-owHkL1ASXTkMQ@mail.gmail.com>
 <CAEemH2dVaMfNPP2m8_nEb235=9Q5bo4H1WtQbpFgrcmyyVESfw@mail.gmail.com>
 <20240621133911.GA694629@pevik>
 <CAEemH2fi-7kF-RLCQvgyqJyTCNHCX-3DnxCn1+LFLk1-z09rUA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fi-7kF-RLCQvgyqJyTCNHCX-3DnxCn1+LFLk1-z09rUA@mail.gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A84F121AFE
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] lib: Add TINFO_WARN
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

Hi Li,

...
> Basically, the method works well, but contains a tiny issue that people
> sometimes need to print variable value in tst_res(, "val = %d", val),
> so it still needs refined code to resolve that.

> I will send out a full support patch after testing good on my side.
> (maybe tomorrow).
... and __VA_ARGS__

see include/tst_test_macros.h

#define TST_FMT_(FMT, _1, ...) FMT, ##__VA_ARGS__

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
