Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CA6C54E90
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 17:48:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 693783CC8AE
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 19:48:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 744623C088D
 for <ltp@lists.linux.it>; Thu, 22 May 2025 19:47:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D3A5F1400054
 for <ltp@lists.linux.it>; Thu, 22 May 2025 19:47:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF17E1F443;
 Thu, 22 May 2025 17:47:47 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1CF313433;
 Thu, 22 May 2025 17:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9sLLNkNjL2geUAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 22 May 2025 17:47:47 +0000
Date: Thu, 22 May 2025 19:47:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aC9jOhqDkRwGp9-T@rei>
References: <20250521095302.13845-1-chrubis@suse.cz>
 <20250522173111.GA19708@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250522173111.GA19708@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: EF17E1F443
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: LTP_SINGLE_FS_TYPE fix fuse blacklist
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
> > The case of LTP_SINGLE_FS_TYPE did not proplerly used the fuse
> > filesystem blacklist and we enabled fuse filesystem even for tests that
> > explicitly stated in the tst_test structure that they do not work with
> > fuse.
> 
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > CC: Jan Polensky <japo@linux.ibm.com>
> > ---
> >  lib/tst_supported_fs_types.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> > diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> > index bbbb8df19..3a394283c 100644
> > --- a/lib/tst_supported_fs_types.c
> > +++ b/lib/tst_supported_fs_types.c
> > @@ -158,8 +158,10 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
> >  	only_fs = getenv("LTP_SINGLE_FS_TYPE");
> 
> >  	if (only_fs) {
> > +		enum tst_fs_impl ret;
> >  		tst_res(TINFO, "WARNING: testing only %s", only_fs);
> > -		if (tst_fs_is_supported(only_fs))
> > +		ret = tst_fs_is_supported(only_fs);
> > +		if (ret == TST_FS_KERNEL || (ret == TST_FS_FUSE && !skip_fuse))
> >  			fs_types[0] = only_fs;
> 
> Is it really good thing to do?
> Because LTP_SINGLE_FS_TYPE forces whatever filesystems, it ignores
> .skip_filesystems. E.g. creat09.c don't want to be tested on ntfs (and others
> but we can force it):

Ah, right, we have to apply the skiplist as well, so on the top of that
we need, I will send a v2.

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 3a394283c..736e68dec 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -159,10 +159,16 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)

        if (only_fs) {
                enum tst_fs_impl ret;
+
                tst_res(TINFO, "WARNING: testing only %s", only_fs);
+
+               if (tst_fs_in_skiplist(only_fs, skiplist))
+                       return fs_types;
+
                ret = tst_fs_is_supported(only_fs);
                if (ret == TST_FS_KERNEL || (ret == TST_FS_FUSE && !skip_fuse))
                        fs_types[0] = only_fs;
+
                return fs_types;
        }

> Could we clearly define what we expect from LTP_SINGLE_FS_TYPE?
> FYI I put links to the discussion in the ticket
> https://github.com/linux-test-project/ltp/issues/1242
> 
> I understand the wish to use LTP_SINGLE_FS_TYPE for a proper testing.  If that
> requires to respect .skip_filesystems, but
> 1) it should be done for all filesystems
> 2) we should have another variable to allow to force the user defined
> filesystem, e.g.
> LTP_SINGLE_FS_TYPE=ntfs LTP_SINGLE_FS_TYPE_FORCE_FS=1

What about LTP_FORCE_SINGLE_FS_TYPE=ntfs that would do the same as
LTP_SINGLE_FS_TYPE=ntfs but would disable the skiplist?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
