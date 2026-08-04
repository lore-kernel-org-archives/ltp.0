Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3793C55184
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 13:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785849082; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=lk5DO9GXCCTzDOqkuptSkw+JC3myjKhDzTGQUxKaAg0=;
 b=RV45btkjVlcGU15f6bgsfQSzOvE+w3Mc5qlJSynYtaZgAQE+2/gv04S3V6CJ8+RkLJBfY
 Ui4wFpgZw6Q93CLSvgGk0c7PZTceichtjTYlfBdUSckJfBsdQfaHKqxv81l8h2O9atXeyh0
 zF3qNfaOtSq5dA2btvBrMhrsER8ZhXI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00E303E1524
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 15:11:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83DED3CC870
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 15:11:01 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B81AD1000445
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 15:11:00 +0200 (CEST)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8f01fso272781a12.1
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 06:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785849060; x=1786453860; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xc9RKgD/xy6nAzz5BLWb8I+urvjNPZy9x544orVQ1+E=;
 b=Wu8/kfOLkEg3fm5LEFgqY7oqM7yZi131HKHS7GnrPW5oDZINsRw/H9v82WPq0M0Li7
 ea8Bmug22Vir1d0vfLFgnSluu+2zAUDhuFnuvin3IcR/Bw4+npKnywS4rQgbho+eWb3s
 nYnRAJgzKCs8K13HZy4hKfnmlGR/EeE0fOP+0M2IYb4ChpM3rS5MLjojicO1+RvTIrnu
 cMMssQvJJSKcIha25e8Qyd5w3lNNFqAXPyqq5Z0Z30ZQw5EGZcqv1WVryJXA7FdKw27t
 N/8jpNbd0s5TyfSGjovwmq6ScbvqYjhZ9Uh51cJRUoU5CSCVi2UMW3MXWBwccWBljazX
 ORsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785849060; x=1786453860;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xc9RKgD/xy6nAzz5BLWb8I+urvjNPZy9x544orVQ1+E=;
 b=hP0fzTJN7meWtbcjKPIvXcwDU6K7uqv9ovXkjLsIn6f0KS3josgVWP6C8Rq29XXEFl
 5vju8EPOmRrGhE48+KRK0WlAzZZ3kcEe5jAajGhQRcsqesjwjI6Voq3QfX9776tTcyV4
 d9hOlC6Q3g/EHQqMmY2K3BZCk+Xvx9kcf9CSFEakg/kIil1GNjn7pwn9JvyXwTus6Koy
 vGto1PHp3r2Onr+9SNoaXPybxzV/uExvI6+ksWiLB2K9tLe/ceI5MmNA4MqcuAzX7gIP
 RnUwCX8exBw2k41lLhKyUPhLI/Iy3toza5Jp5YcCoObzYlYXUSi93zzAls8ALj2WySlg
 oG7g==
X-Gm-Message-State: AOJu0YwATuN4MHap/0vebjHOJEeiireB/GdY96C63w8ovT+9h5v+7H1v
 A4h5ykqjbgKFKOTfklksZtf8RXhqj6HN0XBFb8wYvSOIiF7nN4aH/RGDHxVjmLv2nYz0VOgRSbX
 J9cgPwSI=
X-Gm-Gg: AR+sD13GhGpjH+LDz76rW5hCPho0NdKEJEaOYelsdKxWvDbFA+G6jnoCJepaXTTEE21
 HyIzCzt6wAoh+PceiGh22CpLFhEyKzi9atTMCziAdCYPGX+qv3i8jFVjSGQ6MGFAKttzNsrTr60
 CL5K7osHELcmhOT/bVlIbIbPtyPoKHNiqDoGzJX29MVBk7EX8cFTqeqPkCUO8djVWyxBRzRFXPD
 P8jue0WRafO/AC4ygIzxWtX8Xt4nL278Z32os3NtfayqngpBGVvV44pNbBlSy1Bu1F+cdbgBpuK
 C+feSon2+oEFCaDnlzTzbRlK143BqlL4IXSnjToCngZ+YUibo/l62xTMjEJhgh0IqgS/2FQ2x3l
 CNBdE3xtaLiaQ3FvoZSVWHvHCQLofxXNqw+TuiPJvM8+c/W5n6CS0M95r2kbEd/ejy/bi0VybFG
 hxx1u++OPMHQGEjcqjtghL3ncsZj/UZfix5ySEvbLKbaW0bGhIefojZ8ReAKQbtCw6n++kZ/QL2
 ss3lrjezar6FmWWdfs+isrj38uftQu70iUw6tNM4HZuzw5ZUuYz3PMo+RkF6A/3SSJPRQzLTFfl
 28XozQUzeuwdCsnOWMThPKDL/RB4O04mlbiZdCBFe6et5TXv
X-Received: by 2002:a05:6402:504a:b0:698:a9fe:2eb3 with SMTP id
 4fb4d7f45d1cf-6a1235de68fmr3581820a12.9.1785849060086; 
 Tue, 04 Aug 2026 06:11:00 -0700 (PDT)
Received: from p200300ef2f11090032755c67e6ad8da4.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a145c47d23sm69375a12.8.2026.08.04.06.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 06:10:59 -0700 (PDT)
Message-ID: <6a71e4e3.1a08c196.24c557.03b6@mx.google.com>
To: "Stephen Bertram via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260730194953.274721-1-sbertram@redhat.com>
Date: Tue, 04 Aug 2026 13:10:58 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/2] semctl01: fix SEM_STAT failures under
 parallel LTP runs
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
Cc: Stephen Bertram <sbertram@redhat.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Stephen,

can you please send the correct patch versions?

Now we have a patch series with version v15 and an another with v1 with
two patches inside it. Both needs to split the headers from the tests
which are using them.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
