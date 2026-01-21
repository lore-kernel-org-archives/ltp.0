Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750F6D262B2
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 07:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768980539; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cPB0vaVAeXLzeaeNuIZb9Ltcz278D3bfN2z/J9PRv5o=;
 b=fRg0uvSi2IOk8z2P3frZLRvlZXOsoYc2Zjnl7JGMfDaIeLlv8XrElrPU0exmWm59r8sam
 /urTeCCsy61Ngx7y326Nbcu0ERpPudrbba6YL4t17UjYg8UPU2bxSYB6DNkPRylnrfmgwDm
 oERDSPxOWeWd0rqADiJGgvZxZfsezeg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD3673CB25F
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 08:28:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ED7A3C0FE4
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 08:28:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3EF8360065A
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 08:28:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768980512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BN1HwmY0UyrKuepg1OSkzGd5zXU4KMTr+3QwStWjlWU=;
 b=M+m4zet4cOnr+o9C6xoRBD6O2ri0Gzk0ocvvFuUgeCcUXoeK4/l0MENuF1IwIlQDyjFuF+
 BS2oJ6C+6VN4yPgescGY392oKH4HbzjM8axEDliWXzA9X2dYmGzQPA3TDuLhSwACFPBSXY
 TE3KEvZMS5XLlVZ/D7H1YVZODOE1aqs=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-nXg5-XTaOZuy-mCiiKUNSg-1; Wed, 21 Jan 2026 02:28:30 -0500
X-MC-Unique: nXg5-XTaOZuy-mCiiKUNSg-1
X-Mimecast-MFC-AGG-ID: nXg5-XTaOZuy-mCiiKUNSg_1768980510
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b7155ca88cso161778eec.1
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 23:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768980508; x=1769585308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BN1HwmY0UyrKuepg1OSkzGd5zXU4KMTr+3QwStWjlWU=;
 b=xSpj4zYW79nNU/ogRS6OogimtQ0vZZA08wZ6qIA534nOcSdBKG3ywDX3iKRnTzYERd
 JAbAGYrzmIVNOBf136aDQ6dLPeoYNpajBwVGt5G9VZb9WMfE213KVhlSTpLSKdGHKQKS
 AcC+nWdytDlLTib11HZt2INLD+XeSKL3Ak+I5nFnDqu4SX02ec/SwkXt55wkSSy8jlqf
 //7SMuPC0mUor3hOC0UVSkvAIL+dOprOaAER6bTQihbEsqnsL051Oddaz/dXq4gHizyV
 MTGlMUuFc4vZZZJG8uj6xPONecLmalhIkgfFmpryw3VQxc4q0ZMohiuzf+Av6ZSUC2mj
 LulA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+MTfLVeRJKV3Lrx/6LTEAOQUR1JVhVQOUkSMBxydL2zrYxuiJaISK7hBVOdbQS+9UFRo=@lists.linux.it
X-Gm-Message-State: AOJu0YzbG/ZWoE4+tqEAbzLSBWwzhGUrp/4ByFc8UqF+ypujE/2V0p6L
 CH4DQn+4PvUZPl1h+JkyME6JGygWe2/UGk1vqR+1gTgJliqQvC38PALjaxpSFltPOgakuQqG9fc
 WghqHULwd3RqZW1/VwPUD1p9ZPK5smx+oKaUWMjDnA0EXV8/Ry2XQinaxWimvLPiDFGB6p1WtoC
 q0NrYW+HMX0Fv2AqBNRYeWg/16O1BJulNEec436A==
X-Gm-Gg: AZuq6aKoLEEYX5ACzKy28sE7X8fto2v+zhtpdM16HZtDJUZDRrJo8W8nnHwG6T98pB/
 eX6pDq6rusZf2OCYu+lsUmbZ909EgbfDpznB3fIEq/C8kKIuHtSv5YR49FvMxA38ksyNHLYlySE
 iI/7KlLHWFMsdPXcKwWuTGQoU32fmTU1l3pA45uyvrVOOP3llxaz0WmlVM+9ZdbsvU0ow=
X-Received: by 2002:a05:7300:6422:b0:2ae:55f2:ad57 with SMTP id
 5a478bee46e88-2b6fd7acdb6mr2786529eec.29.1768980507745; 
 Tue, 20 Jan 2026 23:28:27 -0800 (PST)
X-Received: by 2002:a05:7300:6422:b0:2ae:55f2:ad57 with SMTP id
 5a478bee46e88-2b6fd7acdb6mr2786520eec.29.1768980507235; Tue, 20 Jan 2026
 23:28:27 -0800 (PST)
MIME-Version: 1.0
References: <aWmqFAzdtsR0t5aJ@autotest-wegao.qe.prg2.suse.org>
 <20260116070708.GA556902@pevik>
 <CAEemH2foRNfQZt2mFRdR364=xB8db_qjd36pM_ce+EKpJOAhkg@mail.gmail.com>
 <aXBSqvZ8OVP39wd9@autotest-wegao.qe.prg2.suse.org>
In-Reply-To: <aXBSqvZ8OVP39wd9@autotest-wegao.qe.prg2.suse.org>
Date: Wed, 21 Jan 2026 15:28:15 +0800
X-Gm-Features: AZwV_QhqM6rPnAOIYoVuxB-s2FQobEgCkknFON0kXnEieeAwryI7hj2glJPRuEM
Message-ID: <CAEemH2f=YMZOmHJAzDUSxekzZ1Um9tJzFQ_d3crMZ51L5aKJ2g@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d8pXYSlmyM5-XwVElGrTg8uCmvA1WbNWCgv21fd8Isw_1768980510
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clone10.c failed on 32bit compilation
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

Wei Gao <wegao@suse.com> wrote:

> > > diff --git include/lapi/tls.h include/lapi/tls.h
> > > index a067872e0f..eee77899e8 100644
> > > --- include/lapi/tls.h
> > > +++ include/lapi/tls.h
> > > @@ -64,7 +64,7 @@ static inline void init_tls(void)
> > >         tls_ptr = allocate_tls_area();
> > >         tls_desc = SAFE_MALLOC(sizeof(*tls_desc));
> > >         memset(tls_desc, 0, sizeof(*tls_desc));
> > > -       tls_desc->entry_number = -1;
> > > +       tls_desc->entry_number = 13;
> > >         tls_desc->base_addr = (unsigned long)tls_ptr;
> > >         tls_desc->limit = TLS_SIZE;
> > >         tls_desc->seg_32bit = 1;
> > > @@ -72,7 +72,7 @@ static inline void init_tls(void)
> > >         tls_desc->read_exec_only = 0;
> > >         tls_desc->limit_in_pages = 0;
> > >         tls_desc->seg_not_present = 0;
> > > -       tls_desc->useable = 1;
> > > +       tls_ptr = tls_desc;

> > @Wei, @Petr, did you get it to work after trying the above diff?
> > Which kernel did you use?

> 6.19.0-rc5-gb71e635feefc , above diff can not work, just some try.

> > Unfortunately, neither of these methods (including Wei's method) works
> > properly on my kernel-6.19.0-rc2 platform.
> >
> > And no matter what method I try, the child process still cannot switch
> > to the new TLS. More details see I posted in the pre-thread.

> Yes, i guess we are still blocking on i386 scenario. But we can rewrite
> parent TLS's base_addr instead of switch new TLS, this way is correct
> base current kernel's logic but still need further implementation.

Hmm, but it deviates from the topic of our test.

To rewrite the tls_desc->base_addr and manually switch the %gs selector
to validate TLS state, that is not necessary IMHO.



--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
