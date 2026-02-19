Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F3BE9A03B
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 11:21:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8C1E3D0732
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 12:21:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C68113CA4ED
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 12:21:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 13CEB200268
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 12:21:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D4FB5BCC1;
 Thu, 19 Feb 2026 11:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771500080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7CM22KSY+gbj1bdhTZyAfGUbWya5nLzRCeOm5GhSgw=;
 b=Jzgzg21RhMM4FXo+9jCt+Zycwd/lpu/ON36fCRW/UkRTOYJtTLXUeIfFDktcMaoOar5Qx0
 jU1ATvqwaYchy1ZC59xulyVO/Q1BT5UC0uJUVUtdNlAV3sCBUFhjZzQzkAt0xtMszzhOuR
 3StW2f3h+aVhmaPmp6MeKvDPJvQgAug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771500080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7CM22KSY+gbj1bdhTZyAfGUbWya5nLzRCeOm5GhSgw=;
 b=9ABw0K3CP9fYGZ7B7U1ZtOp6cueTt/pI8mhrZ3onPwBXzTuQZE0sd64WylDwylmybayM+f
 djlqRyH4ixlMT1CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771500079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7CM22KSY+gbj1bdhTZyAfGUbWya5nLzRCeOm5GhSgw=;
 b=yVMkhjDsFXaezrsV6mnEGxq/5DAEHzxdAn4eStcWoUhX0facj/2bpfIne5ufjG4uSdwx9I
 zGkZ5LbcUeHRN+SjwYfsoym3GGDp8vMC6t923n5SLLln3C49RXTwD6jjXUvcOJcRRwpwrf
 fwj1or4dcs6Diz5p0PJSKTNOZCMKtxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771500079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7CM22KSY+gbj1bdhTZyAfGUbWya5nLzRCeOm5GhSgw=;
 b=EHbEZMDmdGB8X3cgYHSHCoTeydIBJb9wkQ2cUw1pYlnAo88LO5kNYtsHJHepU4HVvAtLer
 8Q62UjF6WuNsa3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8DF93EA65;
 Thu, 19 Feb 2026 11:21:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eagBLy7ylmn6JgAAD6G6ig
 (envelope-from <rbranco@suse.de>); Thu, 19 Feb 2026 11:21:18 +0000
Message-ID: <8b371cb1-b612-46c7-8cdc-8d9e4da09109@suse.de>
Date: Thu, 19 Feb 2026 12:21:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it
References: <20260218135026.159676-1-rbranco@suse.de>
 <DGIUIYEL9H07.TK6CF1O2WP7H@suse.com>
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <DGIUIYEL9H07.TK6CF1O2WP7H@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] userfaultfd: Add test using UFFDIO_POISON
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 2/19/26 10:54 AM, Andrea Cervesato wrote:
>> +	SAFE_PTHREAD_JOIN(thr, NULL);
>> +	reset_pages();
> This should also go into a cleanup(), otherwise if other syscalls will
> fail (ioctl for instance), memory will be lost.
Will fix this in userfaultfd06.c and then submit another to fix it in 
the rest.

> Also, if I run checkpatch.pl on the code I get:
>
> WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
> #25: FILE: userfaultfd06.c:25:
> +static volatile int poison_fault_seen;
>
> WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
> #26: FILE: userfaultfd06.c:26:
> +static volatile int sigbus_seen;
>
> WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
> #88: FILE: userfaultfd06.c:88:
> +       volatile char dummy;

I've seen volatile being used in tests. There are legitimate uses for 
this, in signal handlers.

> If you have `b4`, please run `b4 prep --check` before sending the patch.
I'm getting:
CRITICAL: This is not a prep-managed branch.

Best,
R.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
