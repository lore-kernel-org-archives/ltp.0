Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00223CAC5B9
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 18:11:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 061B83CE2DC
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 20:11:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7053A3CE221
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 20:11:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DAD2610007B8
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 20:11:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2AAE93A26A;
 Mon, 29 Sep 2025 18:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759169481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xW7jwpAXoGiu+e3bEhq7Eqe429xPDTVl8gO/3UWmv94=;
 b=cxKFDaMEE62AundPjCSgAWmh1wJ6osBisDzkKZgr8RdddHOltlq40sp7Ukzf4Bu1HasQVV
 KzJAocyKQPO2qOYX8oJxz+RpJ3FrIMltEsujVrCVfHrsRvApyOBBNiQDtebV9o3vDxtaRv
 9AULIwRGxjqR1O/KCCXt0Ot4c0iPm6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759169481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xW7jwpAXoGiu+e3bEhq7Eqe429xPDTVl8gO/3UWmv94=;
 b=DlCTOv1GVnf8llNSfT4Jq3ciQ48gqr9spLA0hRCUusp+QGeU6st7EmQI5z4hTSHvpqTnnm
 ZE2k/fmojUKMSHAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cxKFDaME;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DlCTOv1G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759169481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xW7jwpAXoGiu+e3bEhq7Eqe429xPDTVl8gO/3UWmv94=;
 b=cxKFDaMEE62AundPjCSgAWmh1wJ6osBisDzkKZgr8RdddHOltlq40sp7Ukzf4Bu1HasQVV
 KzJAocyKQPO2qOYX8oJxz+RpJ3FrIMltEsujVrCVfHrsRvApyOBBNiQDtebV9o3vDxtaRv
 9AULIwRGxjqR1O/KCCXt0Ot4c0iPm6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759169481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xW7jwpAXoGiu+e3bEhq7Eqe429xPDTVl8gO/3UWmv94=;
 b=DlCTOv1GVnf8llNSfT4Jq3ciQ48gqr9spLA0hRCUusp+QGeU6st7EmQI5z4hTSHvpqTnnm
 ZE2k/fmojUKMSHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F62D13A21;
 Mon, 29 Sep 2025 18:11:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NagzCsjL2mhJdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Sep 2025 18:11:20 +0000
Date: Mon, 29 Sep 2025 20:11:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20250929181114.GA217041@pevik>
References: <20250929112950.24420-1-wegao@suse.com> <aNp1-2OnRNauyQ2e@yuki.lan>
 <c4c658bc-1a29-45de-972b-c6582e926db6@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c4c658bc-1a29-45de-972b-c6582e926db6@suse.cz>
X-Rspamd-Queue-Id: 2AAE93A26A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mount08.c: Add min_kver for test case
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

Hi all,

> On 9/29/25 14:05, Cyril Hrubis wrote:
> > Hi!
> > Again, there has to be explanation here why this is needed...

> > But given that this is a regression test for a security hardening that
> > was added into 6.12 it's okay if the test fails on older kernel,
> > moreover hiding the failure may make the system more vunerable.

> Hi,
> I agree with rejecting this patch. If a kernel is not patched, the test
> should fail regardless of kernel version.

For a record, d80b065bb172 is a merge commit, the fix contains actually 7
commits. IMHO none of them has been backported to any stable / LTS kernel.  I'll
ask Christian and Greg if it makes sense to backport it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
