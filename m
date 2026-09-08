Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B5FC79FA0
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 06:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788848871; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=VSDWH7XMowPqJvbdodjN8J9HQR0hLthYKZwsxIqSyuw=;
 b=aKrOswz7+WH8tTFzdbmfIK1P4NYr9aTHLPdrfx/Ylab7Kwl63H/gs2MK/N3OUffdniLj6
 aSxpfnkRdL8L6TNVgv9jcjchpP4fbFKnta0klR9aPUzvbeBNmNa9lnmyyfVSEzc143DjuQ3
 /A8vUQxNaZB9QomAODLaKHr4t3ZI8jY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 196413E2CB4
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 08:27:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 345113E57F8
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:27:31 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9DD581400C62
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:27:30 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so3143076f8f.1
 for <ltp@lists.linux.it>; Mon, 07 Sep 2026 23:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788848850; x=1789453650; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fyQK5ranp7m3qitOdQ2r4/ouTpq9xjDIrPPBlnEeTyA=;
 b=XwvYQXXDzw+W6SOcqIdNrKtxLfiuuFNaiCJGHj/ol2oLB5icT1zGX4/zqZqzBC0Adz
 W+7i++OMJ2BVYUv6k70AFV9jteqH1gp97nvknl47TvqljmaEUXtHjFb1IHp7EuazaObe
 v9S/ncXdb5C0WzexkEK/xJPyfcSTdU8qjxUdCzW9P+tE/co005jYOhLkpQKXF35U7sbs
 wi6m1v8zSkoX1C5c3jY0i/j6aYrfHLJqINlxdS4jENw0yJxuUhy9NR+sV5n/NgUDf2LU
 C5s2mfRG8CcSdixVD5g5xTl/6vHu8TcTnGSXuGYSM9xNWQoPPhx6divZkEdY/ixFerXa
 pHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788848850; x=1789453650;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fyQK5ranp7m3qitOdQ2r4/ouTpq9xjDIrPPBlnEeTyA=;
 b=DVmbi/7uhrc1uTnWD2P+C5Duu51dIunkuN3BnY+9CuiIWeh88tTeOxVVYnI6zQm5W/
 xaTrhdC3ooRunjBNoZ/Ap34VjeFqW6fVm5OdPz4cpN3z0kSh0ql6uJu7ZpXD9EUK9/PW
 jipIBp/9pi1Mjf6x6Ieqxr87eXwL9EptHg4itg5Jxu18sqE9MPXbRWzrQSU1+/4Hl9ih
 nCtMDv0sN2Tcv/FOIWxLK0hH3aPhyoGb3UifjIQJ4gcDcOjdW/f9fbTtXw1vf/cXsZ2o
 RYakT2anfUeVqT9sXtqKODk3/brIYvB5H0D66yALybRyxbZR10mcg0go6VOvTP0FCkgo
 hXhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/fucl4Z+/cUqV3gPrixnKQeKRqOAsMW72SsE9sCV0NSGFBK4QEM110RPuNRXKwzNkoBY=@lists.linux.it
X-Gm-Message-State: AFuF++nepReNx/MC6wErY9C4HJbN8oYQcTmP6XDCQrKXwhGNzVXFOVfC
 hjKlhW5F9p6fML/uwir5Nt4sJ0ZRs43P5HTeiqfPqHviycSIMaU5Mam5RmOIUhnwPRI=
X-Gm-Gg: AYBFou30971pyCT34ZZFOYAoEODl9Q4pqA0Npe2XMdT2f5oTPoVMTqUrafIexvTa354
 cDOAo2uwKdD00ETzKnhCGeVEo/MYHxhud5nwTX2Ia/c6Jdzb5guIzr14bsK1FwU7GhVTiJ6MLAD
 CPsUULPx++eEAX+dfPLk8Z3JNtSaCFVKLpMQImQTvYLsklNDo9M8RRaPc9Dow+UhLRrN09wpmil
 w7rKelw6imOSdYPeEa5G8mZTkAwCLfRiL989BIoPZFlPTbFVLB5a0KLvqDBR3HQZTvyeVLhnN4Y
 /IVeJe/U1Lk6fwI1NannRaBia0nJUh//i0PkT+1ReYkCU/P748ea8ApK0OWsjGZH5dVU2F3GLsy
 8pmyzGfyEbkWqMeZgJqshYmQ9+MDGUNMUekaJsgKxHkp1fm6WZIaa76n3Ayj8rM7otcWY8gmh1V
 0SljPaEOfSpaYyOtZDzDTXRKsJBs2JDlXmJMWOCabm3Jkli/hfVCN6FNWUBV4ArvuNhalYuLCX/
 wzRtPH9stz85Sq7+IeOsa3R815J+6mjQ895g0Kepo9DQovJiG53neMJfhpeni2g2WM9i/4SsrB+
 c7u2iA==
X-Received: by 2002:adf:fd81:0:b0:482:fbb0:a262 with SMTP id
 ffacd0b85a97d-485872abe78mr22162298f8f.20.1788848849947; 
 Mon, 07 Sep 2026 23:27:29 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d2693e8sm32710182f8f.3.2026.09.07.23.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 23:27:29 -0700 (PDT)
Message-ID: <6a9faad1.2b93268d.bc100.01a2@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260904122012.9088-1-linuxtestproject.agent@gmail.com>
Date: Tue, 08 Sep 2026 06:27:29 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] coredump01: New core_pattern specifiers test
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> --- [PATCH 2/2] ---
> 
> > 		} else if (ph[i].p_type == PT_LOAD) {
> > 			have_load = 1;
> > 		}
> 
> This only proves that a PT_LOAD header exists, not that its data is present.
> A short dump_emit() after the headers and notes leaves WCOREDUMP set, so a
> truncated core can pass every check here. Validate p_offset + p_filesz against
> core_len with overflow-safe arithmetic for every file-backed segment.

Sent a v8 fixing this

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
