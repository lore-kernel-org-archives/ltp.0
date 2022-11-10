Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C779C4332F
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 11:31:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 441E93CD6FF
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 12:31:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD05F3CD6DD
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 12:31:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A944E6005E4
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 12:31:20 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id EDC501F913;
 Thu, 10 Nov 2022 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668079879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l2G6l2XjhPaWOV0zH7euTZEhra1+QLhN2m19oZqCQ1Q=;
 b=gsK6X9d2RGFnlv4b6/BAM3NajfLWhj7tIbbjv0W/ePuB9bYI4Mk+q0u7OMb28vAye2qwpB
 BZU8zr48VGq0ZZcTDGoIwAH93Mq7SO5TXCg4IqHlK0ZbG5clizuJPMwizJaphg2ey2YDQu
 zQWIDbjAkzjCTAKPKc4KloyIlnBl0OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668079879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l2G6l2XjhPaWOV0zH7euTZEhra1+QLhN2m19oZqCQ1Q=;
 b=L+zi0zBTylVCCadgITR8xnWGx05eephr6iM+Zhc426x67dP8Kq5c7fNywn6V/mRjlVqJV2
 aKfwraQTTXjUEpAw==
Received: from localhost.localdomain (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id ADABF2C142;
 Thu, 10 Nov 2022 11:31:19 +0000 (UTC)
References: <877d05wxwe.fsf@suse.de>
 <20221109193819.875478-1-alessandro.carminati@gmail.com>
 <20221109193819.875478-3-alessandro.carminati@gmail.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Thu, 10 Nov 2022 11:29:58 +0000
Organization: Linux Private Site
In-reply-to: <20221109193819.875478-3-alessandro.carminati@gmail.com>
Message-ID: <87v8nnqc54.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/2] c-test-api: Documentation updated
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
Cc: acarmina@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged, thanks!

I removed some trailing whitespace.

Alessandro Carminati <alessandro.carminati@gmail.com> writes:

> Since the tst_find_backing_dev logic is changed, the doc is updated
> accordingly.
>
> Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> ---
>  doc/c-test-api.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 64ee3397f..a7888c242 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -1071,8 +1071,11 @@ voud tst_find_backing_dev(const char *path, char *dev);
>  -------------------------------------------------------------------------------
>  
>  This function finds the block dev that this path belongs to, it uses stat function
> -to get the major/minor number of the path. Then scan them in '/proc/self/mountinfo'
> -and list 2th column value after ' - ' string as its block dev if match succeeds.
> +to get the major/minor number of the path. 
> +This function finds the block dev that this path belongs to, it uses the unevent

There are trailing whitespace on these lines

> +file in sysfs to find the device name. It needs to discriminate between btrfs
> +and not btrfs. For non btrfs filesystems it uses the minor, major numbers. For
> +btrfs it uses the fs uuid.
>  
>  [source,c]
>  -------------------------------------------------------------------------------


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
