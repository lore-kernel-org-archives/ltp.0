Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D46C433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 13:26:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD1433C987F
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 14:26:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 933913C9838
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 14:26:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7FD341000553
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 14:26:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643721994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pk1vCw9/LX0a6qj8blU/C3aQQuB9EmCgcQBMklIDHMg=;
 b=jCdnjlTo2jcFZt8xSzFpUOHZDzeebFuuRC4M7jLGkp1V4Ne4PLhIECGgj61Ebrij3/SSLH
 5G8UG5B0TCuYmTz/mBLozgHHvTjVNF/eifEG+8SYIP4CVPwYJJzAp5LkLcJLJr45Qk2qTM
 qrEGE7Wgt12XYtM6cF+Pt11iW7D46+I=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-0YACgxAoN4WkLZ8OALMxFw-1; Tue, 01 Feb 2022 08:26:32 -0500
X-MC-Unique: 0YACgxAoN4WkLZ8OALMxFw-1
Received: by mail-yb1-f197.google.com with SMTP id
 g67-20020a25db46000000b0061437d5e4b3so32582674ybf.10
 for <ltp@lists.linux.it>; Tue, 01 Feb 2022 05:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pk1vCw9/LX0a6qj8blU/C3aQQuB9EmCgcQBMklIDHMg=;
 b=KCYGI9UgiCC8si+20ePx/898ibnOzDbYXCt8mdAvxYz5mqlmC0ngLTD2kTUaDf8m1Y
 MK28kfdyQltoZ/ms3LkTYReihd1uBFoH5rsKmkv0VxTQKBssKg8VydH7iGEQaQztCyz0
 pfRgMEzzKMpKASr1XPGthMZPyMzDRHh7cjIop7YyR37cXCDNKeTxDhS7FH4Q2u4nCq1X
 +vZibILSyGnV9Vsm/4g71ZQNPlE0tX4/GCqium3QcYoyqX2+HnmmDbDiqY4EptUENIqt
 DtV9VUsjhjcPykbK9EFZonE5ZC+DM+6pG7aRDdzw5SWF5l6llKOhYlgoSYEvQg0oSbYb
 gGIA==
X-Gm-Message-State: AOAM533yE4UPNXmj1AAi9RPwsvtdUd4t4enFzFHZSD6Bo65bTRRO9B+3
 rrWg+U26Tzproq111/mGDwLtrV3rj5k7R+mybqYD3fSnleDqx6LZBgAj+/LC+tOTvOip/pUXX5I
 FiTYokW+ltoUeL/zM8SGLWixsUi8=
X-Received: by 2002:a25:c70f:: with SMTP id w15mr36869393ybe.32.1643721991723; 
 Tue, 01 Feb 2022 05:26:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEOo3BSo2h0Sek1pF4zewXiV3zj7CmwC41ie2HxyfFp7GGzZGQPuKKNOLAzlVCOHtNKQ67bT7OLyAWBWefds4=
X-Received: by 2002:a25:c70f:: with SMTP id w15mr36869370ybe.32.1643721991493; 
 Tue, 01 Feb 2022 05:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20220127171455.9809-1-pvorel@suse.cz>
 <61F609C7.1080803@fujitsu.com> <YfeN6fG28AVNC44n@pevik>
In-Reply-To: <YfeN6fG28AVNC44n@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 1 Feb 2022 21:26:17 +0800
Message-ID: <CAEemH2fRtV+OqrW+x49RosgpyOYqCZ1ULxvZvqwypK8HQn6EQA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run
 at all
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

.

On Mon, Jan 31, 2022 at 3:21 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> ...
> > > +++ b/lib/tst_test.c
> > > @@ -811,6 +811,9 @@ static void do_exit(int ret)
> > >             fprintf(stderr, "broken   %d\n", results->broken);
> > >             fprintf(stderr, "skipped  %d\n", results->skipped);
> > >             fprintf(stderr, "warnings %d\n", results->warnings);
> > > +           fprintf(stderr, "not run  %d\n", tst_test->tcnt -
> > > +                           results->passed - results->failed - results->broken -
> > > +                           results->skipped - results->warnings);
> > IMO, these values are not necessary related. Refer to quotactl01.c(
> > tst_test->tcnt is less than results->passed)
> Ah, correct. Also .test_all means tst_test->tcnt to be 0.
> So my patch is utterly wrong.
>
> > Also, if you want to add a new tag, you should define the situation for it.

That sounds like a complicated method, if we go add a new tag,
we have to count the times for each arbitrary 'return' of the test.
(Because it does not use TCONF)
This obviously brings more work to the author and is not recommended IMHO.

To strictly, every test should follow the principle of new LTP API,
to list all test items in the 'struct tcase{ ... }', and with no tst_test->tcnt
defined means that is only one test.

Based on these, I think the total test number of a testcase
(with 'tst_test->tcnt' defined) should be:
    (tst_test->tcnt * test_variants)

>
> What is my point: number of the defined tests does not mean they are all run.

Agree, at least it makes sense for those tests explicitly defined tcnt.

>
> Maybe printing number of the tests in the test (tst_test->tcnt or 1 when
> tst_test->test_all)?
>
> My point is to have an idea without looking into the code know how many tests
> have been skipped on certain setup.

Yes, I understand. So how about this way:

--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -785,6 +785,8 @@ static void print_failure_hints(void)
        print_failure_hint("known-fail", "hit by known kernel failures", NULL);
 }

+static unsigned int test_variants = 1;
+
 static void do_exit(int ret)
 {
        if (results) {
@@ -811,9 +813,11 @@ static void do_exit(int ret)
                fprintf(stderr, "broken   %d\n", results->broken);
                fprintf(stderr, "skipped  %d\n", results->skipped);
                fprintf(stderr, "warnings %d\n", results->warnings);
-               fprintf(stderr, "not run  %d\n", tst_test->tcnt -
-                               results->passed - results->failed -
results->broken -
-                               results->skipped - results->warnings);
+               if (tst_test->tcnt) {
+                       fprintf(stderr, "not-run  %d\n",
(tst_test->tcnt * test_variants) -
+                                       results->passed -
results->failed - results->broken -
+                                       results->skipped - results->warnings);
+               }
        }

        do_cleanup();
@@ -1529,7 +1533,6 @@ unsigned int tst_variant;
 void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 {
        int ret = 0;
-       unsigned int test_variants = 1;

        lib_pid = getpid();
        tst_test = self;


--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
