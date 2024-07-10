Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9D2C3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 18:13:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F77A3D3885
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 20:13:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1E5B3CE10E
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:12:49 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F1F62100035E
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:12:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 09F8F1F846;
 Wed, 10 Jul 2024 18:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720635167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OYko7VGPwPybaWEmyMVsZ8w2In4z0ZhRHnN0z8FqT04=;
 b=ORd5rPGYWpIvQXvb5YDuWNziaLmVhy9TCxWZyyMZfPf0EDp0GPOuM4XOpFfLurMlSGzlDy
 rwT7GX7YToE/VTwqeeC0yLOuY0XhsFwkYYP0Oli0XyrYHFm+JZIR/IhPFF+77t3rb0Udbn
 zn5Wtor3xZcH+c6ccQOVjBkJBpcAOPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720635167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OYko7VGPwPybaWEmyMVsZ8w2In4z0ZhRHnN0z8FqT04=;
 b=cQw2TAYfrDGx54RyeD90+FzD+4UUK4T6P6bTs0ua6JGIclmPz5aCVo/8k37x2kMqfB+QA4
 MTB9ITuJITk0xpBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720635167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OYko7VGPwPybaWEmyMVsZ8w2In4z0ZhRHnN0z8FqT04=;
 b=ORd5rPGYWpIvQXvb5YDuWNziaLmVhy9TCxWZyyMZfPf0EDp0GPOuM4XOpFfLurMlSGzlDy
 rwT7GX7YToE/VTwqeeC0yLOuY0XhsFwkYYP0Oli0XyrYHFm+JZIR/IhPFF+77t3rb0Udbn
 zn5Wtor3xZcH+c6ccQOVjBkJBpcAOPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720635167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OYko7VGPwPybaWEmyMVsZ8w2In4z0ZhRHnN0z8FqT04=;
 b=cQw2TAYfrDGx54RyeD90+FzD+4UUK4T6P6bTs0ua6JGIclmPz5aCVo/8k37x2kMqfB+QA4
 MTB9ITuJITk0xpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAE04137D2;
 Wed, 10 Jul 2024 18:12:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9WUMOR7PjmYPfwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Jul 2024 18:12:46 +0000
Date: Wed, 10 Jul 2024 20:12:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zo7PGiEC3kWFyx0u@yuki>
References: <20240612112311.10334-1-chrubis@suse.cz>
 <20240701095032.18930-1-joe.liu@mediatek.com>
 <ZoQTD_QLwP8w9sPe@yuki> <20240710155521.GC300896@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240710155521.GC300896@pevik>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched: starvation: Autocallibrate the timeout
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
Cc: alix.wu@mediatek.com, "joe.liu" <joe.liu@mediatek.com>, ltp@lists.linux.it,
 xufeifei1@oppo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:161: TINFO: do_test by pid 4523
> > > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:166: TINFO: main pid is 4523
> > > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:167: TINFO: child pid is 4524
> > > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:166: TINFO: main pid is 4524
> > > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:167: TINFO: child pid is 0
> > > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:176: TINFO: go loop, current pid is 4523
> > > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:145: TINFO: current ppid is 4523, current pid is 4524, go to child() start
> 
> > > main pid is 4523, child pid is 4524, and we only see child pid is working (checking by top)
> 
> > > 4524 root         20   0  14M 472K    0 R 85.7   0.0   0:14.93 starvation_v4 -t 1000000 -l 1000000 <-- cpu_load by top
> 
> > So this looks like we managed to reproduce the issue the test was trying
> > to catch. The child is hogging the CPU and the parent process cannot
> > proceed. And I suppose that this happens only on 32bit because 32bit is
> > less tested these days.
> 
> I guess we can merge this, right?
> Or we still not sure whether this is really kernel bug not related to the
> change?

It stil needs a runtime check at the end of the loop in a case that
timeout is multiplied. I will have to send another version, thanks for
reminding me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
