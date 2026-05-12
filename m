Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4237FCD4855
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 11:11:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBDDE3D0E81
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 13:11:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AD123CCDD4
 for <ltp@lists.linux.it>; Tue, 12 May 2026 13:11:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DBED31A01069
 for <ltp@lists.linux.it>; Tue, 12 May 2026 13:11:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 35080760AF;
 Tue, 12 May 2026 11:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778584256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Haslk+r6xWZV1fnSZtZIfmt89t9/XKHt4kjbGAYQW5E=;
 b=BlHyBFrX1I6rT/gVBjc9SS29dRcteS10jxL/HQ/B9LKMOCWbmNDzCSItiw5Piye/jCjEMi
 RXui1ef0lldYmu8aPzLCWEp4XHb9pEsTFRaCz43vrN/zOaCs7rKexKx7E92I+xiANaElal
 jTe/R9B0uB1hcAQdIpNvxIOALZulJsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778584256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Haslk+r6xWZV1fnSZtZIfmt89t9/XKHt4kjbGAYQW5E=;
 b=3pkaKsFolMp+ljWXNI/XT80fqwFM/X+4bTtaG0fDuO4FQTxTHMjngKD5jTB7l9unjH6ZXb
 BMLknjptWyCsZYAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778584252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Haslk+r6xWZV1fnSZtZIfmt89t9/XKHt4kjbGAYQW5E=;
 b=f6E/ovLyD+uc57Rkd5fqJnzZdKt3gDdiB9JI1dGMsza0IK0n61/xgEZJrc0lJ6b54qW8Xn
 JdH8u+GUQ4rV6D/BU6Jh/dR/fM7GjDyb70K4zmJuChEM1lA0u5hGj81lEJObP1jJxeo+hu
 CaQI/kuNVvWJn2ll+HTN8fDZRBgs6Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778584252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Haslk+r6xWZV1fnSZtZIfmt89t9/XKHt4kjbGAYQW5E=;
 b=XPLOsuXfUo3YbDq295zz4cuOx3Fi1HZCxtg2nhNQFVUTqW1k0ktZgol/D1TU4GO3hfolKp
 dPG8hXRXx+NrqPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22633593A9;
 Tue, 12 May 2026 11:10:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SUwSB7wKA2p6HgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 12 May 2026 11:10:52 +0000
Date: Tue, 12 May 2026 13:10:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <agMKwNsX6A7WDDn_@yuki.lan>
References: <20260509082649.8533-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260509082649.8533-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 yuki.lan:mid, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] OpenPOSIX: Allow 0 return value when detaching
 or joining joined thread
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

Hi!
> Latest test in our openqa setup (Linux 7.1-rc2, Glibc 2.43) show following errors:
> - pthread_detach_4-2: Test FAILED: Incorrect return code: 0 instead of ESRCH
> - pthread_join_6-2: Test FAILED: Return code should be ESRCH, but is: 0 instead.
> 
> These are caused by glibc commit 5da15b15adab661c80e373b6af89be0b5fa5b3ad
> ("nptl: Do not use pthread set_tid_address as state synchronization (BZ #19951)").
> 
> The new glibc logic removed the explicit validation of thread handles that
> previously returned ESRCH:
> 
> --- a/nptl/pthread_detach.c
> -  if (INVALID_NOT_TERMINATED_TD_P (pd))
> -    return ESRCH;
> 
> --- a/nptl/pthread_join_common.c
> -  if (INVALID_NOT_TERMINATED_TD_P (pd))
> -    return ESRCH;
> -
> 
> Update the tests to allow both return codes.
> 
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  .../conformance/interfaces/pthread_detach/4-2.c             | 6 +++---
>  .../conformance/interfaces/pthread_join/6-2.c               | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c
> index a6dc83efd..1e7b84117 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c
> @@ -18,7 +18,7 @@
>   * 1. Create a thread.
>   * 2.Wait 'till the thread exits.
>   * 3.Try and detach this thread.
> - * 4.Check the return value and make sure it is ESRCH
> + * 4.Check the return value and make sure it is ESRCH or 0
>   *
>   */
>  
> @@ -59,9 +59,9 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
>  	ret = pthread_detach(new_th);
>  
>  	/* Check return value of pthread_detach() */
> -	if (ret != ESRCH) {
> +	if (ret != ESRCH && ret != 0) {
>  		printf
> -		    ("Test FAILED: Incorrect return code: %d instead of ESRCH\n",
> +		    ("Test FAILED: Incorrect return code: %d instead of ESRCH or 0\n",
>  		     ret);
>  		return PTS_FAIL;

Technically since this is open posix testsuite we should PTS_UNTESTED on
0 since we were not able to trigger the error since the implementation
does not implement the optional behavior.

Something as:

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c
index 1e7b84117..fc7a6e9c9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c
@@ -58,8 +58,13 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
        /* Detach the non-existant thread. */
        ret = pthread_detach(new_th);

+       if (ret == 0) {
+               printf("Test UNTESTED: Implementation does not return ESCHR\n");
+               return PTS_UNTESTED;
+       }
+
        /* Check return value of pthread_detach() */
-       if (ret != ESRCH && ret != 0) {
+       if (ret != ESRCH) {
                printf
                    ("Test FAILED: Incorrect return code: %d instead of ESRCH or 0\n",
                     ret);


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
