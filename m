Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42D7C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 11:48:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5319E3CA3B4
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 12:48:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DECB03CA273
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 12:47:59 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D993E600769
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 12:47:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81EBC1F388;
 Fri, 28 Mar 2025 11:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743162477;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8jiZ3KFkazoFeZypYyv4NXAKTn4YctiwLYZgI/wV6GM=;
 b=kdPWBJWQG7JyOooIp8f6YfT5FLlEg6bHxDL2ofpF/xB45mT/HwP53guXs6lHb/pIHgg4g9
 Gdp8O2mstjlcvegxG2d+WfzDFVf2YwSRGdpnAtNQZ3lfXzBMkhbKr+o4RmKAIdyOhzr1AE
 F6fbssMiP91J7CYb8m9vA9enRklKsKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743162477;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8jiZ3KFkazoFeZypYyv4NXAKTn4YctiwLYZgI/wV6GM=;
 b=iX2sFc37Qb3yx6sFPfGZKjOR4hUL+o66hRD2cXZCO13MAe7Dfb4+5SD59TCvf0wN1C64GC
 SABH1A4GYfsVJgBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743162477;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8jiZ3KFkazoFeZypYyv4NXAKTn4YctiwLYZgI/wV6GM=;
 b=kdPWBJWQG7JyOooIp8f6YfT5FLlEg6bHxDL2ofpF/xB45mT/HwP53guXs6lHb/pIHgg4g9
 Gdp8O2mstjlcvegxG2d+WfzDFVf2YwSRGdpnAtNQZ3lfXzBMkhbKr+o4RmKAIdyOhzr1AE
 F6fbssMiP91J7CYb8m9vA9enRklKsKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743162477;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8jiZ3KFkazoFeZypYyv4NXAKTn4YctiwLYZgI/wV6GM=;
 b=iX2sFc37Qb3yx6sFPfGZKjOR4hUL+o66hRD2cXZCO13MAe7Dfb4+5SD59TCvf0wN1C64GC
 SABH1A4GYfsVJgBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F316313998;
 Fri, 28 Mar 2025 11:47:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xNO7N2yM5mftQgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Mar 2025 11:47:56 +0000
Date: Fri, 28 Mar 2025 12:47:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250328114755.GA187610@pevik>
References: <20250324120049.29270-1-wegao@suse.com>
 <20250328075958.7616-1-wegao@suse.com>
 <20250328075958.7616-2-wegao@suse.com>
 <CAEemH2fYLZ9=jS190QXiYOza=1=hvVvpHu-8mWOYG7QKEcqgcA@mail.gmail.com>
 <20250328102008.GA170353@pevik>
 <CAEemH2f9==38Dq=6QBuYwsuw3yF=hogWksE5qX1bPUb4ysfOUg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f9==38Dq=6QBuYwsuw3yF=hogWksE5qX1bPUb4ysfOUg@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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

Hi Li, Wei,

...
> Ok, I see, it was used to disable the task from moving between CPUs
> in the cpuset. But to be honest, that's _not_ necessary, because whatever
> the task is bound to which CPU of the cpuset, it all belongs to that
> specified
> node by limited Cgroup.

> So I would drop this knob setting in new C test.


+1. Maybe worth to mention this in the commit message.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
