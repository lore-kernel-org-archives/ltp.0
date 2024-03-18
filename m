Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCCEC54E58
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 12:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710765721; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=x8mvA7j5wkt/zzZXMa0l14OE8jMh7NKh86wRhqcj7kY=;
 b=G1+V/2QnX4iJbltIVZbwBhsZGpeWDtLj4wBe5wsuKL6jr7SH/wIaDCyNW0CIjGEOPPaRT
 FXTLmr6KB2L3UmbZTgkHw1oQ1bFOqC4d/LMn1kpnUadIbQ9r9CfosPDrkgGJABkFwgCIJQL
 7Fr0BraNNXFa6OYIK9rxuVJU5L1eyK8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2B483D0587
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 13:42:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D51223CFC21
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 13:41:40 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E794200091
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 13:41:40 +0100 (CET)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56890b533aaso4831605a12.3
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710765699; x=1711370499; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJse1OR8qMiWATJbIFdDpjtk9REUpRk1aBxZuYCjzPI=;
 b=cVqv1oyw0o2q4E1YUDJ8LhZd1kSZoajsq/LvlNWc/6gXyI9Urg3+MF4UGRZYk5wEnT
 wgYE9A2oXmmdLu3PIBdDt/Q7y4ruAnEphpRXM02I2mkLM/hVu0sBYzj4tWDkZkxdu3W/
 BjkHAa+8GT2gb1hpkxOFH9qZqgU2V7JCzwd28EMHJOPXRf6rCWxVcfBYX+npzjoID09f
 uwHBQtk64CjOJSqEAr2RvoErvmLVPufEXL0gP0pr2nsfvCwiJrBON8lWdx0Ne3g/1d1o
 8Lu0MV+vmOevxZE/0pTzianEd1Sbi7+2FH5T5JuZ4bIcFrVDNRC6rNdgx1d/dyu6M8DN
 73Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710765699; x=1711370499;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GJse1OR8qMiWATJbIFdDpjtk9REUpRk1aBxZuYCjzPI=;
 b=auhaF+CRiTEQnQdPynNJ2Lgr+ZPwBN+IvdgrQkM4JuXkAsIVRx3NVeZ0NpUD6f3qHj
 bN9QbbTo0ATAXGMvgaejupat+oBDjeEdP9Lo6GqaxSKO4NOSD8G3przeSHUreFIB+Zjy
 3AVZwRRsiGLXW0cV0cX3mfrPHlTsrxNIih0q2NmySlg9IiY+ZkrbmRryYhp5bRhZjCp9
 eFARZl9Kh0W0Z7gmzopklD9XJ/bQKRERf+weaVJJCn7IPI6dD4+Apgs86KdJk6CK8ex/
 CYgelEZwK2xAq5zzIIbXToJ7Nhwieqjno8Bokz+G6LVcI7ubtXc1rbMz14UfEOzhIAzn
 q44w==
X-Gm-Message-State: AOJu0YyKfg2QpsYUIp81AqA/aYiQzjqLbu8UehP2cVSauk3CInMpKX43
 7/V//uNiZa79hoNT81JbaC3xYgL21+WXCBHsPJmm470EIRKUK1Ruk5U4oloIhCvL4VFanZj+tvJ
 ljVc=
X-Google-Smtp-Source: AGHT+IGHVz/tdPAlbNO9KbeWkcCE3ZYCN+bPYqIaTLMgzu3Qj49/tfjY7m3jPphvFvxsxC7BcAL3RQ==
X-Received: by 2002:a05:6402:3784:b0:568:b3bd:23ae with SMTP id
 et4-20020a056402378400b00568b3bd23aemr5209686edb.1.1710765699212; 
 Mon, 18 Mar 2024 05:41:39 -0700 (PDT)
Received: from [10.232.133.97] ([88.128.88.41])
 by smtp.gmail.com with ESMTPSA id
 en10-20020a056402528a00b005693985c35dsm1220648edb.36.2024.03.18.05.41.38
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 05:41:39 -0700 (PDT)
Message-ID: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
Date: Mon, 18 Mar 2024 13:41:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] New LTP documentation!
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello everyone,

as already mentioned in the monthly LTP meeting, Linux Test Project 
lacks of a nice and clean documentation that can be easily accessed by 
users, developers and maintainers.
The current LTP documentation is also not matching with our expectancy 
towards the entire project, which is has been heavily refactored and it 
has changed in the past years, providing a higher quality code and new 
testing features.

For this reasons, we think it's time to move forward and to start 
working on documentation, helping people to use, to develop and to 
maintain LTP in an easier way, increasing quality of the overall project 
and to call more developers in the community.

I started to work on documentation refactoring, re-organizing the 
overall structure. The first prototype can be found here:

https://ltp-acerv.readthedocs.io/en/latest/index.html

The idea is to move documents from the current asciidoc format to RST 
format, following the current kernel docs guide lines [1], and to move 
API headers descriptions from regular C comments to Doxygen format.
By using the powerful readthedocs service [2], it's possible to deploy a 
documentation website with one simple setup, using Sphinx [3] as the 
main documentation framework.

For now, website prototype is showing a couple of pages, but the overall 
structure is there and ready to be filled.

The purpose of this email is to ask for feedback and ideas from the LTP 
community, so we can make documentation even better. Let me know what 
you think.


Have a good day,
Andrea Cervesato


[1] https://docs.kernel.org/doc-guide/sphinx.html#writing-documentation
[2] https://about.readthedocs.com/?ref=readthedocs.com
[3] https://www.sphinx-doc.org/en/master


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
