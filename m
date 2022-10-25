Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C5FC38A2D
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 16:53:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0FEC3CA4E4
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 18:53:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A48A13C4D65
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 18:53:21 +0200 (CEST)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1B5DC1A00995
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 18:53:21 +0200 (CEST)
Received: by mail-vk1-xa2a.google.com with SMTP id p9so5634458vkf.2
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L+UU/fRMJcIts4F4OCLKL5bqWRpnC6aNUQPALSFoAVw=;
 b=oGeAd14FMjz0Ajq8eP+aCdwCnp9ly1P6rBS5QhBiH7+UzEaTx/gQ7IYN7Xo/BVAovp
 NiOQwyR2ap4z+1OnVIf2wWHmZbLgqkj9bF8Bsyl7gc9u4+NtDPt7Njg4+Uvnka1Ry0dH
 eSJuuOAPAq0sYa2VchGDQXGGrZGti0xHJZ1H9RxdJfg8/+XeOHg6Ukku/y7gbTUTEm98
 18xixHFdwGKqWQ7uuoa+WalGC/kCaWmJ5ferK2+aOSC+BujP6EE4ql+oE82Egww4NxS2
 9uKis8sj2HlM+1Qj/LZBoU9owc1SDbw/GDD/xhCiYokZLzKXiUEsOlRLW+ZrLnQlVD1d
 WY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L+UU/fRMJcIts4F4OCLKL5bqWRpnC6aNUQPALSFoAVw=;
 b=aW8KyJXEYavjLXoN1753qc6cY/UPaHK1rkYYAmrazgPVIecS1ieaHmGOhvguTzp7cF
 Z3FkL4gn3Eg2GX98x6upnFroMLCNbF3P95mG2nH7XV1/78DxOa2afgTHP3xmmgcU2jcn
 sS3hn8CqVyR08F8oTisJSKFxzOnvViV85APL5vlDyhr0s4dhUrFNuPCh2WIJaZbdELjw
 UOH6pHXLU1WNKhOzzHV3ZElUi9J/mjmznFRiFohs/HOMQ3F4TgrTpk87Aq0N5zbbOlkh
 w73rVAogQrgdtvoaM9XHK81RiG+wTCjKSQnFNxSNEGiTUqpmDjwPYEL+sal7OWN6/iuS
 8QYw==
X-Gm-Message-State: ACrzQf0RXA8AJCeaQCrPy9y4T+vNWIG8T48vFvdbPJBVbIobVnNhRKFb
 U6jINHvV7qh+mAqhFZYygxMNATOFxbFh32bQa8k=
X-Google-Smtp-Source: AMsMyM7vtKL1DfEBIeBa8B5vxRsfw9CoAWe2lpAxeHnDM4+ajy3xAI14M+3vfL/3uwktE4/VjuheHMNo7jEG8Zvw6qk=
X-Received: by 2002:a1f:c2:0:b0:3b5:f7e5:fef0 with SMTP id
 185-20020a1f00c2000000b003b5f7e5fef0mr7120336vka.11.1666716799831; 
 Tue, 25 Oct 2022 09:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
 <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
 <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
 <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
 <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
 <ea4fd7d6-0985-2983-d0ce-489a32a2f6dc@suse.cz>
 <CAOQ4uxib_vxncQa3RiObKYwQg0CQvPXLH+nyRckO9FVg=ihERQ@mail.gmail.com>
 <d80e2e12-899d-f0d2-27c2-f4a92f1b2be4@suse.cz>
 <CAOQ4uxgUXZS4D1VDToGLqXV2nDuPFqUHWqwoY8V=u=iUcQFruw@mail.gmail.com>
 <ab0f73ef-9e6d-5e7e-4ee1-8aa31ef2802e@suse.cz>
 <20221025094810.pakqhh6yoxfy3h7x@quack3>
 <ac20968f-ce12-27fb-8451-7e01d7cde229@suse.cz>
In-Reply-To: <ac20968f-ce12-27fb-8451-7e01d7cde229@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 25 Oct 2022 19:53:08 +0300
Message-ID: <CAOQ4uxjiduWkp9bhV4Svs5GzoA6ac4TKmeDm8rUOsNOo5b1NYQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Oct 25, 2022 at 4:55 PM Martin Doucha <mdoucha@suse.cz> wrote:
>
> On 25. 10. 22 11:48, Jan Kara wrote:
> > On Tue 25-10-22 10:51:01, Martin Doucha wrote:
> >> Imagine two init flags, A and B (doesn't matter which ones) that are not
> >> supposed to conflict in any way according to documentation. And we'll add 3
> >> fanotify14 test cases with the following init calls:
> >> - fanotify_init(A)
> >> - fanotify_init(B)
> >> - fanotify_init(A|B)
> >>
> >> All 3 init calls are supposed to pass and then fanotify_mark() is supposed
> >> to fail. Now imagine that we have a buggy kernel where both flags are
> >> implemented but fanotify_init(A|B) hits a weird corner case and returns
> >> EINVAL. In your version of the code, the test will assume that it's due to a
> >> missing feature and report the test case as skipped. In my version of the
> >> code, the test will report a bug because it knows that all the required
> >> features are present.
> >
> > Yeah, but AFAIU you are trading expanded testing for possibility of false
> > test failures (because the situation that for some features A and B, both A
> > and B are implemented but A|B got implemented only later seems equally
> > probable scenario).
> >
> > Since I don't find this critical to test (it seems like a relatively
> > unlikely mistake to do), I'd prefer less testing against false test
> > failures. If we want to be more precise, we should be spelling out in the
> > testcase (ideally using some common infrastructure) that if A & B is
> > supported, we also expect A|B (or even some C) to work.
>
> This kind of failure may be highly unlikely on a vanilla kernel but it
> can easily happen due to incorrectly backported patches. IMHO it's
> better to get a failure and find out that the test case was invalid than
> to ignore a bug that may indicate deeper issues. We can always fix a
> broken test and possibly also update documentation of past changes in
> syscall behavior.
>
> On 25. 10. 22 13:11, Amir Goldstein wrote:
> > It is a valid test case to assert that the support for two flags is
> > independent,
> > but this is not the job of fanotify14.
> > fanotify14 checks for *illegal* flag combinations.
> >
> > If you feel that there should be a test that verifies that
> > support of flag A is independent of support of flag B,
> > then please write a different test for that.
> >
> > But then would you test all possible permutations of flags?
> > Not only flags that are used in fanotify14?
> > Not only flag pairs? but more concurrent flags?
> > I don't know if other APIs have such rigorous tests (except API fuzzers).
> >
> > I agree with Jan that the value of such a test would be questionable,
> > but it does have a value, so I won't object to having this test, as
> > long as it does not blindly check for all the known fanotify init bits
> > are independent.
>
> We find a fair amount of kernel bugs not because we have a specific
> targeted testcase for them but because they break test setup for
> something else. The subtests in fanotify14 may not comprehensively test
> all combinations of init flags but it's still "free" test coverage that
> will be useful for catching bugs.
>
> > Asserting flag combination independence should be opt-in by the test
> > not out-out like you did with REPORT_FID and REPORT_NAME.
>
> I don't understand this sentence, especially which patch it's referring to.
>

All right.

Let's see which flag combinations we have in the relevant tests in fanotify14:

FAN_REPORT_DFID_FID,
FAN_REPORT_DFID_NAME,
FAN_REPORT_DFID_NAME_TARGET,

That's all.

Support for FAN_REPORT_FID is a requirement for the entire test.

FAN_REPORT_TARGET_FID depends on all the rest of the flags
and support for it is already checked explicitly to skip test cases.

FAN_REPORT_NAME depends on FAN_REPORT_DIR_FID.

So effectively fanotify_get_supported_init_flags() only checks
FAN_REPORT_DIR_FID separately from the combination
FAN_REPORT_DFID_FID.

fanotify16, which tests *legal* combinations of these flags
already checks the separate flag FAN_REPORT_DIR_FID
so fanotify test cases with FAN_REPORT_DFID_FID would
fail if a kernel that supports FAN_REPORT_DIR_FID does not
support the combination FAN_REPORT_DFID_FID.

Bottom line:
fanotify_get_supported_init_flags() did not add any test coverage.

This is why it is a slippery slope to suggest fixes without
proving that there is a bug.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
