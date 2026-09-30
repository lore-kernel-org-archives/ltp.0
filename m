Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADCFCA5FC1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 09:10:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E2033E55FD
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 11:10:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5856E3E55CF
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 11:10:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C7A00140004C
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 11:10:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BE3A21F88D;
 Wed, 30 Sep 2026 09:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790759430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wymqWvd0Lb8kKTiS3evFWCMSCHKTeRDo+L8RT1vwQnA=;
 b=zbEnEFHjKWu0ShE7o8UV7RKnw+xi0zDCUF83G43DH7FJfFNuRgfbYHzoG2ZAEYadumrLIw
 ljCGU23IDcueZpuVihcLYH0buQYIgsMES+nI+eD1f5EAie3GKdTfNAVh09gLYFE/ghcwn0
 5n74m+TlEaYSi0ZEk7plpmTr2uiNK6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790759430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wymqWvd0Lb8kKTiS3evFWCMSCHKTeRDo+L8RT1vwQnA=;
 b=ESong8iCHanmSmydeDYHvTn3l7E1gtQLe512Q8Rz0SuLU4lQulk+aQ1BmDCcl+YjWvNJAU
 zNrSFqK+YuR22WCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790759426;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wymqWvd0Lb8kKTiS3evFWCMSCHKTeRDo+L8RT1vwQnA=;
 b=U7s6hkis4qSaqT/ax8mUD2cftIfeY+Z55/+7aGiSTtkNnQgtKr8WvI1oVRUGBhxOqJBFOi
 N3d/Uw1hfH/coCxSaxN0XhonET9bDoVdknNOHJczL7RazRK49TfrHn6xhIFhQSK9iJNi/h
 OnGHRayf+LdYJcM8byIKpYOvprmxG7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790759426;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wymqWvd0Lb8kKTiS3evFWCMSCHKTeRDo+L8RT1vwQnA=;
 b=azRzEJa3+V9qWdWZPmBcLUvmvfASlUfAX1FoLppHEyEUv1jzCqQHmd1KvMVnaJzXZuHfDN
 WFAvXp2lBHg23hAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7864013A91;
 Wed, 30 Sep 2026 09:10:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4j1AEwLSvGpmJgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Sep 2026 09:10:26 +0000
Date: Wed, 30 Sep 2026 11:10:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260930091021.GB2623399@pevik>
References: <20260930073556.GA57146@pevik>
 <20260930084603.947906-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260930084603.947906-1-avinesh.kumar@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] openposix: timer_*/speculative: fork() to
 isolate the SIGSEGV on old glibc
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

Hi Avinesh,

> Commit d377d1cff1ec ("openposix: timer_*/speculative: Don't pass a
> stack pointer as timerid") fixed a SIGSEGV on i586, where current
> glibc's sign-bit check (timer_is_sigev_thread()) can misread a stack
> address as a tagged pointer. A small constant avoids that.

> But older glibc (<= 2.31, before this check existed) unconditionally
> dereferences timerid as a pointer, so the same small constant now
> faults instead:

>   timer_delete_sp[13131]: segfault at 186a3 ip 00007f15973aed4e sp 00007ffefb52c5a0 error 4 in librt-2.31.so[7f15973aa000+8000]

> fork() a child to make the call, then inspect the child's exit status.
> POSIX defines no required behavior for an invalid timer ID (EINVAL is
> only a recommendation), so the child being killed by SIGSEGV or SIGBUS
> is treated as success.

> Fixes: d377d1cff1ec ("openposix: timer_*/speculative: Don't pass a stack pointer as timerid")
> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
>  .../interfaces/timer_delete/speculative/5-1.c | 56 +++++++++++-----
>  .../timer_getoverrun/speculative/6-1.c        | 55 +++++++++++-----
>  .../timer_gettime/speculative/6-1.c           | 58 +++++++++++-----
>  .../timer_settime/speculative/12-1.c          | 66 +++++++++++++------
>  4 files changed, 169 insertions(+), 66 deletions(-)

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
> index dce9277b5d6a..8e7d1b2e54dc 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
> @@ -5,34 +5,58 @@
>   * of this license, see the COPYING file at the top level of this
>   * source tree.

> - * Test to see if timer_delete() returns -1 and sets errno==EINVAL if
> - * timerid is not a valid timer ID or not.
> - * Since this is a "may" requirement, either option is a PASS.
> + * Test to see if timer_delete() sets errno==EINVAL for an invalid
> + * timerid. Recent POSIX versions leave this behavior undefined, so

nit: I suggest before merge to mention the version:

"Recent POSIX versions leave" => "/Since POSIX 2016 Edition is"

(no need for v4). Why? In 5+ years we can hopefully delete those tests.
Specifying the version saves somebody searching it again.

The code itself LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
