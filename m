Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6156FCC6B1D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 10:02:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC6103E6A17
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 12:02:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9ABF93E2AF1
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 12:02:17 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0C23D1000A0F
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 12:02:17 +0200 (CEST)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-3a87e23860cso41844681fa.0
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 03:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791972136; cv=none;
 d=google.com; s=arc-20260327;
 b=fMyrRfyTpo72JNNbLbQFjvM0OStemniPLiJMTiC0Dsu7SiY3kTdjr+/OkaSDOPqHN2
 8VLtgtrfJ9duQRZpSiTFfTUxrPHqDBFvEX7qkq63mFQoPBgoevfaeDjo8RrBDdTpgH0V
 mal5HU0IkUzV4Gj3HzJP0EYpJnRIN0sRIFGylB8ey4JwWDvBeDtlHD96rvKreMsG0kCC
 HAR7p4hRE1D+rc5b5C18yZRV/vPOV5ZhsrKGLk+tOgKYdO2jOBgk7mHpqH0Pvxb/0DtE
 kd1Tld57HwLGs9Ez1K0z5flBChes/PC9faXnZDoHY/zRqMsyWqM3Px7kIDNwvolm29dK
 ihEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=32dg+3PBHbuDiItavtJPVI0QLQF9hz9nM+iHgJwBEgY=;
 fh=hEINy12EUhEgGn0f8upuE5bndgG6fGdT1SVr+fAXyO0=;
 b=l88Vj4r2dxwnYLtq2ZpvmzVkGOWmZRzfKfRop4++ZXpwMOQew/tTZn0dWLMKZo9PrO
 TCa4jhoOgYVX5to+tV2F1gu2P3Rj5uQiiIbncvqbOOTDaEbsY05NSNAUm+mydjHN+9R+
 AiJTC8FBNaQLYQiBCvCBgPV28AfdIzBfhxVKvGcdz4aCLmVGmxqgEznb+XmDfuiGPKlK
 VrwkomZD6Z4q8jqTQ2VnPevTm3wE20vBgV3w01w2ygqjaGplhpk09Y8VW3AccfmQn4GE
 FgqxJVpWkGCdBf6owoG+/yx+kWv1DYzbvwb2O+TXDqQ6OwmpK6yp2MjthBpXtHoIganx
 n9gQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791972136; x=1792576936; darn=lists.linux.it;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=32dg+3PBHbuDiItavtJPVI0QLQF9hz9nM+iHgJwBEgY=;
 b=GJYIGXHf20FE2dv/XbLD8K9BehbAd3qvNYThw6opHv/DTLhx9DCkTJ8TOQhgXWNtlI
 xG1cN2d/Wjj/9tSE59Of+j+blwlCOiaZAuS0hnO1HZVuqcmHjh8+p7f36VDCI9VEMlAe
 LI8rNlberl6+Bt+XVolba1/uU2NYjJOf3DlgPzVogJpx0SvEY9ugsdMhRklYUTfNLsyf
 MFFGsAHQltns2PZTngclix30YQFAPfxgWHO1x0x6rAzy2OkH2yehSTfqzqtZ+fRrQnZf
 Ln2bZDYUNBzlCuZ/5Tz+50Z3OVZq5R+WqpZ488KMhWjccmvpFQgW4J05MENQWFwHcVE1
 Wk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791972136; x=1792576936;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=32dg+3PBHbuDiItavtJPVI0QLQF9hz9nM+iHgJwBEgY=;
 b=K53KNk09KpABuNeU15v64qKH8TVhEr9vC1xNmNnhLMm7DlHOf6FZYrKJPj4zqI8JN3
 MRsNcM3NaSiRE9UodPXOO6NaAd7RmZm9Hx5Dv+25ZwWEfpZnYZKWB935E7kZRRFp7y3o
 +pYE9AiXIlm8TKt9DIxkniHh3KVP4oyEAhkeRBdq67RmowW0g4ebVIQ4Lm3aA/JjjaBZ
 2YTLzKHpYFUMTqdKhEg9AsMBuE8jiNotqEHy6+soByTXFRb2Iglvi6R+B0q9m3s2hgbj
 hf+cAoygWWCh6vDXfB3s1cExQs5l5nPtyLsA0yZsPUQPO0Lf/Cy0NPlahsmdRifJ5oAd
 zRtw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvUKXQ6DRSBAhLWwyAup08J0Rg79kfDcoZi75gjf5icMvQeYmokOyUaHIptnKVf5bpqy8=@lists.linux.it
X-Gm-Message-State: AFq9FYKhND/AUUPkJoo9Q58QGPPJGqXWAFX4iDbI9xNB3CTS7qKlop1Z
 WcxufdndRLpu6EMkWgtwOrQY+BGn8zgxJx/kHSA8oJvqeSIsBhsBPqaTV85RG4pncVAATPq5Kvi
 WB0x84jG1rJ/BPSpN9LHIn8MV3VV4zEU=
X-Gm-Gg: AYBFou1Ij0TQ6iWi+RWEzj3asMCaX060t5HjtLzlWaXC3z/yfkITbtkpD7rTSX9A1O4
 6Nyfa2GCd+CBsaOmJSzLNs2v1VEkcYHC5VyNqY70P2tsS6WYLJeM8MOp1/q8dZdZgyFQv0RUMBS
 YvgTM7CCmnheF9fXzRBkTbIF1HQtcwVFa44jJ9KF1iPiIRbYucsEfVGy/xIECc9FCvEJe98mfYd
 /6Cwce97BDF0X+zdqCYJsrbJ4vY9WBNEwTHTYFZ8ncdbHkoSFMSSjoNsr444XoJ9QCn2bG2/WPN
 OiAPqe9YY4XcQGz8kAmpFo6eE3OiWjrD1jRXvnpnZzcDOJTvnziYNraycqw+Rg==
X-Received: by 2002:a05:651c:b09:b0:3a9:d22d:a79b with SMTP id
 38308e7fff4ca-3a9d22da89dmr27520541fa.14.1791972134364; Wed, 14 Oct 2026
 03:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260531000822.4114-1-linuxtestproject.agent@gmail.com>
 <6a4382ea.abb839ae.10559d.dfe8@mx.google.com>
 <CAGsesORhG7VtJP8oGOdBDN8SgbYGb7EZrVUyr+3M8bSF--cfnQ@mail.gmail.com>
In-Reply-To: <CAGsesORhG7VtJP8oGOdBDN8SgbYGb7EZrVUyr+3M8bSF--cfnQ@mail.gmail.com>
From: Pradeep Susarla <pradeep.susarla@gmail.com>
Date: Wed, 14 Oct 2026 11:02:02 +0100
X-Gm-Features: AclHuK8ySitobADr9fc3LMim5FWoUr1Cl9AU00VaQsTz1LpRHlYACPYai-OUKtM
Message-ID: <CAGsesOS0RUqRxqWVnRvUUsBkj0puamEPQ1V2n-XmeFX1TayQBQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] hugetlb: Migrate library and numa helpers to libs/
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

I submitted my patch 10 days ago and wanted to follow up, as I haven't
received any feedback yet. Could you please take a look when you have a
moment?

Best regards,
Pradeep Susarla

On Tue, 30 Jun 2026 at 12:13, Pradeep Susarla <pradeep.susarla@gmail.com>
wrote:

> Sure. I have the patch ready with 2 separate commits. I'll submit them
> letter today.
>
> Pradeep Susarla
> Mobile: +447710542285 <07710%20542285>
> Email    : pradeep@pradeeps.org
> Twitter : @pradeepsusarla <http://twitter.com/pradeepsusarla>
>
> On Tue, 30 Jun 2026, 09:48 Andrea Cervesato, <andrea.cervesato@suse.com>
> wrote:
>
>> Hi Pradeep,
>>
>> can you please split the tse_hugetlb.h and tse_numa.h changes
>> into 2 separate commits? They are unrelated changes, but related
>> to a bigger picture that is the full patch-set.
>>
>> The overall idea LGTM.
>>
>> Regards,
>> --
>> Andrea Cervesato
>> SUSE QE Automation Engineer Linux
>> andrea.cervesato@suse.com
>>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
