Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7252C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 16:14:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 173373CFBF6
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 17:14:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5A283CFBF2
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:13:59 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D59DB1002025
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:13:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD868347A3;
 Wed, 20 Mar 2024 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710951238;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qC9zhECEqj3mWyTpQH0YHg8+Gc2y5EIPVccZw6BQ5s=;
 b=FJGrNcGgfBFemKXvRPHqTh6f0tCresG/7LsExrA1fiiOIEOmwU1OHuhYxexRwpw7xm2N49
 xldNSdG1P8bHVqLqsAL5mDkykE0rXcT1E4lyyA2bVlgsgZuBZrV/v19iifPOY/A8eN8vtB
 TuqVubVxlBLzvm3AfexCKpcUT5vr3eE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710951238;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qC9zhECEqj3mWyTpQH0YHg8+Gc2y5EIPVccZw6BQ5s=;
 b=UfkWaVOTxlaskaEpf4XCPmlxsGW8O0UA1ZVOnd8PzxhZqw31Hizm6bpLq+8F2tJONttZtK
 TuzoLCvkozaWaHCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710951237;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qC9zhECEqj3mWyTpQH0YHg8+Gc2y5EIPVccZw6BQ5s=;
 b=pxENAeM319kLpoW3IoJtOw5XjY8I2U7WNBGAhvhLzfWOQxZwvMNse+ZJkK69zAuGsMjTC5
 HkBU4/8IuOCb+z+jnfAUJnooD0vZIA3jWWo4buGZgAfQzLCp5ssXdzMgBaqawoHYEzxNKZ
 8wgVVik89dI7Zf7phUk33BABKLMvZr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710951237;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qC9zhECEqj3mWyTpQH0YHg8+Gc2y5EIPVccZw6BQ5s=;
 b=7Y1SS5PFRyhuGhXtoqOC7DWTsQx771qbvCRGxlXENo5HaGqm5lZCHox9e5jo/ZvkSg1BaK
 6kg474hBnSdAEoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C875136D6;
 Wed, 20 Mar 2024 16:13:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AdOZJ0IL+2XiYwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 16:13:54 +0000
Date: Wed, 20 Mar 2024 17:13:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Message-ID: <20240320161348.GD489473@pevik>
References: <20240313235011.1157132-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240313235011.1157132-1-po-hsu.lin@canonical.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.53 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.03)[56.73%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] scenario_groups/default: remove connectors test
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

Hi,

> The connectors test has been merged into kernel_misc with commit
> 9b642d89c0 ("runtest: Merge runtest/connectors to kernel_misc").

I'm sorry, although you were faster with this, I first noticed pull request,
which I already  merged.
https://github.com/linux-test-project/ltp/pull/1144

Thanks!

Kind regards,
Petr

> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  scenario_groups/default | 1 -
>  1 file changed, 1 deletion(-)

> diff --git a/scenario_groups/default b/scenario_groups/default
> index f17b2061a..ec77d8fb8 100644
> --- a/scenario_groups/default
> +++ b/scenario_groups/default
> @@ -16,7 +16,6 @@ controllers
>  filecaps
>  cap_bounds
>  fcntl-locktests
> -connectors
>  power_management_tests
>  hugetlb
>  commands

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
