Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE471C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783940758; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=gJkp0YFWWKRKHdTI0W02I5xz1nbQKVwVbzOxDrnm7flDDfscxcve5SpRc7SYR6A57ACNg
 seIB7js1sXJwaD5L5IeMod/Tevel/kHdQG8tNJallxr7+j0X51Do1of430+v0MMgAvpUAtu
 2NjIqfQpRebHbboOBrVSMWMtozdO12I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BB7B3E5D41
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:05:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D0513E7FA7
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:05:31 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 468576003BD
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:05:30 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-475881b9a4bso2981130f8f.3
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783940730; x=1784545530; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=EMjoR7RXawPNu921H5Dz7DqodBzjH9XYOLtYbe5KCb5MRcP8k8o1Ge5bi9ebdHD/9Z
 sC6nSOx9bztfDDmYJ4oY0imyoOARH8Flcm4B4rcAtxfBByxqbZQzB114ksQgAZvczdRn
 JgJ3EZXi53YTFDJutUBbg2yNgjzZ4Rmk39e+0vQyESqd59VuDFZJpW5o/eLJWIC7uu//
 ugSxpwxLDgK22ZiCN8w2Cyp+cxx+Jw+VRd5XBsVKlQK3BKuszdwafCYIt9buUZAYqC34
 6AKzv6TxjyIMli7CNKDJvL8X/bx/Ut9Po3lySReK+JKQEzhk85ZBj+eaIMNCN6rP5g74
 DB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783940730; x=1784545530;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=sKVT8wSg30vNh/Z56bYpRSyKyxwvH9Odyu4cTsTupo67Adn1gX9Ix9Yb2lyXR6yes9
 OAbXCZDcNiV9cJX7ArdlFm7cwOi/LLc5Q/ieGU6MtxZ6dAs7y5F4VrTSTBSfLImAVpbC
 RMYDrQ7wa+PhZMHoa2YeS9cvebduPmRatEoAY5v//kY7rquiKi+Uwo7EbMtS6OTBj6xR
 JfSCmjIjOdNReGf2nPCEhRdOcIpj9BMjdvUEP4OXCqBc+xf0TvGI50rj35W1DcBbAglO
 qjM5SfHkVtBoDP3kWThQdr5anYBnXywNvKn7ofwzxYTBOjoXNgPBzT/68q8oWyiHRDuW
 DIjQ==
X-Gm-Message-State: AOJu0Yz/sZ1dnhZiKe5ifaiqB5Xe+t/Ufd6F9BVDF1XQMa2vAZGBtVOE
 SJ9W36Q9Yd4CEh/rVKApLJdjJDoD5GYlMJ2iJZxQXNg9aFapc6v0DcsOmvYY9ZERKIHDwl1idct
 ETPJbbxu1+w==
X-Gm-Gg: AfdE7clfkf//NktDQUWzWtyz62d7j+XobCY4nB3ys4YoHqmzyFFES6HlcDe3idOLzsi
 +vskebAB9ibSh88TcTFtB4HVH/yOLn0qw4xUvAEYtmTzZ3kYWsvgrgwNxp4GTzC2ivMDI6vawwj
 Bhw3cY5inaC1ADvW7UVfKY6QTyhMi15JwJ/gb/n+D/d3lj3dxbydePAvlS+4vyLRyOIRXnMb5jw
 xHc8xcUSMjidzXLZfro91eYVDMGwGDh04xZhJ7vu24E8LAJqQy3HYX259WPHJiveuDK/KAE0lPo
 6R3Mo6Qvs6thcAJZDxMP1ffiQMI7Z32Upol3qZUziSNi2oPjarXQIn8H56GXyUpFoihvLkF93nN
 W87YuWf6v6p+P+rKk2FO1Gqpca3rQUI2GLBj8mhK2pUc7en9RcicAwU1iJYzyD7NCPcoU94QsML
 3N6VFB0aQ4ZO/+tDcUWp4tnRucOXuFG12d
X-Received: by 2002:a05:6000:2285:b0:46f:e15b:415 with SMTP id
 ffacd0b85a97d-47f2dcd19eamr10356003f8f.12.1783940729561; 
 Mon, 13 Jul 2026 04:05:29 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f273195d9sm24721183f8f.3.2026.07.13.04.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:05:29 -0700 (PDT)
Message-ID: <6a54c679.3c943127.a57e5.d3f2@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260710055556.1109220-6-pvorel@suse.cz>
Date: Mon, 13 Jul 2026 11:05:28 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/8] metadata: Add missing licenses, copyright
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
