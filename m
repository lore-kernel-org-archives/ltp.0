Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E00D358F7
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 11:15:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F13843CC032
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 12:15:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7C813C6EEF
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 12:15:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 721D5600803
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 12:15:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D757634069;
 Thu, 29 Jan 2026 11:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769685331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gQcjpl6vAm5RR+LkW8MEe241tLLaLZ0uh+zV60JWBlY=;
 b=JqHhv6dAz+T9nN38EBTPgBK20+nrtO7JS2vJVsiE68cX5ElHMPWkjVua9KaChxB+V/Y1Da
 25P6NEMZE8bRPcuLAjvP39drAMWm1emOXN9aSrwtVUaIIgMidCyvOuNt7QCMR/NkUoSl54
 rjEk21c7jJu0v6HBSQrybxn307Vlhro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769685331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gQcjpl6vAm5RR+LkW8MEe241tLLaLZ0uh+zV60JWBlY=;
 b=GzqXdKQ2fi56q0F5nMY8yopu9oIdUx8PeKkP61WtSHO7CZj8GSDQQb6HOKJk9JKEba8wUw
 Hopt6W2WX0JgrMDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769685330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gQcjpl6vAm5RR+LkW8MEe241tLLaLZ0uh+zV60JWBlY=;
 b=FOzaVbDb2mXdZUpzQYICBFL0nks2QRgPi3nU4uNgfzdmn1Ee4H2U2ZsY6WaMmhw2i8yM5i
 Ec0MCwzHw5p403DHkZLjyEBdA2QReAuTBd73wW02MPNa3m8HOexsuNOLO+08XxVJ+/xqD+
 fr4+kAXLamOKyZE3zJRnd3JUN53qTTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769685330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gQcjpl6vAm5RR+LkW8MEe241tLLaLZ0uh+zV60JWBlY=;
 b=90IuLLy/bXEKznPEVyQVOF4uah8leFl50z63no3r6IXbkUujB+lcANrF2MQkNOiKGxKJgg
 /+BloJzeS61l4xDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E0AD3EA61;
 Thu, 29 Jan 2026 11:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uHVgNVFBe2lcFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 29 Jan 2026 11:15:29 +0000
Date: Thu, 29 Jan 2026 12:15:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20260129111523.GA94367@pevik>
References: <20260122150652.227342-1-kushalkataria5@gmail.com>
 <20260128210346.GA58669@pevik>
 <346f81fd-4ed7-43ea-8dd9-9326c10e0c2b@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <346f81fd-4ed7-43ea-8dd9-9326c10e0c2b@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] kvm: Add needs_driver support to check for kvm
 driver
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
Cc: Kushal Chand K <kushalkataria5@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 1/28/26 22:03, Petr Vorel wrote:
> > Hi all,

> > @Martin Is it enough to have kvm driver? Or do tests depend on any of specific
> > kvm kernel config options (not only from virt/kvm/Kconfig, but arch dependent
> > configs e.g.  CONFIG_KVM_GUEST=y from arch/x86/Kconfig ?)

> Some KVM tests can be run by unprivileged user so those also need a check
> whether they have permission to open /dev/kvm for writing. But that can be
> fixed in a separate patch. Let's merge this one with the commit message fix.

+1, thank you!

Merged and I noted this TODO
https://github.com/linux-test-project/ltp/issues/1219#issuecomment-3817000775

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
