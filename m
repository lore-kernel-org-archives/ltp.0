Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59047CA0ED3
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 04:47:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B54B73C1773
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 06:47:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50E7B3C0E0A
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 06:47:17 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9CE1D60B056
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 06:47:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 470E021B3F;
 Wed,  4 Sep 2024 04:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725425232;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M1/4sw5mq212xk3g4dUzkyd22EGkagOZei3ON6XjkdY=;
 b=RDhvdCGtz9QGzCV/nWMaoNOMQcbH/5WrhAWbzikLEwyk+xgw2RmnlgS2e0Jc32KNHGav++
 +yt5nTMafjYg8lUnGq+WMVtEGv3Mdf36e/3GU1b5r5GVFUMvyPrtoW158DpkA6pber6zPZ
 rjveU+T1SelGjz7LaLlgFrk5ns3AZWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725425232;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M1/4sw5mq212xk3g4dUzkyd22EGkagOZei3ON6XjkdY=;
 b=X77kyqYh2v9biCxAeIMr+goSx6c4e309fxK4AaFgtoVyAEhCjXb3wFZHY88FBbgj+kEj4w
 07ioO96NykIblDBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725425232;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M1/4sw5mq212xk3g4dUzkyd22EGkagOZei3ON6XjkdY=;
 b=RDhvdCGtz9QGzCV/nWMaoNOMQcbH/5WrhAWbzikLEwyk+xgw2RmnlgS2e0Jc32KNHGav++
 +yt5nTMafjYg8lUnGq+WMVtEGv3Mdf36e/3GU1b5r5GVFUMvyPrtoW158DpkA6pber6zPZ
 rjveU+T1SelGjz7LaLlgFrk5ns3AZWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725425232;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M1/4sw5mq212xk3g4dUzkyd22EGkagOZei3ON6XjkdY=;
 b=X77kyqYh2v9biCxAeIMr+goSx6c4e309fxK4AaFgtoVyAEhCjXb3wFZHY88FBbgj+kEj4w
 07ioO96NykIblDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30733139E2;
 Wed,  4 Sep 2024 04:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OdiOClDm12ZbQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Sep 2024 04:47:12 +0000
Date: Wed, 4 Sep 2024 06:47:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240904044710.GA834275@pevik>
References: <20240903081916.27033-1-wegao@suse.com>
 <20240904035808.5891-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240904035808.5891-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mpls01.sh: Add --allow-unsupported for modprobe
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

Hi Wei,

I suggest these changes:

1) use mpls_setup_driver also in mpls_setup()
- replace tst_net_run(). I don't understand why you did not do it in the
  patchset (I suggested that), but I can replace it during merge.
2) update the commit message: s/mpls01.sh/mpls01/
   (fixing all mpls tests)

With that:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

+++ testcases/network/mpls/mpls_lib.sh
@@ -47,7 +47,7 @@ mpls_setup()
 {
 	local label="$1"
 
-	tst_net_run -s "modprobe -a $TST_NEEDS_DRIVERS"
+	mpls_setup_driver
 
 	ROD sysctl -q net.mpls.conf.$(tst_iface).input=1
 	tst_set_sysctl net.mpls.conf.lo.input 1 safe

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
