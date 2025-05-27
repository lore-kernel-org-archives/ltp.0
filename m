Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7D9C54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748339473; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=YdVSPFniimMWRMmn19KQ8xVKGZDhKHs1awqOBnUH/IA=;
 b=kwunU7E6kcyUwGo6FoQkDNU2DMAFq34GawmpAh3BzNewcF/94F6s/z3bT5Gjc+BUn9b6c
 7vw46npGRuY21B1XBlkYC1Pgemxtq+zFthRsLmFg53/gjO2TPwuXFU6GZAOozX59ciZYydO
 5gBxyWlie9kLpTiMnEc4BFTMdBv6mjs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 250F13C56B2
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:51:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1938F3C2C13
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:50:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 783DD140032F
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:50:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748339448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q9o3mgEcqEJZxOE8zJaYH6rbD9e25ussMGzsDBXsbTE=;
 b=XqQCipB67Rtw2TQ2LhCgCZeEQAkWxsqn9REWMAKbGmpq33SLmwfjLwBx8iWOloWY9o+SKi
 eIBqljz/mMBAOvphsK2+K4pZ10gHHzrBGoGPs9jwdjdfjrnd9gCq+xRUtoWNGlIdN9IgAm
 7S4UFWEhk3fJy8slZl3Nn3syx1BtCMA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-NE765a6tNgm_8g2MemDZbQ-1; Tue, 27 May 2025 05:50:46 -0400
X-MC-Unique: NE765a6tNgm_8g2MemDZbQ-1
X-Mimecast-MFC-AGG-ID: NE765a6tNgm_8g2MemDZbQ_1748339446
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3111b16155dso4566934a91.2
 for <ltp@lists.linux.it>; Tue, 27 May 2025 02:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748339444; x=1748944244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q9o3mgEcqEJZxOE8zJaYH6rbD9e25ussMGzsDBXsbTE=;
 b=PrsTBYcSIDkMQwxN6Z8yL2nxC4rb/RHA2/kkR6BJszqAPVJJ5Maxcsjci458zckjxO
 hRz7axd0WPv6sDhUdU39wd/bBY+kXSES8x8eZKUKY4mkCJtgUtbvtZ9bnyWwP03JqWoS
 uX1GNUQh1u9VACpWPfi/Q0Gng4uFTcZRj9AETiyFs5Jream7n8d97HentgjCi5V7BFYT
 6e4PM5sfgSeIy24psWuhKu1zCNxHnfX4/HYcA5IgxtYd9wif/370X/390J+48NtpNlMp
 XlCEPwDo5p0Xp214GamgeOZnlwQOpJ0gDkrUWRUlf5+wQ1EXDiJmd2oOvp+HObq3W36B
 bDBQ==
X-Gm-Message-State: AOJu0Yyr7ZK5jChIHVT8fsuNXjWJs+TrslhzErXMg3bbZkJmVersojoW
 i/p1ZznO664AbNw5faFIqhZisiSpwpPpic2y8Wp0hsGkZZHtSiI9jCgwDk8CdobnRRp7uq5z63k
 aizc+eN7loxaZBpCCoJ4p+vP1MvrtTV/gmTan0HNSW1SYthOcxXlW6B7TA3bD07QgcVL6kpEduS
 I3ASMPXr90H1LIEzi0uYdC2s+TzF3I6pIfpX8=
X-Gm-Gg: ASbGncsqcu6P0wOIrYm6iE7mL2rP+7W1g3b1r5/02Ml5raEULBD+n5rBWbXl09Lj9F6
 nKdzxkVcAg6VvAsQ/bpQEyacM8pHMP00Dhi6uYHBcQuALga0taxU2qbhFeKmXnwaR0iSvYA==
X-Received: by 2002:a17:90b:2b4d:b0:311:c1ec:7d05 with SMTP id
 98e67ed59e1d1-311c1ec7f38mr680994a91.35.1748339443924; 
 Tue, 27 May 2025 02:50:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdoSLgFddWjOuw0dHE+07E2iMgp4TxEfJvpl8UN9zFCH/ya9bE5zTezr7sXWmME0vKNw7eGKpdT9jSTaVD1lQ=
X-Received: by 2002:a17:90b:2b4d:b0:311:c1ec:7d05 with SMTP id
 98e67ed59e1d1-311c1ec7f38mr680972a91.35.1748339443621; Tue, 27 May 2025
 02:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250520202429.577890-1-luizcap@redhat.com>
 <aDWIquJOzozzfHUv@yuki.lan>
In-Reply-To: <aDWIquJOzozzfHUv@yuki.lan>
Date: Tue, 27 May 2025 17:50:31 +0800
X-Gm-Features: AX0GCFvwU5eLn3jDoQmuKVCYqUO8e901Is1Jyx6GLjipta2-SJgrHhZhuzu3rV0
Message-ID: <CAEemH2fcVxSzfmmBw7k+zYf0niJ2zqG=GBNj9-y-Ow6Doi+Rvg@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GFDBhfxxSgmKCsCS7fQaFMs419-vGXfL6efLTAa0jZE_1748339446
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ksm: fix segfault on s390
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
Cc: Luiz Capitulino <luizcap@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Luiz, All,

Patch merged, thanks!

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
