Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD7EC433FE
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 14:04:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB5553CAE26
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 16:04:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0396E3CAE17
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 16:04:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 81CB51A01956
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 16:04:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A67E1F8B8;
 Fri,  7 Oct 2022 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665151479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ftioq9uSNBRaGf6333YRcx+hlnvBATNfuFVm2nofjPA=;
 b=zbLL0yojiUkY1EkklA8jLGZ8zko3Vo9cCuNc6qPM5zz9mc+sev2NyLdgLEbt4/FXsdd4RE
 OlbkLfmzgYqIrQ6WI9qva3TFNQAgApsbXndUPCVCax2irTk/7Wq6OUgE0uDZgVvdRL3vXC
 NmP69m1NHINlwLP2MmnvvsoSLg65TKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665151479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ftioq9uSNBRaGf6333YRcx+hlnvBATNfuFVm2nofjPA=;
 b=/eVS2ucVZJbYs4MpEIMgr9iFxIaIXggGf+5sO5CnsERSgcDdVj0eivww0gMmv/+X+HIPB5
 YrbJsW9DZqrd/pDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D252E13A3D;
 Fri,  7 Oct 2022 14:04:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ploDJPYxQGOgCgAAMHmgww
 (envelope-from <akumar@suse.de>); Fri, 07 Oct 2022 14:04:38 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 07 Oct 2022 19:34:36 +0530
Message-ID: <4450243.LvFx2qVVIh@localhost>
Organization: SUSE
In-Reply-To: <20221006102900.3246-1-pvorel@suse.cz>
References: <20221006102900.3246-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Improve .skip_filesystems documentation
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Thursday, October 6, 2022 3:59:00 PM IST Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/c-test-api.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 64ee3397f..2865160cc 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -894,6 +894,15 @@ If test needs to adjust expectations based on filesystem type it's also
>  possible to detect filesystem type at the runtime. This is preferably used
>  when only subset of the test is not applicable for a given filesystem.
>  
> +NOTE: ext2, ext3 or ext4 in '.skip_filesystems' on tests which does *not* use
> +      '.all_filesystems' needs to be defined as 'ext2/ext3/ext4'. The reason
> +      is that is hard to detect used filesystem due overlapping the functionality.
nit:
s/that is/that it is
s/due/due to
> +      OTOH tests which use '.skip_filesystems' *with* '.all_filesystems' can skip
> +      only filesystems which are actually used in '.all_filesystems': ext2, ext3,
> +      ext4, xfs, btrfs, vfat, exfat, ntfs, tmpfs (defined in 'fs_type_whitelist[]').
> +      It does not make sense to list other filesystems.
> +
> +
>  [source,c]
>  -------------------------------------------------------------------------------
>  #include "tst_test.h"
> 

Reviewed-by: Avinesh Kumar <akumar@suse.de>


Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
