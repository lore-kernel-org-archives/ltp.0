Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63FBC433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 18:20:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5A523C9B6D
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 19:20:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 049C63C071A
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 19:20:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 45B78200966
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 19:20:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 53A731F383;
 Tue,  8 Feb 2022 18:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644344435;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eQlP6JlKIR+a/jL0/s+4hIEgmVPdGl8I7PYkwRHjxzU=;
 b=oFJWqrAwEm2eh+BfYcwjPigKHwTNfrsbUvUsE/MlFXpCEAGEQ3A6KRZCHT6NOb8PIWF5Sy
 rG0Iy6/+zhzck6DOPrhTTGutyRImmcYtY+MFiQzk/6CAzcDurikhka8GzNYN1MK+Wakqsz
 YAU3KOz87Y6mnCSNZYRu/RjX8kcyTzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644344435;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eQlP6JlKIR+a/jL0/s+4hIEgmVPdGl8I7PYkwRHjxzU=;
 b=odAwldkIDORgZRyJKZZwxwFzrRqNkkHwlKAFs0HSmMwcEuqUA4VcYlIe/VMwQdri2iWoIg
 fPK8u6B9nPKbodAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 309A713CDC;
 Tue,  8 Feb 2022 18:20:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YZY5CnO0AmIpfAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 08 Feb 2022 18:20:35 +0000
Date: Tue, 8 Feb 2022 19:20:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YgK0cZEPIhiApuaw@pevik>
References: <20220126181210.24897-1-pvorel@suse.cz>
 <20220126181210.24897-2-pvorel@suse.cz> <YgJ0fnXClLSKuVu+@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgJ0fnXClLSKuVu+@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] tst_test.sh: Add $TST_DEFAULT_FS_TYPE
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

Hi Cyril,

> > +export TST_DEFAULT_FS_TYPE="ext2"

> Actually if we wanted to sync with the C library it should be:

> if [ -z "$TST_FS_TYPE" ]; then
> 	if [ -n "$LTP_DEV_FS_TYPE" ]; then
> 		export TST_FS_TYPE="$LTP_DEV_FS_TYPE"
> 	else
> 		export TST_FS_TYPE="ext2"
> 	fi
> fi

Ah, I forget on $LTP_DEV_FS_TYPE, thanks.

nit: or shorter
if [ -z "$TST_FS_TYPE" ]; then
	export TST_FS_TYPE="${LTP_DEV_FS_TYPE:-ext2}"
fi

> That's equivalent of the .dev_fs_type in the tst_test structure as we
> do:

> 	if (tst_test->dev_fs_type)
> 		tdev.fs_type = tst_test->dev_fs_type;
> 	else
> 		tdev.fs_type = tst_dev_fs_type();

> And the tst_dev_fs_type() returns either $LTP_DEV_FS_TYPE or "ext2" if
> it's not defined.


BTW I meant TST_DEFAULT_FS_TYPE="ext2" as equivalent of
#define DEFAULT_FS_TYPE "ext2"
from include/tst_defaults.h.

Because df01.sh help uses hardcoded ext2:

@@ -23,13 +23,11 @@ usage: $0 [-f <ext2|ext3|ext4|vfat|...>]

 OPTIONS
 -f	Specify the type of filesystem to be built.  If not
-	specified, the default filesystem type (currently ext2)
+	specified, the default filesystem type (currently $TST_DEFAULT_FS_TYPE)
 	is used.

Thus it'd be:

export TST_DEFAULT_FS_TYPE="ext2"
if [ -z "$TST_FS_TYPE" ]; then
	export TST_FS_TYPE="${LTP_DEV_FS_TYPE:-$TST_DEFAULT_FS_TYPE}"
fi

But it's very minor, shell is different than C, we don't have to have variable
for everything.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
