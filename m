Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF75C433EF
	for <ltp@archiver.kernel.org>; Wed,  6 Apr 2022 06:31:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2642E3CA159
	for <ltp@archiver.kernel.org>; Wed,  6 Apr 2022 08:31:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF9823C14BB
 for <ltp@lists.linux.it>; Wed,  6 Apr 2022 08:30:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1DD751A00148
 for <ltp@lists.linux.it>; Wed,  6 Apr 2022 08:30:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E96791F390
 for <ltp@lists.linux.it>; Wed,  6 Apr 2022 06:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649226653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mcYw95nvAh3dAvRKGKP3aSQXTYXjk0w8Vpahwvcxx0Q=;
 b=sMEoYYwjcwksEpQC7ww9niKQnP5Z7lNnm9LirplSkp+RdHH6su3WEFNDtvb95kYKQWtvk8
 xUiw5X853JXOoCSw0BijQ2pVNS8s9Ndk2JR6Bi10KcrP+j0wqiw1wigzivlfwS8rWkcTmJ
 xzu9EIOyLhjJY9goaWBiswaDiGtG8Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649226653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mcYw95nvAh3dAvRKGKP3aSQXTYXjk0w8Vpahwvcxx0Q=;
 b=eGmLt/2bJ08WY6DabfwktWE5mM37rbyXVW/xKvhw05EIL4tcVA/PmE5ueOJAV4jv0Cuhr+
 bzPoZpcOIfMHzPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1423139F5
 for <ltp@lists.linux.it>; Wed,  6 Apr 2022 06:30:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VSJlMZ0zTWKjNgAAMHmgww
 (envelope-from <pvorel@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 06 Apr 2022 06:30:53 +0000
Date: Wed, 6 Apr 2022 08:30:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Yk0znI2Jd5EPderD@pevik>
References: <20220405134838.9440-1-pvorel@suse.cz>
 <20220405134838.9440-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220405134838.9440-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] confstr01: Update to X/Open 7 (POSIX 2008)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I tested it last night on uclibc, it does not have _CS_V7_ENV, therefore it must
be wrap with #ifdef.

Kind regards,
Petr

diff --git testcases/kernel/syscalls/confstr/confstr01.c testcases/kernel/syscalls/confstr/confstr01.c
index f41214add8..ed540cf4da 100644
--- testcases/kernel/syscalls/confstr/confstr01.c
+++ testcases/kernel/syscalls/confstr/confstr01.c
@@ -46,7 +46,9 @@ static struct test_case_t {
 	{ _CS_POSIX_V7_THREADS_LDFLAGS, "POSIX_V7_THREADS_LDFLAGS" },
 #endif
 	{ _CS_POSIX_V7_WIDTH_RESTRICTED_ENVS, "POSIX_V7_WIDTH_RESTRICTED_ENVS" },
+#ifdef _CS_V7_ENV
 	{ _CS_V7_ENV, "V7_ENV" },
+#endif
 };
 
 static void run(unsigned int i)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
