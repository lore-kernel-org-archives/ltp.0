Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D14FC369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 20:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744749797; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=hhM+J7fnsxE/4FdnvyZgGbeoJKWBZjBCzGu2dGARTJ0=;
 b=VeoX+paGTlwUSEK9wYMuTOQSOiB0iBHzDLtQHUHQfSEYV6PY4/x/AAgeETJOvhSsE/VIY
 xPcZ6N7k76xj2PFYDAE0ePnE9YJ44TiDSmTFYAtF07pLrlTcwPsPJfj919VcH6Fz6VdOCq/
 IzExe15SezWcGx2yEhgJtHNvoP/WDZA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 681FD3CB93E
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 22:43:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CAA23CB86D
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 22:42:56 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dbrendel@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 64ACD60007C
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 22:42:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744749773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Emh1k0KXngdMYRjrHisyVuTrWmLwN8DgpFCoFX87grM=;
 b=iGGLUSDeMlhjtKbXiATirsYDcjVdJFaF89/Dr8/dN7ykr1QGC8KqEZdodtTUWc+Uw+JdCD
 ovO6xgoedK79kBwZl+5DrXEIzAtZFLqbivWyvAJtv+5E/omh86TnTKdUZbxSjAt4/Mudc/
 212Q1lhlkcPfsjXUUY4cGmOjuJlae7I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-xJmm89TtOh2b-4V04jDDaw-1; Tue, 15 Apr 2025 16:42:21 -0400
X-MC-Unique: xJmm89TtOh2b-4V04jDDaw-1
X-Mimecast-MFC-AGG-ID: xJmm89TtOh2b-4V04jDDaw_1744749740
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d51bd9b41so47630655e9.3
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 13:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744749740; x=1745354540;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Emh1k0KXngdMYRjrHisyVuTrWmLwN8DgpFCoFX87grM=;
 b=ml+OqUyFRMWUR9D881UqE//jq68asTfbzbb3lByI3WwzQBfGWZJZ4vVl3MgLmF0kdj
 BXZ5Typ31jlFFAJm3Urlalrl1MP72RM5+x2zQJui6IECZezP83TeZek7XXO5QtDKlx+6
 OzBqANsYj74ZR62cLrbbJGb5GluDQJarjCC2INInEe7ZB+/aQrg4NMwL4LSdWni/fg10
 YjTku9m+ZmnivSD3akbwJ9CJqdK8CU1VIFVgN2GawOdvmlQ6i0rrd5pm2BLBwHBZDria
 +Box9pjkLvNZTKm2pN93bwd5Oju20k5/3PXFxGnpIsAx1rCwXHiLnEiOOFimKmIDDinm
 ArQg==
X-Gm-Message-State: AOJu0YwIrQ5GtIumNqYG/ed20odFCNNnfzuCqmrNOld8xHEclRvY+v0L
 /VH0JCG++PkMTHfyJdwUAKGkZ8PcCHLa4d9YBOjN+h7vL4FdpFytlBCWnyyzp0+HWIGkO+bdYPj
 p/5LLr0GmIWz1AAp9eCPa6G1fKaNrsBU0M/EwjRq6GKwao1Ia
X-Gm-Gg: ASbGncugqNhoOgOC4h9LTOeMUkLDhYfKdAG1dC6DB+qyf+eGTqTDPovBq9+PCxssuOb
 8hFfsuBWTStvcy53BDOpflK5TcKP94wt52wOZiWZlfs5X0gPJf1dxCeWNxV9mUNeau71rByaEcp
 +/NgxbXe+PAIl65g4WVoTSzMt8Sme43DFhqGuYTa8H1lC70XSWMvHFJtkRZVTlW7YKtGRnqm/pK
 7X2pQeWF4Nx+I81qCjz/DurekUrm+1Qdh+sZgW7KFrYYher5Y0B9Sr3kMpzIZJwQ/SQCkzRsOtZ
 O2D8U9vgMDWuHNIgZw==
X-Received: by 2002:a05:600c:b90:b0:43c:fad6:fa5a with SMTP id
 5b1f17b1804b1-4405a0ec409mr4111985e9.24.1744749739871; 
 Tue, 15 Apr 2025 13:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlFK7jlOtZNneXrs9dhnD1iACp1k8o8s5iCcN8im5//cBGHh6N6ZN0hW2nnjXrPy3/HlESYw==
X-Received: by 2002:a05:600c:b90:b0:43c:fad6:fa5a with SMTP id
 5b1f17b1804b1-4405a0ec409mr4111865e9.24.1744749739468; 
 Tue, 15 Apr 2025 13:42:19 -0700 (PDT)
Received: from [192.168.178.42] ([185.119.34.122])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4404352a5f0sm20529115e9.1.2025.04.15.13.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 13:42:18 -0700 (PDT)
Message-ID: <9af81e6d-e0b5-4488-a589-76061f2be18b@redhat.com>
Date: Tue, 15 Apr 2025 22:42:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
 <20250415-patchwork_ci-v7-2-bc0b9adca971@suse.com>
 <20250415173535.GA520691@pevik>
Autocrypt: addr=dbrendel@redhat.com; keydata=
 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
In-Reply-To: <20250415173535.GA520691@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VYaDyrd64Wh_iDjIodL1Q-9VvRv_ATO2hagGRPTSGyY_1744749740
X-Mimecast-Originator: redhat.com
Content-Language: en-US, de-DE
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/4] ci: add patchwork communication script
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
From: Dennis Brendel via ltp <ltp@lists.linux.it>
Reply-To: Dennis Brendel <dbrendel@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 4/15/25 7:35 PM, Petr Vorel wrote:
> Hi Andrea,
> You may have noticed in tst_test.sh, that local variable never uses $(...).
> It assign single value, but never call $(...). This is for a reason.
> [...]
> What happen? $? is assigned from result of local keyword,
> it overwrite previous result from $(...). Note even '#!/bin/sh -e'
> would not cause it to fail early.

Here is the corresponding documentation:
https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#index-local

> The return status is zero unless local is used outside a function, an
invalid name is supplied, or name is a readonly variable

So:
If you are interested in return statuses then don't *mask them* with local.

Use this pattern instead:

local my_var
my_var=$(my_expr)

Kind regards,
Dennis

> (Deliberately test with bash to demonstrate local behaves oddly not even in dash
> or 'busybox sh' but even with bash. And yes, given how many errors we caught
> with this script and generate_arch.sh and generate_syscalls.sh due shell strange
> syntax and behavior makes me wonder if we really want to use shell scripts for
> anything longer than 5 lines.)
> 
> Kind regards,
> Petr
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
