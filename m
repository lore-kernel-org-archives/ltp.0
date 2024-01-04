Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C057C47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 12:27:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C1FB3CE729
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 13:27:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7079E3CBDFB
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:26:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 60C991A00932
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:26:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 724941F807;
 Thu,  4 Jan 2024 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704371209;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jyu+CVxkhKp2jGkWeTChBdcksoesKYQys6qwIcfD+x8=;
 b=r+ejqQIRkUryLSRRW0y+vD3KQA70hsiV8DHmKGxt94zA+PCLF6o/EZKsXHPdlLoL4eixGb
 Hv96eJVgSaQR5ZGmRskZ4Qp9hQAwi2GDCHDDXnkX8PvgiXij3tafpuuh/Hh8FEUyON2hm2
 PQszBCTBW8saNdRcKFN4F/6Up+BygMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704371209;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jyu+CVxkhKp2jGkWeTChBdcksoesKYQys6qwIcfD+x8=;
 b=gLAbaLOpOvRf8Ia4CkFeZP50KUeSm2v8xif0z3M+53V7pb5PNWuzdyxJhMgPoUouWuS7oH
 SxzEZz5P/etvETDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704371209;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jyu+CVxkhKp2jGkWeTChBdcksoesKYQys6qwIcfD+x8=;
 b=r+ejqQIRkUryLSRRW0y+vD3KQA70hsiV8DHmKGxt94zA+PCLF6o/EZKsXHPdlLoL4eixGb
 Hv96eJVgSaQR5ZGmRskZ4Qp9hQAwi2GDCHDDXnkX8PvgiXij3tafpuuh/Hh8FEUyON2hm2
 PQszBCTBW8saNdRcKFN4F/6Up+BygMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704371209;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jyu+CVxkhKp2jGkWeTChBdcksoesKYQys6qwIcfD+x8=;
 b=gLAbaLOpOvRf8Ia4CkFeZP50KUeSm2v8xif0z3M+53V7pb5PNWuzdyxJhMgPoUouWuS7oH
 SxzEZz5P/etvETDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17F7C137E8;
 Thu,  4 Jan 2024 12:26:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rrRnAwmklmXFFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 12:26:49 +0000
Date: Thu, 4 Jan 2024 13:26:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240104122647.GB1146860@pevik>
References: <ZZQHPkwg-W2R1ejJ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZQHPkwg-W2R1ejJ@yuki>
X-Spamd-Result: default: False [0.62 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.08)[63.30%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, all,

> If you have any patches that should be reviewed before the release,
> please let me know.

Could anybody have look on:

* swapon01: Test on all filesystems
https://patchwork.ozlabs.org/project/ltp/list/?series=377167&state=*
https://lore.kernel.org/ltp/20231011162428.583911-1-pvorel@suse.cz/
(already reviewed by Marius)

* v2 net: tst_netload_compare(): Ignore performance failures
https://lore.kernel.org/ltp/20240104121001.1155491-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20240104121001.1155491-1-pvorel@suse.cz/

* Cleanup environment variables prefixes (TST_ => LTP_)
https://lore.kernel.org/ltp/20240104122308.1158487-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/list/?series=388855&state=*

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
