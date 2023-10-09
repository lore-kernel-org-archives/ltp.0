Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448C4E95A91
	for <ltp@archiver.kernel.org>; Mon,  9 Oct 2023 11:03:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F4E73CA3A6
	for <ltp@archiver.kernel.org>; Mon,  9 Oct 2023 13:03:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE3143C88C9
 for <ltp@lists.linux.it>; Mon,  9 Oct 2023 13:02:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AA5F2600FC0
 for <ltp@lists.linux.it>; Mon,  9 Oct 2023 13:02:57 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 997D21F381
 for <ltp@lists.linux.it>; Mon,  9 Oct 2023 11:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696849376;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GXMmMh6HWY6Aj32z1JR7i/uYif/8a/0bPN8UkyC9b6w=;
 b=xqPHq8rjkUkYw10UG2UPCBRh5DQVWU6vMqBQo/+4mSPzv34w8ueOU+tdem9CgUtdLtmdTr
 B8YodY49x+xCLqzjNbiGxR2uATd9aTAQFOKYMX6ypYRQAje96glkACKAQggewY4VOosEpB
 /5kmT4XPLm7ryK54wi41D+dtNjCb4F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696849376;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GXMmMh6HWY6Aj32z1JR7i/uYif/8a/0bPN8UkyC9b6w=;
 b=hZFv+AA8c271Fa5HYIMZ/AvjzBtzytXsEx7ckXFu7PoWEKVKNETAC7/stcjJwYyusutj0Q
 5o3JgygZ2vMXBpBQ==
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4BBD32C142;
 Mon,  9 Oct 2023 11:02:56 +0000 (UTC)
References: <20230825063932.30875-4-akumar@suse.de>
 <20230905133118.23912-1-akumar@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Mon, 09 Oct 2023 11:59:42 +0100
Organization: Linux Private Site
In-reply-to: <20230905133118.23912-1-akumar@suse.de>
Message-ID: <871qe412jm.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/mmap14: Rewrite test using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Avinesh Kumar <akumar@suse.de> writes:

>  
> -static void setup(void)
> +static void run(void)
>  {
> -	tst_require_root();
> +	unsigned int sz_before, sz_after, sz_diff;
>  
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	getvmlck(&sz_before);
>  
> -	TEST_PAUSE;
> -}
> +	if (((sz_before * 1024) + MMAPSIZE) > rlim.rlim_cur)
> +		tst_brk(TBROK, "Trying to exceed RLIMIT_MEMLOCK limit");

Should this be TCONF not TBROK?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
