Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A201BC4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 10:40:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F94E3CB164
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:40:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0750F3C9179
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 12:40:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4B61B200062
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 12:40:40 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B4FA522B2C;
 Thu, 20 Oct 2022 10:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666262439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kIjR9mcuJyxl1ex3CI3YHt0ZCQ8vYCZ0ZYyJoMgw4pw=;
 b=Byp0WMgVno73pT/wyJy5imJNaus444agkyaX3nfYpeshQlqFtTCRkGEoNVAs/xYBrfZ2GC
 SfCSjtORAjEczClk9OQeKT2mFR/rWNsiRfWWDnVRsmS5vgR3I+SfqdSdj/7ec6G5aqxzvb
 SUIRimgAktEPPJOgrl0BYVQo26RKxRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666262439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kIjR9mcuJyxl1ex3CI3YHt0ZCQ8vYCZ0ZYyJoMgw4pw=;
 b=1b5PwnCXYl7xbkgE2eoVNF6fZxGEQckAG4caGay5ZVIZti0OtJmFGU+9d4JGF+tzgHG54M
 +kQ6olPHJrzDRNBw==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 080B72C142;
 Thu, 20 Oct 2022 10:40:38 +0000 (UTC)
References: <20221009065520.3236525-1-liwang@redhat.com>
 <20221009065520.3236525-2-liwang@redhat.com> <875ygex5ob.fsf@suse.de>
 <CAEemH2fq9qrr3vag3TOHNh_DE9u7s8TfEbr+ZwEPkj6jy1wZ2w@mail.gmail.com>
 <CAEemH2e1wkUL_ntOE-7R0UpLDospNTFegEa1TJTC3Jem1v5ucw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 20 Oct 2022 11:31:21 +0100
In-reply-to: <CAEemH2e1wkUL_ntOE-7R0UpLDospNTFegEa1TJTC3Jem1v5ucw@mail.gmail.com>
Message-ID: <87czamvkv1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] setitimer03: convert to new API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Li Wang <liwang@redhat.com> writes:

> On Thu, Oct 20, 2022 at 5:30 PM Li Wang <liwang@redhat.com> wrote:
>
>  Richard Palethorpe <rpalethorpe@suse.de> wrote:
>   
>  > -static struct itimerval *value;
>  > +static struct itimerval *value, *ovalue;
>  > +
>  > +static struct tcase {
>  > +       int which;
>  > +       struct itimerval **val;
>  > +       struct itimerval **oval;
>  > +       int exp_errno;
>
>  There is a whitespace error here (see checkpatch/make check)
>
>  yes, thanks.
>
>   
>  
>  > +} tcases[] = {
>  > +       {ITIMER_REAL,    &value, &ovalue, EFAULT},
>  > +       {ITIMER_VIRTUAL, &value, &ovalue, EFAULT},
>  > +       {-ITIMER_PROF,   &value, &ovalue, EINVAL},
>  > +};
>
>  Why do we need value and ovalue in the struct?
>
>  Becuase it does not allow parsing an invalid pointer address
>  from a structure, we have to give a valid address which pointer
>  to save an invalid address. Otherwise segement fault will
>  be hit in execution.
>
> On the other side, it also does not allow to initializer element
> is not constant in structure. So the two-level pointer is only the
> way I can make all things comprised here.

I'm not sure what you mean and I don't understand why we need this
struct at all. The following works and produces better output:

@@ -20,17 +20,6 @@

 static struct itimerval *value, *ovalue;

-static struct tcase {
-       int which;
-       struct itimerval **val;
-       struct itimerval **oval;
-       int exp_errno;
-} tcases[] = {
-       {ITIMER_REAL,    &value, &ovalue, EFAULT},
-       {ITIMER_VIRTUAL, &value, &ovalue, EFAULT},
-       {-ITIMER_PROF,   &value, &ovalue, EINVAL},
-};
-
 static int sys_setitimer(int which, void *new_value, void *old_value)
 {
 	return tst_syscall(__NR_setitimer, which, new_value, old_value);
@@ -38,13 +27,17 @@ static int sys_setitimer(int which, void *new_value, void *old_value)

 static void verify_setitimer(unsigned int i)
 {
-        struct tcase *tc = &tcases[i];
-
-	if (tc->exp_errno == EFAULT)
-		*(tc->oval) = (struct itimerval *)-1;
-
-	TST_EXP_FAIL(sys_setitimer(tc->which, *(tc->val), *(tc->oval)),
-			tc->exp_errno);
+	switch (i) {
+	case 0:
+		TST_EXP_FAIL(sys_setitimer(ITIMER_REAL, value, (void *)-1), EFAULT);
+		break;
+	case 1:
+		TST_EXP_FAIL(sys_setitimer(ITIMER_VIRTUAL, value, (void *)-1), EFAULT);
+		break;
+	case 2:
+		TST_EXP_FAIL(sys_setitimer(-ITIMER_PROF, value, ovalue), EINVAL);
+		break;
+	}
 }

 static void setup(void)
@@ -56,7 +49,7 @@ static void setup(void)
 }

 static struct tst_test test = {
-        .tcnt = ARRAY_SIZE(tcases),
+        .tcnt = 3,
 	.test = verify_setitimer,
 	.setup = setup,
 	.bufs = (struct tst_buffers[]) {

This prints

setitimer02.c:32: TPASS: sys_setitimer(ITIMER_REAL, value, (void *)-1) : EFAULT (14)
setitimer02.c:35: TPASS: sys_setitimer(ITIMER_VIRTUAL, value, (void *)-1) : EFAULT (14)
setitimer02.c:38: TPASS: sys_setitimer(-ITIMER_PROF, value, ovalue) : EINVAL (22)

instead of

setitimer02.c:46: TPASS: sys_setitimer(tc->which, *(tc->val), *(tc->oval)) : EFAULT (14)
setitimer02.c:46: TPASS: sys_setitimer(tc->which, *(tc->val), *(tc->oval)) : EFAULT (14)
setitimer02.c:46: TPASS: sys_setitimer(tc->which, *(tc->val), *(tc->oval)) : EINVAL (22)

The same values are passed to the syscall according to strace.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
