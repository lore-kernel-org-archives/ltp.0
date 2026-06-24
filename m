Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8857CDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782295198; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=dlXyRZIUTeqz4Zbi17gLa8wnHCGHwH/aPBCHce9hMZsEufyuw6ABw5W9lqViX4cTW2ui7
 lNxUxtdkNOEbHza4b8GXLEWupUJs+NwDZPbxhskPgbZZ1O2uJCuRHwQ+R6YRl/6+Gy7zKj/
 Yptzw3vrUKJp/I9kGyJBFXXdOfxAu7o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 292673E5335
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:59:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13A133C9E1F
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:59:37 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 653F660080F
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:59:37 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4924593f45dso8886165e9.1
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 02:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782295177; x=1782899977; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=YvhQOVepzwiFiNpLrCMGctWmAtqd45oaWs2hVRXIGosX6VCMKVx7E4/XHPNMRCWb8c
 yttOE/ocPm76ezXhlH0eecti42hI6fT/k+1sj0TqyLXGz1i/ej86UU6xjHEQT6Ow7YhE
 hzv3iOl08HhHd8J5JUkLEiFR4cmBXDLQIhyLaCtapDZoc+ffQSSA2PwwglKPvfTIP9Ke
 IBnCpDbKoDZ9XyR5dWhT6wKtsADI2GKGeMdA1U9xQ1Ltn3MsTH80JL+56xq+XR12+FYY
 5IBToGS5EjEyJR/+TXjS7zFH0oXp1JSeCrLy/hBsNz/nLq+abr5BHVZhe7Z9bII5Fine
 8AAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782295177; x=1782899977;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=WJa9fOdSKEur8Bg6HYALXQW5cOO+T7J9FB79ZdVmPQ/TMjdjc9SGzQ65fko8V9LDfW
 lxXTaJkr4KpPHBXBv732or/lzo6aJB5bt6mI03SYMz6zcyBl0ZbmE0xuqP/WhhVMY5SB
 V/jC4cwxoPG4wpvMX95/tGNm1cWuxaIagMVesZDGpBfIIbFSvh2c+G17L4sJyupGxTSR
 zgKR2VeB9UGwlfXZ4pwu3SUU+VRAb2K6Sqd3b9lpCF8zxJJTfI0JUn02A6Bpt/vmSi/A
 PubE2YO9Q+yH/HB1NaIcTKrZL7ogkN5odbvhBqjRMu8NAfhJH4ts+RA7sSax/D88vDln
 e6sQ==
X-Gm-Message-State: AOJu0YyvWf4JdRczLHbuyNB2D0TRCy+1nsDIgc57CiIMm9Fefhfy9jK1
 RWRvd3l73m+TNxT1rHSgaLkW0c2Vl5Q8LdKHaqKIlNp8RIxEGE1/Vb0NT8e6wgbdQWs=
X-Gm-Gg: AfdE7cnTNqqPaNDmxXVisEPg8Yq3Qjm4KxiBGBOShcrZbFaGTu+7pLUnY9/d1c0XXZm
 JKjJmE9WblZFHqUMXyA1E8On4JhRslEUtXWddZVfZyF4NK8AYToqjiQc7U2Dbtp5bN1FicqCK16
 11a+tPdafssZHjdTl5rfxiZ+19G9UQQ35m9Ok69csmCqgiVjylbpfJghGWYk1TCISyt7buUSx5n
 pNuz0TBjDNAKmGSlHuYhuKN0d1IwiHqbcO9PegMjXUAgiFyRA3Ye70c4os4suN2PxDfXJdMYMTR
 5M0vy+ZwrKmwSa7SSH1oTfNSNZ1Gzdv9v579VKlRM2NOPQjSZT5ZPNvDnP9GkxZlT6ePf3NIOPb
 RVdrYLhnJgO1UvFixWAOOCN9e0u+TktIRs9p6AqwIs/I+KnHEb08+23MDhrLYGiDVHMFi0Nedjb
 ZczV7xnVnalEbiRiqXvt0CvK4256pfKnP+RPXtVqtkh5Nrm+vmiy9vGtcthfoxJB7qj2Yo2Ieeg
 /W3/1bE8Okp8004liuYOJJHzaMzEYSA+Ln+S+YBY37xZVhiinj2vFMiCQV2ke5+Ndc=
X-Received: by 2002:a05:600c:3f07:b0:492:451c:cc1c with SMTP id
 5b1f17b1804b1-4926086ed5fmr36532705e9.24.1782295176665; 
 Wed, 24 Jun 2026 02:59:36 -0700 (PDT)
Received: from p200300ef2f13eb007ed17b715703ca11.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279b85csm5016732f8f.28.2026.06.24.02.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 02:59:36 -0700 (PDT)
Message-ID: <6a3baa88.795e137c.374e2a.0ace@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-3-chrubis@suse.cz>
Date: Wed, 24 Jun 2026 09:59:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 02/13] keyctl01.sh: Rewrite to the new shell
 library
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
