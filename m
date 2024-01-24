Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF87BC47DDF
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 13:48:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C5ED3CE2A5
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 14:48:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 047403C1DC2
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 14:48:41 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E9CA601933
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 14:48:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3FD3F1FD67;
 Wed, 24 Jan 2024 13:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706104120;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZwL64Ot9MRJfJkGeSbqwDekU8dncxn0ciEsoXiT/Eg=;
 b=KfYaOsN1ss71OqXxRc1DtwP225Nj3TnN0WqtbOft6XN3YJ28vyYA3HFS6FTB+FnIHTOPGg
 IcsX/K9tlEOGq4RVRXI+SiwYHIic+TP2OnaOy7NGI1E22HYw0zyGwpcCkrKQ0Z30sDBTy0
 N69aEt3Uqow/2du5R0AXQZ8voeyNmns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706104120;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZwL64Ot9MRJfJkGeSbqwDekU8dncxn0ciEsoXiT/Eg=;
 b=NaoZpAa+Lx19JjRHReLEtAJbuDH2Q/KlZMae1h4anj+lrAVXqYMCoNJcnrii6qqE9q2NFO
 1ZNyBIpI2WMcX7DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706104120;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZwL64Ot9MRJfJkGeSbqwDekU8dncxn0ciEsoXiT/Eg=;
 b=KfYaOsN1ss71OqXxRc1DtwP225Nj3TnN0WqtbOft6XN3YJ28vyYA3HFS6FTB+FnIHTOPGg
 IcsX/K9tlEOGq4RVRXI+SiwYHIic+TP2OnaOy7NGI1E22HYw0zyGwpcCkrKQ0Z30sDBTy0
 N69aEt3Uqow/2du5R0AXQZ8voeyNmns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706104120;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZwL64Ot9MRJfJkGeSbqwDekU8dncxn0ciEsoXiT/Eg=;
 b=NaoZpAa+Lx19JjRHReLEtAJbuDH2Q/KlZMae1h4anj+lrAVXqYMCoNJcnrii6qqE9q2NFO
 1ZNyBIpI2WMcX7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08DA51333E;
 Wed, 24 Jan 2024 13:48:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zGqWADgVsWXsTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 13:48:40 +0000
Date: Wed, 24 Jan 2024 14:48:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240124134838.GA295776@pevik>
References: <20240123162647.210424-1-pvorel@suse.cz>
 <20240123162647.210424-5-pvorel@suse.cz>
 <9f884555-dbd3-46f8-8eaf-000815bf404c@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9f884555-dbd3-46f8-8eaf-000815bf404c@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[39.67%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] network: Fix tst_brk TFAIL
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

Hi Martin,

> Hi,
> two comments below.

...
> > +++ b/testcases/network/virt/virt_lib.sh
> > @@ -174,8 +174,10 @@ virt_multiple_add_test()
> >   	tst_res TINFO "add $NS_TIMES $virt_type, then delete"
> >   	for i in $(seq $start_id $max); do
> > -		virt_add ltp_v$i id $i $opt || \
> > -			tst_brk TFAIL "failed to create 'ltp_v0 $opt'"
> > +		if ! virt_add ltp_v$i id $i $opt; then
> > +			tst_res TFAIL "failed to create 'ltp_v0 $opt'"
> > +			return

> This is a library function so tst_brk TBROK is probably the correct fix
> here. Also, the message should say ltp_v$i instead of ltp_v0, but that's for
> a separate patch.

Thanks! tst_brk TBROK makes sense here.

ltp_v$i fixed in separate commit with your credit (merged now).

> > +		fi
> >   		ROD_SILENT "ip link set ltp_v$i up"
> >   	done
> > @@ -196,8 +198,10 @@ virt_add_delete_test()
> >   	tst_res TINFO "add/del $virt_type $NS_TIMES times"
> >   	for i in $(seq 0 $max); do
> > -		virt_add ltp_v0 $opt || \
> > -			tst_brk TFAIL "failed to create 'ltp_v0 $opt'"
> > +		if ! virt_add ltp_v0 $opt; then
> > +			tst_res TFAIL "failed to create 'ltp_v0 $opt'"
> > +			return

> Same here.

Yes (tst_brk TBROK).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
