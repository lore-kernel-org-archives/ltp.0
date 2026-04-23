Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A153F9936C
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 11:14:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F29F53E2D81
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 13:14:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8ADD3E1D62
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 13:13:49 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 376F1600669
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 13:13:49 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8ac9ef74131so102019746d6.1
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776942828; x=1777547628; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DuQ0xYndHNK9TYXmNQZC/P7G0P9e2btjG4lSJ8zqPfQ=;
 b=LrUy9ZMuNFlONPBErgzs3vba0KuxuoKKONgzlAS0ffywnZ837mk9CI2FStQXIhJ5Zx
 k30jmbFND1Nc+pmIpEv3JKwJCNb8qO/rzoVkABTz2vzP+Z8qcrjKschF5oE14pAO3DGM
 Y2rcb7WSp/rwWxsUtsHqfYreDEOBmTZpEWSRkFSYzT1clQkeKNiPTHa/+sJmfV3KhfP5
 RqFF+euOkqM5PAqr3AGrM280TLPnDvDwtbFOnRkcy0kBepjzdBLkFawsbJQ3zPq/MXCq
 yesuCuB0a1/RjUZ3F9dQ/yXhsY5achrXG6OS39lJkrmGc28rx7ODCnJrpU7fP+5/bQbU
 mrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776942828; x=1777547628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DuQ0xYndHNK9TYXmNQZC/P7G0P9e2btjG4lSJ8zqPfQ=;
 b=KIuvWHNuq1jRWDgo7wNxSJqTQqpr390uy/kvjVN+jVamGm5y61t+U0QRVwsx9bvqvL
 OFRjrD7z0SK4/IuhNbtj92YUlywZalvVjYKSoIBHR5g2JXdQXTlQcAF+xifdkfceZn81
 yNDGsajtlCQom1cVrCeZuXhEsI97n3qMK8rQUBS4GxHb9cxp8ppVgjwMC8bZj7QYt5t1
 ryha0e+4dgHuGng4/97wENvc2Ybg1wEp3iCLU5sVOOit5c1yjW+e5on6KZEGETaJ220o
 MQoVSNjmPWPOTjl3GFur1VCzOY2q6Na+n2v47c4aB8lAjC+pJt1Z39sWXkdq/zdtCKbj
 t0vg==
X-Gm-Message-State: AOJu0Yyg8OpjLVU8E0WqPw34ETNSF9ws8sNwmJpFGutE4kVOyOvnV0gB
 RO92wYFsBUBYOVtvBPYlaj+lD0QvWQZ1k3sDOrAB7zAnL/tdjpl5JzV8
X-Gm-Gg: AeBDietuo24uYq0ODUbA441nYfbnlqrFvNdHKAqwWUQAXn6TPOs6JfVIO77wqDOYU6E
 baGoY8UfsTgY1zGPuSxa/BJsSmOF1B+DXeZgISv7k05yDedzuvuGKDk1cbFBIEcKBEpcr0axRcG
 4twbMo7r1Gh8iu/Kn9Cp4sMq05lXV8tG71YjfNxxfte6xsNKYEzvtFQegAgUyk5kaZLXm5me86u
 U/3k0M0t0z5Oy/WGX6ZS2suyboIM9xhdmZOGOuonOagmUzxSmIQOOK2e37L7knaxTqyiP1D+xxh
 bm99yRoxjo/06PAOBdU+JFbEHst2YKM4ZMzlBlK1Y5pGIa6X+b7Lkfqe7h93VhRpxXb/LO2sAPG
 qG71fnHK5uiO0g3pAB80BsQ423FNeTdiUY1pnIqC7PC1SQ5n2LeiCwbyP5acJreGctcxf0hSG6J
 JKpsGeCDiPLnUYqpvjKNhHDk8A4malxwpYCCZPI1miF2+UHU0haX6uhVhtu+E612z3+RGUOehyJ
 C/SRNM6fwXd9OEs1e41YRfE2glVIf9WhvtzF55+0tQv7yallzZO
X-Received: by 2002:a05:6214:8094:b0:8b0:31c6:5f85 with SMTP id
 6a1803df08f44-8b031c65fb3mr358764986d6.28.1776942828045; 
 Thu, 23 Apr 2026 04:13:48 -0700 (PDT)
Received: from
 runnervmeorf1.xbqmit5f5f2erozg2hxxbijevb.bx.internal.cloudapp.net
 ([172.174.223.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac429ffsm155643456d6.2.2026.04.23.04.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 04:13:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Thu, 23 Apr 2026 11:13:47 +0000
Message-ID: <20260423111347.4028-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260423105304.59788-1-sachinp@linux.ibm.com>
References: <20260423105304.59788-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc: generate CVE reproducer statistics
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

Hi Sachin,

On Thu, 23 Apr 2026 16:23:04 +0530, Sachin Sant wrote:
> [PATCH] doc: generate CVE reproducer statistics

> Fixes: https://github.com/linux-test-project/ltp/issues/1254

`Fixes:` is for commit references (Fixes: <sha> ("subject")). Use
`Closes:` for GitHub issue URLs.

---
Note:

Our agent completed the review of the patch. The agent can sometimes
produce false positives although often its findings are genuine. If
you find issues with the review, please comment this email or ignore
the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
