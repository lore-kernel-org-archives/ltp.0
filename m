Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50650D7308A
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 03:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775186637; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xWEn9weeSSmxQtDyzN7k7L/g2pBmPtVVGyQqySShmSc=;
 b=JIzXDTk1vuIwL6umgZt8cQjBBlXg9ES3pW+dJ9Y/cn075G6TsN6xxVR8z6bV8xppD1Gsq
 QSkC2Nx1HeFbUrsKiRlZ4jBgvOBJWoGTuwGTS24CF5EvZNrLxfu9qsmGftmlPPffgqsz9+b
 ZBTHzuj8Ssv8SpyXBUfuJ04daU6ebJo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E04D33E54DB
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 05:23:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74CDD3E2389
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 05:23:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CC52E1A0121F
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 05:23:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775186610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kvZVHSIe5cvy72J25zuHPRVHh63z3EjPpHUi5E+LpGw=;
 b=BIVMi4FnM/NHovOksNd/wEerbGT2d+Bd2KMpp26xkumYxmRGCGOiKyqfzCD+fQLPdd7hB9
 ulTmVk0snGPnsmqO8JIsrU400T4s2JkMFXqomwC7B21/Ug/nRYI0xk/+BreNpMdcplvwNN
 0wag+P2BJ6I5wFYcoQTqAoPeS9G5PXE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-AfKdTMgpPRS6s_P7zMdFHg-1; Thu, 02 Apr 2026 23:23:29 -0400
X-MC-Unique: AfKdTMgpPRS6s_P7zMdFHg-1
X-Mimecast-MFC-AGG-ID: AfKdTMgpPRS6s_P7zMdFHg_1775186608
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b242062308so34608435ad.2
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 20:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775186608; x=1775791408;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvZVHSIe5cvy72J25zuHPRVHh63z3EjPpHUi5E+LpGw=;
 b=WQfHd83tqSO0lOpguEx2u6s9Xm4pZzTVm+H6OKf0ENbPvk8q0hOc2Tr4SHcW3ifBpO
 QHFlkd+HT3lfKGrh55JMamgn0mtqg1sK5BqQVn3DtTwjWwnhfXyD3nGofKFNBrLaWkKv
 GfnNqvQCepHt14ns2FvFod9JgqsRNr3QTmvNDQDhrMtRAFbaZsGx2QfqeEGRmtFoGau5
 5EV1+L90vKOEDdtb7bwH6Bz09ojgSZXuJv52Q1miMtsGjC6OssIzAz3nrf/oT+LEmJPo
 JB4DslNt0yyMr81kUdLEFEzdRt7QME9crapDR5whvU44ecYPOF2YCz2N4NInPOn6YcwT
 0Atg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcYhEEXa3S4Fff8FSHJpDlzBZQDCaYE5lgFLpyHIx1AvMSfDVdnW9gSRkR8RIsL2/ZtF0=@lists.linux.it
X-Gm-Message-State: AOJu0YwxfLrexR3w/8q4JJaY5GGYJlBPbnOuNHHmE5JnX8A6ADgWVGU6
 63Cq3HF9mWEEt7Lf+ovocFTK2IZgnmZXeIg+ZvUWAuBTG/rQbu4yKN5QX8QBQjCce4edNuIMfEx
 95RMhdxDWbu/8JCKtzw16nHmhMGR+HAFRRLg1EMwzv3PPF+DlQY2K
X-Gm-Gg: AeBDieuvJbSb/vefkh/Q07op02SbTUpcoXaf3rRCInPVzfOELMjXJiNHHZsjXyvbHHl
 aal9G/D39vspElx7pWG58fvn+3kfRZSxUhrPdYkZZZOktqhMgf9jIEBVqCaVptozaHB5G66Y+tj
 uMegwPspzDOO4CUIig6PL6YfrNtvy+s1Qi7/A01a0BOhGYgmZdcytrIX26sxFGSXbpQw8qj6WEg
 I9T/jCf0bgCW7wk0g+jHDPXflno1OL2k5WRQ/H6b1lNXlLJEs/368NKFq1R/7/EXJe4SSjZw3BP
 Vm5YyykNHuj2lNI2MhMRJph+3MU+OsIp4jKP8z818sZ+TAciONdsqXml/9+tzB572YLDbTpYLuw
 fARhCAucRtUA5ro2LjA==
X-Received: by 2002:a17:903:3204:b0:2b0:6a22:5165 with SMTP id
 d9443c01a7336-2b2818280c3mr16582065ad.7.1775186608036; 
 Thu, 02 Apr 2026 20:23:28 -0700 (PDT)
X-Received: by 2002:a17:903:3204:b0:2b0:6a22:5165 with SMTP id
 d9443c01a7336-2b2818280c3mr16581785ad.7.1775186607560; 
 Thu, 02 Apr 2026 20:23:27 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749a4091sm45659225ad.64.2026.04.02.20.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 20:23:26 -0700 (PDT)
Date: Fri, 3 Apr 2026 11:23:23 +0800
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <ac8yq1ir6r_9Q6C9@redhat.com>
References: <20260331200026.244979-1-japo@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20260331200026.244979-1-japo@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HEAHurfJWFPHjZQ8HtcPFOvpyVMP2DxkJl21v3342vM_1775186608
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] editorconfig: add consistent formatting
 rules for LTP
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is a nice improvement, patch merged, thanks!

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
