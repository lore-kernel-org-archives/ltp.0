Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3891EFD9E30
	for <ltp@archiver.kernel.org>; Fri, 27 Feb 2026 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772161799; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=19Swd9zvC75ruO7IJMWHBYVttmRIBMStSNllZ5qeqkw=;
 b=LJUQKR/VlfUJUhsCHZvp3x/PmUzF6w/5dJ3iq5DKwO3pzAAFi2lOWB+U/tldI9LFjtrRi
 Odyy5liQCt2Zt5VI1N7q6Oxdh9/GwTtlHOkTgp8mchCuIpw0GX+PxJQDlPhPd7gQGlG5NEY
 5tiVdQoo0t3WXE2een+ShyZtL6On5M8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 766293CBD5D
	for <ltp@archiver.kernel.org>; Fri, 27 Feb 2026 04:09:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3878C3C1844
 for <ltp@lists.linux.it>; Fri, 27 Feb 2026 04:09:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 619D5600132
 for <ltp@lists.linux.it>; Fri, 27 Feb 2026 04:09:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772161773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JCEk9raIysVJTe5ZNy5MqPIzcO0Tx6ILf6ituIEagE8=;
 b=Jrmnkfq8nioV/sfcV0D5ZfPojEtIpCat9xpICxD8k1eNEb6k/ZqiXzGfn2RNUJh7fDgNsE
 w5mwFWoItxtPZN24udVBc6I9NCz6N2Abt82eWQGI9e1FDjZzQrRG253IJnukhyxOk0jn+6
 4rIKlx320QgW59jC3CUgnNTGRd59uso=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-jtoc_w_DPF-j_4Hv0voLgA-1; Thu, 26 Feb 2026 22:09:31 -0500
X-MC-Unique: jtoc_w_DPF-j_4Hv0voLgA-1
X-Mimecast-MFC-AGG-ID: jtoc_w_DPF-j_4Hv0voLgA_1772161770
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82739e0f53fso5037066b3a.1
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 19:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772161770; x=1772766570;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JCEk9raIysVJTe5ZNy5MqPIzcO0Tx6ILf6ituIEagE8=;
 b=Lh+JkiI4wWUJ8SbWiCKefL8F/2XKEfxlJib/bGFxGlxYjDevlu+CL0tcwG9VsjebCB
 KkPoP8+l8W83Gb9Wx08UVMKiCA8StBd21g8M5ye4hv3K7E7cgf+zzDhyYEbeWEAP//Pk
 dNuTBbV0azb4SvvN84rSBkUcQigsjYfVqgq8uPIWTfI946yyxpLk0GJRWCBEc2E8RBfV
 d5Ypn/UdhMtXWA61NyX7YOyDMRVcoyAeGAy5akprHmwxDj2Qh91uDwBPpFRql7xLUm7I
 S0nxpjGaEjnXhA90elsp0rWbjPc/Gsb/CboWEi8FbVLYeLoVxLESETahppfGk6bdokJN
 WSBQ==
X-Gm-Message-State: AOJu0YxrFxwfxzoyXihF/uy9aDYq8O023MYRK0QIOo3dKkeVxL29sPMk
 VS7qEuF1CKv8tH6STcjfqquZbWn7qRNs/jhetySmCp+VdIgW4UkAGZR1TvN5Ssb0ABvEj8lXSGk
 XgDYE9PatBUxsw4l0hlQZJuSboGb9WD4s6FeKsX0ek28gu6R9mnOxHWNiP85/
X-Gm-Gg: ATEYQzxxqUs5bD+IDOslml4jNB+sY5iqpwA4kywHprFO4nipaoQc45WdJ5WSZ1CZirc
 5GDbgPymyV7d6dIgvu0T30WnjLwC601tseZ1fDutKj6iSpe/eHT6xR2etimD2cCX+ip/JMfrmDZ
 RMMsz5fNHcWe1Es6BA2K6tygAeb4lUonGmIGKDokP04hm55zgIXHpvpHIcwXxTUY460Q92FksuQ
 U4FL8cLAHK30HRtOx0XGqCqCGXPjswu4VmguM2ocpO3azZHLcUcEssh9Me1tdPOdIhZhfhGkyDU
 ceXwfrPr/ALYvUWxDa821mRavo7lFJCwwbhUwrL6LT3S0V0nIDJW5dNEqybUFz07RiUcRrZagEM
 qfp0m6caP17klnbpR
X-Received: by 2002:a05:6a00:1825:b0:823:108c:5bae with SMTP id
 d2e1a72fcca58-8274d908242mr1403431b3a.8.1772161769882; 
 Thu, 26 Feb 2026 19:09:29 -0800 (PST)
X-Received: by 2002:a05:6a00:1825:b0:823:108c:5bae with SMTP id
 d2e1a72fcca58-8274d908242mr1403407b3a.8.1772161769524; 
 Thu, 26 Feb 2026 19:09:29 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8273a059e89sm3630384b3a.60.2026.02.26.19.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 19:09:28 -0800 (PST)
Date: Fri, 27 Feb 2026 11:09:26 +0800
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <aaEK5hCnkPGedhQV@redhat.com>
References: <20260226155929.3500-1-always.starving0@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20260226155929.3500-1-always.starving0@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n5bj5yjAShOxfkiqy48pEsHGkBeGNkZh9cI2nU3OFmg_1772161770
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open: clean up make check findings
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


Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
