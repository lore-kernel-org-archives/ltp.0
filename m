Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1538FC35FF3
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 08:20:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16FEB3C2E01
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 10:20:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCC353C1BD4
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 10:19:51 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE99A1001849
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 10:19:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 77DE21FB69;
 Tue, 17 Sep 2024 08:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726561189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xuDFv0gWLy/ZiI+ix4hN6AL3Ol/WWNAH0kpV6kzgLHU=;
 b=bL/niYfiBPnnT6VXi/FeX0M/Q6pwt2PoA+7oZlqtLKae4vKiWePjQYObOsNvksDN6gmN5S
 PvRkMISUnaEeKDFME4KE+07I9BMumPc9H8VT4SivWxv5/M5TvyV0bcxjOAyZZbkdNGA/3O
 zJjdq0ljoUKob7nJFFSgbqd0zl86ENg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726561189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xuDFv0gWLy/ZiI+ix4hN6AL3Ol/WWNAH0kpV6kzgLHU=;
 b=rR9CngKHF9zk1VbxzFlrt3QW0jEhZsMHJFHm5SjF8kWUwitU/pLBsyLxfxrxx+6p9tmD5D
 dgqeg/YZYhV2Z/BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726561189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xuDFv0gWLy/ZiI+ix4hN6AL3Ol/WWNAH0kpV6kzgLHU=;
 b=bL/niYfiBPnnT6VXi/FeX0M/Q6pwt2PoA+7oZlqtLKae4vKiWePjQYObOsNvksDN6gmN5S
 PvRkMISUnaEeKDFME4KE+07I9BMumPc9H8VT4SivWxv5/M5TvyV0bcxjOAyZZbkdNGA/3O
 zJjdq0ljoUKob7nJFFSgbqd0zl86ENg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726561189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xuDFv0gWLy/ZiI+ix4hN6AL3Ol/WWNAH0kpV6kzgLHU=;
 b=rR9CngKHF9zk1VbxzFlrt3QW0jEhZsMHJFHm5SjF8kWUwitU/pLBsyLxfxrxx+6p9tmD5D
 dgqeg/YZYhV2Z/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EB2513AB6;
 Tue, 17 Sep 2024 08:19:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HeDSFqU76Wb6TQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 17 Sep 2024 08:19:49 +0000
Date: Tue, 17 Sep 2024 10:18:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zuk7Wn1CWSLaicut@yuki.lan>
References: <20240521081552.2162-1-maxj.fnst@fujitsu.com>
 <20240730103431.GA1371143@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240730103431.GA1371143@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] request_key: Add negative tests for request_key
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
Cc: keyrings@vger.kernel.org, ltp@lists.linux.it,
 Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> LGTM, thanks!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> We also somehow test EACCES (request_key04.c). Looking into man page, there are
> other interesting errno to test I suppose (EDQUOT, EKEYEXPIRED, EKEYREJECTED,
> ...)
> 
> @Eric, other devs, would you have time to have a quick look on the test?

I've pushed the patch, we can add more tests later on.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
