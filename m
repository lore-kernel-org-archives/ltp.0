Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C061C433F5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 07:48:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7127C3C8CF5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 08:47:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 688093C4B8F
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 08:47:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B5F1C1A001D8
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 08:47:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 928071FD58;
 Mon, 22 Nov 2021 07:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637567263;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3gUeHfZeYpJwk8vTvMN+6s+MYAIG0/bmYj9D7Qf+YZY=;
 b=hMuNjDdL49MgSGBD0toy/QtjCq22tq122JvrlrS/2rpRcvbM1RBwpjFVf2flPQAMLd4lOX
 h3o18m8TlOdQLkNjlOzvVn/4GDCbqSYs13XIi6YRpbdT3kGtF65FcaXbSj4axU1aRFBky9
 ZbVwWVwneOYfCTUZ3hRm3xhQ8BAj7GQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637567263;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3gUeHfZeYpJwk8vTvMN+6s+MYAIG0/bmYj9D7Qf+YZY=;
 b=OGpan03wXeu5Pkyx97/2Vt4LfDF0iOGcoMFHvTtd+qDr1z2tuRCUD39j2SDLsEAS3XErLn
 JFTvexderpK+HoBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4801113466;
 Mon, 22 Nov 2021 07:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QJUJEB9Lm2FCJAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 22 Nov 2021 07:47:43 +0000
Date: Mon, 22 Nov 2021 08:47:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <YZtLDXW01Cz0BfPU@pevik>
References: <20211118235744.802584-1-krisman@collabora.com>
 <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
 <8735nsuepi.fsf@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8735nsuepi.fsf@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

<snip>
> Hi Amir,

> I have pushed v4 to :

> https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4

FYI I've rebased it on my fix 3b2ea2e00 ("configure.ac: Add struct
fanotify_event_info_pidfd check")

https://github.com/linux-test-project/ltp.git -b gertazi/fanotify21.v4.fixes

diff to krisman/fan-fs-error_v4:

diff --git configure.ac configure.ac
index a9dc25249..d25183368 100644
--- configure.ac
+++ configure.ac
@@ -160,8 +160,8 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
-AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header,
-		struct fanotify_event_info_error],[],[],[#include <sys/fanotify.h>])
+AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
+		struct fanotify_event_info_header, struct fanotify_event_info_pidfd],,,[#include <sys/fanotify.h>])
 AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct file_handle],,,[

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
