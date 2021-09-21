Return-Path: <SRS0=nxZL=OL=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B29AC433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 15:44:17 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FBB60E08
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 15:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33FBB60E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0814D3CA2AC
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 17:44:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83BE13C821A
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 17:44:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 982321400204
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 17:44:03 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A198220174;
 Tue, 21 Sep 2021 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632239042;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g8TCxuVhcJ0aOSOQszQs+SEKF8ruKKtOdrYv4ag1Tu8=;
 b=Ogah1pgvl8xk9ZPw7BQKtCsghSnYRj7fAWKgMNEBUbfn3klyk3xf36fVD0tlLKc+ep8H/r
 Q6SxRHExcdk9dZdXbzuUeP9hhJDye2lHovxdp0OlVUG6l3xnjJ8kLQffzpw1RxWV+wOKen
 rHvcVifx3pU6V5CcKm3hZeX4+KG0h60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632239042;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g8TCxuVhcJ0aOSOQszQs+SEKF8ruKKtOdrYv4ag1Tu8=;
 b=lM6PcshEOVQ3rTh1uzm0KxL1ZnkG+SChIzwxT9vGN1dzMX6Mb+bBPADb3rVgmVp0pKHov2
 aNneKdfQrP1P1MCQ==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C6D53A3B88;
 Tue, 21 Sep 2021 15:44:01 +0000 (UTC)
References: <20210921130127.24131-1-rpalethorpe@suse.com>
 <CAK8P3a29ycNqOC_pD-UUtK37jK=Rz=nik=022Q1XtXr6-o6tuA@mail.gmail.com>
 <87o88mkor1.fsf@suse.de>
User-agent: mu4e 1.4.15; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
In-reply-to: <87o88mkor1.fsf@suse.de>
Date: Tue, 21 Sep 2021 16:44:01 +0100
Message-ID: <87lf3qkk72.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio: Wire up compat_sys_io_pgetevents_time64 for
 x86
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
Cc: linux-aio <linux-aio@kvack.org>, y2038
 Mailman List <y2038@lists.linaro.org>, Linux API <linux-api@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Deepa Dinamani <deepa.kernel@gmail.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello Arnd,
>
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> On Tue, Sep 21, 2021 at 3:01 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>>>
>>> The LTP test io_pgetevents02 fails in 32bit compat mode because an
>>> nr_max of -1 appears to be treated as a large positive integer. This
>>> causes pgetevents_time64 to return an event. The test expects the call
>>> to fail and errno to be set to EINVAL.
>>>
>>> Using the compat syscall fixes the issue.
>>>
>>> Fixes: 7a35397f8c06 ("io_pgetevents: use __kernel_timespec")
>>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>>
>> Thanks a lot for finding this, indeed there is definitely a mistake that
>> this function is defined and not used, but I don't yet see how it would
>> get to the specific failure you report.
>>
>> Between the two implementations, I can see a difference in the
>> handling of the signal mask, but that should only affect architectures
>> with incompatible compat_sigset_t, i.e. big-endian or
>> _COMPAT_NSIG_WORDS!=_NSIG_WORDS, and the latter is
>> never true for currently supported architectures. On x86, there is
>> no difference in the sigset at all.
>>
>> The negative 'nr' and 'min_nr' arguments that you list as causing
>> the problem /should/ be converted by the magic
>> SYSCALL_DEFINE6() definition. If this is currently broken, I would
>> expect other syscalls to be affected as well.
>
> That is what I thought, but I couldn't think of another explanation for
> it.
>
>>
>> Have you tried reproducing this on non-x86 architectures? If I
>> misremembered how the compat conversion in SYSCALL_DEFINE6()
>> works, then all architectures that support CONFIG_COMPAT have
>> to be fixed.
>>
>>          Arnd
>
> No, but I suppose I can try it on ARM or PowerPC. I suppose printing the
> arguments would be a good idea too.

It appears it really is failing to sign extend the s32 to s64. I added
the following printks

modified   fs/aio.c
@@ -2054,6 +2054,7 @@ static long do_io_getevents(aio_context_t ctx_id,
 	long ret = -EINVAL;
 
 	if (likely(ioctx)) {
+		printk("comparing %ld <= %ld\n", min_nr, nr);
 		if (likely(min_nr <= nr && min_nr >= 0))
 			ret = read_events(ioctx, min_nr, nr, events, until);
 		percpu_ref_put(&ioctx->users);
@@ -2114,6 +2115,8 @@ SYSCALL_DEFINE6(io_pgetevents,
 	bool interrupted;
 	int ret;
 
+	printk("io_pgetevents(%lx, %ld, %ld, ...)\n", ctx_id, min_nr, nr);
+
 	if (timeout && unlikely(get_timespec64(&ts, timeout)))
 		return -EFAULT;

Then the output is:

[   11.252268] io_pgetevents(f7f19000, 4294967295, 1, ...)
[   11.252401] comparing 4294967295 <= 1
io_pgetevents02.c:114: TPASS: invalid min_nr: io_pgetevents() failed as expected: EINVAL (22)
[   11.252610] io_pgetevents(f7f19000, 1, 4294967295, ...)
[   11.252748] comparing 1 <= 4294967295
io_pgetevents02.c:103: TFAIL: invalid max_nr: io_pgetevents() passed unexpectedly

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
