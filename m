Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E202F33809
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 07:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773734118; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2zzgCyvx8oY8J/W8gUPXH51RMxtz5v1GT6cRpH9Wae0=;
 b=puGvD/ToHJLDLFTcGSluYIU/2eV3mPtVs09yEpha/wgd9Juf/eMx+QYJAgx5Q5Yas4wd/
 G2RsvGC+BreUpG9Kb/2/BdZhAMhT0DU98rOm9AVa68oBuWxjXcZIhRi1RfWX64HOsItL0J3
 ZVhOQ8+V89t4BlGmJp4VX3KEw0bwBuc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E571A3DD143
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 08:55:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68B673D0343
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 08:54:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E090320099A
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 08:54:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773734092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mFbBqnVZ8cT3FMBye2LLyUC6A0O4wOyJOdYCRSzoztc=;
 b=O/FHYw3mAchxHPQiR8acxKXsnqMGNNr7MQ42OStJQwVLmncQZiCw4/uMi4iy/IgaJvUwn5
 pKTKBDCqnckeTgY/PsKOp7OsxDNLsG3oyF9EWr+DjeKDwCiYBk0qoU2RabQkhgwPajQwj2
 9RhqMVsuNh0y8nbTzCT7VGfhk+EHHaU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673--ZYMww-mO7uJrrOg-oGmAg-1; Tue, 17 Mar 2026 03:54:50 -0400
X-MC-Unique: -ZYMww-mO7uJrrOg-oGmAg-1
X-Mimecast-MFC-AGG-ID: -ZYMww-mO7uJrrOg-oGmAg_1773734089
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-829b7ed8964so5600142b3a.2
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 00:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773734089; x=1774338889;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFbBqnVZ8cT3FMBye2LLyUC6A0O4wOyJOdYCRSzoztc=;
 b=krBLYO+DOyW5Mvh6AjSDr9kIRMRgklgPIjolNceTZfgsQwopXnxyBT9TDARfKJBpCT
 emczweGIW2DUsFLL0LsAJNZpUCGLGohIT2TXnNCW1dkkWfzoI3OCS+Zus58TELClegIh
 Lz2Tygip3TbfWPifv8d3O0hq5p2K3nQG6qS817H5Kj9Ytmh9aldyzy81SXQfdcOrboKt
 k7KguDlWrXQiyjhyGSwQ2LuSz+Ihj6rA2JbMtGik/fQsgn2gv7t9XorqqseKTSh12XNp
 DoTOVatQe8RZ6xfmMlgtke1x+SMxJ4/II4py6XvYDny+pfRlOiOx+o2oJIKS9yfp901V
 HwSA==
X-Gm-Message-State: AOJu0YwqXDAyJdUauYTu4FrZsrnS0/KiZ33ICMCqeuxB0b+BRDmTieBp
 fgI6/R/iiRGIufwxyigj4v+zFuc0Kfd1D4lux9AaksNQgUp+eyNESfCKe8/gZwFsWKA1dqhjRJO
 S+31J9LeilDBmUX8bQRJcT5O40UfnZJ0n0H9dTJBiqCqzCrlzHMWa
X-Gm-Gg: ATEYQzzvJN/OM9EoNkPcliaCp71g0aEsEDmY8eQNDNab3wvp2pQcMSNQ+cnkju2RkhB
 bz3o/i44g3tphSF58alRGbyZ9wvdlxjqiINu3JJFB6KleaxCEDIpetXdlf44vNZg1clxMbjfIOy
 wpPXic/HNjuUbyPk9pirp3Pklp0vrUt3/7dXTPuIy51Y0hm3Mh3oC3mKwL5qxBKMDhrv7K7tnSO
 Jnp+pFz7mXw1Vkfgd4TwBO/UCK3oTDVRuMZcKRi2qAIam5l8R69erJyX0648ithy9cgE5BzAk0G
 8cilSBHS49GrwhR/30MbhxoPjAtMS+tfaOCugLT3Je4Bz6JwH6hsxUGoYkGvYzfw0oix4+bSg76
 ryKZ9cGTdKg3bMnqBXg==
X-Received: by 2002:a05:6a00:2d90:b0:82a:1337:493c with SMTP id
 d2e1a72fcca58-82a196f63a2mr13342268b3a.14.1773734089146; 
 Tue, 17 Mar 2026 00:54:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d90:b0:82a:1337:493c with SMTP id
 d2e1a72fcca58-82a196f63a2mr13342221b3a.14.1773734088426; 
 Tue, 17 Mar 2026 00:54:48 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a61412c04sm365571b3a.58.2026.03.17.00.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 00:54:47 -0700 (PDT)
Date: Tue, 17 Mar 2026 15:54:45 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <abkIxQQM6xonm9qj@redhat.com>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-3-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260313142600.243939-3-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GG2Z4xenu63wiKo4gq40DgnuypQnFYSmo5Dp57Ex5XY_1773734089
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] tst_env.sh: Backport common functions from
 tst_test.sh
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 13, 2026 at 03:25:56PM +0100, Petr Vorel wrote:
> Backport common functions from tst_test.sh to the shell loader:
> 
> * ROD()
> * ROD_SILENT()
> * EXPECT_PASS()
> * EXPECT_PASS_BRK()
> * EXPECT_FAIL()
> * EXPECT_FAIL_BRK()
> + their dependencies.
> 
> ROD_SILENT will be used in du01.sh rewrite, others will be used likely
> in other tests later.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
