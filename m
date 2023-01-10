Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF23C54EBE
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 09:32:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F23343CB587
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 10:32:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 430B03C85F1
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 10:32:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 98021200B19
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 10:32:20 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D49334DAA4;
 Tue, 10 Jan 2023 09:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673343139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=16QwJwszBBzpyiLhKGj0EoPU36FEf5qWeaGCOS4nqjY=;
 b=k7jpA0f8dlDVKQlYnXJURmZSWgS4Z+B4XK/6DkQRf/dnrLo4Gh/DA/rsFz1RqRHDALfKnT
 h6MWzen9Z8hYnYANe6C4AboLBuXhoA2lOtFdTDCNXuQ6bSTt6iuRNbvgm02T+QScmZZkTd
 kcQZWTQvD+jMSBFEyMrQPJbZXD+9b44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673343139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=16QwJwszBBzpyiLhKGj0EoPU36FEf5qWeaGCOS4nqjY=;
 b=0rY/sIbiYe4U3KRIpkKeJEtK42l7S47rzY1e6UotijjuEhJ48Qj5mHX9aG3iS7Jg4y3Ng0
 bZxozJkn7ujr6RCA==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 46F5E2C141;
 Tue, 10 Jan 2023 09:32:19 +0000 (UTC)
References: <20230103124505.6611-1-pvorel@suse.cz>
 <20230103124505.6611-2-pvorel@suse.cz>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Jan 2023 09:25:20 +0000
Organization: Linux Private Site
In-reply-to: <20230103124505.6611-2-pvorel@suse.cz>
Message-ID: <87lemaivkv.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] configure.ac: Update AC_PROG_AR related
 comment
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
Reply-To: rpalethorpe@suse.de
Cc: Mike Frysinger <vapier@gentoo.org>, Zack Weinberg <zackw@panix.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> AC_PROG_AR was added much later: in v2.72a [1]. Also it looks like that
> redefinition is not a problem thus not wrapping with m4_ifndef([AC_PROG_AR].
>
> NOTE: missing 'ar' don't fail configure (isn't the check useless then?):
> $ rm -rf autom4te.cache/; ma autotools && ./configure; echo $?
> ...
> configure:4878: checking for ar
> configure:4913: result: no
> ...
> 0
>
> [1] https://git.savannah.gnu.org/cgit/autoconf.git/commit/?id=c48fdb81191c8b7c7c0dde6141b861b178a6a284
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  configure.ac                    | 3 +--
>  testcases/realtime/configure.ac | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index c2b0f48e79..edf00687f2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -20,8 +20,7 @@ AM_MAINTAINER_MODE([enable])
>  AC_CANONICAL_HOST
>  
>  AC_PROG_CC
> -# <= autoconf 2.61 doesn't have AC_PROG_AR, but 2.63 has it. Not sure about
> -# 2.62.
> +# autoconf >= v2.72a

This reads like we need the def for autoconf => v2.72a. How about

# for autoconfig < v2.72a

Also which distro(s) do we support which have < v2.72a? We maybe can
include that here *if known*.

>  AC_DEFUN([AC_PROG_AR], [AC_CHECK_TOOL(AR, ar, :)])
>  AC_PROG_AR
>  AC_PROG_RANLIB
> diff --git a/testcases/realtime/configure.ac b/testcases/realtime/configure.ac
> index 6f50f1490f..39f16f1779 100644
> --- a/testcases/realtime/configure.ac
> +++ b/testcases/realtime/configure.ac
> @@ -12,8 +12,7 @@ AC_CHECK_HEADERS_ONCE([ \
>  AC_CANONICAL_HOST
>  
>  AC_PROG_CC
> -# <= autoconf 2.61 doesn't have AC_PROG_AR, but 2.63 has it. Not sure about
> -# 2.62.
> +# autoconf >= v2.72a
>  AC_DEFUN([AC_PROG_AR], [AC_CHECK_TOOL(AR, ar, :)])
>  AC_PROG_AR
>  AC_PROG_RANLIB
> -- 
> 2.39.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
