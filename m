Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4D8C624A5
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788163523; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=zaCYP1meOzbAYbPgV3swvW6J4lslu3XqgUtLEc9Iz3k=;
 b=mOAWdNzW7wUdfE6+W5VOxPpUHDmcZ8ehYkG3lnxVZUfykJBtko8aRY3d0CgLmfclK/zn0
 7+9m+K5AzOJaLgGmME3NMroc85dC+7YU9Efy76R1R7HqNiXrwGxqZ5gGZDLBQ9dRg+AdJ3V
 l/zHkXdIYjTNQjvbkP3mAKPEI+nqusI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 851EE3E59C9
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:05:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CD203CE1C1
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:03:01 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 15EA8600444
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:03:01 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so1912351f8f.0
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 01:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788163380; x=1788768180; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mlAsk53q6Yisg87tMEERAKD4INYHCJWUgjAEh5Jz8cs=;
 b=cHcHcarx5zgpCxT+KrYp24f9+MzyCu1D/CSP+typwgzW5KHdqCyoi26gutvFfooKtZ
 1EBNhCDDvjY2MfOfPkdTJVGcxUCQ2qC7+4K+2T3c/szT2JkHR4+OjolNreAXBADMpvAg
 6OtLIt1yEegjQ7Z/Bvaido9naMS3Rc7p1xnhgXEiLzKhJVFOrbSwfyMPnJYv7vtcN1XR
 vNE28kI3uvYL6ar2BHc1lPC/ty73HlBvJI4l4CUWtUP6Lnidi7Upp2H22lHPZBZqLu9d
 +l+HE/nkb917cK05kl96VzogMUSdQZ1qN4d777Do/gFw0IdamVobQOYWElhdcvLu5e1K
 3hPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788163380; x=1788768180;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mlAsk53q6Yisg87tMEERAKD4INYHCJWUgjAEh5Jz8cs=;
 b=K78J9qrNrsPYjuosRlrq4t5eJjXrUiDibZgcwkyaPjVjL9Pbe8JSxb80tBJCElKrEf
 HttTY4MQckiHO8qbu3SIzZD3boiG8pZXf3aHgYaj/shvJ58D9thM7zP0sOCBrwIXFbas
 FGlyVSWRb+LQBB/DhYqa7LpoC40Mn3ngM0YAdfIRbyxKEy3q3dPa7u+No2r+D8hcz2Kt
 EnehzUJPZL+qbpfn4sACfvnQih3UWFMjCwjNvg9Isa6fzVE3EX1ABo1WRLK5vANmxLKW
 YnphbzYoX+PO32rfPM6gKCjwYeKjf8xNZuIY+XQuLn7SETuw7FUS6meyefuKPu65yy5d
 OrSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByuLFBCLNXIVlaZzQs6mmNWWueMOxEcMvZUVXWhpnB0eG/Iw+QO4WuL12Yp91MLrgfeCMU=@lists.linux.it
X-Gm-Message-State: AFuF++n1zhPZ2y7wlT1fw+4ipIK6ed80sUsacdjXfjBWLipA3r8UZoFH
 tXMOErj8Wse/R9aS4n03pvjVB0Bto7YlsQrZ4EmDQtvk9sINZJGC3SIk4ivtxdGyaw0GypGG7NP
 QScyas//v/g==
X-Gm-Gg: AYBFou0rRHBilmvSfUiDLfZS/PJj+SJ7kzV/GegvlCb3b4NCizB1lSVYXtmUcgofZ7z
 RmXbfY1pmQvU6cafxO3CMeY965yuj2wyEqAEuSCggQoodNoZ60yIIMSEefs/RxZyvHUXOKg7AYC
 hCVVNdvPar8FMKUORKzrYOJr7ABh9O/c9CftdgUac+HcvM4drSsj6S5pbIjZDqmHYjYDb4/iocq
 T21wdQbHvS3wCf/wMs+21gZesCBYdtDU/+qP3sSXKTX1t30e8kmrsAaS6PCzOEhS44L1h2soR3U
 5OY8g9ofcZhLepIrNuB8Dx9KBBYaQL7dNr3GmVca0HMNRTNomQHzIoq5HYiIqwYfN9nDV9/P942
 2yMX6Ecyo75UsyTeXiwSUujKmg/GvHDOuI1G5pbPF9TbhMH+wazTlVHqWDkFKoMZHxcxaGH/UIU
 IRq/ekWWlAY08zt9sSuVtV8OICPRWI4LZCieaHkWPZg5f0izP5i6SMTk90YI6YjlUzxdi0PBOKE
 YJ0xGXpX672SdHixg5xe30kfOUK92ljMcdIQEQfOOAH0Oxvx04vzqEvn8nD3/PuJRyslFE=
X-Received: by 2002:a05:6000:18a6:b0:482:f724:f4ba with SMTP id
 ffacd0b85a97d-482f79de104mr34009287f8f.19.1788163380385; 
 Mon, 31 Aug 2026 01:03:00 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2005esm21071985f8f.24.2026.08.31.01.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:03:00 -0700 (PDT)
Message-ID: <6a953534.332d3c56.285eb4.38cf@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260828211038.8829-1-linuxtestproject.agent@gmail.com>
Date: Mon, 31 Aug 2026 08:02:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/mmap: add MAP_32BIT fallback
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

> On Aug 28, 2026, Andrea Cervesato wrote:
> > lapi/mmap: add MAP_32BIT fallback
> 
> --- [PATCH 3/3] ---
> 
> >  * - Verify that memory in each chunk is readable and writable
> > [...]
> > 		((char *)addr)[0] = 'a';
> > 		((char *)addr)[CHUNK_SZ - 1] = 'z';
> 
> The algorithm says that each chunk is verified to be both readable and
> writable, but these statements only write to the mapping. Could the test
> read and compare the stored bytes, or should the readability claim be
> removed?

this simply requires:

* - Touch first and last byte of each chunk to ensure pages are writable

will add before merge.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
