Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06D5C433F5
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 04:31:43 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3BB61263
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 04:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D3BB61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA6F23C7558
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 05:31:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F5E23C7304
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 05:31:32 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C8C19601CAB
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 05:31:31 +0100 (CET)
Received: by mail-il1-x12c.google.com with SMTP id s14so8361505ilv.10
 for <ltp@lists.linux.it>; Thu, 04 Nov 2021 21:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=28cq1v9lzBEu3BywNkQK3jwk8MKdYZpvqsNwrIFNH/E=;
 b=edIojb+O7WmgSvmRf1/Tc6Tdu1V+07FYYh6YDYAtvmRFK5gJqkX+HEEhjypIpEpdbz
 3Lg6/oawkOg5zu6y1DwZZ+LfIVFPy0osuz8yx3MsETc/5w1ZU8Ij4BY6PfrvIYMeZ027
 gXQ2aswqqNlrvy4mRrej6dvI4DtQbjH9rB0NQDDqYwtpa5nwSts+IsgyPTY3YZdQ2L9X
 tYmCXfWYSALgrtVnx6HX31lpRHdCkCm9ceGmFWHrLbNXaOOS4w/ilqiEpXOmNV4cLcVV
 H3HCTcuFG1k4CduyaT00O2PabFwjfjFvhGp5j1UQTV77HL/aL98rCvejMxrsIO4HVle4
 V5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=28cq1v9lzBEu3BywNkQK3jwk8MKdYZpvqsNwrIFNH/E=;
 b=s3iigtswRxEC19PYphMf6yPMoOCmZkaPR1ZEiyJWb5foy+ixYvNhnO9VRrwNkuzvbC
 uN1wZApNkQjrQxkeawQPz+Daqt7eQspQ7E5WCWxqnDTZHcI83kIWulSP1/GHQy5HcNMt
 xd9WIPQTcky2tjj4ZCcbyunah2iCyyQrXyx4aUvGJ/jbGCiQoGsIK28LNrXmLfHJ99Wf
 pWrsAepGmUZANyJRBtnqSxSoPfVbklttOMRnbQlg2jhfH19yMHHN/0oXVynskGET9DMI
 birjq3mv/5LAwAq+uSO8B+qqIwIOAYdH5DkTShfdsc+SCcEA2L4IfgsI+PpmoW5k2zbU
 +/Bg==
X-Gm-Message-State: AOAM531dBIGHgDmDhMtMDqciDaMoUuQJw90GkkEhTTuXXL1ZVlQRA9LT
 yNaXxZ2gDF4/KtfIo34WWRTDpizV2qaK6+82rt4=
X-Google-Smtp-Source: ABdhPJwclrPXCs5K2CPBvI2vZl3keL9WFdLjuTwLFqW4Wq2Ho5/lMYteLm4SCXhXgkNqha2BP/nGMPzDfjuBtvtJIVY=
X-Received: by 2002:a05:6e02:1ba6:: with SMTP id
 n6mr8260448ili.254.1636086690351; 
 Thu, 04 Nov 2021 21:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <7c11918db7c34d3aa0af98cb42b7970e@huawei.com>
 <YYSenZxvAG0Xgm71@google.com>
In-Reply-To: <YYSenZxvAG0Xgm71@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Nov 2021 06:31:19 +0200
Message-ID: <CAOQ4uxgN2Wx6aAcWYqSO_LNir5hTpAYhPEXHQPqhkQcpeHCPkQ@mail.gmail.com>
To: Matthew Bobrowski <repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify: Kill the child process before
 exit
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

On Fri, Nov 5, 2021 at 5:01 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Fri, Nov 05, 2021 at 02:22:51AM +0000, zhaogongyi wrote:
> > Hi,
> >
> > >
> > > On Thu, Nov 04, 2021 at 07:37:35PM +0100, Petr Vorel wrote:
> > > > Hi all,
> > > >
> > > > > Before the main process exit abnormally, we need to kill the child
> > > > > process.
> > > >
> > > > Amir, Matthew, could you please have a look?
> > >
> > > If anything, I feel as though stop_children() should probably be called from
> > > cleanup() as that callback will be invoked if any of the
> > > SAFE_FANOTIFY_* macros fail anyway, right?
> >
> > It seems that calling before run_children, we need not cleanup though the SAFE_FANOTIFY_* macros fail.
>
> Even if stop_children() is called prior to run_children(), maybe it would
> be OK given the fact that child_pid[] is a global and pre-intialized with
> zeros. Meaning, that if SAFE_KILL() was called passing a PID value of 0,
> then all processes part of the calling process' process group would be sent
> a SIGKILL signal, which is kind of what we want anyway when taking a
> teardown path. This is just a quick thought.
>

This hack is not necessary.

> Nonetheless, you could also introduce barriers into stop_children()
> i.e. checking whether PID values in child_pid[] are all zero and if so
> return early. That'd prevent you from taking any unnecessary cleanup path
> in the event that something fails before any child processes are spawned?
>

This would be the obvious solution.
But simpler to skip zero values then stop the iterator.
This makes the cleanup helper reenetrant:

static int stop_children(void)
{
        int child_ret;
        int i, ret = 0;

        for (i = 0; i < MAX_CHILDREN; i++) {
                if (!child_pid[i]) continue;
                SAFE_KILL(child_pid[i], SIGKILL);
        }
        for (i = 0; i < MAX_CHILDREN; i++) {
                if (!child_pid[i]) continue;
                SAFE_WAITPID(child_pid[i], &child_ret, 0);
                if (!WIFSIGNALED(child_ret))
                        ret = 1;
                child_pid[i] = 0;
       }

        return ret;
}

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
