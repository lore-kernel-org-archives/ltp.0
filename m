Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60B4C41535
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 14:48:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3739C3CF301
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 15:48:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3924D3CABF7
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 15:48:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 35C69200B79
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 15:48:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F2DFF1F7C9;
 Tue, 19 Dec 2023 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702997323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyq2n6sKvMg/KttdWSaA13+U9MrBPVCSccXXmUZlxEQ=;
 b=uFmoRYuk8L9Jtxs7Uuu5CQ8NtRLLOTb4SyvFFUypxjRSdkRLNPTp0QerG+unUBKEE3zG1g
 WKgxH9q5lrcSTQuhf9fsbDcf2FhCoIyxrtKzj16d97a+6Lq0WeNUB9RAydn0E+Lgc+Nvby
 FHi7mY1RDAIQ0AuX8TuEa5ZEeExzZsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702997323;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyq2n6sKvMg/KttdWSaA13+U9MrBPVCSccXXmUZlxEQ=;
 b=aAETQNrFlKP4iLYfXZGq3KK2BH+RTSTIvgUTu1WZ2J/0VqCvZSHNNX1UTOwGK/gdAQ6DrD
 Q+ZAODH1hoXdGtCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702997322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyq2n6sKvMg/KttdWSaA13+U9MrBPVCSccXXmUZlxEQ=;
 b=DfdJynLbIKi5a66YuQObgJxDCB+Q9cGd3TIgU7KSrXAd0Uutl54bQviTAex5BbrEDjtijB
 jIp1T2wemJv/mxIJ6s7lYFI2HRb2xYwTOj1i5WONQphhld9aYfhMwEw9F5CSeTJ4LQLhH8
 hcvk2/hMs9JQckQPqOhF9BwF8oJ8bWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702997322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyq2n6sKvMg/KttdWSaA13+U9MrBPVCSccXXmUZlxEQ=;
 b=VJRSMqaiOKGTd4SNuLsTyVn05yTIJOt0Sjj2kIgx6ay4hPO0Uhpb44gqAUEip0rN6+uBsA
 nTd3F/Q4+QJuW8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E901D136A5;
 Tue, 19 Dec 2023 14:48:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yj6KOEqtgWUMaQAAD6G6ig
 (envelope-from <pvorel@suse.de>); Tue, 19 Dec 2023 14:48:42 +0000
MIME-Version: 1.0
Date: Tue, 19 Dec 2023 15:48:42 +0100
From: pvorel <pvorel@suse.de>
To: Petr Vorel <pvorel@suse.cz>
In-Reply-To: <20231128125632.GB381183@pevik>
References: <20231120154248.15048-1-andrea.cervesato@suse.de>
 <20231128125632.GB381183@pevik>
User-Agent: Roundcube Webmail
Message-ID: <977d4dc47fa4c5163afc1a6646d4fb5a@suse.de>
X-Sender: pvorel@suse.de
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.59 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 XM_UA_NO_VERSION(0.01)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 BAYES_HAM(-1.29)[90.03%]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DfdJynLb;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VJRSMqai
X-Rspamd-Queue-Id: F2DFF1F7C9
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Delete fork09 test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

On 2023-11-28 13:56, Petr Vorel wrote:
> Hi Andrea,
> 
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
>> The fork09 test is actually testing what fork10 is already testing:
>> accessing an open child's file from parent. For this reason, we delete
>> it and let fork10 doing its job.
> 
> in fork09 parent opens maximum number of files, child closes one and 
> attempts to
> open another. That is not exactly the same, but it's very similar.
> 
> I'm not sure if the scenario would really tests different code path in
> kernel/libc or not and we can happily delete it.
> Cyril, WDYT?

@Li, WDYT?

> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
