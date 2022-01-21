Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0710C433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 09:24:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BFE93C96DC
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:24:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDB9B3C9232
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:24:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AAFBE1401126
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:24:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2BBB21903;
 Fri, 21 Jan 2022 09:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642757042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xk641EknsG4hmqMFcGK8PzqDlKdkwOnIPXnQ0K1QzCo=;
 b=UhD3MIEon5uda9e0d4UYzjQ/bPVntCJQXuC8wL0/p25gRh2CA+KL17I/7UubDp58vnEX39
 hQz0OmASiT5EP0YUFRO5CDC4P+gGT0uamY2qQ3xRK5DuKin5yqfV2MlUqVG6lQanet6noi
 OLTPyVHffrTEOh4h7N8R99bybl+z2zE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642757042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xk641EknsG4hmqMFcGK8PzqDlKdkwOnIPXnQ0K1QzCo=;
 b=5svyuNIX8vJz2f0UWaE6STLt+MkxJXDYFq96wFWtL0SnlnXPcagtDF8GkzEidTHUqGrl5/
 0baj5nZiB3kwvkAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCE4F13C1A;
 Fri, 21 Jan 2022 09:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ceTsLLJ76mFNUAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 21 Jan 2022 09:24:02 +0000
Message-ID: <b328e15c-8579-3d4e-0cf8-2a8b0ad5728e@suse.cz>
Date: Fri, 21 Jan 2022 10:24:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20220121091500.8264-1-andrea.cervesato@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220121091500.8264-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Reduce needed memory by the dio_read test
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

Hi,
Acked-by: Martin Doucha <mdoucha@suse.cz>

On 21. 01. 22 10:15, Andrea Cervesato wrote:
> The previous runtest file was requiring half an hour to complete using
> quite amount of RAM. For 100 threads, the test would easily use ~3.5GB
> of memory making really difficult to test on system with few resources.
> 
> With this modification we reduce both read and write buffer size, as
> well as the file size, so test will take few minutes to complete and
> we will reduce memory allocation.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
> ---
>  runtest/ltp-aiodio.part4 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
> index fc1e1d479..54019d47b 100644
> --- a/runtest/ltp-aiodio.part4
> +++ b/runtest/ltp-aiodio.part4
> @@ -62,7 +62,7 @@ DIT002 dio_truncate
>  #Running read_checkzero
>  #gread_checkzero
>  #Running dio_read
> -DOR000 dio_read -n 1 -i 100
> -DOR001 dio_read -n 10 -i 30
> -DOR002 dio_read -n 20 -i 15
> -DOR003 dio_read -n 100 -i 4
> +DOR000 dio_read -n 1 -i 100 -r 512k -w 512k -s 32M
> +DOR001 dio_read -n 10 -i 30 -r 512k -w 512k -s 32M
> +DOR002 dio_read -n 20 -i 15 -r 512k -w 512k -s 32M
> +DOR003 dio_read -n 100 -i 4 -r 512k -w 512k -s 32M

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
