Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E78C282EC
	for <ltp@archiver.kernel.org>; Mon, 17 Mar 2025 12:24:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71D123CAB50
	for <ltp@archiver.kernel.org>; Mon, 17 Mar 2025 13:24:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94FA83C9C9C
 for <ltp@lists.linux.it>; Mon, 17 Mar 2025 13:24:00 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 48EA160070E
 for <ltp@lists.linux.it>; Mon, 17 Mar 2025 13:23:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 186BA1F792;
 Mon, 17 Mar 2025 12:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742214238;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGv207B7bA7R/6gzDSEGPZyFew2f8K8axMfFSzyEmJw=;
 b=c/nG9+WNjsx1pefGtkVvunNsG/xGzpVaV6k5WknQgfIZFsYtN95dTa3RJZ04Viu7/2/3EU
 SD5LKRkw6WI9/oMCTEeHX/nqO2v9aDaWdPIlloVokh6tPs5lHlguHM4fgyvhtoD0wMgFxd
 4JvHwQo9LpDTRd4V7HMW/VK5dPIC788=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742214238;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGv207B7bA7R/6gzDSEGPZyFew2f8K8axMfFSzyEmJw=;
 b=TtZAEB/lb5RMy7b5R3zTO9eIIggOVYgYAzFz8b0UVyIHskGcjFnxJ17e1DTclIeVr/+b4A
 IE2x90DeeaN238CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742214237;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGv207B7bA7R/6gzDSEGPZyFew2f8K8axMfFSzyEmJw=;
 b=xXZc7z6Sn7FZnxlLrTMFATu9dyBkijo7qrjXPb+V6KEnC+/byy5ol/AK0NC4eqAepvt3of
 o5i9e0jNvt86tkH1TrzfCFFrTY6wb5mjBkPi91hkUPoEpRzEFARB3h4feiaz/lrPIiR3IA
 lEjSoBJIad5lk63NbPep8OcX5lhfP9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742214237;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGv207B7bA7R/6gzDSEGPZyFew2f8K8axMfFSzyEmJw=;
 b=jHio1ToV90ed20U1gheVPIAJiwEEsVIADRH/l0MebI0qcwVsRBn9uKUBlW5JLxZRNNPDXM
 rJw1kTfLsrg3BeAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC114132CF;
 Mon, 17 Mar 2025 12:23:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P0FDOFwU2GckRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Mar 2025 12:23:56 +0000
Date: Mon, 17 Mar 2025 13:23:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20250317122351.GA247824@pevik>
References: <d1d830051aea3f077995c30b2183731cd2f04cf2.1742054500.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d1d830051aea3f077995c30b2183731cd2f04cf2.1742054500.git.jstancek@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tracing/pt_test: TCONF if Intel PT across VMXON
 is not supported
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

Hi Jan,

> As noted in 1c5ac21a0e9b ("perf/x86/intel/pt: Don't die on VMXON"),
> some Broadwell systems don't support Intel PT across VMXON.
+1

> If the test fails to find any events, check whether there is a
> kvm_intel module loaded, and if so check for IA32_VMX_MISC[bit 14].
> If this bit is 0, it's not supported. From commit mentioned above:
>     Intel SDM, 36.5 "Tracing post-VMXON" says that
>     "IA32_VMX_MISC[bit 14]" being 1 means PT can trace
>     post-VMXON.

LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
>  static void intel_pt_trace_check(void)
>  {
>  	uint64_t aux_head = 0;
> @@ -117,6 +150,12 @@ static void intel_pt_trace_check(void)
>  	pmp = (struct perf_event_mmap_page *)bufm[0];
>  	aux_head = *(volatile uint64_t *)&pmp->aux_head;
>  	if (aux_head == 0) {
> +		if ((access("/sys/module/kvm_intel", F_OK) == 0)
> +			&& (!is_supported_across_vmxon())) {
> +			tst_brk(TCONF, "Intel PT on this system can not"
> +				" run at the same time as virtualization");

As we discussed at the issue, please join the string before merge.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
