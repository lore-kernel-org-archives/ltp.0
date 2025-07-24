Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4789FC83F1A
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 08:00:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23C233CCDDA
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 10:00:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C36D3CC8E8
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 10:00:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 14E2E1000364
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 10:00:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9B82A219A6;
 Thu, 24 Jul 2025 08:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753344009;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=weCsqmyJMsS9RJBQbt8tgkLEP0xI3H3d2GTnnEQXwko=;
 b=mXYjhyaC3tz00sgRpV2Wh0fznS9KOGjrJzR9SXiAYHl++3ONQ7Q7OGpRlqb78bcKj+yWkJ
 KrZxCiJqEJ1HYARI2kokJ6ni0gQiMm+41wRE58gk+K8T3PafDd99Hpg2vjSmQ9Yh6J8yy7
 xcwjl6Lh08S7AdZL/hyCDaqCLiLHRAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753344009;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=weCsqmyJMsS9RJBQbt8tgkLEP0xI3H3d2GTnnEQXwko=;
 b=NE76UdlBQa4TOvzozsOT9oszm0Jrzo6YQ2bcYpt88IMA9yFgmFG9SrjrJuMxGcP/7yWX4B
 JE87i6g7xyriM4Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753344008;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=weCsqmyJMsS9RJBQbt8tgkLEP0xI3H3d2GTnnEQXwko=;
 b=tLY6LDkRK8hUT+25CQRtaGKnDvLtMmRfsqhsg2swgnV7zIBu+3cejRh4h5ndrZVt5NJMXP
 BM/4861Jn9gKZ7zp3P/0zEtuBNxy4GnmD2LC83sb9uOhjhXahB5OI3xV15oYpICIAujfLI
 5sAcXUiA5WKhycdlclyBnBkVhF5toDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753344008;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=weCsqmyJMsS9RJBQbt8tgkLEP0xI3H3d2GTnnEQXwko=;
 b=ZWjyMd391656p/o7N76vC6auh0yq844bg+b3Sl3PRDSOUKQSojvlo0LEcKQ7Ri77z/a/Qv
 pR5a8dbf0tJTXsBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11696136DC;
 Thu, 24 Jul 2025 08:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZbtrAAjogWhWOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 24 Jul 2025 08:00:08 +0000
Date: Thu, 24 Jul 2025 10:00:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20250724080002.GA6636@pevik>
References: <20250721154946.34223-1-mdoucha@suse.cz>
 <20250722083221.GB19816@pevik>
 <e77e593d-8900-4f07-9736-22b1de085999@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e77e593d-8900-4f07-9736-22b1de085999@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] open14: Rewrite to new API
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
> feel free to amend the patch during merge.
+1, merged.

Thanks for the rewrite!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
