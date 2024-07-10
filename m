Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96821C3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 19:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720638932; h=date : to :
 in-reply-to : message-id : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=TKgL8NcjY8sKRCgqZTx73vVaGcM4zk66Yp1oLwChSKY=;
 b=iJnXQHjcVg3DOb1+gRHrLEfY0GOKddSxRIAR6K8ajQMCDlgUNoPKCNjY+HfI43jEjuYBD
 vs0tQ3KoP4NZDPB2YXKRq1vjD0CC1Z8NJbKSdte4SnuNm5if24U51RtXSfCjpIN5Sz8EGRa
 fHEGrQEu/ADBnuAG3nUZsS1yKdxhCtY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0720C3D387D
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 21:15:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3B473D3860
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 21:15:09 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3B697208282
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 21:15:09 +0200 (CEST)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6510c0c8e29so1182027b3.0
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720638908; x=1721243708; darn=lists.linux.it;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xpJH7O0IK+mWa36m8icY/tzE/YoR+c7Wf4G7xE5ZzLM=;
 b=RETNEYPNU9WQboXFBMluO/MhJjYM01RcBLU4zrHrTa1NOEJt4KdhoAHZkapqG4f8Xz
 RVM97FT+dYFhGnGVmt7FfE2a5or8m0oh2fivOx/C3yU1nQPRsH6u2VUug9vmI2Zh1uIe
 VkYAm/TOKh/4cUTucTKhFWhCVQ/k8TOU/jK0aKDoneqc1x/nTSASzx9hhoYs5ZwrTbzs
 EIk8MPFQf4rubBz0pQlxBzaOQt6LSrBSj/C+EmowqA1hax2iJ8WcLYl9uSvOOiykytHZ
 SK46ECg7C30g0nxP8WgGuyEJLOlDITUOOsrrK4R4DIkuXaSjpE3rHmhaMVO6rBo4eopC
 VV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720638908; x=1721243708;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xpJH7O0IK+mWa36m8icY/tzE/YoR+c7Wf4G7xE5ZzLM=;
 b=gNux/lvlClomzvmdqKuHatm8u4lkkBKMB81g36o3yvTRJmsJzHzlElp/w6uS/QacG7
 btv1gdvux2oGF3ODjPd60kA1iQ3OK+cpI5kngWu7mddZekKV9DFWzIgRw/IlElDpbJqr
 C80053VTL0WBS50OEbZUzlL8aEjFEnGdfMvaJ/5yQ+l383cCwc3LpMZtJfwjxh6h4rSs
 eFnlHrZ/I3h3dT/gk4nlR4kRNhgPAFVp3TLJ7GCA3xxYmyDpbi0fik64dj6/VfnoCeY3
 MkfOstS2ZXW+5JAhngrqlvYKD1pIfJCb2DAw+oVu3ICUJKLMKK/y1IaKPDXXMc81kOZi
 55PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4JcPWVLv0gEH1BBQAATv/1VivpnYOPHh/9l/O0fIUfl31AqPl5sd551x7DK2V4fXlu6dex3WwAxlFEpV/Yc4jfc8=
X-Gm-Message-State: AOJu0YzCJuI4J4WBasYVS/p1jfXJnt+ARnji/RPwMRV+98Ou0xlupqgI
 JI2YO7h3m5wxS6DNo2XpWQi6vw0q3h7+g3TDebwFEhONQpQygl7oGAbXwu2CYw==
X-Google-Smtp-Source: AGHT+IFWZTHBjlwLdnh07cjhHTC+j0sZPJwKS9lkD9EQ+SwBth2W8WJCPyjo5BJ/hREJijMn9wPueA==
X-Received: by 2002:a05:690c:ec5:b0:630:de2f:79b8 with SMTP id
 00721157ae682-658eed5ebd3mr74295227b3.13.1720638907584; 
 Wed, 10 Jul 2024 12:15:07 -0700 (PDT)
Received: from darker.attlocal.net
 (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-658e4d2d5d1sm8308867b3.55.2024.07.10.12.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 12:15:07 -0700 (PDT)
Date: Wed, 10 Jul 2024 12:14:55 -0700 (PDT)
To: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <2fe63ea9-613a-4904-8b68-134442c43261@gmail.com>
Message-ID: <75bc4bf4-afe0-a1e0-36bb-1fad7ecee210@google.com>
References: <202407101031.c6c3c651-lkp@intel.com>
 <dd08adbb-6df5-4556-9fc4-cf37b6234aa1@gmail.com>
 <053bd429-ae19-4beb-a733-a7a838b1e010@gmail.com>
 <4bc6400e-6199-4147-9399-4a54c94613fd@gmail.com>
 <612af749-0a59-f91d-693a-43d6217ffebb@google.com>
 <2fe63ea9-613a-4904-8b68-134442c43261@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [mm] 47325a5c88:
 WARNING:at_mm/slub.c:#free_large_kmalloc
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
From: Hugh Dickins via ltp <ltp@lists.linux.it>
Reply-To: Hugh Dickins <hughd@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Nhat Pham <nphamcs@gmail.com>,
 lkp@intel.com, David Hildenbrand <david@redhat.com>, "Huang,
 Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 kernel test robot <oliver.sang@intel.com>, ltp@lists.linux.it,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 10 Jul 2024, Usama Arif wrote:
> On 10/07/2024 21:49, Hugh Dickins wrote:
> > It's a long time since I was active hereabouts, but the bot report
> > and your flurry of updates make me think that you should step back,
> > slow down, and look more carefully at the precedents here.
> > 
> > IIRC, the main problem is that parts of the swap_info_struct can
> > still be in use from before while you're wanting to set up new values.
> > Observe how alloc_swap_info() may return a fresh or an old allocation.
> > Observe how enable_swap_info() is called after getting swapon_mutex
> > late in swapon(), once past all possiblities of error.
> > 
> > I expect that your new zeromap needs to be taking the same care as is
> > taken with swap_map and cluster_info: to be safe, follow their example
> > in both swapon() and swapoff().
> > 
> > Hugh
> 
> Thanks, yeah sent too many in quick succession :). Will be more careful next time.
> 
> Both the 2nd and 3rd version are careful to solve the problem of using old allocation
> which you described.
> 
> The 2nd one takes care of it in the same way as swap_map.

It didn't look like that: it set "p->zeromap = zeromap" as soon as
zeromap had been allocated; whereas swap_map is only installed later
via enable_swap_info().

> 
> But I believe its unnecessary to do all that change in the 2nd version, when you can just
> set it to NULL after kvfree, which is a much smaller change and takes care of reusing old
> allocation equally well.

It's possible that there's a good reason why zeromap does not need the
same care as swap_map; and it's possible that things have changed down
the years and swap_map itself doesn't even need all that care.

But you haven't persuaded me: I repeat, step back, slow down,
think carefully about why the existing sequence is as it is
(and please don't respond without doing so).

Hugh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
