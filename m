Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55363C5516D
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785441027; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=poHKywh0tmDtCB+h0KgSR2M+BLjd8uyUg6kn8RLFIdw=;
 b=CIrspIJY5e6DgkSHFBeq95ZoTor2a37qDj+48LZLP1fNDzr90EsBJL0/7JPqUJ5e+kSsU
 1JtRxH8bWCLOIT+9cbj9dzcWXDGlNHcc0mTIezgzJhMKkesPLLH2QcwfQo/ffVZmQu+PPmh
 0ZFQUrS6GgBr1vUUjdnXmk28ZBHVq5E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E01BD3E7256
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 21:50:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 511E63E49F7
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 21:50:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B972B100036B
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 21:50:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785441002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2IdGeM8sck3ZTZf1q8V43j/uWtgKsAOKu2DlN27Ql98=;
 b=QZyzwlpD6qep6dgA8FT7o8IdjhpFmXR2KrdcXoD1mcNNGH7vDHaJlJknDQT+DO3ZoTKtfq
 VxBz0YswA82BiDyaFzJeW+BD0JQmuC9FS/cGP3L7+/uerSApi9ZFhMsxG887mL5D9KltAp
 3cBimwxegD9MvU+cMFS8fmiZdY3CZJM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-VezChQ6APPiUbtNqfkH6JA-1; Thu, 30 Jul 2026 15:50:00 -0400
X-MC-Unique: VezChQ6APPiUbtNqfkH6JA-1
X-Mimecast-MFC-AGG-ID: VezChQ6APPiUbtNqfkH6JA_1785440999
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-930b6bdcb4fso26337285a.2
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 12:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785440999; x=1786045799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2IdGeM8sck3ZTZf1q8V43j/uWtgKsAOKu2DlN27Ql98=;
 b=EfBR3LHDFWRdtb4StIZBJL7If0At+VnAep5ZRiAKo+82RdGEjZX+O9OjpokPsjcbqg
 bpLsiGJgnvh8kvEXDLtvXpsppgmm1VPDmjf61D2lgyfCcmUA9fmOF8b2AmU3qD94zslj
 SDILXCzpBGRqvuSpelwFNuiMP/INlTOQ328dUVC7EpfSUVaevNHkhzk+RWB358gqcjtw
 VSQ+M/mxz/bwnBbd7X+EHnm0MpkUS5DgpRx3MR6paU/mpYDjGIi6/AajVf5bq8ZwxyAz
 Dlfw4q4OZFEbrihUcV7Y9W8jf6M0i2tWWI5x1hKdYwwrRq4WOrvUhpMIS1fDeB4caUqS
 RooA==
X-Gm-Message-State: AOJu0Yye1tse/GQjwbBRwsl940ufHbNRnOyIArg0PPiXIT48Y9y4jvvd
 sEO1trPx+bed6+kVdECmjtErvt5QJLVzsrsxcXjjm75m3sv8KABDDinMQQdW82jQZRyRpYlN8xT
 zwcmiOwUdvSCD7vkIU14lyuOe70++ynaFXSpzozFUUHlgDTc6pbOws65TyvChfAVMNwqKWW5l4m
 8OZYxLp7DnNbZ50n2F9++qFEvxoYmqkR73P8EP
X-Gm-Gg: AR+sD105uEBbW1Cdb9/d8/T0H1/ADl9ppkd0CR/ATzjb3ci+RNrwy6VmtBYET3kO/hH
 s5AiAfEfQwu1+qGPK64wUFnqf6vFQupLTNgPG0MlSuCfNT/pmy7ZJ5LYupp1qsGQtmyoMALNymb
 YdNSns8dCkYbrsEJ5J1YnwBP6fYrbsP+xYdwwZ635aG6whtb3dXtc9W88b6V1XN3/bQm3YCDbAe
 TOmIJ0lfpp6m6gDWbKoicTiU9M5HFIr8KKoFYYndKKSvr7FoJYReIDn7FTqNJBgvYowNKid1BA/
 /ojcMVHy1VTUELwMWN2PEWJXtDKN3G3cSaxvtS7x4wEldUxWwqF0CBcaQEiWb4wH5jkgg1BBYuP
 SKDgr9wRcoXxamvaCA2vry7VMXw==
X-Received: by 2002:a05:620a:4008:b0:932:fcb4:4d0b with SMTP id
 af79cd13be357-93485fef24amr447252385a.24.1785440999235; 
 Thu, 30 Jul 2026 12:49:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4008:b0:932:fcb4:4d0b with SMTP id
 af79cd13be357-93485fef24amr447236985a.24.1785440997083; 
 Thu, 30 Jul 2026 12:49:57 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933e73181e1sm479185485a.25.2026.07.30.12.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 12:49:56 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 30 Jul 2026 15:49:49 -0400
Message-ID: <20260730194953.274721-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730171956.237584-1-sbertram@redhat.com>
References: <20260730171956.237584-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B6qqLJmj5juV9WrC3PTAXqXZFQprPDBWvbf66nlj3I8_1785440999
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/2] semctl01: fix SEM_STAT failures under parallel
 LTP runs
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Stephen Bertram <sbertram@redhat.com>

Split from the single-patch version per review feedback, so each patch
is one logical, independently-bisectable change:

  1/2: introduce get_ipc_idx_from_id() in libs/newipc and convert
       shmctl01 to use it (no behavior change)
  2/2: fix semctl01's SEM_STAT lookup on top of the new helper

See the prior thread for context:
https://lists.linux.it/pipermail/ltp/2026-July/050268.html

Stephen Bertram (2):
  newipc: Factor out generic get_ipc_idx_from_id() helper
  semctl01: fix SEM_STAT failures under parallel LTP runs

 include/tse_newipc.h                        | 20 ++++++
 libs/newipc/tse_newipc.c                    | 13 ++++
 testcases/kernel/syscalls/semctl/Makefile   |  2 +-
 testcases/kernel/syscalls/semctl/semctl01.c | 76 +++++++++++++++++----
 testcases/kernel/syscalls/shmctl/shmctl01.c | 14 ++--
 5 files changed, 105 insertions(+), 20 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
