Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187B0C64ED6
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 11:27:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F5223CDE36
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 12:26:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2E773CAF43
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 12:26:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D92E123EC42
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 12:26:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 978071FD63;
 Mon, 27 Feb 2023 11:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677497207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dbvGRQrFeEdPg+H84CXUgDaSkESq7Rjlt3MjDL1NSEk=;
 b=je9d1BBIjoCeroERi47IwkWKpY5j/E4fs8BtnvfZlbjTvGOvNbWRiTB80XyS35BCrLBQCe
 maMsQ+phrs/lVMPWFIHB61dwB2She6m9j7viWTjMVEtg3uppVwH1UNb0lap1cexOgi9Xgq
 Sywif7rqCrv1bKHI1PAv31XrHXUBm00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677497207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dbvGRQrFeEdPg+H84CXUgDaSkESq7Rjlt3MjDL1NSEk=;
 b=Av4IJddd1p/sIFZyjLbQt86gvQ19ki+h8X7vx4BoxAeMARNgl2xoPltvxON1O7rJ8+m36D
 FUPezx6yQkzKDtDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8428D13912;
 Mon, 27 Feb 2023 11:26:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0DhBH3eT/GOwGQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 27 Feb 2023 11:26:47 +0000
Date: Mon, 27 Feb 2023 12:28:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Message-ID: <Y/yTyk9rYYsPJyVA@yuki>
References: <20230226192554.669332-1-fontaine.fabrice@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230226192554.669332-1-fontaine.fabrice@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure.ac: fix mount_attr detection
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
> Commit b857f8723f30a4b9554bf6b0ff8fa52fd07e8b60 tried to fix build with
> latest glibc which provides mount_attr in sys/mount.h. Unfortunately,
> the following build failure is still raised because sys/mount is now
> unconditionally included in include/lapi/fsmount.h:
> 
> In file included from fsconfig01.c:9:
> ../../../../include/lapi/fsmount.h:55:8: error: redefinition of 'struct mount_attr'
>    55 | struct mount_attr {
>       |        ^~~~~~~~~~
> In file included from ../../../../include/lapi/fsmount.h:14:
> /home/autobuild/autobuild/instance-4/output-1/host/armeb-buildroot-linux-gnueabi/sysroot/usr/include/sys/mount.h:210:8: note: originally defined here
>   210 | struct mount_attr
>       |        ^~~~~~~~~~
> 
> Fixes:
>  - http://autobuild.buildroot.org/results/4dbb72e1bf081afd3cd944571b9beeefc7608865
> 
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> ---
>  configure.ac | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index c2b0f48e7..a6d8ac826 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -225,10 +225,10 @@ AC_CHECK_TYPES([struct __kernel_old_timeval, struct __kernel_old_timespec, struc
>  
>  AC_CHECK_TYPES([struct futex_waitv],,,[#include <linux/futex.h>])
>  AC_CHECK_TYPES([struct mount_attr],,,[
> -#ifdef HAVE_LINUX_MOUNT_H
> -# include <linux/mount.h>
> -#else
> +#ifdef HAVE_MOUNT_SETATTR
>  # include <sys/mount.h>
> +#elif HAVE_LINUX_MOUNT_H
> +# include <linux/mount.h>
>  #endif
>  ])

I wonder if we can get this whole mess of two different fallback headers
simplified. Looking at the glibc implementation it seems to include
"linux/mount.h" if it does exist. So most reasonable solution would do
the same I guess which we did before the commit you reference.

@Li Wang where does the the sys/mount.h and linux/mount.h conflict? As
far as I can tell the UAPI linux/mount.h never defined any functions,
just constants, which should be solvable without the complex ifdefs, we
just need to check for existence of the types and define them only if
missing.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
