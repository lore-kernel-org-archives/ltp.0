Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ADFE77188
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 11:58:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B57D73C029B
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 12:58:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B584B3C01E9
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 12:57:56 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CFFC61017174
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 12:57:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 83A821F394;
 Fri,  3 Jan 2025 11:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735905473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GgHaTZ7q7yccp8DFsqgAciSefLxzOMs3cbe1fTCO52o=;
 b=3c5lyE3kn3BbeEA0fgMxApXt5p90nO/9zUWYJs5sTDsI5jVQZuorm+zao6lgRCAQkOvJcg
 hxotTfiGUMU2iXlqg8PjN3qIGCAVfmeiIGXlEgmS2Y0Xri2uCE2d3ZGCxeiBovNzuKxD8O
 hEFz0zjx34vS1INRP/z8ZelqAZYPN10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735905473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GgHaTZ7q7yccp8DFsqgAciSefLxzOMs3cbe1fTCO52o=;
 b=3IQdQoCPfy3axChVybp40e+DrDSJ/iX3F5ZhcWxHo+jZBDaaZXefvbpWqoaNohPCNRcEPW
 LaAAzWOSwugHnhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735905473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GgHaTZ7q7yccp8DFsqgAciSefLxzOMs3cbe1fTCO52o=;
 b=3c5lyE3kn3BbeEA0fgMxApXt5p90nO/9zUWYJs5sTDsI5jVQZuorm+zao6lgRCAQkOvJcg
 hxotTfiGUMU2iXlqg8PjN3qIGCAVfmeiIGXlEgmS2Y0Xri2uCE2d3ZGCxeiBovNzuKxD8O
 hEFz0zjx34vS1INRP/z8ZelqAZYPN10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735905473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GgHaTZ7q7yccp8DFsqgAciSefLxzOMs3cbe1fTCO52o=;
 b=3IQdQoCPfy3axChVybp40e+DrDSJ/iX3F5ZhcWxHo+jZBDaaZXefvbpWqoaNohPCNRcEPW
 LaAAzWOSwugHnhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F16F134E4;
 Fri,  3 Jan 2025 11:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CRC8EMHQd2dINQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 03 Jan 2025 11:57:53 +0000
Date: Fri, 3 Jan 2025 12:57:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250103115743.GA211314@pevik>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-2-pvorel@suse.cz>
 <fa7b251e0b7966e9d32117996f4ae8390bc4f6cc.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fa7b251e0b7966e9d32117996f4ae8390bc4f6cc.camel@linux.ibm.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/8] IMA: Add TCB policy as an example for
 ima_measurements.sh
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi,

> Hi Petr,

> On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> > Taken from IMA docs [1], removed dont_measure fsmagic=0x1021994 (tmpfs)
> > as suggested by Mimi.

> > [1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> After thinking about it some more, anyone interested in constraining the
> "measure func=FILE_CHECK" rules based on LSM labels to avoid integrity
> violations would need to reboot the system anyway. [1]

> For this reason, please include the new dont_measure tmpfs rule as proposed in
> "[PATCH] ima: limit the builtin 'tcb' dont_measure tmpfs policy rule". [2]

Sure, I'll add in v3:

dont_measure fsmagic=0x1021994 func=FILE_CHECK

Kind regards,
Petr

> [1] Integrity violations -
> https://ima-doc.readthedocs.io/en/latest/event-log-format.html#template-data-hash

> [2]
> https://lore.kernel.org/linux-integrity/20241230142333.1309623-2-zohar@linux.ibm.com/

> thanks,

> Mimi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
