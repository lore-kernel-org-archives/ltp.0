Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE04DEFB7F9
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 08:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771921091; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=F/Ts/EOoYmQ63Y4EcjG7uYSiBKttSf2ZxoWtK1jeZ0g=;
 b=esTsYcL5IkPqpGHgk4vhQHRUuF+fPYi8xHy8YrjI7ddMBDIHda3hZ8WqWgoGvTiiJRl4I
 S5lLr5rGj6GVMKHUwUK3NRfaGoBvV0QaeMYj33lVzl+mIwywfY6updLLISU4NVEuMuDZWz/
 ETu4c2N1BsHTLPXAAmwDSiVrYd/WpM0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 819D33D0F7E
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 09:18:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35AB93C2C22
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:17:47 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 12DE41A00808
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:17:46 +0100 (CET)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-436e87589e8so4922529f8f.3
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 00:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771921065; x=1772525865; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMJhfe8bLoOGGGRHn0B8LSXBRpxLGbIzyGz7T0liZOY=;
 b=eZUtIRT6xfz6AfTRXoiVxsAOcwZBou85bY605w/7X1NxAd9Y2snJmoH7TygZdMpx3C
 8HFF6TbLbjH7b/WM9wCu8ojptLKDijVofYZgWKHmovwwFZYDskuXjalDR5QVo27emDgu
 EmXrZxbmda+s4Ds33wBrbByIUl6iJsUVBjucc5K3oNAcS1vvLaq9+pC+6kAj3iAXW/Kr
 T3GGER4dFHT2P+dmlXnCo52pi8JIrPAKSvCXOmvkA65hsm5FVNzlg8q0h9KlIAUi07by
 GY9ETGCNSKoj7TCy6U4wKOLQdJXs3QkUBU3d/eQts6fw9Vk5hTFmCnGM2GwzjZ4KPaBB
 DFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771921065; x=1772525865;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sMJhfe8bLoOGGGRHn0B8LSXBRpxLGbIzyGz7T0liZOY=;
 b=SH8+jHWln7idcrc+Obdd35adiJ/RiBcaq5ZkPbwTd7wmGDbpAey6ory9cVKQWdn5C/
 L+uBPzeSxuj6MggHliL8ZW2NPq8Jiva9fpVQkqDf+fCPBQfT3T/HJ3vSeps/ayIqK6nc
 xd5bukxXAf1qnfAPw0w3gxWwNbfpGmCT7G5f05jL9JR00hHbyG3Xw9BCtnG22fgWrcb9
 nUT7ih2A3foXsHIVrSikyf2RqRzJloPhFXYF4qSVNIEKjrKGRiXMr5g53V6ICc/aRyGQ
 FdVW9F9e4z+ihKOhGuC/3ScJjszngDsyrLBWW+Xdu5g6E29sYCaRrjBceamrStJkHmPW
 eQjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHKyHOA3qXZkLnwJEwcNJDsqLE4fOdHd7B9r1+EwULBNGqAY6VFv7KtVyvQ4NkRUFyPNY=@lists.linux.it
X-Gm-Message-State: AOJu0YySiFy40XjP4fefJnb27lOI6i8ZZIWnNv6Y0jSRFPNwL0GeOQLt
 DC4WKoOWnO4yppmm68CJy5+7e1T8c5/YZz7przq0w49jAQ1GXgd6Y87GzWalT9UBD9I=
X-Gm-Gg: ATEYQzyBPI2OMcBqq1JMfMvroggR9RmgjLP1CFfvBmiWJksYs/fX0v0fTPNSOdU7UNT
 uoUGMGCR7yme37bCuqbjCUQ95HA2dI8TXrHId3t8xQoC8J5RMv3nWLsuTCOGtcSGzEV6jJMlNcH
 AhGsYK3utYIxPdk+XF5AVUGFJatcK3OstvqPe0PckZDI/Er5UdNi1r4NCzGuv9+LCV7f4Kfq4fY
 NNJbRsbolH5b3WdUhus6gCx1xjcpw+HgeGaJQvKCU5VOJ05w8ePlOXMj8ih1rMomrbANjDXgefW
 lgL0JA1REZ4F6v0z8rm4je2iDMq+s8Ff1gnkbecYRWVFw2dzLUrNbsKIJsQK3VKBNPb47/3BWob
 OSoebJneAU0jbMDo06TBEkg6YIQ9dLwadg+8QhOJRCPd7GKxuyLaBSlXYQLpl6oWzsAkYTn/jHJ
 cAaSzRgb3MV5F7V2J1jr1J9wQvQPZfcX0dhCo7NTcqLk5BUOMaNwQv0vlHi9x9RBrceNZ1XeUrj
 mYI48a+J+1kmjz+qKI=
X-Received: by 2002:a05:6000:24c9:b0:439:8913:baa with SMTP id
 ffacd0b85a97d-43989130cc2mr1091537f8f.53.1771921065348; 
 Tue, 24 Feb 2026 00:17:45 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43986aa2f84sm2547445f8f.7.2026.02.24.00.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 00:17:45 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 24 Feb 2026 09:17:44 +0100
Message-Id: <DGN1LFH0ULK0.3D30H8MFVV9GM@suse.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, <chrubis@suse.cz>,
 <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <aZg8NDoUFezK-WTE@yuki.lan>
 <20260224073734.34802-1-always.starving0@gmail.com>
In-Reply-To: <20260224073734.34802-1-always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] open: remove O_DIRECTORY case (move to fstat
 test)
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

The patch is not compiling. Please verify that patch is applicable
before sending it:

https://patchwork.ozlabs.org/project/ltp/list/?series=493107&state=*
https://linux-test-project.readthedocs.io/en/latest/developers/writing_tests.html#testing-builds-with-github-actions

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
