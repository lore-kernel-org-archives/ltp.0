Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13A5ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 20:30:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CF373CAC1C
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 22:30:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E73603CABD0
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 22:30:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4426C14013BE
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 22:30:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81DB95CB58;
 Wed, 14 Sep 2022 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663187406;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vI/MZjjpbCt66e4tcsrR/2tnW28T7kXQQlrF3Vst1UI=;
 b=wY8MGMz4iQ8SIKT1AdjnaMPMuyZzZwYoZLutCljPLDgT+bBWvwCxw2FCfjzRRaBdXrx8U8
 D4Di57BmU7lJ/NypJDC1EmBbOYKEDt84p4o8PbM3AmkZBxhtaaejELcq6T+ZOtPbJlJLEf
 gIB6EBvPkgPJsrT8Nby6chTPztAFBTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663187406;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vI/MZjjpbCt66e4tcsrR/2tnW28T7kXQQlrF3Vst1UI=;
 b=p2GWDYSZzeovprbZxc8KM5VbD14RoN3hV676lqL/idmq55cTR8z2GYrc7Tfs34GL51w00/
 OzlWqQFbeevTl8Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 520FF13494;
 Wed, 14 Sep 2022 20:30:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id O7eEEc45ImNoKwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 14 Sep 2022 20:30:06 +0000
Date: Wed, 14 Sep 2022 22:30:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyI5zIjoLpgBUuRa@pevik>
References: <20220914161930.27681-1-mdoucha@suse.cz>
 <20220914161930.27681-3-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220914161930.27681-3-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] copy_file_range01: Add max_runtime
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

Hi Martin,

merged, with Cyril's RBT (as he proposed this value in v1).
Thanks!

Kind regards,
Petr

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> Changes since v1:
> - Changed max_runtime from 20s to 5s

>  testcases/kernel/syscalls/copy_file_range/copy_file_range01.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> index 7d27007a3..bbcb0ca3b 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> @@ -232,4 +232,5 @@ static struct tst_test test = {
>  	.all_filesystems = 1,
>  	.test = copy_file_range_verify,
>  	.test_variants = TEST_VARIANTS,
> +	.max_runtime = 5
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
