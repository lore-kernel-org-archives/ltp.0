Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C8ECEFC26
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 15:41:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBAB93C21E7
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 17:41:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69D8F3C1C8A
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 17:41:01 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 538E0200C7E
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 17:40:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 98D2721D1B;
 Tue,  8 Oct 2024 15:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728402058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DbcScCUmqo5puM7eLQBwt1aUwF6Pb7qTqC/DXYbfj6A=;
 b=GRNJ0qVusDkcvBXo6w4acQepS1eVRNEtopCthCAE1g0iONRRgS0YovcA59dcq5HPcwvX94
 aF6mULf2K/Xj/YeaSh683WiLFEbCnvjq2eMJWTjY2ie0YNcmhsovKHSl0n2/rgqOCocQNY
 9QkdegbBJOXeWgWXUP7QYTrreaXmJ+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728402058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DbcScCUmqo5puM7eLQBwt1aUwF6Pb7qTqC/DXYbfj6A=;
 b=4BAqiJvmjHB5lYOzcR73vUUJ2SUYMQqMoeQi+rukQkgYvcccpW9D0XLP0yKPSkYwC5WrnN
 cQoeVAm3Z155RzAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728402058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DbcScCUmqo5puM7eLQBwt1aUwF6Pb7qTqC/DXYbfj6A=;
 b=GRNJ0qVusDkcvBXo6w4acQepS1eVRNEtopCthCAE1g0iONRRgS0YovcA59dcq5HPcwvX94
 aF6mULf2K/Xj/YeaSh683WiLFEbCnvjq2eMJWTjY2ie0YNcmhsovKHSl0n2/rgqOCocQNY
 9QkdegbBJOXeWgWXUP7QYTrreaXmJ+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728402058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DbcScCUmqo5puM7eLQBwt1aUwF6Pb7qTqC/DXYbfj6A=;
 b=4BAqiJvmjHB5lYOzcR73vUUJ2SUYMQqMoeQi+rukQkgYvcccpW9D0XLP0yKPSkYwC5WrnN
 cQoeVAm3Z155RzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CBDA1340C;
 Tue,  8 Oct 2024 15:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Fs0GHopSBWcqOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 08 Oct 2024 15:40:58 +0000
Date: Tue, 8 Oct 2024 17:39:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZwVSTk7lHAffDpyo@yuki.lan>
References: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
 <20241008-listmount_statmount-v5-16-66f4e1a9e7db@suse.com>
 <ZwVJHzkFhggPqrik@yuki.lan>
 <781538d9-fa64-4352-af94-6ee0edc7d2c4@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <781538d9-fa64-4352-af94-6ee0edc7d2c4@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[3]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 16/16] Add listmount04 test
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
> >> +	{
> >> +		.req = &request_small,
> >> +		.mnt_ids = mnt_ids,
> >> +		.nr_mnt_ids = MNT_SIZE,
> >> +		.flags = 0,
> >> +		.exp_errno = EINVAL,
> >> +		.msg = "request has insufficient size",
> >> +	},
> > It took me a while to realize that this is a request with .size set to
> > 0, which is obviously rejected as invalid. Maybe it should be called
> > request_zero_size instead.
> This is actually a request with a small memory size for mnt_id_req. I 
> remove 4 bytes allocation from the struct, so it doesn't make sense 
> request_zero_size.

But you pass the size as a zero, at least I do not see that you ever set
request_small->size.

> > Also there is quite a bit more errors we can trigger, looking at
> > statmount kernel syscall we can easily trigger at least:
> >
> > - param > 0 && param <= MNT_UNIUQE_ID_OFFSET -> EINVAL
> > - spare != 0 -> EINVAL
> > - nonexisting mnt_ns_id -> ENOENT
> >
> Andrea

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
