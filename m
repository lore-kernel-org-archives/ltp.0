Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DEBC61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 11:33:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5C793EA7BA
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 13:33:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 251FF3E9A3D
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 13:32:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8FD271400DA7
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 13:32:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D4BA6219B4;
 Thu,  3 Sep 2026 11:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788435169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nMk09//pkedeLZgVEi/MTJvCyBQfwE118AQC3mP8Sxk=;
 b=I0+NYPK4f6Jjz/b1I+SLu+4ldboXBaXP+jIyqEW1bD8N2MVlvVRJWzbJd2HaWWPwuIyNdW
 c2ILzKhtHf+1MTQ7Rg+vbfX7xSP/KQiB618uaJ50QUp9AnwgBTIbj8CGFl2BeqKntJclul
 f/UfyW3m2Gp9W4PM1BWtmT2PaxMYhjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788435169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nMk09//pkedeLZgVEi/MTJvCyBQfwE118AQC3mP8Sxk=;
 b=mhf208nLVDLEK/4nO/Cbs8O+pyvWsOg6vUcPXhZ0lO9IjACuk0APBpZvGK4l0iEo3RD+lL
 zSwaWKjoP0Y0w1DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788435164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nMk09//pkedeLZgVEi/MTJvCyBQfwE118AQC3mP8Sxk=;
 b=xXhdJVhmNatHDLgzCYSuGEx+ZDhktT1TQpXz4ZH+njnB9ekdyAt5PTvr9kVF4gxH4EVT+y
 3iJQu7yrQXkz/46NxOtgLxnKgre49UpHf8EsSWKuoQZIOptkV5hQq1eJ4/2nr0rf+QtE4D
 ImyDndfb4zf6OdYPXBuwRZCIgRoLwNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788435164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nMk09//pkedeLZgVEi/MTJvCyBQfwE118AQC3mP8Sxk=;
 b=vxMgwxfsBEUvM+NBnuCnw9rADsPsoS/cQq+0POhxetTABT0IGZJeV8oMIOehYVmxv2TMpx
 lNsct6GgswUvmkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF39B136E6;
 Thu,  3 Sep 2026 11:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EezFKtxamWrgYQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 03 Sep 2026 11:32:44 +0000
Date: Thu, 3 Sep 2026 13:32:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <apla4DklqK8990v6@yuki.lan>
References: <20260828-swapon_discard_coverage-v3-0-136924a1a730@suse.com>
 <20260828-swapon_discard_coverage-v3-3-136924a1a730@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260828-swapon_discard_coverage-v3-3-136924a1a730@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] swapon02: Add test cases for invalid
 swapflags
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  static void setup(void)
> @@ -66,20 +96,20 @@ static void cleanup(void)
>  
>  static void verify_swapon(unsigned int i)
>  {
> -	struct tcase *tc = tcases + i;
> +	struct tcase *tc = &tcases[i];
> +
>  	if (tc->exp_errno == EPERM)
>  		SAFE_SETEUID(nobody_uid);
>  
> -	TST_EXP_FAIL(tst_syscall(__NR_swapon, tc->path, 0), tc->exp_errno,
> +	TST_EXP_FAIL(tst_syscall(__NR_swapon, tc->path, tc->flags), tc->exp_errno,
>  		     "swapon(2) fail with %s", tc->err_desc);
>  
>  	if (tc->exp_errno == EPERM)
>  		SAFE_SETEUID(0);
>  
> -	if (TST_RET != -1) {
> -		tst_res(TFAIL, "swapon(2) failed unexpectedly, expected: %s",
> -			tst_strerrno(tc->exp_errno));
> -	}
> +	/* If swapon() unexpectedly succeeded, undo it for the next iteration */

This probably falls into commenting the obvious.

> +	if (TST_RET == 0 && tst_syscall(__NR_swapoff, tc->path) != 0)
> +		tst_res(TWARN | TTERRNO, "swapoff(%s) failed", tc->path);
>  }
                                 ^
				 TERRNO

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
