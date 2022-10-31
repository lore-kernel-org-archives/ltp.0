Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF43FA3740
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 11:37:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A68DD3CA99A
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 12:37:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C5FB3C9ED2
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 12:37:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 13E376006CE
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 12:37:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1636D21DAF;
 Mon, 31 Oct 2022 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667216252;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IIZrvNWSsqPW7wBLy6RfwYHLwFi2b4bZHAb2NSu9IXA=;
 b=KT70HYNxhOyVcOzOWn9khkAqPxKCRuUcgvWggWnS0ksPziBYkYoUSzc8N88QWuEInEV011
 iIM+fWSlyOW/yAQva5xRwn9YnxNT5fUOhqcXHl+v+UpZtE+nA4sj/WvmsCWhfBZZQ1WdI/
 DPGVOR1nKAL0ZYH7JsbBGbdtz0soaJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667216252;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IIZrvNWSsqPW7wBLy6RfwYHLwFi2b4bZHAb2NSu9IXA=;
 b=Oi5nJkvQhl0Vsh0mD822/mcHPVSYHjQ28Lik9rJ6+zwk2T5a4Cdkk8iA/Z6fbJWlGlzwKt
 dxM5GWgNpi9XsZDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAE9913451;
 Mon, 31 Oct 2022 11:37:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zEgDNHuzX2MgIAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 31 Oct 2022 11:37:31 +0000
Date: Mon, 31 Oct 2022 12:37:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <Y1+zeo9kmWOl2yE3@pevik>
References: <20221027140954.4094-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221027140954.4094-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: using -1 as invalid fsuid for
 setfsuid()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> a uid which does not have an entry in the /etc/passwd
> file is not really an invalid fsuid for setfsuid(), so changing
> the test to use -1 as an invalid fsuid.
> And second setfsuid(-1) call is to verify that preceding call has
> actually failed and there is no change in the fsuid.

Here was supposed to be
Fixes: 85f0b8478 ("setfsuid02: Rewrite using new LTP API")

as the problem was introduced in your rewrite, right?

> diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid02.c b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> index 850f17834..f5aa1c004 100644
> --- a/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> +++ b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> @@ -21,9 +21,7 @@ static void run(void)
>  	uid_t invalid_uid, current_uid;

>  	current_uid = geteuid();
> -	invalid_uid = 1;
> -	while (getpwuid(invalid_uid))
> -		invalid_uid++;
> +	invalid_uid = -1;

IMHO it should be casted

invalid_uid = (uid_t)-1;

as the code in shadow-utils:
https://github.com/shadow-maint/shadow/blob/eaebea55a495a56317ed85e959b3599f73c6bdf2/src/newusers.c#L342-L345

This does not work on 16-bit version, because uid_t is unsigned int,
-1 overflows the allowed value when we do check:

UID16_CHECK(invalid_uid, setfsuid);

setfsuid02.c:26: TBROK: uid -1 of invalid_uid is too large for testing 16-bit version of setfsuid()

It also does not make sense to check invalid_uid, it should have been
current_uid in 85f0b8478 (my bad not catching this):

UID16_CHECK(current_uid, setfsuid);

Please, always try to test 16-bit variant (most of us does not bother to test
32-bit compatibility, but at least to see TCONF is worth).

If you agree, I merge it with changes below.

Kind regards,
Petr

diff --git testcases/kernel/syscalls/setfsuid/setfsuid02.c testcases/kernel/syscalls/setfsuid/setfsuid02.c
index f5aa1c004..92e1979fa 100644
--- testcases/kernel/syscalls/setfsuid/setfsuid02.c
+++ testcases/kernel/syscalls/setfsuid/setfsuid02.c
@@ -21,9 +21,9 @@ static void run(void)
 	uid_t invalid_uid, current_uid;
 
 	current_uid = geteuid();
-	invalid_uid = -1;
+	invalid_uid = (uid_t)-1;
 
-	UID16_CHECK(invalid_uid, setfsuid);
+	UID16_CHECK(current_uid, setfsuid);
 
 	TST_EXP_VAL_SILENT(SETFSUID(invalid_uid), current_uid);
 	TST_EXP_VAL(SETFSUID(invalid_uid), current_uid,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
