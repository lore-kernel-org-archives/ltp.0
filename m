Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEF0C54FDF
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 10:10:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0A953E7253
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 12:10:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC3B83E16FC
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 12:09:56 +0200 (CEST)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com
 [95.215.58.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7F4A46002DD
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 12:09:56 +0200 (CEST)
Date: Thu, 30 Jul 2026 18:09:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785406195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=05bIdyBE07yI1qOgqEBS1brppFhq0NgbOwl9soMW7Fs=;
 b=ZmUKlFzs3n4bOB6Mc2Ia0qs1KVDWgel1t7dUtHFx98HZUOOEu1OTjPylCTpF4ss00mGiRH
 Bvix1KI9HT3Mt45IZmGkwS1IG0WLN+9hZuBCbSM1b7QidRmTSQEny4/ZBEfS1Jebz5mDaW
 FAJWNtaG8/B7lCvVwKDl60YgOfRA93g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>, andrea.cervesato@suse.com
Message-ID: <amsi77l_1J8Bdbfz@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, andrea.cervesato@suse.com,
 Li Wang <liwang@hygon.cn>, ltp@lists.linux.it
References: <20260730074120.180101-1-li.wang@linux.dev>
 <20260730074120.180101-2-li.wang@linux.dev>
 <20260730095122.GA80062@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260730095122.GA80062@pevik>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mailmap: enable liwang@hygon.cn address
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
Cc: ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel wrote:

> Hi Li,
> 
> > Signed-off-by: Li Wang <liwang@hygon.cn>
> > ---
> >  .mailmap | 1 +
> >  1 file changed, 1 insertion(+)
> 
> > diff --git a/.mailmap b/.mailmap
> > index d1e4419f0..35f54a937 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -1,3 +1,4 @@
> > +Li Wang <li.wang@linux.dev> <liwang@hygon.cn>
> 
> Acked-by: Petr Vorel <pvorel@suse.cz>
> 
> Congratulation to a new job :).

Thank you Petr, Andrea.

Yes, I have started a new job and will still be working on
Linux quality related area, with a continued focus on LTP :).

Just sent out v2 but forgot to include both of your Acked-by tags;
I will add them when merging.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
