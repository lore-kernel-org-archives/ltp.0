Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC55BCAC5AC
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 00:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758674629; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=MvOgtiaWMn1TeZb+5CH3rxjBckEbRwF43qpghqQhzgA=;
 b=Yu8g7Cy7VoBKmqQHgbOITJ5M7p9JV7YSIsLnX8turfips9hhIqqy9APILNnlRhlkFBhmI
 vXJsKTle6dBNb/RPOcnBWCzD/nkDsOEXk7wd7KrIElRmCJ3EtbfAmsgL4dCw5dakjr5SK9V
 NS8cpLjl9D+acYpow0thVSNtCGmkmrM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE4B73CDECE
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 02:43:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 694473CDB61
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 02:43:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A703F2001A8
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 02:43:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758674606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W+mtm7eAXj+4dyUh52SKSzbWwVtbSd96nXIxlWWsxXY=;
 b=gDCq5Mw/RGKg/gHc3b/KRo5yuxFeAWXcGIy0CTtmwM94chWh6K1cPtOyzxs7k9jnnxeg8n
 FdJK2wG6bQeNOgqvRDiV2nH1JcO3nhUVnzd9Kh0SFKXfoeTVvEh1d+oJ3KUjX54uWUVij+
 5dyQqBWs7lZWR/QD8qpxcaAvQiHqvT8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-DPfWEFVvMzypnccH82E2fw-1; Tue, 23 Sep 2025 20:43:24 -0400
X-MC-Unique: DPfWEFVvMzypnccH82E2fw-1
X-Mimecast-MFC-AGG-ID: DPfWEFVvMzypnccH82E2fw_1758674603
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2697410e7f9so114992405ad.2
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 17:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758674603; x=1759279403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W+mtm7eAXj+4dyUh52SKSzbWwVtbSd96nXIxlWWsxXY=;
 b=Oom0KjLs8p8V+7rrjciWGbIO/jY0UNd8SOxfZDhV+lmwORhNoJuZKuDqdg5Xv4GkB9
 840RzkwWkxfUMChpGdko8wqRaemTz+4IdxF+mX4buFn4l5IepBQR0ck0ZkBCA+ntyQCy
 ApYbDkNcJp35fDsY3yrk8esR6QRXxEkDbipY/boi0JjMeZRm5TGB8w2YIG4JpTPXrufC
 XspBH+JSQsPL/YjjyO1y6wwAKOEtWWIKjS0IdcaEfxBIGZS7lkJ5oLd88J3EGJ6y3YG2
 6iQFtTfnkRAtb0M/Ies4wwAmJnVy8xwZrLkWlGLzgTLgnZtO3bNUKzZrILVqMYQL/EWM
 svrA==
X-Gm-Message-State: AOJu0YxyCreitylW8ZCPUA64BpIbYduq4iKu9Sd+NTVH1xVPMD2n4ILz
 tFYefIsbn0vzEOBNXWxCMkOuZ93o4WzN1rJxmEFkAaTyYkGooZECVq7ZCISyJwYCFn+DJOxk2lb
 NrHtN2I2YQAIV5S+uvPpTycWDgzXjYCHmZYZnFbm5mW1TPMUTVB1qy1KeqKj/ZUS3WBwfdbBQrb
 rEiN8KVPc4OnDbf9q5aeBFQePriDQ=
X-Gm-Gg: ASbGncugZjTQzwhFUVnJNS6E93iO6fa+bia5ibrK5tJmD/JYeC5GgZPCNctnFzEuNQE
 1wlqN1LdEwk0uBUPJAfui/X3GYBVRp3kIpJvvxGT08Bi6HHznX37kjqLSIeE8nH0o3Ae8y/lK4C
 QAZjKYXJQXJnCGbKacIa5wIw==
X-Received: by 2002:a17:903:2ac5:b0:24c:cb60:f6f0 with SMTP id
 d9443c01a7336-27cc836c460mr52218195ad.58.1758674603381; 
 Tue, 23 Sep 2025 17:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/4/bcodAgxVdopdGosZBSZrKBvn2+26Jpw9595VuwMj6lXY3zNw1BwJKXtLo/cvZGzYD/GK2rKjqPEADdOrQ=
X-Received: by 2002:a17:903:2ac5:b0:24c:cb60:f6f0 with SMTP id
 d9443c01a7336-27cc836c460mr52218005ad.58.1758674603012; Tue, 23 Sep 2025
 17:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250917075729.30093-1-liwang@redhat.com>
 <20250923110732.GA9158@pevik>
In-Reply-To: <20250923110732.GA9158@pevik>
Date: Wed, 24 Sep 2025 08:43:11 +0800
X-Gm-Features: AS18NWAg_n_anEcl69TF6A1AS4WMUwx8LKLgaDv5qI0XL9nn1A6Rv9ZTmt4rpDA
Message-ID: <CAEemH2fCH=1YJkgdgYFx0C8mqqnbkuoBnKVpgLiKpUHwbt_ibg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3krabb8NGVMWJEU7xkqXBf3_hcfWNUKuk818nwzpv04_1758674603
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] mmap22: Improve MAP_DROPPABLE test stability
 using mincore()
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

Merged as you suggested, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
