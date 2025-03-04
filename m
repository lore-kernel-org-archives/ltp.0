Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3966FC282D2
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 17:44:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67FF13CA08D
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 18:44:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E6AB3CA020
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 18:43:45 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 81DFF63AA73
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 18:43:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B2FD1F456;
 Tue,  4 Mar 2025 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741110224;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eB0kFmZ1ba8iiUIFBYCBKE7udjSI3kpPf37ki3Fbwcg=;
 b=xeNCDDs3HlYQ6d+5/EwiLmJJtvSCTsyMRXHwCailt4BuaEOCIhgIcc9znNsoIF9eUbY+JN
 zrulqkQJxqwO8R4CMhSTyVO7Bo1jymMYV9bRACvn7ZbR4xVr7HFIw06z2CuCnmkYKf9dB3
 lf7CcJOmuLFKpOW840NtnqaLmuJBWtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741110224;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eB0kFmZ1ba8iiUIFBYCBKE7udjSI3kpPf37ki3Fbwcg=;
 b=se7dNW2WMHrH4vZem2bva8uQZCU7wIvDcSelRa+vHK3MO7wOWGKqKywKUi0ibhBz65vbcH
 UzoU9BVFfoFjGGBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741110224;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eB0kFmZ1ba8iiUIFBYCBKE7udjSI3kpPf37ki3Fbwcg=;
 b=xeNCDDs3HlYQ6d+5/EwiLmJJtvSCTsyMRXHwCailt4BuaEOCIhgIcc9znNsoIF9eUbY+JN
 zrulqkQJxqwO8R4CMhSTyVO7Bo1jymMYV9bRACvn7ZbR4xVr7HFIw06z2CuCnmkYKf9dB3
 lf7CcJOmuLFKpOW840NtnqaLmuJBWtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741110224;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eB0kFmZ1ba8iiUIFBYCBKE7udjSI3kpPf37ki3Fbwcg=;
 b=se7dNW2WMHrH4vZem2bva8uQZCU7wIvDcSelRa+vHK3MO7wOWGKqKywKUi0ibhBz65vbcH
 UzoU9BVFfoFjGGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF99213967;
 Tue,  4 Mar 2025 17:43:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CtpuNc87x2dccAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 04 Mar 2025 17:43:43 +0000
Date: Tue, 4 Mar 2025 18:43:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250304174342.GA97130@pevik>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
 <20250304115331.524842-2-zohar@linux.ibm.com>
 <20250304133101.GC81126@pevik>
 <678478de87319625e591e8e956a57b31c700bbd2.camel@linux.ibm.com>
 <54cf5311ec5e0debd6dfd63669e8d01883c0ba23.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54cf5311ec5e0debd6dfd63669e8d01883c0ba23.camel@linux.ibm.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] ima_violations.sh: Update validate() to
 support multiple violations
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, 2025-03-04 at 09:44 -0500, Mimi Zohar wrote:
> > On Tue, 2025-03-04 at 14:31 +0100, Petr Vorel wrote:
> > > Hi Mimi,

> > > > Add support for the number of expected violations.  Include the
> > > > expected number of violations in the output.

> > > Unfortunately this works only on fixed kernel (e.g. the one with v1 of your
> > > "ima: limit both open-writers and ToMToU violations" kernel patchset [1]
> > > (I haven't built v2 [2], but it's really just
> > > s/IMA_LIMIT_VIOLATIONS/IMA_EMITTED_OPENWRITERS/ => it will work)

> > > Testing on any other kernel it fails on first testing after reboot:

> > Hi Petr,

> > I only tested by specifying the "ima_policy=tcb" on the boot command line.  This
> > failure happens when loading the test specific policy rules.  If setup() is
> > called before loading the test specific policy rules, forcing the $LOG file
> > violation at setup() would be too early.

> Sorry, that doesn't seem to be the case.

> With the changes to validate(), even the original tests will only work on a new
> kernel.  I'll rework the patch set, so at least the original tests will continue
> to work.

+1, thank you!

Kind regards,
Petr

> Mimi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
