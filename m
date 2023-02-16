Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFE1C61DA4
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 09:50:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 439D53CBEDC
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 10:50:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F5703CAEE8
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 10:50:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 900681A0027A
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 10:50:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 887A622010;
 Thu, 16 Feb 2023 09:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676541009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6RcIEyPOml9KJ/6s5h7KZYaIyLwa7U8hUvDtLd/CGY=;
 b=IlWST+tguEdfoP2uXBbfO34MX3Hb9RawXg+yUP/5BFiPip6K40nA1SQ0DbgjDT/QhSL40c
 DqZf2ZHfhWFw8KSrpUvkEXg0/iKocZ3lk7zsl6S7FQgffr9rnq/v0JcL6eIJywdhiQv9dq
 g8Z0ntNxKJegmVx1iADZXYYWCK49U+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676541009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6RcIEyPOml9KJ/6s5h7KZYaIyLwa7U8hUvDtLd/CGY=;
 b=kH7HoDNfRWIIek2KPxxTZM4EjDzXVduwZxW15sBEetB33zJQzsyyGSSoBt3bfHsuftVSbH
 e1L9TWbYp1uWQMBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E4E8139B5;
 Thu, 16 Feb 2023 09:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EW/bGVH87WOIMgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 16 Feb 2023 09:50:09 +0000
Date: Thu, 16 Feb 2023 10:51:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrei Gherzan <andrei.gherzan@canonical.com>
Message-ID: <Y+38qMc2Kdh2DPA7@yuki>
References: <Y+zcqqNE01cNcm1Y@qwirkle>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+zcqqNE01cNcm1Y@qwirkle>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP fs_fill test on vfat - ENOSPC
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
> There a couple of ways to deal with this:
> 
> 1. Force the filesystem creation in FAT32. This would be the best way
> forward in my opinion, but I can't see anything that supports doing so on
> a per-filesystem basis in LTP.
> 2. Increase the minimal numbers of entries available in the root
> directory via "-r ROOT-DIR-ENTRIES"[1]. This would only push the crash
> on fewer systems.
> 3. Use a subdirectory in the test setup. Something like /subdir/threadX.
> If I'm not missing any support to do 1, this would probably be the
> easiest to do.
> 
> I'm happy to go forward with a PR to fix this properly but looking
> forward to your feedback on how to steer this.

For number 1 we could probably add a special case in the test library,
something as (beware untested):

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 736324f04..0e6e9ebd1 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -50,6 +50,9 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
                return;
        }

+       if (!strcmp(fs_type, "vfat"))
+               argv[pos++] = "-F 32";
+
        snprintf(mkfs, sizeof(mkfs), "mkfs.%s", fs_type);

        if (fs_opts) {


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
