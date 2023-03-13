Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D8BC74A4B
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 09:01:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92E603CAE69
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 10:01:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87FFD3CAD8E
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 10:00:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8FF312003AA
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 10:00:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678698054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+EnvDHxQVNBTL0zRGf54cbxoY2bXExlz3F0DovXW76c=;
 b=d9uGcaEnd75dGfcchkGQNHDi3HEvIQO0hHq4RevYQqLtS6AFIthPOFPrBIVZ2Zvg/+tvcs
 XhucxcsbSvtHkn2fJzWSExt5HMzzXWmcAjR4u19DBkbLEUOJfq+mGQGrodlgWBJiy9Hu5b
 ma2hyYFB78sn0WAoxWegyiNMjxJb+30=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-RFKKvChWPJGZb8J5zIwKXA-1; Mon, 13 Mar 2023 05:00:50 -0400
X-MC-Unique: RFKKvChWPJGZb8J5zIwKXA-1
Received: by mail-wm1-f72.google.com with SMTP id
 m28-20020a05600c3b1c00b003e7d4662b83so7505421wms.0
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 02:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678698048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+EnvDHxQVNBTL0zRGf54cbxoY2bXExlz3F0DovXW76c=;
 b=nbMz6mwEesL2p2pb66k2PQo2g4B756rltyUS3QE6t2bqC4+Ew4tlfz9S1+yvFawcbP
 qvVNeAVl1zh2actlrz/OjdmtzvfS1+wqU93a/Kc1D6Xexd0dDEZ6C9KwKBc20Sp4mGN+
 f14FHsNTF/HW7Qeet+gZ+o6ylLKNi6OKMayz6gSsnrHiiE4ENHTFba8z6Qzyh15fhSQr
 77WrA46NVKO7F9ONAAcjk8Zsqps58N4Sw77v/TC3EgqK6RITkeNpfR0zU5Dev1Wl5/JF
 7gPcEU8REMMhgUJa3N9pHkJS8LH0Z3EyqvNrGP20Jt6lZdWENxvwlZWS1Pg+5qafnip5
 RvLA==
X-Gm-Message-State: AO0yUKUpvw4xi8zRfpSwldYKogR/tArzPVpZ+DBrSkrzebY2L/+OFSd2
 k3La1WaXnfU7QeGkHRt6MyOHA5eWC60CStoe2BcC6EoPZtY4Gk0UEIl/vfyQo+E/lK2LLrWgYyd
 MWaP5xaTvIhg+Gplbw8pzs6zIYDIbco8X7mVvNZHH
X-Received: by 2002:a5d:468f:0:b0:2ce:3426:6304 with SMTP id
 u15-20020a5d468f000000b002ce34266304mr5954906wrq.8.1678698048344; 
 Mon, 13 Mar 2023 02:00:48 -0700 (PDT)
X-Google-Smtp-Source: AK7set9YZb3bwA99InjP69xU5dNActhAMW/G7bRa4sXT/d+Y7d54UmrO/cYXuF21WN6g3VtvjgAFG4If9+o0lwehjmQ=
X-Received: by 2002:a5d:468f:0:b0:2ce:3426:6304 with SMTP id
 u15-20020a5d468f000000b002ce34266304mr5954899wrq.8.1678698048129; Mon, 13 Mar
 2023 02:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230309085454.735531-1-pifang@redhat.com>
In-Reply-To: <20230309085454.735531-1-pifang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Mar 2023 17:00:36 +0800
Message-ID: <CAEemH2fy0qq7OYN66L47_yj+ef+TZUzm5Wjwgzt_4g3D-t=W5A@mail.gmail.com>
To: Ping Fang <pifang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] setfsuid02_16: Fix uid -1 too large for
 testing 16-bit version
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

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
