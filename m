Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB24CFD624
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767790860; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dngXLaCXnXqpdNm8p1WQXPfr22rD94Y+nwRb9LpJY5c=;
 b=eOhS6ZADo465ZlwTbOJ1rBczgA5Kb6wChGQ5a8skgjJm0m7+hHieJ7bzXgTqCvX3DBkrw
 nVlog17Uy9XWVFXiNb9dR9IHLA0C2j00lBimRp/OhfkJqLZvuthqL5ZGAhyzpc3rocePWtp
 eF1YeJ2PgyJ85TBm0e7lDdg0I4jBSjM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FB753C30CF
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 14:01:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA3F63C2B90
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 14:00:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4D8432005C1
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 14:00:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767790832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JcnfM6kFt1x+ZjgIiMAbOxbclotpeZ4hpUqPTR9sbiY=;
 b=Dg/tSKIT6/0Kb6U+kYOrGnL/Qb3sgx7hl6ZX2EwecFN5HC/fweGoxf9Cmiq55VtZJ1dE00
 3szJUBOQbLn4BBnsCw4VGBFodutmOEt1HQ6/I/7zYh+rXJuRVHs8ANIRiQ55O94GtGDTJ3
 Ef+CNyp5GXsdydOXllG0EH4xa0uTGWM=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-AVvkaTavPSOgu9--Q5nxqw-1; Wed, 07 Jan 2026 08:00:31 -0500
X-MC-Unique: AVvkaTavPSOgu9--Q5nxqw-1
X-Mimecast-MFC-AGG-ID: AVvkaTavPSOgu9--Q5nxqw_1767790830
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b0751d8de7so1914812eec.1
 for <ltp@lists.linux.it>; Wed, 07 Jan 2026 05:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767790829; x=1768395629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcnfM6kFt1x+ZjgIiMAbOxbclotpeZ4hpUqPTR9sbiY=;
 b=U3RTbZzQWFCkYb0KsWnCMDEl+YtRELbQbmT5Jq8YqIE4nCSinZ0iBlu3lquvutmx1f
 4uklA3c5+M3KCxm2Uy0WspDzoK1yK1J0AsYZG5LRGJX90IdwZuocEL5y+5PWRALtwiOn
 bTpsVC+oEyZChsWiSDOsbMCj43WXlnbPKoMeC3BH0rh41CfkKDsQqCXxUO05ELY2d++T
 LkJlJaU8N/C/CovR7kIym+Q0HvqK+VQe6k5z1+5QZDHIGYbvHzLZWtmypC+MZ0bW6/vW
 22qudwNCYeT88CoTjOvAENd1f4QdY9lRjHURLiEWJnj9vR8tROpO8xaPJslKuCA1y5X/
 bpdg==
X-Gm-Message-State: AOJu0YyL9HEssl+iNlCYZ5R34lqVk6anfD7EDOIXhjI9qb4YC538H62K
 AowJ0ur/eykDzpgoN4pv238jlxdNQCkxshgrK8O063dqeVw5hwe0QmZgqA0Cgm6qqHC7DFZI6mk
 A4UyjnqvJXGOuK8v87E4BvcK0TaqS6ahNPFMH/ke370CsYl6XrMgF7TcIeF7XMajMI/b2DG/QkM
 QpHwBAljPFmc7smAJD6uPmdxGAYHEQSEMh/qXop07eYqw=
X-Gm-Gg: AY/fxX4DVuGPdfvk+6EYE4rjqZI6DpprXkd259qEp82uYt/SoEL9IrYjuWQ/CutBQV+
 OV3NJLDJyTY1jk5CvK7+xX0U4fUoAecLpvxhfkufUkCl3J12Oh3ngdy6VnaYpQpzaID1LcZVeDK
 3ulBsl/Ywyezf9tjJP3ABHAs7758VkCaCHKJ4fDUP2rd610eba1QaIGREd4rPpQ2PTgxo=
X-Received: by 2002:a05:7300:3f05:b0:2b0:56fd:4b67 with SMTP id
 5a478bee46e88-2b17d21b4dcmr1253678eec.12.1767790828805; 
 Wed, 07 Jan 2026 05:00:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXS2nMdi2Ii0l2qT6IXUmVzO7LVbEt5QVZN/qmUtM5bvvEWOxcegejb1OM94x+eA2et9jvZQg54XSTXuER7vU=
X-Received: by 2002:a05:7300:3f05:b0:2b0:56fd:4b67 with SMTP id
 5a478bee46e88-2b17d21b4dcmr1253657eec.12.1767790828162; Wed, 07 Jan 2026
 05:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20260107111133.27041-1-chrubis@suse.cz>
 <20260107111133.27041-3-chrubis@suse.cz>
In-Reply-To: <20260107111133.27041-3-chrubis@suse.cz>
Date: Wed, 7 Jan 2026 21:00:16 +0800
X-Gm-Features: AQt7F2qk6DzyD-7lTuqYAUtY4OAU-cmKHup3ACr-1qLEmdpt11C_6t6gX7ysFls
Message-ID: <CAEemH2cFexCWE8A=qC6P5i8yv3mA-0gUQTDULzFdYQenMK8c8A@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n_isgdoYmK8n9T2o1EVKsIGS1uyV-5QU3kNOjbSgRkA_1767790830
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] doc: Add ground rules page
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cyril Hrubis <chrubis@suse.cz> wrote:

> This is a continued effort to write down the unwritten rules we have in
> the project. Feel free to suggest more topics for the page.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Li Wang <liwang@redhat.com>


> +Split changed into well defined chunks
> +======================================
> +
> +When sending patches to the project make sure to split the work into small well
> +defined chunks. Patch that changes too many files and does too many different
> +things is not going to get reviewed soon or possibly may not get any reviews at
> +all. Ideally patch should do a single logical change. However at the same time
> +make sure not to break the code in the middle of patchset. Each patch in a
> +sequence has to compile and function properly after it has been applied.

How about splitting it into sub-items for better readability:

"When submitting patches, split your work into small, well-defined changes.
Patches that touch many files or mix unrelated refactors, behavior changes,
and new features are difficult to review and are likely to be delayed
or ignored.

Aim for one logical change per patch. If the work naturally spans
multiple steps,
send it as a patch series where each patch:

  - builds/compiles successfully,
  - keeps tests and tooling functional,
  - does not introduce intermediate breakage,
  - has a clear commit message to explain the change,
  - Significant changes need to be detailed in the cover letter."


> +Kernel features and RCs
> +=======================
> +
> +LTP tests or fixes for kernel changes that have not yet been released may be
> +posted to the LTP list for a review but they will not be be accepted until
> +respective kernel changes are released. Review of such changes is also
> +considered to be lower priority than rest of the changes. This is because
> +kernel changes especially in the early RC phase are volatile and could be
> +changed or reverted.

I'd add one more requirement for this rule:

"Such patches should explicitly include keywords in the theme to indicate that
the feature is in the staging phase.
Examples:
    Subject: [PATCH v1][STAGING] fanotify: add test for <feature>
(requires v6.19-rc3)"

> +In a case that a test for unrelased kernel is really needed to be merged we do
> +not add it to the list of test executed by default and keep it in
> +:master:`runtest/staging` file until the kernel code is finalized.



--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
