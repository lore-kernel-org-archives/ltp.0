Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725FFC61DD6
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788518288; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=lb1EYrVwkF5Z9LUc32j3yt+eYPmmrCouuNEc1OuUcktfnnb19gAZNrjFUpD7DwL0ogkUi
 OqLNX0GD3YlZuNyDMBtidzM9vimvLblUSZN+GXrjWJlpzAOmPJubvyHPQpFf8HbHgimbWFC
 mqtKva9YxX1HAIFQawn2rJ7Wh6oSPzg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B76703E9765
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:38:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F6023E9762
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:37:37 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E187C1A0118F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:37:36 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49b9320423cso9275345e9.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 03:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788518256; x=1789123056; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=SRyfSoSidNrfzHY3z9hIyLd/UtIhtf/Kkt+0Tw+kysDVe5vp80qQXGs7lb0DJa6wsD
 VSO5ixEcIXE2q/RpuVWnvdW6iaDZkp9ZWTUxxzPKyJFUsY1NfSjYX7gMT23oam1z9Yyb
 +sD/5KW8UqZWFfu6t2bUOQZZSU69vFYXcR9ASXm7JjK66bZQNfkIPbYkeXLQe4pke/An
 jaL7k+HM2n0Udz2VSHU/Gl2NA/9IlDqUof6JrtRXdmntaKGvxMDI6ydS3b7H1bx1Fb08
 TsneiHHgCe1ZAdXvnJUsX2Duy4hVuRo0WmWotjQGvqhM00W5sFuH994kHWdKzPoZ+8R9
 suyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788518256; x=1789123056;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=fUJ+PNuMatFc6BJLH67rzIhiM8WocaF3Vz1OecxJhzm1B7u9N76wwNuHoCujlSidIh
 HjCm6NsDIxV6kbRc7iFshv9Nm1FQLkxgoguXg5mk4Kb+6+RvHEbl1/cU2sfAOBEdN+ya
 Z8mxfvq8n4363PkuIr5Utl+Z5D3cuIiJair0hadOm+PabadEykaJu+8LkoEiPTtR+Y5a
 drXS6Mu08CUeLdmhmHsZO0HuFHKVglaOX/CoOc/BcUoiTUYF3o3+ZxHtY8n7Veoa6s4t
 MMsxQCF7XBsZmClQt+9XSn8qkgGyXwO7tI3uEbgh6PSnD1/6U42s/2RVCQ754JYmC4gI
 Ignw==
X-Gm-Message-State: AFuF++kgMMRBFULir1Eq0e2PLwUM4PCk+bNtuIA6nu6xopdJl4Qwv8Sm
 nAbHDg0aq36Ipp6VAsgk0iy7a5GfV520p/mXggxbcsFoB24ox+3s6yOzMYx2e8NuTio=
X-Gm-Gg: AYBFou2df+aQyzm2HOHoguhnKo9miVEN8/a/WsnuLRcFF1hjMIfzqHbYT1YY0klsp5y
 hqpKNK5agQnV587/VL3n9Dh7SOQe6K5mNEc0JoQjJZ9A7uu29RHTz79r82RDw4K97ZL30DpCFEU
 hXXuqP0vwG8AK+nvEP7FbSz71bJEClJ/WE8OQoceBizIPn3ByyVQ9jSYetSxx7p2VksyuJ/O4iz
 mMq5UK3rMKr4bozz2qiz6iWbigvzp3p+m8h9XmROvsBjOhPr5xh0xjxJgoVpwsdPt75mwq6ALGp
 K3djqjIZWpIuNEvzFYyrgXWlX/2sCFD82oHHlPTXrs/v2VwhJUirDVJHVi2FFAM/PtmIAgPDWxV
 G+lZA4D/JLa+GSFbOW96PpXCdDqrzyBAiKPkceLMphexfnHkTMBW9VNlHIcl6ZyLKDwaxH40v9P
 VZ36ef2+eCgzop7bI+zmhY5leW6hL5I3hlLipOpj2psHmu1MPTzbv4Hj99PDHKncRh5Z+bto1PU
 DIbdat2HxKDjVba/qh/tT8=
X-Received: by 2002:a05:600c:6383:b0:49c:e88b:b7ce with SMTP id
 5b1f17b1804b1-49cf823f147mr80807315e9.11.1788518256214; 
 Fri, 04 Sep 2026 03:37:36 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce592b019sm31109595e9.2.2026.09.04.03.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 03:37:35 -0700 (PDT)
Message-ID: <6a9a9f6f.6439a68c.e4bbc.60f4@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260831020028.19193-4-wegao@suse.com>
Date: Fri, 04 Sep 2026 10:37:33 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v13 3/3] open16: allow restricted O_CREAT of FIFOs
 and regular files
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
