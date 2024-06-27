Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B51C2BD09
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 10:26:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AB783D1293
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 12:26:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D05D03D1243
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 12:26:42 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 052D31000EA2
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 12:26:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1F1291FBB6;
 Thu, 27 Jun 2024 10:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719484000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EzNMq1x2P4BLmWGvavOLX01rucSO8DhBOlqyYwiJHK0=;
 b=Bvpb81tXwyFsn5gXgn9DhI0Hp2uL1uuaOFcIERfc7jzopNnWQ7p1sWKQ4gdZeHPP5EfumM
 y9yv9Imh2GT3+LbHaNARNH1PBzML4mdciVDrnEZIJ8kEVyOMeUpgWi3OlLNBmI2Rm8WbdH
 GZs06p/7MhqMDgdqi8CvFRv32fhyCM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719484000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EzNMq1x2P4BLmWGvavOLX01rucSO8DhBOlqyYwiJHK0=;
 b=l6cBI1jEp8cCDfMIgDyf3seAOggy7ypcAI+hXBXUeqJQYJEZ01BsZv1PXZcP8QMDpQTqPT
 6OALILM3+uf1O6Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Bvpb81tX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=l6cBI1jE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719484000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EzNMq1x2P4BLmWGvavOLX01rucSO8DhBOlqyYwiJHK0=;
 b=Bvpb81tXwyFsn5gXgn9DhI0Hp2uL1uuaOFcIERfc7jzopNnWQ7p1sWKQ4gdZeHPP5EfumM
 y9yv9Imh2GT3+LbHaNARNH1PBzML4mdciVDrnEZIJ8kEVyOMeUpgWi3OlLNBmI2Rm8WbdH
 GZs06p/7MhqMDgdqi8CvFRv32fhyCM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719484000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EzNMq1x2P4BLmWGvavOLX01rucSO8DhBOlqyYwiJHK0=;
 b=l6cBI1jEp8cCDfMIgDyf3seAOggy7ypcAI+hXBXUeqJQYJEZ01BsZv1PXZcP8QMDpQTqPT
 6OALILM3+uf1O6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F763137DF;
 Thu, 27 Jun 2024 10:26:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jjdgAmA+fWZzLAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 27 Jun 2024 10:26:40 +0000
Date: Thu, 27 Jun 2024 12:26:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: John Stultz <jstultz@google.com>
Message-ID: <Zn0-VWfPTqrAzuuj@yuki>
References: <20240626133004.15810-1-chrubis@suse.cz>
 <CANDhNCpKJ5i41eNw_sthFQfdTaYoJU76swEWmwmBy_Y2t2pszQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANDhNCpKJ5i41eNw_sthFQfdTaYoJU76swEWmwmBy_Y2t2pszQ@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1F1291FBB6
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] include/tst_timer: Add TST_NO_LIBLTP
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
Cc: kernel-team@android.com, Darren Hart <darren@os.amperecomputing.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> So instead you can implement in a header once:
> 
> #ifndef TST_NO_LIBLTP
> static inline void test_brk(int i, char *s, long d)
> {
>     abort();
> }
> #endif
> 
> And then the downstream users don't need to have #ifdefs littering their logic.
> 
> Again, just an idea.

That indeed looks better, will send v2.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
