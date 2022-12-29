Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0F5C4332F
	for <ltp@archiver.kernel.org>; Thu, 29 Dec 2022 03:04:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 191AB3CB85D
	for <ltp@archiver.kernel.org>; Thu, 29 Dec 2022 04:04:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 662FC3CB7DD
 for <ltp@lists.linux.it>; Thu, 29 Dec 2022 04:04:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 30122200904
 for <ltp@lists.linux.it>; Thu, 29 Dec 2022 04:04:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672283068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UZ4MSq6wfNIgKL5atpz1a881gK7SRa659nwLu/X6+sU=;
 b=SG/eXTnMCm/qMPYP4931GsfKHURAIUVWGsu3A/FV6v9JCGH54riv9ohbbor3gyuaiJKCdn
 eQcgJvwIquYESs8q72ygioV9kRAgs4Kqjy1RztLr0x9nolhJH8GEfo8gj78vBF2jVfbj0y
 870qQ3yvDTWiY9aJoesVruM41CubCVI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-232-zu4fO9gXMLygybzjyAQ3mg-1; Wed, 28 Dec 2022 22:04:25 -0500
X-MC-Unique: zu4fO9gXMLygybzjyAQ3mg-1
Received: by mail-wm1-f70.google.com with SMTP id
 bg10-20020a05600c3c8a00b003d9717d882eso8441375wmb.2
 for <ltp@lists.linux.it>; Wed, 28 Dec 2022 19:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UZ4MSq6wfNIgKL5atpz1a881gK7SRa659nwLu/X6+sU=;
 b=jw/h98uSLXLX7gOpAu1ERNXUGMpMF3AYBJCxtuVF5rvIjhii8bxFUQCsENf/PJcQ4X
 YiTldVjpUs4eeQlNIhZBhxamYldTgL/PodRDWB+X3JhjRvDqOmIcNH3ulROm3Gpvfu5Z
 WPrzZP1HVxQK3N5ck9HAe9vWaPP90VT5NpvW3lbNd9IxmrENW3BDFUvGp+s7VAV4F/q+
 SNJcEGAvLwMbCz105bJ0QIU5G7VEVXnF8QxJYu8kL2D/p/tZdkzFY1J/1J4RaQN/QOvz
 o3mlrNHPSEMjbCv28u22FQHrlSlY7WXT027VkW2f1u+A30qr/9N6Sp4o7D5sZFrTLRpH
 X6iQ==
X-Gm-Message-State: AFqh2kq3KOF9dtxVmIPjoBUUKssVinOBsgmblLyElG2ZR2K09YCez0/F
 /fHF6OyokRk4qc4pLj1PsPofheo8bfFvhBpNK5jeTm8B1pOJ3VHYvSpF94OK3WpcpP1xpTv1UxA
 t/LJrTNTLUp/V/B5f6mE9OySNOHQ=
X-Received: by 2002:a5d:444d:0:b0:242:3a48:1757 with SMTP id
 x13-20020a5d444d000000b002423a481757mr1075932wrr.528.1672283064178; 
 Wed, 28 Dec 2022 19:04:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvFEJVckaQScOy1Nn5X02A3ScTKRf8P+0B2gsUCYY1xCKc/h7FLEbsaNoBNxtRURrL3AFwhDaSb/YMINvc1SfE=
X-Received: by 2002:a5d:444d:0:b0:242:3a48:1757 with SMTP id
 x13-20020a5d444d000000b002423a481757mr1075930wrr.528.1672283063954; Wed, 28
 Dec 2022 19:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20221220054549.1757270-1-liwang@redhat.com>
 <Y6HD05Aa9WmWyUhl@yuki>
 <CAEemH2eCfzyTggCu9F0BEanen2aN=zzaB9f3WwMZB+3JDJMypw@mail.gmail.com>
 <87pmc3st8g.fsf@suse.de>
In-Reply-To: <87pmc3st8g.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 29 Dec 2022 11:04:12 +0800
Message-ID: <CAEemH2ceBni8N00EhZfqwZk_4mZch7ONMcL1oMKuVH-QtNmU_Q@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] set_mempolicy01: cancel the limit of maximum
 runtime
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

On Wed, Dec 28, 2022 at 6:44 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello,
>
> Li Wang <liwang@redhat.com> writes:
>
> > On Tue, Dec 20, 2022 at 10:15 PM Cyril Hrubis <chrubis@suse.cz> wrote:
> >
> >> Hi!
> >> > It needs more time for running on multiple numa nodes system.
> >> > Here propose to cancel the limit of max_runtime.
> >> >
> >> >   ========= test log on 16 nodes system =========
> >> >   ...
> >> >   set_mempolicy01.c:80: TPASS: child: Node 15 allocated 16
> >> >   tst_numa.c:25: TINFO: Node 0 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 1 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 2 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 3 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 4 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 5 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 6 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 7 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 8 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 9 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 10 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 11 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 12 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 13 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 14 allocated 0 pages
> >> >   tst_numa.c:25: TINFO: Node 15 allocated 16 pages
> >> >   set_mempolicy01.c:80: TPASS: parent: Node 15 allocated 16
> >> >
> >> >   Summary:
> >> >   passed   393210
> >> >   failed   0
> >> >   broken   0
> >> >   skipped  0
> >> >   warnings 0
> >> >
> >> >   real        6m15.147s
> >> >   user        0m33.641s
> >> >   sys 0m44.553s
> >>
> >> Can't we just set the default to 30 minutes or something large enough?
> >>
> >
> > Yes, I thought about a fixed larger value before, but seems the test
> > time go increased extremely faster when the test matrix doubled.
> >
> > I don't have a system with more than 32 nodes to check if 30mins
> > enough, so I guess probably canceling the limitation like what we
> > did for oom tests would make sense, that timeout value depends
> > on real system configurations.
>
> IMO, this is what the timeout multiplier is for. So if you have a
> computer with 512 CPUs or a tiny embedded device, you can adjust the
> timeouts upwards.
>

Well, exporting LTP_RUNTIME_MUL to a large value is useful for
extending the maximal test runtime, but the side effect is, it will
change the runtime for many other tests as well, especially those
who use tst_remaining_runtime() in their infinite looping
(e.g. pty06/7, swapping01, mmap1, fork13),
which leads to the whole LTP suite costing more time to complete.

That's why we love LTP_RUNTIME_MUL but dare not set it too high.



>
> The default timeouts are for workstations, commodity servers and
> VMs. Although I suppose as this is a NUMA test the average machine will
> be bigger, but 32 nodes on a physical machine would be 128-512 CPUs?
>

I guess yes, after checking one 16nodes physical machine it has 128 CPUs.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
