Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07768C71145
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 06:55:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EA493CC4B5
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 08:55:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB7273CC49E
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 08:55:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6C84A601405
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 08:55:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E64E920E6C;
 Thu, 24 Aug 2023 06:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692860112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+vk3eW3JOLCOIxgrhVjDUZHcwhQhnyWL7bfK4DTswMs=;
 b=dqmJ3UHVTNJwqpjwknq58yTqbHRx/L6r4hJD++fWPgPBCVPtQXUILfhpn2cDIyKZ99iv/P
 g9X5zf5c51clpbPuH6rQSodIn4FY2CjLpB74Hmrc1MxXsVrU42z2e6tQ7BYEgi/jS2fnor
 8VNpBrLlGP4OmQfQ2i3wIMqIxC/bzLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692860112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+vk3eW3JOLCOIxgrhVjDUZHcwhQhnyWL7bfK4DTswMs=;
 b=WRUZ5K8uXprU9rl/S06yCxhCe9qIkWfGD8AC8oSBm6Is6Lzxf8qlifQRXFNCYaOiU7RqEp
 6tXfPWPAbO9exaCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52D1E138FB;
 Thu, 24 Aug 2023 06:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OIPPCND+5mShFQAAMHmgww
 (envelope-from <akumar@suse.de>); Thu, 24 Aug 2023 06:55:12 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Souta Kawahara <souta.kawahara@miraclelinux.com>
Date: Thu, 24 Aug 2023 12:25:10 +0530
Message-ID: <2424913.C0n9F0bVQ2@localhost>
Organization: SUSE
In-Reply-To: <447b0209996f33c5d7f6f5e0f146ca1abfe28346.1692858827.git.souta.kawahara@miraclelinux.com>
References: <447b0209996f33c5d7f6f5e0f146ca1abfe28346.1692858827.git.souta.kawahara@miraclelinux.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] doc/c-test-api.txt: fix wrong chapter
 number
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

Hi Souta,

Reviewed-by: Avinesh Kumar <akumar@suse.de>

On Thursday, August 24, 2023 12:06:22 PM IST Souta Kawahara wrote:
> Chapter number "1.36" was duplicated.
> Incremented the second "1.36" and subsequent chapters.
> 
> Signed-off-by: Souta Kawahara <souta.kawahara@miraclelinux.com>
> ---
>  doc/c-test-api.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index e4e88edec..3c059bb3a 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -2141,7 +2141,7 @@ the prefix field of file pointed by path equals to the
> value passed to this func Also having a similar api pair
> TST_ASSERT_FILE_INT/STR(path, prefix, val) to assert the field value of
> file.
> 
> -1.36 Using Control Group
> +1.37 Using Control Group
>  ~~~~~~~~~~~~~~~~~~~~~~~~
> 
>  Some LTP tests need specific Control Group configurations.  'tst_cgroup.h'
> @@ -2322,19 +2322,19 @@ kernel docs. Presently the LTP library does not
> attempt to handle most differences in semantics. It does the minimal amount
> of work to make testing on both V1 and V2 feasible.
> 
> -1.37 Require minimum numbers of CPU for a testcase
> +1.38 Require minimum numbers of CPU for a testcase
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>  Some tests require more than specific number of CPU. It can be defined with
> `.min_cpus = N`.
> 
> -1.38 Require minimum size of MemAvailable for a testcase
> +1.39 Require minimum size of MemAvailable for a testcase
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>  Some tests require more than specific size(MB) of MemAvailable. It can be
> defined with `.min_mem_avail = N`.
> 
> -1.39 Test tags
> +1.40 Test tags
>  ~~~~~~~~~~~~~~
> 
>  Test tags are name-value pairs that can hold any test metadata.
> @@ -2376,7 +2376,7 @@ struct tst_test test = {
>  };
>  ---------------------------------------------------------------------------
> ----
> 
> -1.40 Testing on the specific architecture
> +1.41 Testing on the specific architecture
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  Testcases for specific arch should be limited on that only being supported
>  platform to run, we now involve a '.supported_archs' to achieve this
> feature @@ -2412,7 +2412,7 @@ static struct tst_test test = {
>  };
>  ---------------------------------------------------------------------------
> ----
> 
> -1.41 Skipping test based on system state
> +1.42 Skipping test based on system state
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  Test can be skipped on various conditions: on enabled SecureBoot
>  ('.skip_in_secureboot = 1'), lockdown ('.skip_in_lockdown = 1') or in
> 32-bit

--
Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
