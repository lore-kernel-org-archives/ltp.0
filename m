Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33844EE20AB
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 15:47:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96D953CD17F
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 16:47:40 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70BA63C932E
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 16:47:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EA7ED600736
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 16:47:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 69F355BCC9;
 Fri,  6 Feb 2026 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770392840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qi0HnhSvCUlfQkJ4bTsZgFbH+XfFGzwOaPgCWGsPzHE=;
 b=EuSR4kpWnQ5OLyMyPzhUpUyp/2ply0+aqqnp865126EBHBoYZswxMy0cfurKARB94+AejE
 zIGqEFflGKT1lX7m4vJDmHsXmmAmXcbzQKHwO2APO/nez0nphBna0OQdH7+GEMMD++A7Fl
 DsAVFyB3jdXTsQG4fKDgDrf03fDS/Rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770392840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qi0HnhSvCUlfQkJ4bTsZgFbH+XfFGzwOaPgCWGsPzHE=;
 b=Y63h/MdViCjo5ju+/Sytx7IkSMPGa7/36wwCqli5Ferj+nkrCQYpH5gYLw6mgw3xNWo6nF
 sJ53Qll8zKns54Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770392840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qi0HnhSvCUlfQkJ4bTsZgFbH+XfFGzwOaPgCWGsPzHE=;
 b=EuSR4kpWnQ5OLyMyPzhUpUyp/2ply0+aqqnp865126EBHBoYZswxMy0cfurKARB94+AejE
 zIGqEFflGKT1lX7m4vJDmHsXmmAmXcbzQKHwO2APO/nez0nphBna0OQdH7+GEMMD++A7Fl
 DsAVFyB3jdXTsQG4fKDgDrf03fDS/Rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770392840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qi0HnhSvCUlfQkJ4bTsZgFbH+XfFGzwOaPgCWGsPzHE=;
 b=Y63h/MdViCjo5ju+/Sytx7IkSMPGa7/36wwCqli5Ferj+nkrCQYpH5gYLw6mgw3xNWo6nF
 sJ53Qll8zKns54Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D3F93EA63;
 Fri,  6 Feb 2026 15:47:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ykNoDAgNhmlmPgAAD6G6ig
 (envelope-from <rbranco@suse.de>); Fri, 06 Feb 2026 15:47:20 +0000
Message-ID: <69de38e6-5540-4f56-8a98-feaf33012385@suse.de>
Date: Fri, 6 Feb 2026 16:47:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260205205609.147851-1-rbranco@suse.de>
 <aYX_DueFX9WiLHSu@yuki.lan>
Content-Language: en-US
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <aYX_DueFX9WiLHSu@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd: Add test using UFFDIO_POISON
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



On 2/6/26 3:47 PM, Cyril Hrubis wrote:
> Hi!
>> +static void run(void)
>> +{
>> +	pthread_t thr;
>> +	struct uffdio_api uffdio_api = {};
>> +	struct uffdio_register uffdio_register;
>> +	struct sigaction sa = {};
>> +	volatile char dummy;
>> +
>> +	sa.sa_handler = sigbus_handler;
>> +	sigemptyset(&sa.sa_mask);
>> +	SAFE_SIGACTION(SIGBUS, &sa, NULL);
>> +
>> +	set_pages();
>> +
>> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
>> +
>> +	uffdio_api.api = UFFD_API;
>> +	uffdio_api.features = UFFD_FEATURE_POISON;
>> +
>> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
>> +
>> +	uffdio_register.range.start = (unsigned long) page;
>> +	uffdio_register.range.len = page_size;
>> +	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
>> +
>> +	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
>> +
>> +	SAFE_PTHREAD_BARRIER_INIT(&barrier, NULL, 2);
> Why does this test need barriers and the rest of the tests that looks
> nearly the same does not?

This one is more complex because of the signal handling & siglongjmp.

In the other tests we can just wait for the handler thread. In this test we
must also coordinate with the signal handler,

The alternative would be fork + waitpid with WIFSIGNALED,

Best,
Ricardo.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
