Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C50E7716D
	for <ltp@archiver.kernel.org>; Thu,  5 Dec 2024 13:18:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFDDD3DFAA7
	for <ltp@archiver.kernel.org>; Thu,  5 Dec 2024 14:18:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 556703DFA9D
 for <ltp@lists.linux.it>; Thu,  5 Dec 2024 14:18:10 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 52E04623FDD
 for <ltp@lists.linux.it>; Thu,  5 Dec 2024 14:18:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 67F801F38F;
 Thu,  5 Dec 2024 13:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733404687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hsi+65jCcb6LmoO5jLDq08G/nfOdyQfM/sJZKykl0tU=;
 b=N7vt6V0YM8dVjp6iaqlLjZYgf4F0v0pgLYoqSkD0mF5nNO7bs9pFbMrhzyr2oDszapEDpG
 38wEMcNMuJEQ0xVkbah1xKN+OiexbPb+RGQly/3UEea/uNqWxdasEqoGVwDzyypcsHJJMF
 9WWl7F0xdc+e1+7OGt6dJi9/yDGFWvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733404687;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hsi+65jCcb6LmoO5jLDq08G/nfOdyQfM/sJZKykl0tU=;
 b=zPvxvUhjeOJctvM56n0iqpmo09CDAsPNp2nexHMhwHk8Tpl+Gd/R8llMjvIJYf56OgJcho
 PP3DOy8bGUa4sbAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZWdWd7Ay;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="e62I+U/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733404686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hsi+65jCcb6LmoO5jLDq08G/nfOdyQfM/sJZKykl0tU=;
 b=ZWdWd7Ay4VcOF3SU9/HBeEwYeTtyycjKnkld8p5OJGfEnQyAXIzQcKPSnPwMORJbKKJ1hj
 VHF2ShsaMTtB8Q+OBYYeyoHP6wLIuVHw/QYMVwwACZqAPGI1Bn/yZwI0d7XHnimF6nEvUf
 0XfLwQA+yhOAsNwOJaJg7Lleoxjwekk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733404686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hsi+65jCcb6LmoO5jLDq08G/nfOdyQfM/sJZKykl0tU=;
 b=e62I+U/k5qYLzry918Dqsr1B4fPP0wnvKj9rwgAG/g9AUuCWw069moUGHBP8qawi1OxRrR
 DD0KSzwY7/rR92AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56760132EB;
 Thu,  5 Dec 2024 13:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bCHzEw6oUWdzRgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 05 Dec 2024 13:18:06 +0000
Date: Thu, 5 Dec 2024 14:16:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Message-ID: <Z1GntmAaGo_alyE0@rei.lan>
References: <20241108053710.8639-1-wegao@suse.com> <Zy3fh5YZeJ5djPt3@yuki.lan>
 <Zy30Vzk/14/GaEVk@wegao> <Zy30xPImjjRMKnC0@yuki.lan>
 <ZzFwK5nP+cegx2fK@wegao> <ZzHzs-jVLwurbLm0@yuki.lan>
 <dnhjiv6iqwbref6kaq2amylqbwrksnph3l7ewxgqetp6crrz3s@3k5j5t4sy2gl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dnhjiv6iqwbref6kaq2amylqbwrksnph3l7ewxgqetp6crrz3s@3k5j5t4sy2gl>
X-Rspamd-Queue-Id: 67F801F38F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,rei.lan:mid,suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_cgroup.c: Force tst_cg_scan only scan
 specific cgroup version if needs_ver exist
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
> > You are supposed to get an error here, at least that is what I thought.
> 
> That depends -- if the controller's tasks are all in its (only) root
> cgroup, it can be re-bind between hierarchies (v1 to v2 or vice versa).
> 
> > I do get error here on vanilla 6.10 but on debian 6.1 the mount succeeds
> > as well. CCing Michal.
> 
> If /sys/fs/cgroup/cgroup.subtree_control contains `cpuset`, it's likely
> used by some of the services, hence not all tasks are in the root cgroup
> and re-binding fails. That's what can differ between systems.
> 
> > Michal I was under an impression that a controller that has been bound
> > to v2 cannot be removed from there and bound to v1 anymore, but it seems
> > that it may happen in some cases.
> 
> It can happen under the condition above.
> (And in a future kernel it may be truly unavailable in v1 with
> !CONFIG_CPUSETS_V1.)

Thanks for the clarifications.

I still do not think that re-binding controllers to v1 is a good idea
though. Firstly v1 is being phased out and we will eventually get rid
of it, so there is no point in investing too much effort into v1 testing
in hybrid environments.

And secondly I fear that we may end up skipping v2 tests because of the
rebinding. What I think may happen is that the cgroup cleanup is
asynchronous which means that there still would be remnants of the v1
cpuset cgroup even after the particular v1 test would exit, which would
cause next test a v2 test to be skipped, because the rebinding would
fail.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
