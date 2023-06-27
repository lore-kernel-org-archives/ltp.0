Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE96EB64DC
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 11:09:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C20673CC39D
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 13:09:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B9513C99A3
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 13:09:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C51DC60084B
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 13:09:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 04C881F459;
 Tue, 27 Jun 2023 11:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687864173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjOw5XXk10PNCwK+PbtOQO7TI1HJix1ms4KDuyBaM7I=;
 b=yFABoLf7VeJrY38Oa8NBQJhPDWLvPZ45i4juFOb9dwUrYkXT9awyRlSqt8ztE5AgcNZIws
 iKBw/iA+UnKZpkp73mfwS4FOLakx6lKTV+EaoZJMoyQ5V+KDTa86hDeqcW+oxb5H8pkJie
 Bl7fCWVR5Zty2Vka+mUB7t+WmS7+hqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687864173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjOw5XXk10PNCwK+PbtOQO7TI1HJix1ms4KDuyBaM7I=;
 b=CSJUqoHpXFAnNwJ8ezM2r+vOAuY1s5wgROXSs84HOdaaf17M6j413jK0PBIPVfh8ZNNhDF
 LLWrDUDCl5rv5PDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA3B613276;
 Tue, 27 Jun 2023 11:09:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XtgELGzDmmRsGQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 27 Jun 2023 11:09:32 +0000
Date: Tue, 27 Jun 2023 13:09:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Message-ID: <20230627110931.GB24533@pevik>
References: <1687445437-2453-1-git-send-email-kashwindayan@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1687445437-2453-1-git-send-email-kashwindayan@vmware.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sctp_big_chunk: Do not use md5 hmac algo if
 fips is enabled
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
Cc: tkundu@vmware.com, akaher@vmware.com, vsirnapalli@vmware.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> MD5 is not FIPS compliant. But still md5 is used as the default algorithm for sctp
> even when fips is enabled. Due to this, sctp_big_chunk testcase is failing because listen()
> system call in setup_server() is failing in fips environment.

> Fix is to not use md5 algorithm while setting up server, instead set it to none

> Signed-Off by: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
> ----
> v2:
> As per the review comments given by Petr, did below changes in v2,
>         * Moved the logic to sctp_server() function
>         * Setting none as the default algo
>         * make sure cookie_hmac_alg file is present before accessing it
BTW I suggested modprobe, because I'm not aware of other way to trigger it.
But maybe creating SCTP socket would trigger it, e.g.
socket(PF_INET, SOCK_STREAM, IPPROTO_SCTP);

If yes, IMHO it'd be more elegant solution and (likely) we would not depend on
modprobe.

Kind regards,
Petr

> ---
>  testcases/network/sctp/sctp_big_chunk.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

> diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
> index a6a326ea2..31786dd39 100644
> --- a/testcases/network/sctp/sctp_big_chunk.c
> +++ b/testcases/network/sctp/sctp_big_chunk.c
> @@ -34,6 +34,24 @@ static int addr_num = 3273;

>  static void setup_server(void)
>  {
> +	const char *const cmd_modprobe[] = {"modprobe", "sctp", NULL};
> +	const char hmac_algo_path[] = "/proc/sys/net/sctp/cookie_hmac_alg";
> +	char hmac_algo[CHAR_MAX];
> +	int hmac_algo_changed = 0;
> +
> +	/* Disable md5 if fips is enabled. Set it to none */
> +	if (tst_fips_enabled()) {
> +		if (access(hmac_algo_path, F_OK) < 0) {
> +			SAFE_CMD(cmd_modprobe, NULL, NULL);
> +		}
> +
> +		if (!access(hmac_algo_path, F_OK)) {
> +			SAFE_FILE_SCANF(hmac_algo_path, "%s", hmac_algo);
> +			SAFE_FILE_PRINTF(hmac_algo_path, "%s", "none");
> +			hmac_algo_changed = 1;
> +		}
> +	}
> +
>  	loc.sin6_family = AF_INET6;
>  	loc.sin6_addr = in6addr_loopback;

> @@ -46,6 +64,9 @@ static void setup_server(void)
>  	SAFE_LISTEN(sfd, 1);

>  	srand(port);
> +
> +	if (hmac_algo_changed)
> +		SAFE_FILE_PRINTF(hmac_algo_path, "%s", hmac_algo);
>  }

>  static void update_packet_field(size_t *off, void *buf, size_t buf_len)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
