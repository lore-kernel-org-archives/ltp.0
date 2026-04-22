Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23C4F9EDC6
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 12:42:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CD7B3E53C4
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 14:42:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C819B3E229D
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 14:42:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 41A7560008B
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 14:42:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B859D5BD2C;
 Wed, 22 Apr 2026 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776861731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hX9BPKc2FPL2o0LP8ebWR6YR1peIeQdQAFO/OVJ4sos=;
 b=swXNCOF1c0D2xtAmjiFoTKd+kL/qV9vnHFbphQMaZDHf/PAOlRe2X1ZQ/eZgc/qE0kVIDP
 4k8+0cXmhHMbKdolQLqfxs9LBqeOF3SZPsh2fDjmtcDzRTLctdLncfOcTZc63gb9VL52Vx
 l2ikfPhnzS2l5Iqmf6avwCwvlh5TEoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776861731;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hX9BPKc2FPL2o0LP8ebWR6YR1peIeQdQAFO/OVJ4sos=;
 b=ZygtBNLy8MigzggT15wQ0/LhEyXUtVBFQpbsxoJ6Qg3uY8l0hhgAorUxV7fnBqeHlNKM+k
 WbBkCXiypt3UTfBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776861731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hX9BPKc2FPL2o0LP8ebWR6YR1peIeQdQAFO/OVJ4sos=;
 b=swXNCOF1c0D2xtAmjiFoTKd+kL/qV9vnHFbphQMaZDHf/PAOlRe2X1ZQ/eZgc/qE0kVIDP
 4k8+0cXmhHMbKdolQLqfxs9LBqeOF3SZPsh2fDjmtcDzRTLctdLncfOcTZc63gb9VL52Vx
 l2ikfPhnzS2l5Iqmf6avwCwvlh5TEoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776861731;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hX9BPKc2FPL2o0LP8ebWR6YR1peIeQdQAFO/OVJ4sos=;
 b=ZygtBNLy8MigzggT15wQ0/LhEyXUtVBFQpbsxoJ6Qg3uY8l0hhgAorUxV7fnBqeHlNKM+k
 WbBkCXiypt3UTfBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 835D8593AF;
 Wed, 22 Apr 2026 12:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FwpmHiPC6GkYeAAAD6G6ig
 (envelope-from <rbranco@suse.de>); Wed, 22 Apr 2026 12:42:11 +0000
Message-ID: <ec5e037c-b02f-4475-aede-c3aa68d8a10f@suse.de>
Date: Wed, 22 Apr 2026 14:42:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20260421152349.1673057-1-mcermak@redhat.com>
 <20260422053712.GB392764@pevik>
 <319d3965-30f0-49c5-b747-ad16334391e2@suse.de>
 <20260422121742.GA419002@pevik>
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <20260422121742.GA419002@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.983]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [PATCH] Make userfaultfd0{1, 3,
 4} LTP tests valgrind compatible
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
Cc: valgrind-developers@lists.sourceforge.net,
 Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 4/22/26 2:17 PM, Petr Vorel wrote:
>> Perhaps we should cover both?
> What do you mean by "both"?
>
> Run test with both processes and threads e.g. via .test_variants?

Yes.

Best,
R

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
