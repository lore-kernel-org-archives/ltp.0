Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47E4C77B7F
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 07:49:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5ABB3C6E96
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 09:49:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 174513C597B
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 09:49:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 20AB7600C45
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 09:49:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 177CA21171;
 Fri, 27 Jun 2025 07:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751010540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EZKamrn3zhiXqOG7Q0G3q8vYBmO1T8skidnSQ4QbqSo=;
 b=fFT+ZRQ+fWEE3k+G9inRLHDwFYPE7wQas0YMbsQlKIvEBt9eoQ93EbdrET6o1booaVrylx
 XtEntBra9mBogoMTtf+PEGWbKov4p8FDUzfZAG1grAPO+VY0aYO8+MjHD48e4Rfu1e804+
 J13dqURQ/qmq55YXL4U2sc803xgLvjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751010540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EZKamrn3zhiXqOG7Q0G3q8vYBmO1T8skidnSQ4QbqSo=;
 b=Nq0j6cDipygZVi3lt1NQQRtnwLpfhPX92fpj6gDkIguVT+BIZKokyMZr9czm/PQyzU9ub6
 fEO3F+Wzc0/7rKBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751010540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EZKamrn3zhiXqOG7Q0G3q8vYBmO1T8skidnSQ4QbqSo=;
 b=fFT+ZRQ+fWEE3k+G9inRLHDwFYPE7wQas0YMbsQlKIvEBt9eoQ93EbdrET6o1booaVrylx
 XtEntBra9mBogoMTtf+PEGWbKov4p8FDUzfZAG1grAPO+VY0aYO8+MjHD48e4Rfu1e804+
 J13dqURQ/qmq55YXL4U2sc803xgLvjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751010540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EZKamrn3zhiXqOG7Q0G3q8vYBmO1T8skidnSQ4QbqSo=;
 b=Nq0j6cDipygZVi3lt1NQQRtnwLpfhPX92fpj6gDkIguVT+BIZKokyMZr9czm/PQyzU9ub6
 fEO3F+Wzc0/7rKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05E6613786;
 Fri, 27 Jun 2025 07:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l1QkAexMXmhQTwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Jun 2025 07:49:00 +0000
Date: Fri, 27 Jun 2025 09:49:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aF5NFP5KpuebdkwV@yuki.lan>
References: <20250616102619.54254-1-liwang@redhat.com>
 <aF1KmkMhXNWBbUwi@yuki.lan>
 <CAEemH2esWnKqv2q-UM3tHoTRfR6caLp-0yZN1yF6XCk79XSOyA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2esWnKqv2q-UM3tHoTRfR6caLp-0yZN1yF6XCk79XSOyA@mail.gmail.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] checkpoint: Refactor and unify shell/C reinit
 support
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
> > I think that the root of the problem is that the shell function
> > _tst_init_checkpoints() does not create the IPC region with the magic.
> >
> > What about this patch:
> >
> > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> > index c32bd8b19..a310d3922 100644
> > --- a/testcases/lib/tst_test.sh
> > +++ b/testcases/lib/tst_test.sh
> > @@ -627,6 +627,7 @@ _tst_init_checkpoints()
> >                 tst_brk TBROK "tst_getconf PAGESIZE failed"
> >         fi
> >         ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$pagesize"
> > count=1
> > +       ROD_SILENT printf LTPM | dd of="$LTP_IPC_PATH" bs=1 seek=0
> > conv=notrunc
> >
> 
> No, I'm afraid this won't work as expected.
> 
> The PEC failure wasn't caused by the shell checkpoint missing the "LTPM"
> magic. Instead, the root cause was that the reinitialization logic
> (tst_reinit())
> expected a different IPC format.

I do not think so, both the PEC C helpers and the tst_checkpoint.c call
tst_reinit() so as long as the function succeeds the memory layout will
be the same. The checkpoints will start at some offset in the page of
the IPC memory, but that was always the case.

And it turns out that the patch I've send yesterday does not work
because of endianity. The magic in the IPC region is MPTL on little
endian.

This patch actually works:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 495e022f7..17ce91932 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -52,7 +52,13 @@ const char *TCID __attribute__((weak));
 #define CVE_DB_URL "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"

 #define DEFAULT_TIMEOUT 30
-#define LTP_MAGIC 0x4C54504D /* Magic number is "LTPM" */
+
+/* Magic number is "LTPM" */
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+# define LTP_MAGIC 0x4C54504D
+#else
+# define LTP_MAGIC 0x4D50544C
+#endif

 struct tst_test *tst_test;

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c32bd8b19..4be10a4f9 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -627,6 +627,7 @@ _tst_init_checkpoints()
                tst_brk TBROK "tst_getconf PAGESIZE failed"
        fi
        ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$pagesize" count=1
+       ROD_SILENT "printf LTPM | dd of="$LTP_IPC_PATH" bs=1 seek=0 conv=notrunc"
        ROD_SILENT chmod 600 "$LTP_IPC_PATH"
        export LTP_IPC_PATH
 }


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
