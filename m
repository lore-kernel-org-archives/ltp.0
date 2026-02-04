Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEF7E9536B
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 09:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770198830; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=qTygxedOq+IlzYoqB+oYuVX7kMfHZfRittTikREAxok=;
 b=J/xJKJDc6I+thygOghHaTmqshGtviGNzanJupEdiusD5sCzjtt1iX9cLUG09lJmlworVc
 sTFS/Sm3pZyhdEZAJZyHqCnM1XQ8LXxUQj2dFumjoEpjEz36ryd5+qn1VHfdGLlZq70n+Qv
 kOvJ/1ErSHD3ijsEWXy+GYGRN6Oy1hk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 022973CE053
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 10:53:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E4043CCFCE
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 10:53:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CCBB21A00358
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 10:53:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770198802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oFuAbG1n+HbQmfTzBbbk+ARc9/lXgLk3knsntgjphsw=;
 b=RJ5m9hzP+GFksa0BQltjuoM74lh4xh6grcRqUwWsUtVMqZMYXVJ4ljx45LIQ2ozGyDsMbf
 206xjLkrKiAIVNYvWk4SzKKQr1feq9eaQ79gOh33EbFWGgzj/W6X5WdotxlvjUorIywKuR
 6HJcTbOQWhWYsJr7owdQjLAWehimfgE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-YkNxH9MJOOu2DWs_jn3j6A-1; Wed, 04 Feb 2026 04:53:20 -0500
X-MC-Unique: YkNxH9MJOOu2DWs_jn3j6A-1
X-Mimecast-MFC-AGG-ID: YkNxH9MJOOu2DWs_jn3j6A_1770198800
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a07fa318fdso6914625ad.0
 for <ltp@lists.linux.it>; Wed, 04 Feb 2026 01:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770198799; x=1770803599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFuAbG1n+HbQmfTzBbbk+ARc9/lXgLk3knsntgjphsw=;
 b=Fd+Fh83UyV5OpUpKLGWHrErjgLyISdzOFRd70I0bHHfu5PziNYPyfx3wx/ehJ2BTzQ
 dsbPV0zHafXSlEtJ/iU8xQBTcjr9A3ngq7eTYVcf6WsHiFMBLS6aQjmpCmTSQ/MrM3v3
 L9TUAoU6v+U9DZYHodhvI9OwEUccG4HR/TA7dhyDDFrxA404thEfQPA9q/l290Gc6Vej
 0USWQBk2s28VLFDCbXigk0nyyEYSbWthpYxCrtmUYgbG+w5ip7K8iq8uxNj8oYG5a6ys
 PQ1tQGHJ8TScm0hRD64C95iyilnvzrcT8nVUtW5kbH2SJxfq0LYstY113u/NvW/wMn8Q
 wH8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYqua/IcyBfvescMuH92gz4sFyHttoPKTCcM9P94X9d9fFbtrVGW61wyk/pS9LVBexe2U=@lists.linux.it
X-Gm-Message-State: AOJu0YwqlBZGja2pADZJQrUOTnR5SPkVtXYIo9jwHdRQbPck0MAkMWva
 zfRpBnJPFjPRTrQnkfSMtV7gmv/JL8SBysugGWsLIshk3bxtMLVoLwJkBHWHnkyvYooCEHcZCjz
 NBaZ/puuimgoCjo/wM2OktRng1z+us/brIwNwFblDondze92hRwzV
X-Gm-Gg: AZuq6aLx/h5/qBk6bAkVCyeZajkGuwzNOsBPO/O5u9DQ4TF//FzySdN9OgMvvid7TiK
 6c84z7Zu9pOxt4jJNidn2caqTvptkE8rVJT2Yv8P4u3VkNtdEcRHH1YxQzOtU34pgIatHxk8gOj
 dtWEdgB5mmJSnoQoKOG39YznpfyTiXhq2hL0SSdmpNHToL37B96a5Yf+9uAYUUSBjlfWgHOVZjn
 qXg+RQESSq/iFMhP2pj3R23i3531CDEJUAdd1MpRX5Z399ijEnA8gJPuyNTK4XDpD5k8B7hvqKF
 ti+I1TMeyQa5JxWQVFyrihfT/0Rgn7vI0gQtCKu7XfMQpJcAV+o2wNJPfpe3JBviT/lq45W4HOT
 eUa4O
X-Received: by 2002:a05:6a20:2447:b0:38d:f8e6:fc8b with SMTP id
 adf61e73a8af0-3937248a5d5mr2537641637.58.1770198799603; 
 Wed, 04 Feb 2026 01:53:19 -0800 (PST)
X-Received: by 2002:a05:6a20:2447:b0:38d:f8e6:fc8b with SMTP id
 adf61e73a8af0-3937248a5d5mr2537627637.58.1770198799182; 
 Wed, 04 Feb 2026 01:53:19 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c8506377esm1725677a12.25.2026.02.04.01.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 01:53:18 -0800 (PST)
Date: Wed, 4 Feb 2026 17:53:16 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aYMXDMKoSJkRWUrE@redhat.com>
References: <20260203094317.685385-1-vasileios.almpanis@virtuozzo.com>
 <DG596JIOEG2S.14PUR2IXLFTC5@suse.com> <aYMQ63RcLp5KdlVt@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <aYMQ63RcLp5KdlVt@yuki.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u9BGRX3NJ0-qCtKmpsB-dRiSiVs3YJyjEa7WuiJHcdU_1770198800
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] runltp: fix regex for disabled testcases
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
Cc: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Kirk has been stable for some time, I suppose that it's about the time
> we finally remove runltp from LTP.

+1

Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
