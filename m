Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C65C00523
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 15:30:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB8FA3CE3D4
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 17:30:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A66A3CA59A
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 17:30:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E986140126E
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 17:30:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 66420201F6;
 Wed, 20 Sep 2023 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695223799;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AnqIrvUW62ndZV1dUavPpnUvBKS377/AlzKtrPWpvbA=;
 b=Xh+1kP4s1T8oCtSNwq3reLMFVQlfiMjMx2QXJlCRHlKCQx3QOJ+B+Lb4C7AxURqmpkw0s/
 8uJRkrE2q36ea3TtMnP2Ge0STvH/6uKLggESL9+GietQ1XJ11NMZHw1IHGTxCi/0rTINqB
 tFZRpwi7mgSREF5Y33c6Wh4YstJTbMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695223799;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AnqIrvUW62ndZV1dUavPpnUvBKS377/AlzKtrPWpvbA=;
 b=X3rApVxpLQdyOXGpDUnBGmJPmHRWSz+BVVRMP25END0YTtrVK8Dh7qGb5DiI2QkKt7H3N7
 eaJGa6qbOdsg2ABw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A008132C7;
 Wed, 20 Sep 2023 15:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YoEFAfcPC2UCRwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 20 Sep 2023 15:29:59 +0000
Date: Wed, 20 Sep 2023 17:29:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230920152957.GA375961@pevik>
References: <20230920095318.340582-1-pvorel@suse.cz>
 <20230920095318.340582-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230920095318.340582-6-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] doc: Update release procedure
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> +++ b/doc/LTP-Release-Procedure.asciidoc
> @@ -5,54 +5,103 @@ This page contains quick summary of what needs to be done to do a LTP release. I

>  NOTE: The string YYYYMMDD should be substituted to the current date.
This line should have been removed as well.
If we agree on these changes, I'll fix it before merge.

Kind regards,
Petr

> -1. Tag the git
> +1. Release eve work
> +-------------------
> +
> +a. Collecting the (must have) patch list for new release
> +b. Reviewing and merging the patch list of (a.)
> +c. Widely testing, explicitly post results
> +d. Tiny fix according to release testing
> +e. Writing release note
> +
> +2. Tag the git
>  --------------
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
