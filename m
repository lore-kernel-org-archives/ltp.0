Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E72C6379F
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 10:36:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B46373CB19F
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 11:36:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A0C83C1047
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 11:36:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A776B60027F
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 11:36:43 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 064F120C4D;
 Mon,  6 Feb 2023 10:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1675679803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Ta6HnWliJ6mTW6kpeQk/zlPjQNwYmoQmMoiVOBCVFo=;
 b=Ub8E/uc0YwI/HHMc45nwycjKCU6zKIcQUlaci/I0OH3v0PP3GC5A4jU0Lu1FeGIFLT5l9J
 qTLWekla1QBv3uskT1vy2lVocXeetjec6mvMEy9kdc1fbVv7r7Tw9E0Kp8nbnGCRg436b3
 ypW6EPtfN9b1HRxq+QvF09QJQxMr6Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1675679803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Ta6HnWliJ6mTW6kpeQk/zlPjQNwYmoQmMoiVOBCVFo=;
 b=zb1p70VhVzOUGApA7AjOSGMXOAiOV1CE2faOUrW1efOnZINrk9216UBMW6Igc2JRiQjn9V
 AUIhJCpoaOF9JnAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 32664133A6;
 Mon,  6 Feb 2023 10:36:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 7+80OTnY4GMdEgAAGKfGzw
 (envelope-from <akumar@suse.de>); Mon, 06 Feb 2023 10:36:41 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 06 Feb 2023 16:06:39 +0530
Message-ID: <4806953.31r3eYUQgx@localhost>
Organization: SUSE
In-Reply-To: <20230206061001.13164-1-pvorel@suse.cz>
References: <20230206061001.13164-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Allow zero iterations (-i0)
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

Hi,

Reviewed-by: Avinesh Kumar <akumar@suse.de>

On Monday, February 6, 2023 11:40:01 AM IST Petr Vorel wrote:
> -i0 is helpful to test if setup and cleanup are working.
> We suggest that in maintainer-patch-review-checklist.txt.
> 
> Fixes: 4c0465f217 ("lib: Replace atoi/atof with SAFE_STRTOL/SAFE_STRTOF")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/tst_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 23d21c8255..04d6b13bfc 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -678,7 +678,7 @@ static void parse_opts(int argc, char *argv[])
>  			print_test_tags();
>  			exit(0);
>  		case 'i':
> -			iterations = SAFE_STRTOL(optarg, 1, INT_MAX);
> +			iterations = SAFE_STRTOL(optarg, 0, INT_MAX);
>  		break;
>  		case 'I':
>  			if (tst_test->max_runtime > 0)
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
