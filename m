Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEC5C3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 20:02:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42B843D1CA3
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 22:02:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57F7C3CF2B6
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 22:01:52 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6A03F6007A3
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 22:01:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 761AB219DE;
 Fri, 26 Jul 2024 20:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722024111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Svv5nK+K0PSQ/jRCHIBwzxBEDM4/p99+S/kILIorRzo=;
 b=y28PFh6PV8AxEZfFTfsjcYFtuDKOLr7Jcf7Wc2+52kqAfslcKtW9AEiKzk1mAQhxrfHJOZ
 R3Ab/MAV8RuG+ZWIyoRoACGsYVNCYv6LBOo8tl/zSJ/2sxTvo4HT9KvdnEPySlcgc7UwxC
 jxSuJNYAYZ3vO6OxSLN28rWvE4dZX24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722024111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Svv5nK+K0PSQ/jRCHIBwzxBEDM4/p99+S/kILIorRzo=;
 b=kk5D1YMuEJZiV7SVxRlaaXohQNr11OPEA59txwEsQiTxtCzok/0pLPr7Az/CtVwV6OS32u
 I8KnVRRg9BgO4MBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722024111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Svv5nK+K0PSQ/jRCHIBwzxBEDM4/p99+S/kILIorRzo=;
 b=y28PFh6PV8AxEZfFTfsjcYFtuDKOLr7Jcf7Wc2+52kqAfslcKtW9AEiKzk1mAQhxrfHJOZ
 R3Ab/MAV8RuG+ZWIyoRoACGsYVNCYv6LBOo8tl/zSJ/2sxTvo4HT9KvdnEPySlcgc7UwxC
 jxSuJNYAYZ3vO6OxSLN28rWvE4dZX24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722024111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Svv5nK+K0PSQ/jRCHIBwzxBEDM4/p99+S/kILIorRzo=;
 b=kk5D1YMuEJZiV7SVxRlaaXohQNr11OPEA59txwEsQiTxtCzok/0pLPr7Az/CtVwV6OS32u
 I8KnVRRg9BgO4MBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD9711396E;
 Fri, 26 Jul 2024 20:01:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LxKuI64ApGZ5cwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 20:01:50 +0000
Date: Fri, 26 Jul 2024 22:01:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Brent Yardley <brent.yardley@gmail.com>
Message-ID: <20240726200147.GA1153287@pevik>
References: <92C0327A-E1AB-46B6-A180-9D886977902D@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <92C0327A-E1AB-46B6-A180-9D886977902D@gmail.com>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; FREEMAIL_TO(0.00)[gmail.com];
 TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Re-enable access to LTP
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

Hi Brent,

> I was removed from the LTP due to not having TFA enabled.  I have reenabled TFA on GitHub, can I please be added back to LTP?

Thanks for info, you should have the invitation in your inbox.

Kind regards,
Petr

> Thanks,

> Brent Yardley
> brent.yardley@gmail.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
