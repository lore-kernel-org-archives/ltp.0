Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EB7C55838
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 11:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785844434; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Nq5s38jGdQTW8mYGSBt4PQGUFPkmBTykX0wb+S80mEE=;
 b=DSqiS7vq5clYolUXnDW29uf1ILBLO9jDKO3Nm7sO0+Zun3/82c6eSQktpy1X2068UnsRb
 MspNnv1kJOB2IuUN8sVgrxMgz/h9dXINxPLZGGbK0fDUOgVbLpE+vh/3qvwB4SG/4JQMZS7
 J7WAReI4rWnhXj2UPStK83rTVIbMHPU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4C693E7188
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 13:53:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 246BE3E2EEA
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 13:53:34 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0015020006D
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 13:53:32 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47fde295992so710737f8f.0
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 04:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785844412; x=1786449212; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0SoEv3bNsNTTCx01r8nAKZ4vaZtKavZBXBYMLB5n/yY=;
 b=P/zZ7o93WB0C8Xo7hFkb2sbmW6Ddp+pWZDhIkSJjvzeni23HRZWjGl9DLLE/LLmYhV
 YT2bDJb4HPjJDAT9t4MaePBfttBwlVk+MugjJKXc8jI7UkaGOh1vdS5kQLO7XTi501f5
 jtISnW1fjI4l2bjp9NTkV61dyjMp/1cNWR+2Q4htaQ0KgvU8FZRq0JxBFcgaDcdZzWtV
 eHlzR3bV5sJJ5A7riRpQwrtIhPUsW8ia0m5an4zd6UhCRsOhsaDM3VlHO+lgYZ3pR3Wj
 4PIiLVa1Y/6JpMZKFnK7TUkJcrsnTp0jSTgZ9bmbPQGE/bQ9FNSfh2rTKJyx7KUMXJ/M
 Hhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785844412; x=1786449212;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0SoEv3bNsNTTCx01r8nAKZ4vaZtKavZBXBYMLB5n/yY=;
 b=k12MI4WlkCYGVwaoqkcSS1TMWqRq7Q35VZKXxhIr2snCgVPEkKJ7IeyP4GNSogaw7t
 W9I9nJO2SE0uUjWePommqKMq0wMqQ5shKXJy+Adawnd9cvS+HajuDu4AwuWy2NbT8aRv
 EfGg/TUdWsVoeOWuk8yoPAeSdPmqxPNtNlKkS2PZUlHTjocCNAIoF6o/AYpw00zM6rtQ
 4aiQGHQ/mP1E4UhArvVeMIraw0GOsiVV7MqEP19NK7lWYwKGaL6q7a/lb5RS+6pYdQSP
 YRo9OeN1bS2EQFqYjGEIPR4raTdXTafdRL1nhgbCFOs8okHMiWyfeGE54V0Sq/LWZLKx
 /2CA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqe+R+4JUiaBhikCh8E+SeuVStvXRDJN8Az31zMeVfdZtRoijODkDjKYcSSM4qqiEg5R+w=@lists.linux.it
X-Gm-Message-State: AOJu0YxcN97TFL63nExpvUWk0Tf5X9oWMFE5mYMslgED7ZVf01JV+S+R
 UG4TypH9Vy4FPAljEaY1PDxBPoL5o9CzY/siad0IUcHb8O0e7D6zGXqxG+sYEV+YsSVfClgBsoY
 GbHgWaiE=
X-Gm-Gg: AR+sD12TJ95iIFAUh9rC96TjYv9do+bVw//aWvxip1FvMvMjRwPGjWYAlxDe/C8F9tU
 8XQDonbGVZxxRNDSe+V2aUt8JS9mzKf93ZfO4CrNXibw3XvAiAIG3GEEu56bLykRcBnp3gdjmC2
 UuNfsqNGyksf0DNvaswSbnO6JX3FKNxo2v3sbutGYKa1VqbkuhcgOj21R+Sj0H0kQ4jJd1RVKDZ
 dpEtnUOlPMQlZzS5ieuvKk2+zrVa+NmteDuLbXhUa1+4aeVw9vip+c+SeFKwfXFPCaugnMuqlwZ
 /UoQgHePUj/AorYkWLI1ZoyC24HZbEheG0DEHOe9TeHvRx7NyHXIvrcLehmkW+sf3jcgazAYMPh
 FPxGfkzVJ9PRyM49y6MFDrqEwxvizUxmgQhE13M3oX1QI5WAKEvMtfEck8Va5ohYzV/Qr8SaD2l
 N0gri66Bs2Vuz9JYhjv+dxebS/NBZx//iSR2NJyXTGncS+S3NyGy45Vcwqst1Pti4Yny+9ZNwOn
 KLcWme29W/nJA5PBROi1ZRrfrUcC8bp6OBvItunXaFQGIBldy9CpO4S1q4eLRJDN4Z7OOAnauTl
 yUtDCll49AHDcNh+6PVnXvXRW6kTrjG/6ToCfQ==
X-Received: by 2002:a05:6000:25fc:b0:47f:853c:ad7b with SMTP id
 ffacd0b85a97d-47fe81bdd49mr9479235f8f.9.1785844412241; 
 Tue, 04 Aug 2026 04:53:32 -0700 (PDT)
Received: from p200300ef2f11090032755c67e6ad8da4.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a6d7sm44073884f8f.19.2026.08.04.04.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 04:53:31 -0700 (PDT)
Message-ID: <6a71d2bb.3fefe569.37edfb.0582@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <anCSiSrmcM1BTfmd@yuki.lan>
Date: Tue, 04 Aug 2026 11:53:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] metadata: add linter for JSON file
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> What I had in mind for make check is that there would be a single test
> mode "-t" switch and we would skip the extract_tests and passed the JSON
> right to lint_tests()
> 
> ./metaparse foo.c | lint.py -t

ok, so as far as I understand, you don't want to have a linter that checks
automatically for all tests in metadata, but selectively check the one we
need? Considering how fast we are to parse metadata and to run linter,
we are 1 pipe away from your solution by using grep:

    lint.py metadata.json | grep <test>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
