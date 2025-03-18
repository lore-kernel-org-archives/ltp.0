Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32690C282EC
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 11:19:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BAA53CABF7
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 12:19:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6FC63CAB9B
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:19:02 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7663D1400BF8
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:19:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 99FFF21EA3;
 Tue, 18 Mar 2025 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742296741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wT0+I7JIIZgpwtZQO6/lKiA8VTiwbPfGy54BiO4+zCY=;
 b=Em4EIGnQQ4S3MnXOKxZtnxdsRASRpYpWG5iUduEDeD1uTA3bCPHV6OPO2I6Z7gPTyOquii
 pcw9lNzjobSyZAHPXiJv3wDxFgxY979DiYrkJLl6hmiH8JZHFcyLUfVrsAX8Soh2DhXFPN
 WzyAZZyPGTRFp1woEURN3R17uQne4E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742296741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wT0+I7JIIZgpwtZQO6/lKiA8VTiwbPfGy54BiO4+zCY=;
 b=11axSg4zoDsw7NcNKoBwzKmogB2KfsLpWvZQUIsTS44sYqc2nf2dyomd7iKYqIomc0uSOa
 6203OnGaCOMJkSBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742296741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wT0+I7JIIZgpwtZQO6/lKiA8VTiwbPfGy54BiO4+zCY=;
 b=Em4EIGnQQ4S3MnXOKxZtnxdsRASRpYpWG5iUduEDeD1uTA3bCPHV6OPO2I6Z7gPTyOquii
 pcw9lNzjobSyZAHPXiJv3wDxFgxY979DiYrkJLl6hmiH8JZHFcyLUfVrsAX8Soh2DhXFPN
 WzyAZZyPGTRFp1woEURN3R17uQne4E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742296741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wT0+I7JIIZgpwtZQO6/lKiA8VTiwbPfGy54BiO4+zCY=;
 b=11axSg4zoDsw7NcNKoBwzKmogB2KfsLpWvZQUIsTS44sYqc2nf2dyomd7iKYqIomc0uSOa
 6203OnGaCOMJkSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88091139D2;
 Tue, 18 Mar 2025 11:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6BpeIKVW2WcWSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 18 Mar 2025 11:19:01 +0000
Date: Tue, 18 Mar 2025 12:19:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <Z9lWurYY7h33xtBV@yuki.lan>
References: <20250227184907.392133-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250227184907.392133-1-edliaw@google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] perf_event_open02: set process as RT during Setup
 stage
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
Cc: "kuan-ying.zhu" <kuan-ying.zhu@mediatek.com>, kernel-team@android.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Move the action of set the task RT from the Verify stage to the Setup
> stage. Avoid potential risks of task migration due to scheduler policy.

What exactly goes wrong if we switch to the realtime policy later? I
see that we do bench_work(500) at the start of the setup. That may mean
that we may get different estimate on how many loops we do per second,
but that would only mean that the test would run for shorter time.

We also do bind_to_current_cpu() just after that, the task shouldn't be
migrated after that.

The actual change looks reasonable, however the patch description should
tell why we need to do this change.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
