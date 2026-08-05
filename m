Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4782C55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785938896; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=hzapRpYbtH9c2ATanCPRiVwWWpipOGuTTiBjtOlS9kmNtQZGRb9MsCgMUq2uSjk8GiEfa
 L+Hg34nN6tPLPezB/tjuJMIx4Z5/FlSTM4nSNSOtoKW9lEcEh5f7eiLMvs+86cAa54hbLam
 DKmxL6wlwUJqrJAylJMxW60fgRCrKgA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0931A3E7153
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 16:08:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D69A93E715C
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 16:07:35 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0AF431A00CAE
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 16:07:35 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso9460495e9.3
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785938854; x=1786543654; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=RJUKqm5oSsffh2IPhBZz7q/9GfG8UhlYPTLuNfdndP1pcMJoUMNEQmPbdtOiYbkKMS
 tDyYgDbzDTRUghYHxCtlp+p+10FNIQzEdnNNLgrgkwJFHA22NtFm/KrsrftlySKeP2pV
 H7FnZ+ZUzcPODFeA38dtY5gAAFI9IPa85O0peRtbKPC6aWujsnr7ZoSqn6Spi0HN+Uvu
 PWnFn4lahLlttHM5LA5XLzfEEQpE+q7fABTuOKzR/ehHYAL9jpotrs1XzCaq3QjSzvB1
 fO71ika+rL/CCgp/aBv2hehcoPp/A5Rq1/GEHak2pXA5OGuUZBntM5CroOqvJ7qByP09
 9Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785938854; x=1786543654;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=F7iO1TgE3Pff173TOIR+RrnqDCwIGHEtBZJ9c69zG7xpWP2q+UweCEUdVs03mpnEZ0
 Y3U2xfdMccW85VTepPZmiV7AXDGlI+xwJC7LpNovAxYSZMq2TA8P83P4G/q4QQRkinTj
 PIRhnIrEjFaaSOYhKWirFLPhPG8CgVKSze3a9IB41iuo8ImSjZ9qPjLpt5Vsf2Yks1bV
 5xbeg+ry2TOe2yXDwjirnvzNsHjKn/P298aCiRRpnQxNlV1O/sKmHoWRzVxMYhLI60ER
 BIBKlGCZtAD5xyP3UAfVw39cqW3uQpgnl6eh1mvwJelaSi9EQ1CFFh7ic7Z64v/4tQ31
 8aHA==
X-Gm-Message-State: AOJu0YwrwI9zn8EEYDiPjQyger9UxgdMjSw9+3fQ2PkGsjG/DXEOv4bq
 tbSdE6D+nyYb42xlOHkHQwRfB0lvTmpsQkj6SIudk5ejIFg+O4kwrj32tHSW7LGbQ9I0h7CcjTZ
 buxZ6qjM=
X-Gm-Gg: AR+sD13iP4O+IdgRWvCbqgdKglgwlJ54lIKrMMvXpqbMOPx+Czg3oMYE1L8KL+IdkAU
 6VcnpVHHAYMDTzYvdukyUxCKNtcBLNQIn26MCLsh56Qm7F7q6BAcv/cWaNOhVHWtbkuySJuoDQf
 4uMLboaNwPEE5HsswgIEhG/b5gW3f7wH8XvRYuGOWtRFz7ScRcmnwiEK7yzIrlNQHUfT/BdH8AH
 ruDeSN/AZbAEMYItLwbYQ+rw3NY+qYU14CV36jNpVB6eNeLmdLWweB6iG9kJqBgK6ZH7gvzFZvn
 KRXSGVNXwVpERd5KK+szcbvhZsURy2mv3pw/Z0RQLz75odYFfLkfDH4oOHDXUkomo65hwHx/sIj
 jgsJjKQSaFp9BOTQYWbuPoIVTDdcDxeKwbQ8WNeB2OU614hbyNbo4LrkHnINPZI3vM67d+1Cqyo
 uv5z11W7RhayNclJTxZJVZiwmBp+l9a8Q+55TX9ho4RqYaysqgI1fu6dKdPGhU9/IzwHSLI4rAB
 Z4O8xtR155KT42AVETKKvQhMJIKU96eU6wTkSSaMr/wGG94NWlGLlnMejw/+BByZ5rPx/0glTNN
 x6Llt1z7eHuVdqdKIG2Bmbc6krzpXe6iSvywfQ==
X-Received: by 2002:a7b:c854:0:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-4994e7d7320mr73018105e9.19.1785938854309; 
 Wed, 05 Aug 2026 07:07:34 -0700 (PDT)
Received: from p200300ef2f1109007d27a2191b5ea63b.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e99c035sm47216945e9.4.2026.08.05.07.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 07:07:34 -0700 (PDT)
Message-ID: <6a7343a6.e9cff95d.3c7aec.845e@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260805094935.448896-5-pvorel@suse.cz>
Date: Wed, 05 Aug 2026 14:07:32 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] tst_kvercmp.h: Further links to manpage
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
