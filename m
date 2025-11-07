Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A8ACCF9F8
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 12:19:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 300E73CEE76
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 13:19:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 573E03CEA0D
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 13:19:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AEB4A200CE1
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 13:19:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F107E1F393;
 Fri,  7 Nov 2025 12:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762517977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IHBLLZnQAS2EDfVpeIZQa6OmVAFn3b7oU3Ggic5EIxc=;
 b=BHeL4/trpr3zbOAZ2VhAdjI+O15Fl0quQkPIVQvzK8rI7sxMiToYJjun7jDQ8fpVdQ7FKz
 aTYUqT73cfE3sm6EROBe9uYe00pOomZpzxHHc3YwFhGtDwq/4OVTFVc9YNDThBQmPyL6G8
 9mHUF8Bg4JDFBczMFZIDTRivYF5GRvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762517977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IHBLLZnQAS2EDfVpeIZQa6OmVAFn3b7oU3Ggic5EIxc=;
 b=CB8N3TjHu+1PP5YuZmFRwzzD52mcXML04mEWaRk7J5dOqqe96mNRHo80jj7u3gCmrlsFdh
 GYmB4DH3FFgsmhAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762517976;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IHBLLZnQAS2EDfVpeIZQa6OmVAFn3b7oU3Ggic5EIxc=;
 b=aSpt6eDZAUrtWWDaH2PTYRkaP8K3i9qne16ZXxkVtYCz75vGegT8DrkxMQakSo9zFK4fkH
 E615+a5Xn/tPtNzmAPeTfULIa5fQhhn5Vm5RONgLc+JjxMJwEvBArQdyE7hR4PcTRP6bHi
 x7bBOMiihjyoYwIt97Diub8yylWLS4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762517976;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IHBLLZnQAS2EDfVpeIZQa6OmVAFn3b7oU3Ggic5EIxc=;
 b=t1KzjLAnwNA0fadJpF5tDqiGEq5+4l7ygeQwIBhvQsCbYbG/BptlzsWq3AieLz79ass0FE
 wazBJLi0RGAA8PBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE8891395F;
 Fri,  7 Nov 2025 12:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aERyMdjjDWkCLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Nov 2025 12:19:36 +0000
Date: Fri, 7 Nov 2025 13:19:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: jiaying.song.cn@windriver.com
Message-ID: <20251107121935.GA1126593@pevik>
References: <20251020111315.2338881-1-jiaying.song.cn@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251020111315.2338881-1-jiaying.song.cn@windriver.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/time01:Avoid using TST_RET in time()
 test to support Y2038-safe time_t
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

Hi Jiaying,

> On 32-bit systems with Y2038 support, time_t is 64-bit while TST_RET
> remains a long (usually 32-bit).Using TST_RET to store the return value
> of time() causes overflow after 2038, leading to incorrect comparisons
> and false test failures like:

>     TFAIL: time() returned value -2085977741, stored value 2208989555 are different

> This patch replaces usage of TST_RET with a local variable of type
> time_t (ret_time), ensuring correct behavior with large timestamps and
> avoiding truncation.

+1

...
> +++ b/testcases/kernel/syscalls/time/time01.c
> @@ -23,24 +23,23 @@ static time_t *targs[] = {
>  static void verify_time(unsigned int i)
>  {
>  	time_t *tloc = targs[i];
> +        time_t ret_time = time(tloc);

> -	TEST(time(tloc));

nit: wrong whitespace indent (can be fixed before merge).

Fixed that and merged.

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
