Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1A9CD8C85
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 19:56:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1BC13E5FC7
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 21:56:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A0783C888C
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 21:56:31 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 75AB41A006AB
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 21:56:30 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490be03d47bso24754425e9.0
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 12:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780775790; cv=none;
 d=google.com; s=arc-20240605;
 b=B63eHG9fpyV12D7dYkq/q1BkzZiJ+jJrSk1LXuGjG4j5R4MKT9164UbL6YCPWAIafg
 xQzWgJZcsdoLB4eU5WNO/O5wNM0930FVPjrIMX2gE/a+zye8Pu+lhbqPPBbKwamZKUBh
 OiSfZBuwzKonT6FnEQWTLA9ykHuBZD1ALCOpij4ljbBm9eeehSauNh0d0T6EF/882Qys
 teMUl8eRuBqYxVWASHrkptirnauxMsF9ZosnCd97LSzsw2VcvCbJ3N6U97tPqEEaNJ7g
 ZTVXf4fQ4VUQn0wW6xAsTCNzi6Y9tVM9m2Rb7IXvsL5jewkkcOeVJLUUN1QUGj/wDvsE
 siOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LQNfm5sLQqJ3JjRMRn7FV2f+bEg1KyySrHSIgtzxwls=;
 fh=b0eNH9RvD8XXI5/t++skn8rGfPbQGMoqY/Y0j0bpd7E=;
 b=KBL7TCXzih8bg0TmAbsV9O28MGPstAfqqk1v6BX2XetEmgUkjekI5T2ruc/tol1spg
 +IEpSoASV7o0AWs0jrpMnEgBQ/U+VKTRejCJqecA0dwnqbd6s111AkU9wrgeXjPcLCjp
 y43pn1txjqUKu2a2mRfqTmg3t77Wp1nibUV8z6KzApjz4SXuw5olpdhltwPYZKrR8njW
 pd2ioNEphRPxgNLBGoxLjMI8+SUEfzcXZhjactos+qGVaZwvkDFcvhPDioMqe046Oqo7
 s2yno7AHttgC6WzE2PaC0Il4aLlw1sopIwELg53g4qgACHAsMd8oRr9uJx6V9fWbITIG
 eSzQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780775790; x=1781380590; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LQNfm5sLQqJ3JjRMRn7FV2f+bEg1KyySrHSIgtzxwls=;
 b=a0nMKPNIF9/0rMx0+qz5788U0+19VlkB4pS5OAoVmtC6fE6SMovfTaR+6FS1H4l+Zs
 x94CSn+xCnv5EAZCLxtc9Sts5pWWWfJzwyTKCVdCjRPi8nyRw9yR/JYLR3gNehDLPa9K
 MxSgH+W912lz527/abnCtfqRs4voiC5o44MZeAGxG1C123SusUDzpDy03nfQKPcdSg6i
 eA8vTnTo+NN56Z6ZD8yivuT/GipVCIP5E/AKw5hsBht6YBBt+ckOUirwO1j4pro+/uS7
 OYb6YrD9mvFYz/oLZMV+JQOzKzGHO15xuo7eAf7xLcnMnzHCIoVsyvFEwkX/p3ouFar+
 Bg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780775790; x=1781380590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQNfm5sLQqJ3JjRMRn7FV2f+bEg1KyySrHSIgtzxwls=;
 b=JGwC0HE88IbF6r0267tVycImq1Hppnuy1MkYVhwwK50kQcdMp+J953VOFBMxAdF65s
 U2ydyvhNOUaWNdmhcds+g1mtFuCS2IH3U9m/HSjzeoGTcA/+EeuAPE26bjHVbndsJUQA
 GqmymJ0Gyo7mXGvFSvT+7LFJ9hpHrK14q6YrHltN/zbi/574gos6HDtdWoaAiO2NTKYB
 I54fnCSqyEP3T22g0sXA4k4rxwibYZFoAgSgt51DM/RUmPOB6ome94sGZA65Iu7RCFqq
 msEPOvi8aXNIoPEKgOqpFUJa4zcfAD5vEZD4Gfi/8tb/kksN9F/256lkiXQd9DHxwMDO
 Ay4g==
X-Gm-Message-State: AOJu0YwkdvvAonggRfTU91Cl2ayjQSowk7IMTjOf65CILxoh9KQcupzQ
 jDWPQtnJNGS9oJwAP/YT0zVlSJZGVnNwOfjq6LLCAeT6idcClKAw7MtHsOsPPDQwd06nbnA6biD
 eQJVoZrjsl7j6Tp78QX6DSSgTiaXKQ08=
X-Gm-Gg: Acq92OH+4ntUPikCsN+sSbQljCHGfAQ0yGUjSQstl0QQhNJMva18QpY8biUe00yWWem
 wAvV2FoKmr5VHhLBPKiqm/DH4x4TqQCId3kg9ae7lt82jCok+fPhtW8m51bvOW5TLBoUcTaEJ/G
 9hNRNrfS5M+Pdnic8s1tgt0aIIv+1LGfGHsRY+fsk/voyTi8NhNpkxam/ehrQJT7LFihX+2xBX+
 mHciHxpCb0fN4vbOOqew8XHjL6lksCW2fhPYA9BTjWOmN4MydhuL8ynsMI/KMj15O8FBQI7E8mk
 3uCArQ0OxDlaWs0BAPbK/3zgy48SprypP7tJHS85yUCvkDrwXQdHUkXZf90Jig==
X-Received: by 2002:a05:600c:314e:b0:490:a29b:e72f with SMTP id
 5b1f17b1804b1-490c25898d8mr152636585e9.4.1780775789642; Sat, 06 Jun 2026
 12:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260507073417.64123-1-sachinp@linux.ibm.com>
 <51507e20-d908-4213-967e-df74bacd87fa@linux.ibm.com>
In-Reply-To: <51507e20-d908-4213-967e-df74bacd87fa@linux.ibm.com>
From: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Sat, 6 Jun 2026 21:56:17 +0200
X-Gm-Features: AVVi8Ce3wAMIlywY_NBcECqsFkFF3PxfsQXXKMexVd0_sBO8LnTKyli4WytmDKQ
Message-ID: <CAJCsO8fQOQfa08bN92zkbqhU_B0B0Ojx2xRm0+TA6jP6WSkZ5g@mail.gmail.com>
To: Sachin Sant <sachinp@linux.ibm.com>,
 Sebastian Chlad <sebastian.chlad@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v7 1/4] io_uring: Add io_uring04 test for vectored
 I/O operations
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

Hi Sachin

On Tue, 19 May 2026 at 10:45, Sachin Sant <sachinp@linux.ibm.com> wrote:

> A gentle reminder.
>
> Let me know if there are any additional review comments
> on this patch series.
>

I see some fundamental problems here which admittedly started before this
series. I believe these need to be fixed before we apply more tests on top
of it.

In io_uring_submit_sqe() and io_uring_submit_sqe_vec(), opcode is passed as
user_data:
io_uring_submit_sqe_internal(s, fd, opcode, (unsigned long)buf,
                             len, offset, opcode);

user_data is supposed to be a unique per-request identifier for correlating
CQEs back to their SQEs. Using opcode there is meaningless as a tag.

The existing tests happen to pass because io_uring_do_io_op() and
io_uring_do_vec_io_op() always submit exactly one SQE and immediately
block waiting for its CQE, so correlation is never actually needed.
However, any test with multiple in-flight SQEs of the same opcode would
pass;
the user_data check in io_uring_wait-cqe() would match regardless of which
CQE corresponds to which request.

Please hold off on applying this series until the underlying issue is
fixed. I will send a patch to correct the user_data handling.

I also think io_uring_do_io_op() and io_uring_do_vec_io_op() should not
tightly couple SQE submission with waiting for a CQE.
Keeping them as a single helper makes the tests effectively synchronous and
does not model real io_uring usage.
It would be cleaner to have separate helpers for submitting SQEs and
waiting/reaping CQEs, and let each test handle CQE validation and
result reporting in its own body.
Having basic smoke tests, sending single SQE and checking CQE makes sense
in LTP, but I doubt we shall have this as a helper.


> --
> Thanks
> - Sachin
>
>
>
Thanks and let me know if I misunderstand something here. It's the first
time I look at this code really.
Sebastian


> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
