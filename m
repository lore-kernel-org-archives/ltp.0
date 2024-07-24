Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14C6C3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 10:05:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 496AC3D1C0F
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 12:05:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 095373CB72F
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 12:05:42 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 38D881B61065
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 12:05:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E26F21BE3;
 Wed, 24 Jul 2024 10:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721815541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CL/c6eSBtkgHTaPZ/HBiWwD+hC2Ei5KC0L4gSY4X5H0=;
 b=PUPVkTHp/fBIQFiUQA1Rek7ucPKsvnc95q8k/Jpt6yKYbA+qgdwIQ9h1glXkyBJQyw53C1
 3xTZg2SmN7EJlSYAILwha/+pf7CCAqy6rJlMJ+Hqd0vuJ5FRyfidn2IEYrQMd29BVEJHRb
 obNTwnNjQdOppNOIQ+XQqiuf3aaZhlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721815541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CL/c6eSBtkgHTaPZ/HBiWwD+hC2Ei5KC0L4gSY4X5H0=;
 b=N0UdWM/tT8it/wcZeojLUsixhPID0v4SUiYIqBLKiAc51QfVNZCh9oZMEuT4HJlzOmFa6B
 N4N7fWrryVWbgnBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721815541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CL/c6eSBtkgHTaPZ/HBiWwD+hC2Ei5KC0L4gSY4X5H0=;
 b=PUPVkTHp/fBIQFiUQA1Rek7ucPKsvnc95q8k/Jpt6yKYbA+qgdwIQ9h1glXkyBJQyw53C1
 3xTZg2SmN7EJlSYAILwha/+pf7CCAqy6rJlMJ+Hqd0vuJ5FRyfidn2IEYrQMd29BVEJHRb
 obNTwnNjQdOppNOIQ+XQqiuf3aaZhlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721815541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CL/c6eSBtkgHTaPZ/HBiWwD+hC2Ei5KC0L4gSY4X5H0=;
 b=N0UdWM/tT8it/wcZeojLUsixhPID0v4SUiYIqBLKiAc51QfVNZCh9oZMEuT4HJlzOmFa6B
 N4N7fWrryVWbgnBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCEB313411;
 Wed, 24 Jul 2024 10:05:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Jqg8M/TRoGYDYAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jul 2024 10:05:40 +0000
Date: Wed, 24 Jul 2024 12:05:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZqDRzH6c_H2cbo1B@yuki>
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-2-chrubis@suse.cz>
 <7787ae84-8c5a-4f31-815b-afb12fce2575@suse.cz>
 <ZqDNpfMzFbmmQlxa@yuki>
 <efb1e013-ca23-4edf-aaff-4fd1dd25635e@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <efb1e013-ca23-4edf-aaff-4fd1dd25635e@suse.cz>
X-Spamd-Result: default: False [-7.60 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] Add support for mixing C and shell code
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
> That still doesn't solve the incorrect return value from the script if 
> it's intentionally possible to run it as a stand-alone test, without any 
> parent process written in C.

I do not think that it will make sense or be possible to use these
scripts without the C library. The whole point of this patchset is to
use as much of the C library as possible so that we do not have to
reimplement it in shell. Which would mean that most of the functionality
needed to run these shell tests will not we available without the C
library.

Maybe these script shouldn't have a shebang and shouldn't have
executable flag so that people are not confused about this. The test
library can run them with /bin/sh $filename instead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
