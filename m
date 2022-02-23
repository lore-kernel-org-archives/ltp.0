Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A79C433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 14:40:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE2C73C9A7C
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 15:40:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD2A93C9780
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 15:40:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B07752013DE
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 15:40:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CDDEC2110B;
 Wed, 23 Feb 2022 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645627210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ja+bgEGEclHEStGJuc46qNe3bmQktyq+buAayxkYos=;
 b=wMF2YjG8fDkKa8HzdCoRyOjamgVd3sSkCDE7jZATAC/5YOJ4FdSe+lQzTwXnDesbho9hQl
 1izwC2bZiElggdeOWta8/RdrXmgP0ZIRLPMZLgA48AQd3wCfBP3YAqdyGbppLHFIZWc5RJ
 IPKUwZaObb5DfUQa1F3IFLDd9NnOaYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645627210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ja+bgEGEclHEStGJuc46qNe3bmQktyq+buAayxkYos=;
 b=CBOlfP6J7PIpVuwneHIM6XsaSeueArH7PH/GcHvNAyfxV++m0pwG2QP6p24dNOJS9Qg42B
 TsRv+VFKrQk3krDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6B7713D7C;
 Wed, 23 Feb 2022 14:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gMciLEpHFmJBUAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 23 Feb 2022 14:40:10 +0000
Date: Wed, 23 Feb 2022 15:42:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yael Tzur <yaelt@google.com>
Message-ID: <YhZH0Cu25UCtUlZK@yuki>
References: <20220222181034.1005633-1-yaelt@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220222181034.1005633-1-yaelt@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void do_test(void)
> +{
> +	key_serial_t masterkey;
> +	key_serial_t encryptedkey1;
> +	key_serial_t encryptedkey2;
> +	char buffer[128];
> +
> +	masterkey = add_key("user", "user:masterkey", "foo", 3,
> +			    KEY_SPEC_PROCESS_KEYRING);
> +	if (masterkey == -1)
> +		tst_brk(TBROK | TERRNO, "Failed to add user key");
> +
> +	encryptedkey1 = add_key("encrypted", "ltptestkey1", ENCRYPTED_KEY_1_PAYLOAD,
> +				60, KEY_SPEC_PROCESS_KEYRING);
> +	if (encryptedkey1 == -1)
> +		tst_brk(TFAIL, "Failed to instantiate encrypted key using payload decrypted data");

I guess that we should print errno (by adding the | TERRNO to the TFAIL)
here as well.

Also we can make the message shorter since the FAIL part is printed by
the library because of the TFAIL flag. So maybe something as:

	tst_brk(TFAIL | TERRNO, "instatiation of encrypted key with decrypted payload");

Which would print message as:

	foo.c:XX: TFAIL: instatiation of encrypted key with decrypted payload: ENOMEM (12)

Or even better use the LTP TST_EXP_*() macros which will generate most
of the code for you.

Assuming the return value from add_key() on success is >= 0 we can do:

	TST_EXP_POSITIVE(add_key("encrypted", "ltptestkey1",
	                         ENCRYPTED_KEY_1_PAYLOAD,
			         60, KEY_SPEC_PROCESS_KEYRING));

	if (!TST_PASS)
		return;

The TST_EXP_POSITIVE() has optional printf-like parameters if you want
to customize the message, so if you want to keep the original message
you can do:

	TST_EXP_POSITIVE(add_key(...),
	                 "instatiation of encrypted key with decrypted payload");

And the return value from add_key is stored in TST_RET.

> +	TEST(keyctl(KEYCTL_READ, encryptedkey1, buffer, sizeof(buffer)));
> +	if (TST_RET < 0)
> +		tst_brk(TFAIL, "KEYCTL_READ failed for encryptedkey1");

And here as well.

> +	encryptedkey2 = add_key("encrypted", "ltptestkey2", ENCRYPTED_KEY_2_PAYLOAD,
> +				60, KEY_SPEC_PROCESS_KEYRING);
> +	if (encryptedkey2 != -1)
> +		tst_brk(TFAIL, "Instantiation of encrypted key using non hex-encoded decrypted data unexpectedly succeeded");

We should check that the errno was set correctly here as well. We do
have a TST_EXP_FAIL() macro for this. If this is supposed to end with
EINVAL it can be simply done as:

	TST_EXP_FAIL2(add_key("encrypted", "ltptestkey2",
	              ENCRYPTED_KEY_2_PAYLOAD, 60,
		      KEY_SPEC_PROCESS_KEYRING), EINVAL);

And you can pass a printf-like parameters to this macro as well to
customize the message.

> +	tst_res(TPASS, "Encrypted keys were instantiated with decrypted data as expected");
> +
> +	keyctl(KEYCTL_CLEAR, KEY_SPEC_PROCESS_KEYRING);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_USER_DECRYPTED_DATA=y",
> +		NULL
> +	}
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
