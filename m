Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD175C10F1A
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 10:05:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67C7E3CE0E7
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 12:05:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC0EA3C02C5
 for <ltp@lists.linux.it>; Thu,  9 May 2024 12:05:30 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 00A751A008B9
 for <ltp@lists.linux.it>; Thu,  9 May 2024 12:05:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD09D22151;
 Thu,  9 May 2024 10:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715249129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mw3uuTmNLPymP8alybB4eDL/PVK12owWOUih+Ylk8pk=;
 b=GLt02uiIjKbdtuI+Aebasf54BZDveqLoluBFELfdu1ytNIz5EeZLC4VhM77V1jX8LE4izY
 Z/efzWu5kdE+Mk6udeNU3Y4Z1fpqEzA7qKdXsx/04hm3w/PCDg5Pe8F/KgXyHWxKt0/Vq+
 yia5WOdPG7iKpOpkKqlujM9g1AQX1vY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715249129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mw3uuTmNLPymP8alybB4eDL/PVK12owWOUih+Ylk8pk=;
 b=SGbJVmyfcr1wgJ+OcsW+d946gP5w66KGUdRhpZIrz3aArjSY+16CoX2Lw6ab5SGlvFlbvv
 ckNS9v9O8UkhpVCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715249128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mw3uuTmNLPymP8alybB4eDL/PVK12owWOUih+Ylk8pk=;
 b=BBKq42E6j7ESqI7SdZE++YhozGovNHZsX5XtvnpreGbE4KU9NmaT/Qcig91o8peaGfLomn
 I3vZwe7ThKxKWxhzREUMDVyvUuwsbwRgY6w6wBf/0JH/4akgPXfamMWA5mmJ4vh2hr8sd1
 AJh7R9M/8WlS9ZWQOWjFx4MVw5qry0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715249128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mw3uuTmNLPymP8alybB4eDL/PVK12owWOUih+Ylk8pk=;
 b=wTi3EwsixNuMkNH2OTz2GPIAN6nG2M9k9ECRXemqw6r49A9anSjyu+A/5pcizo19YTA/eh
 KmJ8JZhsQSIYb8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC02513941;
 Thu,  9 May 2024 10:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vufWLOifPGYuOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 May 2024 10:05:28 +0000
Date: Thu, 9 May 2024 12:04:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zjyfukg9pEwAb4aP@yuki>
References: <20240419124221.207445-1-pvorel@suse.cz>
 <20240419124221.207445-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240419124221.207445-2-pvorel@suse.cz>
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 URI_HIDDEN_PATH(1.00)[https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] doc: Clarify that the only public CI testing
 is build only
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
> Also convert .github/workflows/ci.yml as link to github
> (unfortunately that remove code formatting).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/developers/writing_tests.rst | 4 ++--
>  doc/users/supported_systems.rst  | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
> index 032fbcbd5..3db56a558 100644
> --- a/doc/developers/writing_tests.rst
> +++ b/doc/developers/writing_tests.rst
> @@ -346,8 +346,8 @@ Testing builds with GitHub Actions
>  Master branch is tested in `GitHub Actions <https://github.com/linux-test-project/ltp/actions>`_
                   ^
		   build
>  to ensure LTP builds in various distributions, including old, current and
>  bleeding edge. ``gcc`` and ``clang`` toolchains are also tested for various
> -architectures using cross-compilation. For a full list of tested distros, please
> -check ``.github/workflows/ci.yml``.
> +architectures using cross-compilation. For a full list of tested distros, please check
                                                            ^
							    build
> +`.github/workflows/ci.yml <https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml>`_.
>  
>  .. note::
>  
> diff --git a/doc/users/supported_systems.rst b/doc/users/supported_systems.rst
> index 82774c2ef..a9086f4d8 100644
> --- a/doc/users/supported_systems.rst
> +++ b/doc/users/supported_systems.rst
> @@ -3,6 +3,12 @@
>  Supported systems
>  =================
>  
> +Build testing is done with `GitHub Actions <https://github.com/linux-test-project/ltp/actions>`_.
> +
> +.. note::
> +
> +      There is no CI testing of the actual tests run.

Maybe a bit better "There is no CI for the actual test runs."

>  Kernel version
>  --------------
>  
> @@ -38,6 +44,9 @@ Oldest tested distributions
>        - 10.2.1
>        - 11.0.1
>  
> +For a full list of tested distros, please tested distros, pleae check
                     ^
		     build
> +`.github/workflows/ci.yml <https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml>`_.
> +
>  Older distributions are not officially supported, which means that it
>  may or may not work. It all depends on your luck. It should be possible
>  to compile latest LTP even on slightly older distributions than we
> -- 
> 2.43.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
