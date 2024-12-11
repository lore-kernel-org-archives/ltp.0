Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7809EE7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 19:49:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C37823E9BD3
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 20:49:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1450D3E8A19
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 20:48:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 14727142580C
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 20:48:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2B2CB1F38D;
 Wed, 11 Dec 2024 19:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733946524;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0fOS5FQnchX46ZLxJOMD+J4hxGukjoz1kSqwjBh0yOo=;
 b=VFhr7b21tA8H1Qe49VcAoQqTQL/Sl9s5NF7XmFObhTo6rClK7rfuB+BjquNnzIXCdWdZ/r
 UFF/Ux3LGAS9GSWAawoshwOr2hx/mZ+9JMVEDAWiGq/DQ7uUQFQeZGONvFqDRDiTfwExqe
 6CQgSAsqTZrpPAemQszq9eIk8+RX88k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733946524;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0fOS5FQnchX46ZLxJOMD+J4hxGukjoz1kSqwjBh0yOo=;
 b=g96QiO/i23+2y677l9vCbT6rdtE0QaXK60DWRtqYs8ZX8UaNbCCpLEd+JSjURYdnfE1hHd
 Y1lY5YfPoW29HhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733946524;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0fOS5FQnchX46ZLxJOMD+J4hxGukjoz1kSqwjBh0yOo=;
 b=VFhr7b21tA8H1Qe49VcAoQqTQL/Sl9s5NF7XmFObhTo6rClK7rfuB+BjquNnzIXCdWdZ/r
 UFF/Ux3LGAS9GSWAawoshwOr2hx/mZ+9JMVEDAWiGq/DQ7uUQFQeZGONvFqDRDiTfwExqe
 6CQgSAsqTZrpPAemQszq9eIk8+RX88k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733946524;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0fOS5FQnchX46ZLxJOMD+J4hxGukjoz1kSqwjBh0yOo=;
 b=g96QiO/i23+2y677l9vCbT6rdtE0QaXK60DWRtqYs8ZX8UaNbCCpLEd+JSjURYdnfE1hHd
 Y1lY5YfPoW29HhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19C0F1344A;
 Wed, 11 Dec 2024 19:48:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I+AlA5vsWWd3EwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Dec 2024 19:48:43 +0000
Date: Wed, 11 Dec 2024 20:48:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20241211194836.GE443680@pevik>
References: <20241126173830.98960-1-pvorel@suse.cz>
 <20241126173830.98960-3-pvorel@suse.cz>
 <710315f59b9378d76d226e209fee698f6bc11c06.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <710315f59b9378d76d226e209fee698f6bc11c06.camel@linux.ibm.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] ima_setup.sh: Allow to load predefined policy
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
Cc: linux-integrity@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi, all,

> On Tue, 2024-11-26 at 18:38 +0100, Petr Vorel wrote:
> > environment variable LTP_IMA_LOAD_POLICY=1 tries to load example policy
> > if available. This should be used only if tooling running LTP tests
> > allows to reboot afterwards (because policy may be writable only once,
> > e.g. missing CONFIG_IMA_WRITE_POLICY=y, or policies can influence each
> > other).

> Thanks, Petr.  Allowing the policy to be updated only if permitted is a good
> idea.  Even with the LTP_IMA_LOAD_POLICY=1 environment variable, the policy
> might not be loaded.  For example, when secure boot is enabled and the kernel is
> configured with CONFIG_IMA_ARCH_POLICY enabled, an "appraise func=POLICY_CHECK
> appraise_type=imasig" rule is loaded, requiring the IMA policy itself to be
> signed.

Yes, it's an attempt, which can fail for various reasons. I'll add this example
of failure to load the policy to the commit message and to the docs.

I'd like to detect if policy got updated to avoid wasting time with SUT reboot
when policy was not updated. But this probably will not be always possible
(e.g. (CONFIG_IMA_READ_POLICY not set).

> On failure to load a policy, the ima_conditionals.sh and ima_policy.sh tests say
> "TINFO: SELinux enabled in enforcing mode, this may affect test results".  We
> should stop blaming SELinux. :)

This info was added for LTP shell tests, which got often affected by
SELinux/Apparmor. Because IMA is written in LTP shell API it gets this.
Error message is printed on TBROK, TFAIL, TWARN. Is this the only part where you
would like to avoid the message? Or do you want to remove SELinux/Apparmor
warning from all IMA tests?

Kind regards,
Petr

> thanks,

> Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
