Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DE4C38A2D
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 11:11:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84CEC3CA3B2
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 13:11:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25D923C86C5
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 13:11:37 +0200 (CEST)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4CA5F60085F
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 13:11:37 +0200 (CEST)
Received: by mail-ua1-x92e.google.com with SMTP id e26so1330082uaa.7
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VJ+Lf1KnG2ZEHy+vtehJ67+0Ydv0T44t/tpyWwADdLo=;
 b=UAk9qHeB/zcK0o3R8tRvY022dpRGylWIe079JcNnj2M22Qu2WwNC5+1X9F7xisJqdG
 7QAN7rqAkZsOI6aM/qqBIpObij12aPJ0iT45eCx/ziw7NlqHsJ9cpOR+MME4/bzWgVeJ
 ndXAbwfJwkzOeQrEvnS6SrjRiqWokLj0R/wtvLQDEEBUckcOGI/Xo8EAk+xXJvsjctdu
 lJ9KFlzF6L6E+E70yEG8H4E4TyUxeqX7jaoeaXrUx9rhTXH01TvcMQNHBsPv5e076WyP
 2jop02HDhDjbHJ6OD7nyFGd+CiS+gi4c0ugPvz8kmjdDqza4Mje2rhgvh1KZ7O80T+YC
 n3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJ+Lf1KnG2ZEHy+vtehJ67+0Ydv0T44t/tpyWwADdLo=;
 b=0pYV4Bs15uYrJ+lvmaZurBjNhJcmipUMDUhA+pmnC/AjEP0npMLh9JSG7KlHkL9SFo
 cMn6KH36Y+P8ojOhhDtKW5KEqW0mZjbC9b0LJN1uR1d3qDJeS3uYKXHu45jEEJ/3q52A
 r0MsF5P9D4pU+A1JBMgo9ZoxfaLTyJocv07bKsNlxTsR5I5FMsDBZD2ME76WUHn/0eky
 LaPkPg1yrdlOCh6gpB5YO24O8XHCeKoPWarbqYfd9DYQXVDP/lzoNJsq3FgSnP63sY38
 7jCW5/1/1RDpkt6IlbJ4XyTbarCNrIZfULbDHi5YwbCbjshKLQG3Vj9VhYfDnqOM4MQ4
 K2bg==
X-Gm-Message-State: ACrzQf2v15N7EloveH2eEyJzBDiTVXEpzXhFjWpJlx6Bys+jXxXBpbJY
 bkGbshORwlKe9Enle7J899XPSW3isS0+gZGXH00=
X-Google-Smtp-Source: AMsMyM4v7b6dAW9OyIigVMDuPovbe3hpD0jvUf57qALcS0rBMk9nN6KLRrHMe1P54wdrjqi+YzgkPdBaC8CKF0IvdSI=
X-Received: by 2002:ab0:4715:0:b0:3ea:d249:de4c with SMTP id
 h21-20020ab04715000000b003ead249de4cmr22307877uac.80.1666696296081; Tue, 25
 Oct 2022 04:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221020130843.15147-1-mdoucha@suse.cz>
 <20221020130843.15147-3-mdoucha@suse.cz>
 <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
 <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
 <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
 <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
 <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
 <ea4fd7d6-0985-2983-d0ce-489a32a2f6dc@suse.cz>
 <CAOQ4uxib_vxncQa3RiObKYwQg0CQvPXLH+nyRckO9FVg=ihERQ@mail.gmail.com>
 <d80e2e12-899d-f0d2-27c2-f4a92f1b2be4@suse.cz>
 <CAOQ4uxgUXZS4D1VDToGLqXV2nDuPFqUHWqwoY8V=u=iUcQFruw@mail.gmail.com>
 <ab0f73ef-9e6d-5e7e-4ee1-8aa31ef2802e@suse.cz>
In-Reply-To: <ab0f73ef-9e6d-5e7e-4ee1-8aa31ef2802e@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 25 Oct 2022 14:11:24 +0300
Message-ID: <CAOQ4uxjKgPzmU3eNJ5Z284rzuLd-ct55p1nY917f6CemDiQg-Q@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

On Tue, Oct 25, 2022 at 11:51 AM Martin Doucha <mdoucha@suse.cz> wrote:
>
> On 24. 10. 22 18:18, Amir Goldstein wrote:
> > Show me how this could hide a real bug.
> > Give an example.
> > It does not need to be a specific kernel
> > use an example with imaginary kernel with a backported feature if you like.
> >
> > fanotify14 is not about making sure that flag combinations are allowed
> > it is about making sure that flag combinations are not allowed.
> >
> > If the test case is testing illegal init flags, the outcome must be
> > fanotify_init
> > EINVAL.
> >
> > If the test case is testing illegal mark flags, the outcome of fanotify_init
> > may be EINVAL meaning that this test case will be skipped.
> > It does not matter which specific init flag or init flag combination
> > causes this EINVAL.
> >
> > I am ready to be proven wrong, but with examples,
> > like the one you provided with test case #8 and kernel 5.3.
> > hand waving and talking about vague "real bugs" won't convince me.
>
> Imagine two init flags, A and B (doesn't matter which ones) that are not
> supposed to conflict in any way according to documentation. And we'll
> add 3 fanotify14 test cases with the following init calls:
> - fanotify_init(A)
> - fanotify_init(B)
> - fanotify_init(A|B)
>
> All 3 init calls are supposed to pass and then fanotify_mark() is
> supposed to fail. Now imagine that we have a buggy kernel where both
> flags are implemented but fanotify_init(A|B) hits a weird corner case
> and returns EINVAL.
> In your version of the code, the test will assume
> that it's due to a missing feature and report the test case as skipped.
> In my version of the code, the test will report a bug because it knows
> that all the required features are present.
>

It is a valid test case to assert that the support for two flags is
independent,
but this is not the job of fanotify14.
fanotify14 checks for *illegal* flag combinations.

If you feel that there should be a test that verifies that
support of flag A is independent of support of flag B,
then please write a different test for that.

But then would you test all possible permutations of flags?
Not only flags that are used in fanotify14?
Not only flag pairs? but more concurrent flags?
I don't know if other APIs have such rigorous tests (except API fuzzers).

I agree with Jan that the value of such a test would be questionable,
but it does have a value, so I won't object to having this test, as
long as it does not blindly check for all the known fanotify init bits
are independent.

Asserting flag combination independence should be opt-in by the test
not out-out like you did with REPORT_FID and REPORT_NAME.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
