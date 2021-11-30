Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE57EC433F5
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 10:22:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D8973C66FF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 11:22:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E97003C551F
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:21:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 852DA60103A
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:21:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD9171FD54;
 Tue, 30 Nov 2021 10:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638267715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DIrSwsnKYht7d07V4vAgwrJyzD1yqK6L/CX2mNQTArg=;
 b=oGIQbrI6OlqK+1D5kWAPIgZSuUzahMF2zjNNpT5Rt+Rf197+2qvUopFJ8JraP6i3dGZkMz
 fa1LXfLs7cxTfgUE9Men5B7LfQoPPrXX01PZ3rNF7cFBorwkFt6DqVliM8uUM4bWYZ6jKy
 zJVLseLVkZziEbtG5jNg/tSwRDKIr4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638267715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DIrSwsnKYht7d07V4vAgwrJyzD1yqK6L/CX2mNQTArg=;
 b=CkBqL08p8qQUSd668nOjarJDEx0sEV720JulQu+64Msa+L/N1wdu8mW9XC17qZ5LBqjZ+/
 t89fxkxYIM5ca5CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B12B613D2F;
 Tue, 30 Nov 2021 10:21:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UOAIKkP7pWHtMwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 30 Nov 2021 10:21:55 +0000
Date: Tue, 30 Nov 2021 11:23:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YaX7i/ezRhxANBwM@yuki>
References: <20211123124348.31073-1-rpalethorpe@suse.com>
 <20211123124348.31073-2-rpalethorpe@suse.com>
 <YZ3l+QtJA+/RCp6v@pevik> <87v90akpyy.fsf@suse.de>
 <YaX6nLRGwtfUTjrP@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YaX6nLRGwtfUTjrP@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] tools/sparse: Add static check
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
Cc: chrubis@suze.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Thanks! pushed. Please pull and try it out.
> 
> Looks like it fails on fuzzy sync since it uses tst_ but it's in an
> header.
> 
> These definitions should be static inline and changing them so fixes the
> warnings. It looks like static inline functions does not make it into
> the symbol test at all.

This is even stranger, the 'static inline void' functions does not make
it into the check function, but anything that returns a non-void value
does get there so we need:

diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
index 2f32bfa38..b1677d336 100644
--- a/tools/sparse/sparse-ltp.c
+++ b/tools/sparse/sparse-ltp.c
@@ -98,7 +98,7 @@ static void check_symbol_visibility(const struct symbol *const sym)
        if (!(mod & MOD_TOPLEVEL))
                return;

-       if (has_lib_prefix && (mod & MOD_STATIC)) {
+       if (has_lib_prefix && (mod & MOD_STATIC) && !(mod & MOD_INLINE)) {
                warning(sym->pos,
                        "LTP-003: Symbol '%s' has the LTP public library prefix, but is static (private).",
                        name);

And:

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 8f97bb8f6..bc3450294 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -210,7 +210,7 @@ struct tst_fzsync_pair {
  *
  * @sa tst_fzsync_pair_reset()
  */
-static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
+static inline void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
 {
        CHK(avg_alpha, 0, 1, 0.25);
        CHK(min_samples, 20, INT_MAX, 1024);
@@ -230,7 +230,7 @@ static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
  *
  * Call this from your cleanup function.
  */
-static void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
+static inline void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
 {
        if (pair->thread_b) {
                /* Revoke thread B if parent hits accidental break */
@@ -254,7 +254,7 @@ struct tst_fzsync_run_thread {
  * Wrap run_b for tst_fzsync_pair_reset to enable pthread cancel
  * at the start of the thread B.
  */
-static void *tst_fzsync_thread_wrapper(void *run_thread)
+static inline void *tst_fzsync_thread_wrapper(void *run_thread)
 {
        struct tst_fzsync_run_thread t = *(struct tst_fzsync_run_thread *)run_thread;

@@ -268,7 +268,7 @@ static void *tst_fzsync_thread_wrapper(void *run_thread)
  *
  * @relates tst_fzsync_stat
  */
-static void tst_init_stat(struct tst_fzsync_stat *s)
+static inline void tst_init_stat(struct tst_fzsync_stat *s)
 {
        s->avg = 0;
        s->avg_dev = 0;
@@ -292,7 +292,7 @@ static void tst_init_stat(struct tst_fzsync_stat *s)
  *
  * @sa tst_fzsync_pair_init()
  */
-static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
+static inline void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
                                  void *(*run_b)(void *))
 {
        tst_fzsync_pair_cleanup(pair);
@@ -340,7 +340,7 @@ static inline void tst_fzsync_stat_info(struct tst_fzsync_stat stat,
  *
  * @relates tst_fzsync_pair
  */
-static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
+static inline void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
 {
        tst_res(TINFO, "loop = %d, delay_bias = %d",
                pair->exec_loop, pair->delay_bias);
@@ -493,7 +493,7 @@ static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
  *
  * @relates tst_fzsync_pair
  */
-static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
+static inline void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 {
        float alpha = pair->avg_alpha;
        float per_spin_time, time_delay;



-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
