Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052A6C32793
	for <ltp@archiver.kernel.org>; Wed, 18 Jan 2023 17:02:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78DA03CC85D
	for <ltp@archiver.kernel.org>; Wed, 18 Jan 2023 18:02:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51DAC3CB034
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 18:01:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CBBB51000BDB
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 18:01:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 38ED43F75D;
 Wed, 18 Jan 2023 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674061314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1I2U+kRhUEL233OL1WI41WQkwAJ/V/rkY59N8BZje3M=;
 b=MG2EkHVbKjGwbKlJmJ3g6vdBTZAjDkK1UF8QMr7nJ6MMl9iESa6qJ2lK9DUSuRHn+c5LOR
 cSmwt6F41HCMKo3sGHs7+a+Z90ebehmKXIx4EDng3aSmdE8nYaqcSIBNzFPwsrpXhR9rND
 56IOrt4oP0TQnpgR9myKcEuNjGG+guk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674061314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1I2U+kRhUEL233OL1WI41WQkwAJ/V/rkY59N8BZje3M=;
 b=Djq/Iwbxe02rlElI10PyCrnFWnDpBxu1DdUfdnr4ZieVsCp1d6uqv3xrxQ7Ts+C32+3Kh+
 4lqOmOpn43jP9wDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E55E138FE;
 Wed, 18 Jan 2023 17:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ERqsBQImyGNdOwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 18 Jan 2023 17:01:54 +0000
Message-ID: <37ee8021-c13b-c4a9-f27b-84f504800169@suse.cz>
Date: Wed, 18 Jan 2023 18:01:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20230118133643.11371-1-chrubis@suse.cz>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230118133643.11371-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statvfs01: Correcly zero terminate the
 strings
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 18. 01. 23 14:36, Cyril Hrubis wrote:
> Fixes random failures caused by the fact that the stack is not
> guaranteed to be zeroed.
> 
> Fixes: e305ac4a305f ("statvfs01: Convert to new LTP API")
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Petr Vorel <pvorel@suse.cz>
> CC: Richard Palethorpe <rpalethorpe@suse.com>
> CC: Avinesh Kumar <akumar@suse.de>
> ---
>   testcases/kernel/syscalls/statvfs/statvfs01.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c b/testcases/kernel/syscalls/statvfs/statvfs01.c
> index dd14d6a0e..f17dc4cfa 100644
> --- a/testcases/kernel/syscalls/statvfs/statvfs01.c
> +++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
> @@ -38,6 +38,9 @@ static void run(void)
>   	memset(valid_fname, 'a', valid_len);
>   	memset(toolong_fname, 'b', valid_len + 1);
>   
> +	valid_fname[valid_len] = 0;
> +	toolong_fname[valid_len+1] = 0;

Is there a possibility that valid_len could be equal to PATH_MAX-1? I 
think toolong_fname[] size should be bumped to at least PATH_MAX+1.

> +
>   	TST_EXP_FD(creat(valid_fname, 0444));
>   	SAFE_CLOSE(TST_RET);
>   

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
