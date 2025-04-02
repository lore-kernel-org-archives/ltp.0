Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD22CC28B20
	for <ltp@archiver.kernel.org>; Wed,  2 Apr 2025 10:14:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3086A3CB0A9
	for <ltp@archiver.kernel.org>; Wed,  2 Apr 2025 12:14:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B6C83CB062
 for <ltp@lists.linux.it>; Wed,  2 Apr 2025 12:14:06 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7F55D2001A4
 for <ltp@lists.linux.it>; Wed,  2 Apr 2025 12:14:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3F82F21170;
 Wed,  2 Apr 2025 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743588843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKBmnbIIaYWcpvqLJMc+AsFMRgIi5WbdfTASbrEnPEc=;
 b=HrWq21FYnOU4IB1Hkxe94PInlzUYk5ANuS2e3YxSDnftds/8X5lvW/mSPN2lxvAwnLoksL
 315ctLeXRQxK/DjhR3xCqE2yeMdW/q3QfepKsUfDnacnEJnw89HVhHCTr8RQVydKHb5EpD
 Wf04ABzQ+HWf5UJhueDRhfrFNn9Xkjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743588843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKBmnbIIaYWcpvqLJMc+AsFMRgIi5WbdfTASbrEnPEc=;
 b=TaIHkqLaAAUaws9w6ASFYO7Y1VKajnhiWsuvFLxvENRYR51wh/WajsPUNsjBXQtjnYDGJg
 hfgb9H+0CriOd7BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HrWq21FY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TaIHkqLa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743588843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKBmnbIIaYWcpvqLJMc+AsFMRgIi5WbdfTASbrEnPEc=;
 b=HrWq21FYnOU4IB1Hkxe94PInlzUYk5ANuS2e3YxSDnftds/8X5lvW/mSPN2lxvAwnLoksL
 315ctLeXRQxK/DjhR3xCqE2yeMdW/q3QfepKsUfDnacnEJnw89HVhHCTr8RQVydKHb5EpD
 Wf04ABzQ+HWf5UJhueDRhfrFNn9Xkjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743588843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKBmnbIIaYWcpvqLJMc+AsFMRgIi5WbdfTASbrEnPEc=;
 b=TaIHkqLaAAUaws9w6ASFYO7Y1VKajnhiWsuvFLxvENRYR51wh/WajsPUNsjBXQtjnYDGJg
 hfgb9H+0CriOd7BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AB52137D4;
 Wed,  2 Apr 2025 10:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sj+NCesN7We7UwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 02 Apr 2025 10:14:03 +0000
Date: Wed, 2 Apr 2025 12:14:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z-0OBM_ta3VesFGV@yuki.lan>
References: <20250328114311.187541-1-pvorel@suse.cz>
 <Z-q6Okh-lkvbx5mA@yuki.lan> <20250331173102.GA268097@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250331173102.GA268097@pevik>
X-Rspamd-Queue-Id: 3F82F21170
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 0/2] Add safe_get_nodemap()
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
> +1, thanks for suggesting a proper struct :).
> 
> BTW why we can use enum tst_numa_types in struct and not as function parameter?

Lazines I suppose.

> -struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb);
> +struct tst_nodemap *tst_get_nodemap(enum tst_numa_types type, size_t min_mem_kb);
> 
> Old toolchains? Maybe not needed nowadays? I guess with using enum we could get
> rid of the check for enum validity:
> if (type & ~(TST_NUMA_MEM))
> 	tst_brk(TBROK, "Invalid type %i\n", type);

No we couldn't because you can stil pass whatever you want even when the
type is enum.

> > And then use that in tst_test structure. That would certainly make
> > sense, but I guess that we would have to move the numa library to the
> > lib/ as well. I'm not sure that we can have a function call from
> > tst_test.c library to something that is not compiled in by default.
> 
> Correct, file is in libs/numa/tst_numa.c. But how about use predecessor check?
> 
> if (tst_test->numa) {
> #ifdef HAVE_NUMA_V2
> 	...
> #else
> 	tst_brk(TCONF, NUMA_ERROR_MSG);
> #endif
> }
> 
> With help we would even get rid of else part of the compile check in the
> tests:
> 
> #else
> TST_TEST_TCONF(NUMA_ERROR_MSG);
> 
> But we would have modify lib/Makefile to conditionally add "-lnuma -lltpnuma".
> "-lnuma" would be based on NUMA_LIBS (stored in include/mk/config.mk, detected
> in m4/ltp-numa.m4), e.g. something like this could work:
> 
> ifneq ($(NUMA_LIBS),)
> LDLIBS += $(NUMA_LIBS) -lltpnuma
> endif

I do no think that this would be enough, because all tests are linking
againts -lltp and if -lltp potentionally calls into the libnuma suddenly
all tests has to be linked againts libnuma. Or libnuma must be moved
into the ltp library.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
