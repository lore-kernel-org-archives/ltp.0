Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C20C2BD09
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 12:05:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00F103D12C7
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 14:05:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 672F13D0EEF
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 14:05:11 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5ABDA601567
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 14:05:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4701B21B8E;
 Thu, 27 Jun 2024 12:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719489910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J1GLvqTjoW3/KbLuXD4wblOLEhO3Vdw3/B/gmBu+CFg=;
 b=B199NiNKTMHgtKtuvzItkVvYaoHJ2fNAkZRYGtQ+nGm4L7UqumScDlbRskYdyhjDGnjnfP
 1raxEcwiy4l//ynXtnmg93WPyrtrKPtXG5J90SeCP6vEJcp6MANnU9ZGuP6zgyPBJ3Cs4R
 8dTzLi9nubYg0RGR03WfuzpG/qtDEIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719489910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J1GLvqTjoW3/KbLuXD4wblOLEhO3Vdw3/B/gmBu+CFg=;
 b=8M/SVS5MX7zM25J4qQSgU83V05pLjRnnORHsmVzvEqIg5wEboO2QlNVEeAJHT0TlmQr2UU
 LWhEVEj9CWawIdAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719489910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J1GLvqTjoW3/KbLuXD4wblOLEhO3Vdw3/B/gmBu+CFg=;
 b=B199NiNKTMHgtKtuvzItkVvYaoHJ2fNAkZRYGtQ+nGm4L7UqumScDlbRskYdyhjDGnjnfP
 1raxEcwiy4l//ynXtnmg93WPyrtrKPtXG5J90SeCP6vEJcp6MANnU9ZGuP6zgyPBJ3Cs4R
 8dTzLi9nubYg0RGR03WfuzpG/qtDEIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719489910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J1GLvqTjoW3/KbLuXD4wblOLEhO3Vdw3/B/gmBu+CFg=;
 b=8M/SVS5MX7zM25J4qQSgU83V05pLjRnnORHsmVzvEqIg5wEboO2QlNVEeAJHT0TlmQr2UU
 LWhEVEj9CWawIdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8286137DF;
 Thu, 27 Jun 2024 12:05:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Er/uL3VVfWbGSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 27 Jun 2024 12:05:09 +0000
Date: Thu, 27 Jun 2024 14:04:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Zn1VawzZsbkirhjN@yuki>
References: <CAEemH2fsBssjDyyozHnFt4T5y7LCWFEDqfN3nE7t3kyd19FjLg@mail.gmail.com>
 <20240627031440.799114-1-liwang@redhat.com> <Zn1PluxR0lVO1qdn@yuki>
 <CAEemH2eh3kDZ7xLPp94buH1f9b3Z3JgiVaRVEzvgiGw8mv3mow@mail.gmail.com>
 <Zn1RbDki07G3_yJB@yuki>
 <CAEemH2dr-UMbVQo9EVcr8mbW-PpVJ6mvv33GoKnRLVWq2ez77w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dr-UMbVQo9EVcr8mbW-PpVJ6mvv33GoKnRLVWq2ez77w@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] msgstress01: remove TWARN from runtime
 remaining
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> How about giving the actual finished numbers?
> 
>         if (!(*fail))
> -               tst_res(TPASS, "Test passed. All messages have been
> received");
> +               tst_res(TPASS, "Test passed. %d messages have been
> received", *finished);

This is not the number of messages though, it's incremented by writer
threads once they send num_iteration messages. So most of the time it
will either be 0 if we had to stop the execution because of runtime, or
2 * num_messages, if we managed finish in time.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
