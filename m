Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320D7C87FCF
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754355023; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=oWTG4KiVr1VLAeoJDaYVm3vT83cy2Wrj7yZfWhjO5dA=;
 b=F/WBGqYGTVo2JTDXN1u3y1gVDOg9KPppGja6DkoIwT5lDyQyPznRF7HBKamqHT8YK5FZ5
 2MLGe2bxb2UEzrNxWXmTZbo1816Az5rPgzuahEYkjbIpVe8xzcSLlKbxazpjJA+YraC7tJL
 +tPqJWRNbQHbfC5lxGVWaYoiwp3fdvk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E1A23C7423
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 02:50:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95EBC3C324A
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 02:50:01 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 58C521400142
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 02:50:00 +0200 (CEST)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6157ed5dc51so8756021a12.1
 for <ltp@lists.linux.it>; Mon, 04 Aug 2025 17:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754355000; x=1754959800; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B7SmZnL6VRL7+bBKpNPXZ08UcqiyXXe6UNiZZAKtnzU=;
 b=Z39f3qFV9ipbiw1JsPZscmgK6BMmKfX2Llcq97d56+SoQ4RcxDNP8hk9R1juT1LJ9k
 gFtKr7ed0LZIiL2LAbez4O/8M8/KBXc15UfyOGMZ6SJmiLE4DMM5HN94vxwmLL+OZA3X
 GIYiK/1ItF7VLhq0yGx5TbOTvP9CNkI5XP9ZnzAr5ARi/ac5bPhjdF3RuoBnbZrxN8jO
 ewkKxj8g701gaL0QiWy+5Q1KeZmtcIzYgkcn13m+eIf+GbHvqvilFcRgMuOp31oDFw/B
 /HzXyWo0Lp8PEz0KR4WOCyqkY+GmmS1U2Ma80VGUsMDhZQLRmatTx16bDoeJ8dhiRZjF
 j+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754355000; x=1754959800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7SmZnL6VRL7+bBKpNPXZ08UcqiyXXe6UNiZZAKtnzU=;
 b=jkDr9mXR1lGed5YdAkAKhdPzHjCgBJVKMw4MYlIMwk8N4ebnqx1M5X4twoER3JJlQU
 cTACKMNDKShvOJMnAJuOA/v0zh5JZvjSb/7XHoTDIrBbqWtZxEtINpuBi/RHMzJP4qNl
 CcJryvF/2NID0703yzpoyr4TzN8LYRAh57Tk0FGGL9DpNv+l0N1+8eoVqXF9/ffqgwm5
 deHBziRYVb4BuWLVRNculW8uQJDgQxIRcHK/rTTjLBuiJ+ju1zyYVTjAr2QcB768ScHy
 f7U4ZR8fIaT6e9QUeEZznh/+OvGTEKuQkt8FVodWH1wEvjTwCTfzp8RSIK+JkcwSwEeA
 sWFw==
X-Gm-Message-State: AOJu0YwXV7xEntLi+2d89ywWdmjf2KCVwcU5vgm9v5PqoD88qiy6rTTT
 AF+af0auJTN/5B9t2jRIV0jiSXynx8cqui7Pgm9Z3fowl+cbkIYqRQdyH45Wy0b+y4gwoeAfFTu
 Iyb0=
X-Gm-Gg: ASbGncvi0GBwdfX9TRlDi+nZmZglKhsH93wUzVpFIuOPziLcYRoSUhSvHt7aXh0z3No
 iEAtjAm5CeKm9HzEeMbNNaSCtji5IhF8DLZkKrszWDryI6xXXPxF/WkbT1KWJtjsUome4KqR2qW
 osYcpadb7T62DjRUGvGP4u2qSWhQhFQ1iIKAyKRgGi4/KffA9NiNr/aB8aEa+8i5/anVF5OmALC
 p+XfwdCBTyRlXw/afoMhdPCY0J5R6YLBtA0NS8DlZoOq1tiEgEc3azp5bPtDj0o+eirDdRoW6Va
 mNBhAtu1WYAP0aeFzgucjEkVdTvrvviAP9KJAouHROdYUDrBSqAkh1anYCH8PGQhkBBTR5JgOAb
 TsQH3t1ON2vNxenEwTcuX3w==
X-Google-Smtp-Source: AGHT+IGIQjCeSDqY/s6JlgToDECfsuhclrMba5m8nVMsSJIXgIMv0OCDtHOftBADr/L00dAGjPOkFQ==
X-Received: by 2002:a05:6402:26c9:b0:612:7439:4190 with SMTP id
 4fb4d7f45d1cf-615e6ed02c7mr9869858a12.10.1754354999710; 
 Mon, 04 Aug 2025 17:49:59 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8f15fa5sm7414342a12.14.2025.08.04.17.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 17:49:59 -0700 (PDT)
Date: Tue, 5 Aug 2025 00:49:57 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aJFVNdvkdfqPFsse@localhost>
References: <20250804184850.313101-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250804184850.313101-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] rpc_test.sh: Check for rpcbind remote calls
 support
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: linux-nfs@vger.kernel.org,
 Ricardo B =?iso-8859-1?Q?=2E_Marli=E8re?= <rbm@suse.com>,
 libtirpc-devel@lists.sourceforge.net, ltp@lists.linux.it,
 Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Aug 04, 2025 at 08:48:50PM +0200, Petr Vorel wrote:
> client binaries rpc_pmap_rmtcall and tirpc_rpcb_rmtcall require rpcbind
> compiled with remote calls.  rpcbind has disabled remote calls by
> default in 1.2.5. But this was not detectable until 1.2.8, which brought
> this info in -v flag.
> 
> Detect the support and skip on these 2 functions when disabled.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
>  testcases/network/rpc/rpc-tirpc/rpc_test.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> index cadae55203..1a8cf46399 100755
> --- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> +++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> @@ -53,6 +53,11 @@ setup()
>  		fi
>  	fi
>  
> +	if [ "$CLIENT" = 'rpc_pmap_rmtcall' -o "$CLIENT" = 'tirpc_rpcb_rmtcall' ] && \
> +		rpcbind -v 2>/dev/null && rpcbind -v 2>&1 | grep -q 'remote calls: no'; then
> +		tst_brk TCONF "skip due rpcbind compiled without remote calls"
> +	fi
Should we check rpcbind version? Since you mentioned remove call
detectable until 1.2.8.
> +
>  	[ -n "$CLIENT" ] || tst_brk TBROK "client program not set"
>  	tst_check_cmds $CLIENT $SERVER || tst_brk TCONF "LTP compiled without TI-RPC support?"
>  
> -- 
> 2.50.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
