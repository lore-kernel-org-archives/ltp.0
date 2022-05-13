Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AC6C433F5
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 12:18:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34A503CA9F3
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 14:18:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3101F3CA928
 for <ltp@lists.linux.it>; Fri, 13 May 2022 14:18:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4FFCE1000D41
 for <ltp@lists.linux.it>; Fri, 13 May 2022 14:18:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E50111F954;
 Fri, 13 May 2022 12:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652444305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J+u60xJfXS+b+Hj07FHQ7nZ5sCaGGtgAEoPGdQUh0gw=;
 b=QoRIcjYMfdBA2ISYn7Wj8MCAyCQzlsxAub5RSfK6pZ5I/mah3FB2EI772m3RQzPARV0BcB
 zg2jujZkEeyRp0DpWwUJr/u2CvCeAosO9xvHTE0jdk9qzs7gtHa1ztZ38R70+3YHr8O3oj
 N8lVVxT98e3YymMCWFZHdaB69WRg3DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652444305;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J+u60xJfXS+b+Hj07FHQ7nZ5sCaGGtgAEoPGdQUh0gw=;
 b=UU7qGIgkTo71IkWpv/pOOZp58UxywSPWwGAtcZtT3Fnng1JmkWmf6igKYPBuKr+fr1DCjb
 JQSOFcnuTCQAWADQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2CFA13A84;
 Fri, 13 May 2022 12:18:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dlwnMpFMfmKuTwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 13 May 2022 12:18:25 +0000
Date: Fri, 13 May 2022 14:20:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yn5NGPpfoddFYTs2@yuki>
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-23-chrubis@suse.cz>
 <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 22/29] fuzzy_sync: Convert to runtime
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> > index 4f09ed416..bef424002 100644
> > --- a/include/tst_fuzzy_sync.h
> > +++ b/include/tst_fuzzy_sync.h
> > @@ -160,15 +160,6 @@ struct tst_fzsync_pair {
> >         int b_cntr;
> >         /** Internal; Used by tst_fzsync_pair_exit() and
> > fzsync_pair_wait() */
> >         int exit;
> > -       /**
> > -        * The maximum desired execution time as a proportion of the
> > timeout
> > -        *
> > -        * A value x so that 0 < x < 1 which decides how long the test
> > should
> > -        * be run for (assuming the loop limit is not exceeded first).
> > -        *
> > -        * Defaults to 0.5 (~150 seconds with default timeout).
> > -        */
> > -       float exec_time_p;
> >         /** Internal; The test time remaining on tst_fzsync_pair_reset() */
> >         float exec_time_start;
> >         /**
> > @@ -214,7 +205,6 @@ static inline void tst_fzsync_pair_init(struct
> > tst_fzsync_pair *pair)
> >         CHK(avg_alpha, 0, 1, 0.25);
> >         CHK(min_samples, 20, INT_MAX, 1024);
> >         CHK(max_dev_ratio, 0, 1, 0.1);
> > -       CHK(exec_time_p, 0, 1, 0.5);
> >         CHK(exec_loops, 20, INT_MAX, 3000000);
> >
> >         if (tst_ncpus_available() <= 1)
> > @@ -291,7 +281,7 @@ static inline void tst_fzsync_pair_reset(struct
> > tst_fzsync_pair *pair,
> >         if (run_b)
> >                 SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);
> >
> > -       pair->exec_time_start = (float)tst_timeout_remaining();
> > +       pair->exec_time_start = (float)tst_remaining_runtime();
> >  }
> >
> >  /**
> > @@ -644,10 +634,9 @@ static inline void tst_fzsync_wait_b(struct
> > tst_fzsync_pair *pair)
> >   */
> >  static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
> >  {
> > -       float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;
> > +       float rem_p = 1 - tst_remaining_runtime() / pair->exec_time_start;
> >
> > -       if ((pair->exec_time_p * SAMPLING_SLICE < rem_p)
> > -               && (pair->sampling > 0)) {
> > +       if ((SAMPLING_SLICE < rem_p) && (pair->sampling > 0)) {
> >                 tst_res(TINFO, "Stopped sampling at %d (out of %d)
> > samples, "
> >                         "sampling time reached 50%% of the total time
> > limit",
> >                         pair->exec_loop, pair->min_samples);
> > @@ -655,7 +644,7 @@ static inline int tst_fzsync_run_a(struct
> > tst_fzsync_pair *pair)
> >                 tst_fzsync_pair_info(pair);
> >         }
> >
> > -       if (pair->exec_time_p < rem_p) {
> > +       if (rem_p >= 1) {
> >
> 
> I hit a new problem while testing new pty03, that seems here
> will fall into an infinite loop and test timed out finally. The printf
> shows rem_p will be overflow I haven't figured out why.
> 
> But with comparing with 0.9, it always gets passed on to the same system.

That is strange, since we do:

	rem_p = 1 - tst_remaining_runtime()/pair->time_exec_start;


And the tst_remaining_runtime() should return 0 once the time is up so
the end result should be that rem_p will end up 1 sooner or later.

Anyways we can as well use the value from tst_remainig_runtime()
directly instead as:

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index bef424002..db5bec7a4 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -634,7 +634,8 @@ static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
  */
 static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
 {
-       float rem_p = 1 - tst_remaining_runtime() / pair->exec_time_start;
+       int remaining_runtime = tst_remaining_runtime();
+       float rem_p = 1 - remaining_runtime / pair->exec_time_start;

        if ((SAMPLING_SLICE < rem_p) && (pair->sampling > 0)) {
                tst_res(TINFO, "Stopped sampling at %d (out of %d) samples, "
@@ -644,7 +645,7 @@ static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
                tst_fzsync_pair_info(pair);
        }

-       if (rem_p >= 1) {
+       if (!remaining_runtime) {
                tst_res(TINFO,
                        "Exceeded execution time, requesting exit");
                tst_atomic_store(1, &pair->exit);


Does that fix your problem?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
