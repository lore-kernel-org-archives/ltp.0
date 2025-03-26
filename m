Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B31C36008
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 11:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742986920; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GQOTG9mZmbVQ6M1zkOCvhaELvuByaJFHuqRdFVg0YqI=;
 b=QE0K1EjjFfvto45SV+hf5b9FGxSVzKhU8IQ1BGq2iaQVFRH86JKlUD4jQRpBZQzBSU/3l
 st6N2BNeZ9S1MTCNUEGFee4NapVup1mGW9pdu5vtGfzqMyCHnXCw0//Idk6+Gs7woxs5G1z
 rVX0Ol6lg/L+c3pr2FPZ9P6/n1o3g3M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F27E3C9447
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 12:02:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 802903C100A
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 12:01:38 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 68C2E10009DF
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 12:01:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742986895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JV+Tig7URbzdP2zdT9YNsV/2UpIU2jSSbcZTGlgE3EQ=;
 b=ZmQcMzXIq52Z6rWhDq/oHoPs0RUotq/WWa5vSDWyFryZDyG3uIupM1OFy1RCnoMkjERqCm
 XaDyfCELjeu9rsWgePR9QI+G2ZvWE7mDGlw3pQkmT74LNAyCXu4u9YvNSRUBKA9zuv1sSS
 R9ngBHwxlK/rnJQUz9DcDZsWvTDsV4k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-EnkZ4gKrMNWcCEgJYNzfUg-1; Wed, 26 Mar 2025 07:01:30 -0400
X-MC-Unique: EnkZ4gKrMNWcCEgJYNzfUg-1
X-Mimecast-MFC-AGG-ID: EnkZ4gKrMNWcCEgJYNzfUg_1742986889
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3032ea03448so7229465a91.2
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 04:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742986889; x=1743591689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JV+Tig7URbzdP2zdT9YNsV/2UpIU2jSSbcZTGlgE3EQ=;
 b=tXKSUptsZw9Gbz+fdBvERnIjlJS83/+qpRgOXNBMp3KLrcDdIPYHc7Z4kJiI3Kng/k
 X3kHzd6lY0ruxZ0ydbwyn7Qd5qJHd8b5hoDzMSin6RmtvsCajyABFUSU13hqiY69B4YP
 fd74MvJ4olrzRoM/qouOFZr/QTELDsyrxLDN3g0OceKjoi+pskskFsLtR5swOb3g60iv
 LAROiyzcv9gs9lOq4tMmET64otpLplrC/qM5IpVprt4e8g8BO57lbGR3WaaGYLeo4qdg
 9/GbWEunhHGVWK8FjJV1tHmzj0QsRm0OLKv4yx+twr83rqTlDQPTf+hkHL4m+VgUkFMe
 SguA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFRb7DsAdTuuHE0WHo4dDLVdsNpN0pxtgWI/E9OucZ0yoBFJ1elU6KtUUQXWG5VCT28rE=@lists.linux.it
X-Gm-Message-State: AOJu0Yy+Pv5vxRTi/GX6Jqf2QjIhQPnmFsHjwastkCCXjoBQglwTL+5E
 KX9QuN8neJh2ylWmX6vwbavcsRSfGlWnTAUZqZ/B/o+akdkaf7kje6tNhxSyfk6FUZeIOvupflx
 eS5JunRDjOBvGCamuR6C5kNo2Xj60wLkAM4EeyEYmnFor8v1X2gBdhOhdDRc7+Dem0oo0BGTsAa
 Z1XGo8uQOt7vAdPht6dEsj3Io=
X-Gm-Gg: ASbGnct7/fCMbbc8j5kQNI5e8hPb5r1W+HB81FJIyutDa0S96o24Xs8mKb4lK4OBw+x
 N7Ks6DmMObazZG0TAcP/QFXv3bIBSeCOs8jqVAhXswwpmHTk9smhjHJAlwDa0zKWp7WkylhMjSA
 ==
X-Received: by 2002:a17:90b:5408:b0:2ff:6fc3:79c4 with SMTP id
 98e67ed59e1d1-3030ff10972mr28310998a91.27.1742986889143; 
 Wed, 26 Mar 2025 04:01:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhIstyfTp9XObEag96kqFDtjC8FlBWW1SPhZCLv1vuvYLqQqzxdSkYzuQK3PQ2wvGjxmdqA9yb+L6F8mEqREc=
X-Received: by 2002:a17:90b:5408:b0:2ff:6fc3:79c4 with SMTP id
 98e67ed59e1d1-3030ff10972mr28310935a91.27.1742986888578; Wed, 26 Mar 2025
 04:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250305050805.7905-1-wegao@suse.com>
 <20250324120049.29270-1-wegao@suse.com>
 <20250324120049.29270-2-wegao@suse.com> <20250325140018.GA448693@pevik>
 <Z+N/LjYbZJKq3qsS@wegao>
 <CAEemH2dNduMxZZzvC-ENpCMLcrD7CXYuV8iLsRJXisRu6LLSLA@mail.gmail.com>
 <Z+PEy9Ap9OBeNDkI@wegao>
In-Reply-To: <Z+PEy9Ap9OBeNDkI@wegao>
Date: Wed, 26 Mar 2025 19:01:15 +0800
X-Gm-Features: AQ5f1JoB5l8H6r5sfOJzXCtDsebYRUATsCXveS42B2cLcZ1hOr3Q-yOZwhi1bZw
Message-ID: <CAEemH2eLqLsf0kvBPm38FOBCY274kBpukanaFpMoiPTncwP2ow@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tmQhQCxvd8VaJ_0LIk-wEGOhv9X1fG48FCiE1-L9Du8_1742986889
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v7 1/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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


>
> > It depends on what you wanted there, if only 1 general huge page,
> >  `echo 1 > /proc/sys/vm/nr_hugepages` will try to reserve 1
> > from a NUMA node randomly.
> Thanks for your valuable information, now i guess i find out why
> original code using 2 * node->cnt instead of 1, it try to make
> sure every node have at least reserve some pages.
> >
> > But if you prefer to get 1 hugepage from a specified node, we need:
> >  `echo 1 >
> > /sys/devices/system/node/node%u/hugepages/hugepages-%dkB/nr_hugepages`
> >
> > However, both ways won't guarantee the reservation will be 100%
> successful,
> > which is based on the memory fragmentation situations.
> >
> > To be on the safe side, I would suggest using LTP unified API to reserve:
> >
> https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-API.asciidoc#134-reserving-hugepages
> >
> > You could reference usage from:
> >   mem/hugetlb/hugemmap/hugemmap16.c,
> >   syscalls/move_pages/move_pages12.c
>


> This case is check allocate memory on specific node, so if we set
> .hugepages = {1, TST_NEEDS},
> then 1 page will reserve on NUMA node randomly, that means case still has
> chance to fail.
>

Right.



> Also i guess current .hugepages can not support ".hugepages = {2 *
> node->cnt, TST_NEEDS}"
> So the easy way is keep v6 implementation like following:
> SAFE_FILE_PRINTF("/proc/sys/vm/nr_hugepages", "%d", 2 * node->cnt);
>
> Correct me if any misunderstanding.
>

In this case .hugepage may not fit your requirements.

We could directly keep 1 hpage reserved in each node
(in setup phase) for the coming allocation.

  echo 1 > .../node0/hugepages/hugepages-%dkB/nr_hugepages
  echo 1 > .../node1/hugepages/hugepages-%dkB/nr_hugepages
  echo 1 > .../nodeX/hugepages/hugepages-%dkB/nr_hugepages


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
