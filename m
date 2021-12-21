Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B62EC433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 09:02:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 970993C925B
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 10:02:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B9413C06C4
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:01:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2373D1A014A5
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:01:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 065F721117;
 Tue, 21 Dec 2021 09:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640077317;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hNkASE91271N7CeDuT3M7bBED42kg/o4zLewajWHevA=;
 b=uRhZTgQ64ZFNw2Z4Ssd10/Z3BaoLEbGFwI/Lv6Hf36as/NGskXHbUuGCu72cpe+VTF2oZW
 bHUO6aFcoFKCoAZEIEuGg3NWssir1xBL/y5Flm3bBAf1HrO0C0QK1ci1mSbXGSm/DHzaZ3
 uMXwmEACw0ue7HHidn60xxEzm/rLIVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640077317;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hNkASE91271N7CeDuT3M7bBED42kg/o4zLewajWHevA=;
 b=ptnMdv2SSM4byjCiteTUVulmOekX56lDgC+PtvQhR2v3al9urJRLBRqQfWl5kQ23nNmRSv
 cEN2SIqERwlZJWBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6BE413C26;
 Tue, 21 Dec 2021 09:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id frlTJgSYwWFLNwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 21 Dec 2021 09:01:56 +0000
Date: Tue, 21 Dec 2021 10:01:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yael Tiomkin <yaelt@google.com>
Message-ID: <YcGYAhskkG1r+5Qs@pevik>
References: <20211221023721.129689-1-yaelt@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211221023721.129689-1-yaelt@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/keyctl09: test encrypted keys.
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Yael,

you still have some problem when running more iterations:

./keyctl09 -i500
keyctl09.c:49: TPASS: Encrypted keys were successfully instantiated and read
keyctl09.c:49: TPASS: Encrypted keys were successfully instantiated and read
...
keyctl09.c:33: TFAIL: Failed to instantiate encrypted key using payload decrypted data

(some people really try high number of iterations.)
Could you please have a look?

> Test that encrypted keys can be instantiated using
> both user-provided decrypted data
> (https://lore.kernel.org/linux-integrity/20211213192030.125091-1-yaelt@google.com/),
> or kernel-generated numbers.
+1 for doc!

...
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
nit: this might be TBROK (test preparation phase), not sure
(and not that important).

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
