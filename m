Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAE5CCD199
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 16:23:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 325373CEEB9
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 18:23:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F4303CEE9D
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 18:22:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DFC2A600286
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 18:22:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 356111FF7E;
 Fri, 17 Oct 2025 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760718167;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pc+CsWiOF1/JY/zWRH8XTSs6CLZ/OuICE6bEjWm60xI=;
 b=bHoLFucJ90LAC8UHfhF66aDBwXxp4cn3lzxQZwNc+b5//t5eyYdHpugxTeahoAHn2Id8j3
 PhzLVEA2Z4KIGACnFvl02D2rwA029IF4TrEDf1lzzhIUCkI08i2Yz9I+rknA2Us5sl8eT5
 O3IkGW2Fa4TJExsq+lkeodFsdsnqG6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760718167;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pc+CsWiOF1/JY/zWRH8XTSs6CLZ/OuICE6bEjWm60xI=;
 b=ZXX27O5QJdI9a+YY3s6BD5uY4SDjtEsUV78F8IiJ4YTmE9RCJOTnOpkvwqhkCNjpFRs8zK
 q7jh1A3Dki5xKMDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760718167;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pc+CsWiOF1/JY/zWRH8XTSs6CLZ/OuICE6bEjWm60xI=;
 b=bHoLFucJ90LAC8UHfhF66aDBwXxp4cn3lzxQZwNc+b5//t5eyYdHpugxTeahoAHn2Id8j3
 PhzLVEA2Z4KIGACnFvl02D2rwA029IF4TrEDf1lzzhIUCkI08i2Yz9I+rknA2Us5sl8eT5
 O3IkGW2Fa4TJExsq+lkeodFsdsnqG6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760718167;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pc+CsWiOF1/JY/zWRH8XTSs6CLZ/OuICE6bEjWm60xI=;
 b=ZXX27O5QJdI9a+YY3s6BD5uY4SDjtEsUV78F8IiJ4YTmE9RCJOTnOpkvwqhkCNjpFRs8zK
 q7jh1A3Dki5xKMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF481136C6;
 Fri, 17 Oct 2025 16:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AsQxKFZt8miMRwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Oct 2025 16:22:46 +0000
Date: Fri, 17 Oct 2025 18:22:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ben Copeland <ben.copeland@linaro.org>
Message-ID: <20251017162245.GB351168@pevik>
References: <20251016124025.1472694-1-ben.copeland@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251016124025.1472694-1-ben.copeland@linaro.org>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_SEVEN(0.00)[9]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] overcommit_memory: Fix integer overflow and
 32-bit limits
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
Cc: arnd@arndb.de, lkft-triage@lists.linaro.org, ltp@lists.linux.it,
 dan.carpenter@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> The overcommit test uses sum_total, the sum (memory and swap) to test
> the overcommit settings.

> This fixes two problems on 32-bit systems. The first is seen with a
> integer overflow can occur when calculating sum_total * 2, if the
> sum_total is larger than 2GB. The second is limited virtual address
> space (2-3GB) means the test can fail from address space exhaustion
> before overcommit has been tested.

> Now the test runs correctly on low-memory 32-bit systems while avoiding
> both the overflow bug and virtual address space issues.

Thanks, also this patch merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
