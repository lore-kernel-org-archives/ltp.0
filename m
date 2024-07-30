Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C66C3DA49
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 07:09:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FE9D3D1C18
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 09:09:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDC6C3CE640
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 09:09:00 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 618311400E61
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 09:08:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0565C1F7CF;
 Tue, 30 Jul 2024 07:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722323339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQQ6Dy8K/mdHGkM9I8Hxv672AT3k+tTRRrcRr/mjTOs=;
 b=B5Z6ZOdnglOgYMcKPNd4vVECNl6V42gCOQx+iENtxKyiruLjmjmrj8D8zmoArKAmR/0gnx
 Q8sqGjj7RC/I5UZ3LCExpSip+f4jSsKEl8JyHzz7tM7Q9E9aZWuCyawFA3Bl0MTs/sOAM7
 WDMGdTWmG7S0A+4B8xNpWBnIJKxZyRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722323339;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQQ6Dy8K/mdHGkM9I8Hxv672AT3k+tTRRrcRr/mjTOs=;
 b=L9zHFzl1fYMK12190OVzjuI15BlmNYb3txvkmkiglRy0F7BSnmiXImWkTtevg+ENIKTd5i
 sUM8ovUvJHUznYAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722323338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQQ6Dy8K/mdHGkM9I8Hxv672AT3k+tTRRrcRr/mjTOs=;
 b=eHefgxfs9fbrzH4uVo+GFlXxOLicNTFOK9/PH09Z6jifEXntfVGXLFng3a101Hxt+63ng9
 Cxq4yzbyC//weGj7q9HvxfUz+Sng2SZI7ciYrosMKCm1FvFKZ0sGXKG6SS7reYMYqZTtYJ
 VYdg4K1RPsy+vXfT2fkTD5AVNxbV/hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722323338;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQQ6Dy8K/mdHGkM9I8Hxv672AT3k+tTRRrcRr/mjTOs=;
 b=KA2ZUXggCF+VAdByxfPPH5DkgyRhkbd7CtReLb1T+yq1xd9aTyUuMqfg+xUoegrCh5unEI
 Afir3Krck4alWvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE63713983;
 Tue, 30 Jul 2024 07:08:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Zc08MYmRqGa1aQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 30 Jul 2024 07:08:57 +0000
Date: Tue, 30 Jul 2024 09:08:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZqiRaf0bPloFV3LI@yuki>
References: <20240722145443.19104-1-chrubis@suse.cz>
 <20240729205112.GA1287954@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240729205112.GA1287954@pevik>
X-Spamd-Result: default: False [-7.60 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] sched: starvation: Autocallibrate the timeout
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
Cc: joe.liu@mediatek.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_starv8seE as tmpdir (tmpfs filesystem)
> tst_test.c:1806: TINFO: LTP version: 20240524
> tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
> starvation.c:71: TINFO: Setting affinity to CPU 0
> tst_test.c:1658: TINFO: Updating max runtime to 0h 04m 00s
> tst_test.c:1650: TINFO: Timeout per run is 0h 04m 30s
> starvation.c:117: TPASS: wait_for_pid(child_pid) passed
> 
> => test runs ~ 13s - 19s on aarch64, ppc64le and x86_64. Therefore not sure if
> 04m max runtime is good.

Are you sure that you have run the test with the patch?

Because it's missing the messages produced by the autocallibration and
the wait_for_pid() should not be there after the patch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
