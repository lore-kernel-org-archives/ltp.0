Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138E9C71145
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 06:54:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 230283CC4E7
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 08:54:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D01AE3CC497
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 08:54:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A240B601408
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 08:54:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C3B820E68;
 Thu, 24 Aug 2023 06:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692860043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drsdwRv2q5O5yUXRVBtUsrQ7XXIgMYPiKquGzBD2s70=;
 b=Vgfg+sl9+zv4OR8VAjq9abKK3C/M95lgLhPgzD+SXZ3xeWI4SBBjRShdvSy3LdfQ0VeyZo
 AeaIcIn80oX2VP9fmBs8LBd2gwPcLJGkaWC3sAwLgj2cx1qJ7Q7evea05aAmE7FNK7I+4y
 ZaRMR/JnHxBBXmqgD1HB8CgJ+lLzXYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692860043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drsdwRv2q5O5yUXRVBtUsrQ7XXIgMYPiKquGzBD2s70=;
 b=CS6sY3Yni0f9PtTqi5N6aPsMupecHVEdSbm0dLAyukpEsJcMIGHCJvQevgXsA/Jt6kVbct
 4P7OtffOYalfk0AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 076DC138FB;
 Thu, 24 Aug 2023 06:54:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id evr9MYr+5mSRFAAAMHmgww
 (envelope-from <akumar@suse.de>); Thu, 24 Aug 2023 06:54:02 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Souta Kawahara <souta.kawahara@miraclelinux.com>
Date: Thu, 24 Aug 2023 12:24:00 +0530
Message-ID: <2011008.QOpSKoWEuR@localhost>
Organization: SUSE
In-Reply-To: <d83140dc8ddd7aec2458061e283bd9fb4fbe73ca.1692857370.git.souta.kawahara@miraclelinux.com>
References: <f8c3549f405479aa521dd654c105a2ba8d4d6f36.1692839061.git.souta.kawahara@miraclelinux.com>
 <d83140dc8ddd7aec2458061e283bd9fb4fbe73ca.1692857370.git.souta.kawahara@miraclelinux.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] fix broken example code
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

On Thursday, August 24, 2023 11:42:18 AM IST Souta Kawahara wrote:
> There is double definition of 'test'.
> Fixed it.
> Also Fixed example code for the same function described after that.
> 
> Signed-off-by: Souta Kawahara <souta.kawahara@miraclelinux.com>
> ---
>  doc/c-test-api.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index e4e88edec..2ad841038 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -36,7 +36,7 @@ static void setup(void)
>  		tst_brk(TBROK | TERRNO, "setenv() failed");
>  }
> 
> -static void test(void)
> +static void run(void)
>  {
>  	char *ret;
> 
> @@ -64,7 +64,7 @@ next:
>  }
> 
>  static struct tst_test test = {
> -	.test_all = test,
> +	.test_all = run,
>  	.setup = setup,
>  };
>  ---------------------------------------------------------------------------
> ---- @@ -257,7 +257,7 @@ value and errno and reports the test result.
> 
>  [source,c]
>  ---------------------------------------------------------------------------
> ---- -static void test(void)
> +static void run(void)
>  {
>  	...
>  	TST_EXP_PASS(stat(fname, &statbuf), "stat(%s, ...)", fname);
> @@ -278,7 +278,7 @@ begin with a format string and then appropriate values
> to be formatted.
> 
>  [source,c]
>  ---------------------------------------------------------------------------
> ---- -static void test(void)
> +static void run(void)
>  {
>  	...
>  	TST_EXP_FD(open(fname, O_RDONLY), "open(%s, O_RDONLY)", fname);
> @@ -294,7 +294,7 @@ positive integer is returned.
> 
>  [source,c]
>  ---------------------------------------------------------------------------
> ---- -static void test(void)
> +static void run(void)
>  {
>  	...
>  	TST_EXP_FAIL(stat(fname, &statbuf), ENOENT, "stat(%s, ...)", 
fname);
> @@ -308,7 +308,7 @@ passed as the second argument.
> 
>  [source,c]
>  ---------------------------------------------------------------------------
> ---- -static void test(void)
> +static void run(void)
>  {
>  	...
>  	TST_EXP_FAIL2(msgget(key, flags), EINVAL, "msgget(%i, %i)", key, 
flags);

--
Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
