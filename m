Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C5FC07545
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 09:32:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 902023CEC75
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 11:32:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D06233CCF04
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 11:32:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1061B60137A
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 11:32:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F6CD218B5;
 Tue, 24 Oct 2023 09:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698139948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UImzd1sh/LRAfCtTn0HquaaS7ETWYcPhZNl0LU4i+fk=;
 b=cTLYjheovoUWfbwNhyQ/I4KCUJNbmBtE846GWcWJaOW7qlPhMEcw5YV755oQCeyS5+2emV
 d2KqiPYOXj/YKr4hbZJn7sRndG4F4Hs3aChriKSsgxytOiUsjF4V1JwOh7v0wlSTjWWSas
 t76ZSrg7wjV7dzehOn4YHd1u/PkZAl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698139948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UImzd1sh/LRAfCtTn0HquaaS7ETWYcPhZNl0LU4i+fk=;
 b=8PH5YLrxfqGi215w8IbCf21pO6Rh6U0apZkSeM4rIL/yvkCu+g2FFqBMshiFxDLpdJD3Wi
 foxWsTVvhY3gXKBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C7D0134F5;
 Tue, 24 Oct 2023 09:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id o0c8GiyPN2UTCAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 24 Oct 2023 09:32:28 +0000
Date: Tue, 24 Oct 2023 11:33:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZTePTBOKBQDK0v24@yuki>
References: <20231014033104.31424-1-wegao@suse.com>
 <20231017131646.1297-1-wegao@suse.com> <ZTaAUO1-Jr3BbJa9@yuki>
 <20231024091052.GA219060@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231024091052.GA219060@pevik>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.49)[97.68%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [CI FAILURE] Re: [PATCH v4] Add test for UI_GET_NAME ioctl
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
> > I've adjusted the FAIL/PASS messages and pushed, thanks.
> 
> UI_GET_NAME() from include/uapi/linux/uinput.h is not on the old CentOS 7 we
> still support:
> 
> https://github.com/linux-test-project/ltp/actions/runs/6614554688/job/17964785134
> /__w/ltp/ltp/testcases/kernel/input/input_helper.c:194:2: error: implicit declaration of function 'UI_GET_SYSNAME' [-Werror=implicit-function-declaration]
>   SAFE_IOCTL(NULL, fd, UI_GET_SYSNAME(sizeof(sys_name)), sys_name, NULL);
>   ^
> 
> I'll have look later today for the fix. I suppose we need lapi/uinput.h with
> adds a fallback definition. It was added in kernel v3.15 in
> e3480a61fca7 ("Input: uinput - add UI_GET_SYSNAME ioctl to retrieve the sysfs path")
> 
> Also, there is also an API version change, we could use this if simple ifndef
> UI_GET_SYSNAME + fallback will not be enough (e.g. test fails because it
> requires newer kernel API).
> 
> -#define UINPUT_VERSION         3
> +#define UINPUT_VERSION         4

Given that UI_GET_SYSNAME is a macro we can do as well:

#ifndef UI_GET_SYSNAME
# define UI_GET_SYSNAME(len) ...
#endif

However at the same time we would need to actually check if the ioctl is
supported or not, because if the CentOS 7 kernel does not support
UI_GET_SYSNAME ioctl() the SAFE_IOCTL() will fail with EINVAL.

Also looking at the linux/uinput.h there are three more ioctls() added
in version 5 that should be tested as well. I suppose that we will need
add an issue for that.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
