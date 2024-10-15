Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE81CFC293
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 12:09:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 394F53C6724
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 14:09:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1E6C3C66EF
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 14:08:47 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3494F11E5072
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 14:08:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 941D51FB9A;
 Tue, 15 Oct 2024 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728994125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b8mvfWw/v4NtRqrOGDuF2zwwL7sX6wlpche17qmxovs=;
 b=Sylebg9KP8FUzbB17C1wzad36ZSbYsWN1Folr2tMFtfe9cDgn53SNGO0ZzOYr3kMItFUDl
 dXn84AF8NUgZ3/0guDYZljpp2QV1y9bVhyk9QnaVB/VxNGdgyj9XDA+qTLEoytj6T7BKO9
 tYTGvzV3hzSrX8GA3f4wKwZZBQ4WL1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728994125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b8mvfWw/v4NtRqrOGDuF2zwwL7sX6wlpche17qmxovs=;
 b=NMapZ5X2T06MH6AoH8tbaylq0oiwW39adudpkeAw8ZvhpGVAS1uMVv4hynBQy8D/kkoFn9
 4f6aQggwyDUjScAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728994125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b8mvfWw/v4NtRqrOGDuF2zwwL7sX6wlpche17qmxovs=;
 b=Sylebg9KP8FUzbB17C1wzad36ZSbYsWN1Folr2tMFtfe9cDgn53SNGO0ZzOYr3kMItFUDl
 dXn84AF8NUgZ3/0guDYZljpp2QV1y9bVhyk9QnaVB/VxNGdgyj9XDA+qTLEoytj6T7BKO9
 tYTGvzV3hzSrX8GA3f4wKwZZBQ4WL1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728994125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b8mvfWw/v4NtRqrOGDuF2zwwL7sX6wlpche17qmxovs=;
 b=NMapZ5X2T06MH6AoH8tbaylq0oiwW39adudpkeAw8ZvhpGVAS1uMVv4hynBQy8D/kkoFn9
 4f6aQggwyDUjScAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8191C13A53;
 Tue, 15 Oct 2024 12:08:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1KvJHk1bDme9VwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 15 Oct 2024 12:08:45 +0000
Date: Tue, 15 Oct 2024 14:07:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Zw5bCxNMuCz4aKWC@yuki.lan>
References: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
 <d53bcc8476d4c2ef37b92543b2f7fe8338420f0b.1728992854.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d53bcc8476d4c2ef37b92543b2f7fe8338420f0b.1728992854.git.jstancek@redhat.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/statmount07: change "invalid buffer
 size" test
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
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/statmount/statmount07.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/statmount/statmount07.c b/testcases/kernel/syscalls/statmount/statmount07.c
> index 0cc83429872f..58fcc20acce7 100644
> --- a/testcases/kernel/syscalls/statmount/statmount07.c
> +++ b/testcases/kernel/syscalls/statmount/statmount07.c
> @@ -20,10 +20,10 @@
>  static struct statmount *st_mount;
>  static struct statmount *st_mount_null;
>  static struct statmount *st_mount_small;
> +static struct statmount *st_mount_bad;
>  static uint64_t mnt_id;
>  static uint64_t mnt_id_dont_exist = -1;
>  static size_t buff_size;
> -static size_t buff_size_invalid = -1;
>  
>  struct tcase {
>  	int exp_errno;
> @@ -90,12 +90,12 @@ struct tcase {
>  	},
>  	{
>  		EFAULT,
> -		"invalid buffer size",
> +		"buffer crosses to PROT_NONE",
>  		&mnt_id,
>  		0,
>  		0,
> -		&buff_size_invalid,
> -		&st_mount
> +		&buff_size,
> +		&st_mount_bad
>  	},
>  	{
>  		EFAULT,
> @@ -139,6 +139,7 @@ static struct tst_test test = {
>  	.bufs = (struct tst_buffers []) {
>  		{&st_mount, .size = sizeof(struct statmount)},
>  		{&st_mount_small, .size = sizeof(struct statmount)},
> +		{&st_mount_bad, .size = 1},

With this we create a mapping where PROT_NONE is before the buffer, not
after it, since guarded buffers are primarily guarding about off-by-one
at the start of the buffer. There is a canaray after after the allocated
buffer that will potentialy be rewritten, but that would be detected
only at the test exit.

If I remmeber correctly the mappings will look like:

| PROT_NONE |_ CANARY BYTES |
             ^
	     And this is our 1-byte buffer.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
