Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391A1C77B7C
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 18:38:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C33863CE0B6
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 20:38:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73BB93CB504
 for <ltp@lists.linux.it>; Wed, 10 May 2023 20:38:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A34DB1A00706
 for <ltp@lists.linux.it>; Wed, 10 May 2023 20:38:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D534821892;
 Wed, 10 May 2023 18:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683743895;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pNqx9zgQIoRJ6E325I1d32CFFruQIWhcItiyTwSt96Q=;
 b=ogeZ2XY51FO2Mp/yuP4FGDUNG/55P+OqXOMlD62QA7x3rgL+WGRMzXJU5q4ncYWjlkyman
 iZtkKWaFOE4Z7cdCsSTbQEz1CMsMYEF4iV9Pr/a3ioD9x2NT7DrATMefxnuMaCIwTIIVa5
 Q8ggmaTXKgYFsyPDekOkSMKde/Gnegs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683743895;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pNqx9zgQIoRJ6E325I1d32CFFruQIWhcItiyTwSt96Q=;
 b=YHHgbOzYhd+WDr/omb+d5/nwv09knR/OMRWqziaAvOX+kPinpZF9B36VfJoLa29I1rfyu9
 lnyeiVzee1NewZAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E838138E5;
 Wed, 10 May 2023 18:38:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ksS1GJXkW2S+LgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 10 May 2023 18:38:13 +0000
Date: Wed, 10 May 2023 20:38:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20230510183810.GA248413@pevik>
References: <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
 <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
 <ea4fd7d6-0985-2983-d0ce-489a32a2f6dc@suse.cz>
 <CAOQ4uxib_vxncQa3RiObKYwQg0CQvPXLH+nyRckO9FVg=ihERQ@mail.gmail.com>
 <d80e2e12-899d-f0d2-27c2-f4a92f1b2be4@suse.cz>
 <CAOQ4uxgUXZS4D1VDToGLqXV2nDuPFqUHWqwoY8V=u=iUcQFruw@mail.gmail.com>
 <ab0f73ef-9e6d-5e7e-4ee1-8aa31ef2802e@suse.cz>
 <20221025094810.pakqhh6yoxfy3h7x@quack3>
 <ac20968f-ce12-27fb-8451-7e01d7cde229@suse.cz>
 <CAOQ4uxjiduWkp9bhV4Svs5GzoA6ac4TKmeDm8rUOsNOo5b1NYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjiduWkp9bhV4Svs5GzoA6ac4TKmeDm8rUOsNOo5b1NYQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Add fanotify_get_supported_init_flags()
 helper function
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir, all,

> On Tue, Oct 25, 2022 at 4:55 PM Martin Doucha <mdoucha@suse.cz> wrote:

> > On 25. 10. 22 11:48, Jan Kara wrote:
> > > On Tue 25-10-22 10:51:01, Martin Doucha wrote:
> > >> Imagine two init flags, A and B (doesn't matter which ones) that are not
> > >> supposed to conflict in any way according to documentation. And we'll add 3
> > >> fanotify14 test cases with the following init calls:
> > >> - fanotify_init(A)
> > >> - fanotify_init(B)
> > >> - fanotify_init(A|B)

> > >> All 3 init calls are supposed to pass and then fanotify_mark() is supposed
> > >> to fail. Now imagine that we have a buggy kernel where both flags are
> > >> implemented but fanotify_init(A|B) hits a weird corner case and returns
> > >> EINVAL. In your version of the code, the test will assume that it's due to a
> > >> missing feature and report the test case as skipped. In my version of the
> > >> code, the test will report a bug because it knows that all the required
> > >> features are present.

> > > Yeah, but AFAIU you are trading expanded testing for possibility of false
> > > test failures (because the situation that for some features A and B, both A
> > > and B are implemented but A|B got implemented only later seems equally
> > > probable scenario).

> > > Since I don't find this critical to test (it seems like a relatively
> > > unlikely mistake to do), I'd prefer less testing against false test
> > > failures. If we want to be more precise, we should be spelling out in the
> > > testcase (ideally using some common infrastructure) that if A & B is
> > > supported, we also expect A|B (or even some C) to work.

> > This kind of failure may be highly unlikely on a vanilla kernel but it
> > can easily happen due to incorrectly backported patches. IMHO it's
> > better to get a failure and find out that the test case was invalid than
> > to ignore a bug that may indicate deeper issues. We can always fix a
> > broken test and possibly also update documentation of past changes in
> > syscall behavior.

> > On 25. 10. 22 13:11, Amir Goldstein wrote:
> > > It is a valid test case to assert that the support for two flags is
> > > independent,
> > > but this is not the job of fanotify14.
> > > fanotify14 checks for *illegal* flag combinations.

> > > If you feel that there should be a test that verifies that
> > > support of flag A is independent of support of flag B,
> > > then please write a different test for that.

> > > But then would you test all possible permutations of flags?
> > > Not only flags that are used in fanotify14?
> > > Not only flag pairs? but more concurrent flags?
> > > I don't know if other APIs have such rigorous tests (except API fuzzers).

> > > I agree with Jan that the value of such a test would be questionable,
> > > but it does have a value, so I won't object to having this test, as
> > > long as it does not blindly check for all the known fanotify init bits
> > > are independent.

> > We find a fair amount of kernel bugs not because we have a specific
> > targeted testcase for them but because they break test setup for
> > something else. The subtests in fanotify14 may not comprehensively test
> > all combinations of init flags but it's still "free" test coverage that
> > will be useful for catching bugs.

> > > Asserting flag combination independence should be opt-in by the test
> > > not out-out like you did with REPORT_FID and REPORT_NAME.

> > I don't understand this sentence, especially which patch it's referring to.


> All right.

> Let's see which flag combinations we have in the relevant tests in fanotify14:

> FAN_REPORT_DFID_FID,
> FAN_REPORT_DFID_NAME,
> FAN_REPORT_DFID_NAME_TARGET,

> That's all.

> Support for FAN_REPORT_FID is a requirement for the entire test.

> FAN_REPORT_TARGET_FID depends on all the rest of the flags
> and support for it is already checked explicitly to skip test cases.

> FAN_REPORT_NAME depends on FAN_REPORT_DIR_FID.

> So effectively fanotify_get_supported_init_flags() only checks
> FAN_REPORT_DIR_FID separately from the combination
> FAN_REPORT_DFID_FID.

> fanotify16, which tests *legal* combinations of these flags
> already checks the separate flag FAN_REPORT_DIR_FID
> so fanotify test cases with FAN_REPORT_DFID_FID would
> fail if a kernel that supports FAN_REPORT_DIR_FID does not
> support the combination FAN_REPORT_DFID_FID.

> Bottom line:
> fanotify_get_supported_init_flags() did not add any test coverage.

> This is why it is a slippery slope to suggest fixes without
> proving that there is a bug.

Naresh Kamboju reported [1]  5.4 mainline LTS kernels are failing on fanotify14,
exactly the same way Martin reported on SLES kernel based 5.3.18 (+ tons of
backported patches). Linaro did not mention this before, because they tested 5.4
on older LTP.

@Amir, Isn't this a reason to either accept these 2 Martin's patches or bring
another approach which fixes the detection in fanotify_init() ?

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/CA+G9fYuT3N0LFaJGzQW2SYPJxEbEWLONDZO2OfBbeHNrsowy2w@mail.gmail.com/

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
