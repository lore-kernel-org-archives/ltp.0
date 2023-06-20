Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B91EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 22:24:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE6763CE0F3
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 00:24:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E49F3CA861
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 00:24:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C15101A005E5
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 00:24:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41B40218E1;
 Tue, 20 Jun 2023 22:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687299852;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I2axlHNEHiEbAmTaYKIqiDLIRLZBHI+D6UWj3sW5xUo=;
 b=kbWXyoLA3NJ6QH7mHMlgnQokRG5cyeRvdyexm0uAC5bQLalmfkQ+Zz+X6T86BoSHtCuZSO
 lv0cdyWBsd7AJJDnQzMqgN4MipGlrUUxCNjNQbpezACOrSZqlpIPUajA8mAoR95Wv4/Miw
 qRzJHZrjdI2wn3eJTjUOd+O/tDLMGvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687299852;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I2axlHNEHiEbAmTaYKIqiDLIRLZBHI+D6UWj3sW5xUo=;
 b=2gDiroCgS2wnxrjqr6/U0suzY+O+/uw4Pv8YHRYcgsdi4sBCEd2lN/50mW0/6FywVPCa9B
 IJNn92h+XCNi5aDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D75101346D;
 Tue, 20 Jun 2023 22:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 91hbMQsnkmREHQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jun 2023 22:24:11 +0000
Date: Wed, 21 Jun 2023 00:24:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Message-ID: <20230620222410.GA340710@pevik>
References: <1687280634-5906-1-git-send-email-kashwindayan@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1687280634-5906-1-git-send-email-kashwindayan@vmware.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sctp_big_chunk: Do not use md5 hmac algo if fips
 is enabled
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

Hi Ashwin,

> MD5 is not FIPS compliant. But still md5 is used as the default algorithm for sctp
> even when fips is enabled. Due to this, sctp_big_chunk testcase is failing because listen()
> system call in setup_server() is failing in fips environment.

> Fix is to not use md5 algorithm while setting up server.
> Instead use sha1 as algorithm if it's supported or else set it to none.

> Signed-Off by: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
> ---
>  testcases/network/sctp/sctp_big_chunk.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

> diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
> index a6a326ea2..267f1cb45 100644
> --- a/testcases/network/sctp/sctp_big_chunk.c
> +++ b/testcases/network/sctp/sctp_big_chunk.c
> @@ -133,11 +133,15 @@ static void setup_client(void)
>  }

>  static const char mtu_path[] = "/sys/class/net/lo/mtu";
> +static const char hmac_algo_path[] = "/proc/sys/net/sctp/cookie_hmac_alg";
>  static const unsigned int max_mtu = 65535;
>  static unsigned int mtu;

>  static void setup(void)
>  {
> +	char hmac_algo[CHAR_MAX];
> +	int fips_enabled = tst_fips_enabled();
> +
>  	if (tst_parse_int(addr_param, &addr_num, 1, INT_MAX))
>  		tst_brk(TBROK, "wrong address number '%s'", addr_param);

> @@ -146,8 +150,18 @@ static void setup(void)
>  	if (mtu < max_mtu)
>  		tst_brk(TCONF, "Test needs that 'lo' MTU has %d", max_mtu);

> +	SAFE_FILE_SCANF(hmac_algo_path, "%s", hmac_algo);
> +
> +	if (fips_enabled) {
fips_enabled is used only here => if (tst_fips_enabled()) {

> +		if (!system("grep hmac\\(sha1\\) /proc/crypto"))
This would not be acceptable. We have SAFE_FILE_LINES_SCANF()

Something like would do:
SAFE_FILE_LINES_SCANF("/proc/crypto", "hmac(sha1)");

But I wonder if just setting "none" on FIPS would be enough.

Also, shouldn't this be set in setup_server() before SAFE_LISTEN(),
to be obvious what needs it?

Kind regards,
Petr

> +			SAFE_FILE_PRINTF(hmac_algo_path, "%s", "sha1");
> +		else
> +			SAFE_FILE_PRINTF(hmac_algo_path, "%s", "none");
> +	}
> +
>  	setup_server();
>  	setup_client();
> +	SAFE_FILE_PRINTF(hmac_algo_path, "%s", hmac_algo);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
