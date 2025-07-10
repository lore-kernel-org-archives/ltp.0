Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDB1C83F17
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 21:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752183349; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nY7DRCcuPc0GqYTp7TiVF2zJ5sjfF6G0WOYdvgRyzwc=;
 b=GkkWkWsJNt5Pv1GEY9K+9R/vamVLnu5YVlVIc02BwzCjKh14pJ2e1JkUZHtP81eNCIVXa
 VMAvVmbhS9cwY9HZpORO8/YRI92KpFWhgcOtz/YxESFxVIapMBgV7kkDz+ujbYNxm3jhsdb
 /85//rtMOSiqSTV50KuH+pA19n60yY8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 608783CB22B
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 23:35:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BAD03C2122
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 23:35:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 61B26600872
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 23:35:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752183326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iaBfKo6RTURXx0ELoqzRXhrZeBlqCrRUjKsjoFtffO8=;
 b=GqZwSDFGJt1uV5F+shM7y4GSI7Ynnk9d/tY9zqjksRs4GqKsfogYkn/XZnVrxyIxXW70mo
 39Reb0SPN/brtlHXcq7soHOYDk5F57fSqxMD/IR4C0bvInGF/5SGGUGyMTMPHi8WIfpuOC
 4tcsWTbgkl1fUBLLC8iIzlSmqVqGAg8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-sbiXOQgoMI26Gv2t5BLJzg-1; Thu, 10 Jul 2025 17:35:24 -0400
X-MC-Unique: sbiXOQgoMI26Gv2t5BLJzg-1
X-Mimecast-MFC-AGG-ID: sbiXOQgoMI26Gv2t5BLJzg_1752183324
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b3ba7659210so1071005a12.2
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 14:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752183324; x=1752788124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaBfKo6RTURXx0ELoqzRXhrZeBlqCrRUjKsjoFtffO8=;
 b=XtEL64IMarEAnuvKSZXVsCKOEW5lgwFQZ4VkqgezUnyRAK2kJs6HNDVoqrFM/PHdoF
 n6TwJWP4Y7YwHYwl1qpcBmwOfyRalWMDIHwgOVx/baRqet/KNe0vivwn6jmEYkrj0nJc
 14JEw59V7iI+8mLyecHp514vUq3je7PINCgJKqLmrlqntfi7sMF+TPFyC1oH0++eq+s4
 5LHATWSThedMaOozBF/Rm+7E4GPioApaRDlXXD+5fgzN1LNiXvfUDXGS21j3FJvpFQ0X
 8A0FOFAan72yXPEynw6nCyIAA/riotbu67rUq++BBqrHyaVXHsi8mrCL1ha2zGi7IGDQ
 sM3g==
X-Gm-Message-State: AOJu0YxeG6XYYNF3cLblSSViVHetIUee7hl5MZ+CpSVQF73d6q61Qflw
 LklfWi87U2WXOfArr8lWTexCyuYYCViZBl+WS7XMB2BmneKZT4rYeNn9V0nmD9OMWzkN1wBmAOy
 zQ9j0clrrrH62gmu9fI+ci6Pt/a+ymM3bUBx+UqZlVJojS1eULZXf
X-Gm-Gg: ASbGncvcHxZoXb8x17JVzdEyCyModB3NVJ7+9yV7PlpO22ypCCeLoENFG+p8XxMXYP9
 32gXY1etjpY2polzmqSg4eCZzuftGVpmCDtl0KfaKL9LNw7VYDB2enhd3PQh7UK/HnStAVtCuy+
 01K7cOo8fVrr2TaqGHNyP/BhZ/I5AuN1KhMmwcgpCEfPYqCWuuCoL/xSsnKpTh8hYHdpQmM8en4
 Na4SKEGGwZexNIwn8n97Hu0gSCzvmyA0GpdymPvQI4HBHC3VBU6i5T8zc4kBq8XEs0qTMjb5EFr
 hI5nqZTqj6GhK8ndKHTqmqZGr9k4mxZ+2wICwPR94VYRpM1wo/D9RSkGaA/gDfY=
X-Received: by 2002:a05:6a20:729b:b0:220:245d:a30b with SMTP id
 adf61e73a8af0-23137486db2mr862810637.38.1752183323803; 
 Thu, 10 Jul 2025 14:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdHCen5U/vcKYd5k+M7BFtCd/TiNc1E7UuneOXsmwYQtJq/FI1F7p51ixunctm4wXH2U/N8w==
X-Received: by 2002:a05:6a20:729b:b0:220:245d:a30b with SMTP id
 adf61e73a8af0-23137486db2mr862777637.38.1752183323224; 
 Thu, 10 Jul 2025 14:35:23 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9dd5ccesm3351499b3a.27.2025.07.10.14.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 14:35:22 -0700 (PDT)
Date: Fri, 11 Jul 2025 05:35:19 +0800
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250710213519.pqmh42fbpw7nf4ji@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250708055950.m25zfqyfr4n4qkcm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <c5247046-97ab-4d21-aacc-e4018ed4a366@suse.com>
MIME-Version: 1.0
In-Reply-To: <c5247046-97ab-4d21-aacc-e4018ed4a366@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: On9CvCqCezaUpkJxSwbjaDp3enHj5-WP_WnS9moUCp8_1752183324
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Bug report] kirk can't run ltp's fs_readonly
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
From: Zorro Lang via ltp <ltp@lists.linux.it>
Reply-To: Zorro Lang <zlang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jul 08, 2025 at 10:59:22AM +0200, Andrea Cervesato wrote:
> Hi!
> 
> fixed by https://github.com/linux-test-project/kirk/pull/61

Thanks! That's helpful :)

> 
> - Andrea
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
