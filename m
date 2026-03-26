Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26650106F2FC
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 08:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774514355; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=AQ+0arMTCCO0qO4RK595pyQtAm3UojdozrF6P8ARA9c=;
 b=aES++iOjcfzozxMY30gh7ID1lPprscp05++Ayx8DyHKvgtuzTnA/q+OUDX/TcD6BFarLP
 niGvsZWWvCnKWoVYX0LcYojEyYdAw2ysDp9pCbgfqN2ik+mtrMKOebJAAqY7EeDpuMuFA3w
 8onPs2QAu9qTqF7fXBv2gBS5Bv8pBpc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35F4F3E222F
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 09:39:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB3B33DCACD
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 09:38:51 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2371E10006A3
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 09:38:51 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b4d734678so546884f8f.1
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 01:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774514330; x=1775119130; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=w5J87hJo++lLTa1ExApkTjBjeeHBS8GhCdI5lpGlXH4=;
 b=FOwYo7pd5vsvo7HoVlbMPd0N/7i0t/+FjmAWgqRE2m7W2GidC0b4lQy/2fDvq4MbBO
 UlO//MpkpuBfaE7AZWnuRVeDBDkTPhKiAGXUJietCbIuJNWuCv4u4m3W78bh8SlqBFXA
 w3T0ZudxMoifsv7M5ccHLB/d1fBEyMGvIlUzhpVplx4x7wZHGy/6Iv2q2ZCr40et0FvX
 IL4arL4hykFg4r/yPCXaRP1qTOuA5+F0Ewtv39P4smNCZBTGHAgX4u8trYRokRLsSfMh
 oF3lhzBh3LS3OvZwCf5K9+1BfdGexBff5cp0SEFpxevPEQKxds86+GA2ohRfn5cLFZmq
 /pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774514330; x=1775119130;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5J87hJo++lLTa1ExApkTjBjeeHBS8GhCdI5lpGlXH4=;
 b=eQ5TLEBtT8c9xwicu5jXsNNwnBf5ZpzfzdIbgXsRLnVmgy5Jvz5+RkEdTMM3NjzY/m
 5Ku6YlU1MJGQUfCkcinmMbQB6Flh3QD8ahCE+qm7b4u8EE/VAexJUsy8h7RaLcKe3WNy
 hOvlZrglU8P2EiujpQMrpndmvgmfm4VeGXEyCno5f7j9xwxOMCDomD5K6giUxQSjbBGI
 SPg3RTBkLvn6SZ5LwQhIUX1jZwWTtjP0dDVghDNZDYTPd7+l3bvFRfFw9QuHzqdY8kC3
 A24RJxeCVjH7ScwIiqdxuAgimDAGky5/QczLzhMf+E3PsF4dYbR/FN7XMAccIqqH6whm
 Qh+Q==
X-Gm-Message-State: AOJu0Yz9azUlwFYQoiTTIMtYPPkke1VypMLLuhpAMXKZQAiyc6KXuSOp
 8/osYU9ermiJ//lo2FiCVNm7faIodK0Qivyw2MPcH2kNu5j/ownUCYCfHGl+gsS/XQk=
X-Gm-Gg: ATEYQzx4aK7sVPQPshwxnO4FMZjsZ46SbXegMejfG664bo+iQeFqy7Sndi1U9X8XkVf
 btwi7izp2zfAzIKka6CrMEICiImddRjBfgzMDno8dbSrXI2eLcpMvcs8REo2kPygPNslVjNrrX8
 GXF6v/hzHHa+tbCRVguGoaJsGLrc7eYIedzcewWny5NiHXPHEAQoQPW8J7ESNqAKNUtRvOlOmIm
 uwXbrIud2NPwDn12YMZnqq8z59g4I0vqsdvO5N3sU0qmcVLUycc61ovqBX8nq3tUuGf/zR6SMq8
 O5GeY+xYcsoQV3I8AJXkQdF0eltVyaJikJ9pB4KPGvPr+zIV7fOo1DawsIyCKba8fApkrS/K3Pe
 UPPu5SuOYuXdqgtJe30qYPwItPPcn+/sbwSGFD98DarnB494yIrl6ni+72rPwEzjtzpI14qcaLM
 +R5SotuUrwLReV4FDtw8d4Pvu/fH4a0D+VbG1Ga9WmeWMKR27vgNMObbwYptl9W8xozeebIn6/S
 5iR5jL5k9Ey8+LIUj9SCLiYLHeEH2SY8jU=
X-Received: by 2002:a05:6000:2dc8:b0:43b:3d80:b0b7 with SMTP id
 ffacd0b85a97d-43b88a1c5afmr9574019f8f.42.1774514330421; 
 Thu, 26 Mar 2026 01:38:50 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919588e6sm5627295f8f.16.2026.03.26.01.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 01:38:50 -0700 (PDT)
Message-ID: <69c4f09a.df0a0220.10eb49.07d8@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <20260325154714.102467-1-rbranco@suse.de>
Date: Thu, 26 Mar 2026 08:38:49 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Minor fixes
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

Hi ricardo,

> +	if (page) {
> +		SAFE_MUNMAP(page, page_size);
> +		SAFE_MUNMAP(copy_page, page_size);
> +		page = NULL;
> +	}

This is gonna TBROK when copy_page is NULL. The same apply to all other
tests which are affected by the same bug.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
