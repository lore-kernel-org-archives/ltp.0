Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E436CA0EF8
	for <ltp@archiver.kernel.org>; Wed, 20 Aug 2025 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755682803; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ukvJWcRejSx7bJaaO3Oi6bb0NiCTtxTLAcJ/hm7BSSI=;
 b=Eucf2u6fH2UR2UC0SPSJiNlIR5kjaNcsziEMGHdRAiwvpk9W7dZZHjduDTEW5AxFcuUlv
 DrXJG0I5bX8Gm6BC3G3R7cLzMzbIlEEezFEQc5sbhr5f8DIXaSQYECte8S9L0Uz7nNJJC+o
 09PS7ICYsqddf2fXze2CIMHuefwHDdM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C89A3CCADC
	for <ltp@archiver.kernel.org>; Wed, 20 Aug 2025 11:40:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF1E73C782A
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 11:39:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4C2616017D4
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 11:39:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755682780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=heqte+8IKC6leU/XuqesFao/Dx3kT12kOukcbYMRyFg=;
 b=ZyQMI7obOX75xJv8tm+SW+XT7Z9NAPMcBzOKEmRvmfod1YXEbTmOyHQ8tViB4fbW6wUnQ8
 yJ830FZCUUILazwswIyY97pZZPfF1WNiu9K9urIjXZGguRYjmEYBBQNkFJaqg09lQ/7hjk
 SKcbpzQToOdenIaw86pD7JNsxXMc6Ac=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-H7MjuroxOcS0hpSFNwYxEA-1; Wed, 20 Aug 2025 05:39:37 -0400
X-MC-Unique: H7MjuroxOcS0hpSFNwYxEA-1
X-Mimecast-MFC-AGG-ID: H7MjuroxOcS0hpSFNwYxEA_1755682777
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2430c5d4d73so10396575ad.1
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 02:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755682776; x=1756287576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=heqte+8IKC6leU/XuqesFao/Dx3kT12kOukcbYMRyFg=;
 b=bV+Ki5q6aR2rRPJwjcEaF7sHUbuNXOt7r6XnWhJuQtwGdQ87PjkgL/NZHKZVv5biie
 PGVakce8z6zhmUzpkDWSC61uiCFhghVl381FkxcAwj+f6/a6/mMamJtPwKeqdQCjLeKn
 bFw+S4U0W4272z98MO3fyoLgdznlaMDTlEAb4py4F+YI3Q3hSvGQRRRlR63F3uV0uF9h
 RRgGmV649Rn1+I6z1Kb1spm9hRb/9fwa7WcAVS8OjoY2j5EVVMTCBTMHv1K2MM6FHVPI
 pTkma8vkzKElpZwlbYG50foJkDdWt0Zq57irlssQvaRWbyaojO/A/PkNHd8jk3xd1XPp
 9r0Q==
X-Gm-Message-State: AOJu0YygxEhg20eo85/uPwGTs51wfPn2/FoNeOB9uE676f9CnIFJ5W02
 DqwSqvY7duwFFwWRKT8v6McRHezNLiJ4JTtF3xr2WS/U/TA74fYHmlASwrlqIxqgonVnplgy5YV
 pOr4CWVfO7Rb4lyOSclhd4BnI0SZmRthKkBHQpTMtBTat5B0Xn8a3fQDzXCzYQXsrJAysQsgJMx
 WTX7CCGqgeqMIvF+e0Nq/5wE2zBYg=
X-Gm-Gg: ASbGncvGOiMI9Abt4XGQZXDrGv6tKZGWHGGUY6JT3hlNVRgkvZ2OcQY5pM37w5BRC/n
 MxSEBdQEuXMfuoygOXwOubRkhukqQXIq23aBAdqffowCNvIieQ1lok+Tx31vA8qbxPCtyz/IVmM
 NTY6UNu1gZJtIKB/DwucEayQ==
X-Received: by 2002:a17:903:2311:b0:23f:b00a:d4c with SMTP id
 d9443c01a7336-245edfd95f0mr35419795ad.2.1755682776605; 
 Wed, 20 Aug 2025 02:39:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYK0SuKyC29yM7uVd8au0XaYqAZNqSVOabP8V47fUn3FVZggpj9JecpE+48ifEeV/D7puXtUEda3jtFppr1Jc=
X-Received: by 2002:a17:903:2311:b0:23f:b00a:d4c with SMTP id
 d9443c01a7336-245edfd95f0mr35419535ad.2.1755682776106; Wed, 20 Aug 2025
 02:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250820085937.50868-1-mdoucha@suse.cz>
In-Reply-To: <20250820085937.50868-1-mdoucha@suse.cz>
Date: Wed, 20 Aug 2025 17:39:23 +0800
X-Gm-Features: Ac12FXwYQlcn_Uhu3pdixDpB5q4vIJb3_kv1uFx7z7wmAzQC_-AlsfvADdS6l2g
Message-ID: <CAEemH2dd+KW+4fQQ2vFRp9-=QAQBHGwK40rqw-GMdbDA-PHaYg@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wnyt_c2zVlsOhhSxc1EVav28JpdlXKI2DADP8Re2fPY_1755682777
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] Makefile: Fix module dirs search
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

Martin Doucha <mdoucha@suse.cz> wrote:

Module dirs search runs relative to current working directory instead
> of the source directory. In an out-of-tree build, the search for makefiles
> will come up empty and grep will try to read from standard input, blocking
> indefinitely. Search for makefiles relative to the source directory to fix
> the issue.
>

Patch merged, thanks for the fix!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
