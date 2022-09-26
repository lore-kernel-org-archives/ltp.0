Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BE8C32771
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 19:26:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A72D93CAE07
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 21:26:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E5073C1BAD
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 21:26:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7B9D0100048C
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 21:26:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 62D161FCDA;
 Mon, 26 Sep 2022 19:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664220396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dRwJd3d6sx39QbmfAVPA3uG1E2hrCuJ7qJJ6Nq4LqbY=;
 b=1eFjKwisGBMIWOiKZFIHYxqmTI40eiYB/ScQcpuPPeCrPyCmf3xRVVgchAuADADS+OvH9D
 i+ty59bNDUVCr57dsgEjZCNT0vWbWnvV1voAwIDk9uCx3uE7wRd0buhl7/Tzs7uPC+tcFm
 FMaF8SYVLk/OZPt6Jt5+Fxuh8mP0geI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664220396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dRwJd3d6sx39QbmfAVPA3uG1E2hrCuJ7qJJ6Nq4LqbY=;
 b=2fcLGH1AIXPglItrDPoyBCb04KDpGI7pCt8AU85xcAl9NClauI5JY66VoEjYYgeUR41Yx9
 wiNkb2w7CZ1N/ZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F6BC13486;
 Mon, 26 Sep 2022 19:26:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id i2zICez8MWNzAgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 26 Sep 2022 19:26:36 +0000
Date: Mon, 26 Sep 2022 21:26:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Message-ID: <YzH86TOjFZj3cUwq@pevik>
References: <20220926165949.23407-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220926165949.23407-1-mpdesouza@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure.ac: Fix redefinition of mount_attr by
 checking sys/mount.h
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

Hi Marcos,

> mount_setattr and mount_attr are defined in sys/mount.h.

> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  Tested on openSUSE Tumbleweed

>  configure.ac | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/configure.ac b/configure.ac
> index 1deeffc0c..0e9895415 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -71,6 +71,7 @@ AC_CHECK_HEADERS_ONCE([ \
>      sys/epoll.h \
>      sys/fanotify.h \
>      sys/inotify.h \
> +    sys/mount.h \

Well, we don't add check for this, as sys/mount.h has been here since "ever", so
it'd just make configure little bit slower for no gain.

But you'd have to use somewhere compiler macro #ifdef HAVE_SYS_MOUNT_H, as this
macro is generated by configure script. Adding header to the list does nothing.

You obviously wanted to fix something, could you post the problem you're trying
to solve + steps you did to ML?

BTW I have no problem to build locally on the latest Tumbleweed. Also LTP
package build for Tumbleweed is also fine:
https://build.opensuse.org/package/binaries/benchmark:ltp:devel/ltp/openSUSE_Factory
https://build.opensuse.org/package/binaries/benchmark:ltp:devel/ltp/openSUSE_Tumbleweed

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
