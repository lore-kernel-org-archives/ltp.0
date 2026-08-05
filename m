Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A931CC55ABA
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 14:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785938915; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=FAvuEXC2qa3VfOje6rNmvy+hR2b6gS6dE6gqchUSKCg865J/xojAixiukMvyLWu8K7o+h
 FEGUanmJjzluBtnOmggqwF0SftGBoKMP4gLvgW3EzEvCElfFecGWvGdtTR+fK+LrIfhwnk6
 Sa/tx1cD6YoFcA2aMDLjnlkj5COt5T8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 339E63E707C
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 16:08:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3C6A3E7184
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 16:07:38 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1C33C600A0F
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 16:07:38 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so10019785e9.2
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785938857; x=1786543657; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=HiHEBP1hXhgYXOWtrhuepR0OUMzFb2X110ShJyzweMy2Pk2OnUQMNJGNewv9stpkcz
 bkit3wJJpc5ruCQJ8Yc2OgsoRsiM867nCnThjxZ5d56X+uqCK6Rk7uLKLOuWsu6VSQLn
 iocw1Ip7LBR/wcL9c6b3GTkbPya1wQnEZvqGTk0kcMFizTBGoZ+7HnKBSjR1aQl3ElJI
 fIpH/mk2i30i9C+nSaGtkxg3ofjex95ztOkhqxOxqHfVLEG53y7pa6dSKwgJFfjJyERl
 8XM37q8vqGMV0+ifGZJXFKOwZ625CHIpdoDWMbkRteLEq52/1y+tDq2YayrBOcUrtWmD
 ANuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785938857; x=1786543657;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Z1mMrlciGTNYj2+agxiqFhptT4oeX7rUYp5g5evyLIkbL41xOH7r91eoQ79omkGWS6
 xhZrdTub5kp93dXPyZ9FLbW6vH2cX4pRRXHNVJzgUwhwZgzykd4JTO1Ne6JWZREV35Aw
 L1fEhYiFXxU0dfBxSGzqYaL9M1rrjLtZXvIiGEga2gM+1gBun2qUrLDU3TfNEwE91XDJ
 rsouPDnaQ3N5cs3YBFaAKvOWUwoC2fmsIvWtocEzYpeTidzTd4nWOCS+MkqZuDuJtRat
 LvsU9gFduSmdk4gF1vwkkmBpb4NEgUfH1+85U3TACjRBpl+ie/JRr6Y+BqjtWhChFFdo
 800Q==
X-Gm-Message-State: AOJu0YxBEVWoxf8nmWFuN80UF+6R20Igf/MEq52p4rLwxC7mK3AUb9eC
 8b+rKSMZT2eeLQTKSZIWXoKkf+TCKWDQRu3zjAvVX7ofUia9sGSvpwGkKfjig3CBAG8=
X-Gm-Gg: AR+sD125Zk7qDxLRNuC5keCYIQ9wzb8J6548dkbvcHlRqDnZjLmXNFjWmjPq9naVEvl
 yE3F9kxyz0tddMt7PHnquq0TJSnnXLFxQGkPMC/XrlkzKjr1KNG9/FbHnDBgZov3Mlfql8ZELi8
 X/gF5+7/r9j3xDidvpkseEvyXcEC/FYk3vzuJwi2WbSU+VWqi+kJ/KskAyY4824xImZz8ZHZNgu
 lwFuacYlaAdxQQVWVIaQGGseoZsj7dxHVCd2mcUjV4Uf1pEI92X4hIT47mpiCksyeZUkxA4eeLo
 aRUhwqvO8Ssa0ST7c5RssJ0K/3qIxePdfVSPNSl73dLxxUFFSWjTd6AGw6MirleL6RwFyeCNRx6
 fgaEd7WtEbuoN/Aq/EnCHQ5Uy7pm2wbT6tZHi+7a5hfb9Us5+wftitvu2W0rQ/CQMqARSv99/N+
 mwCh6C/TH0i6KLJ1yJprZEBtN5G3Xqzm+F3EEEz5KQeq9/WnHzmKMeeUOVIvXEt52508ZVJg54B
 8b3aUaL0Pcs20PwbcMeD0B/xKhY6P6bnS0AZsQYRJEEvNfDh1Sr+K/BCe7eYERtNxY3r/dw/Wrx
 xI6PnUuZ0SErtvtgUyiWB3OmRHQqUmXygDVvv88=
X-Received: by 2002:a05:600c:3150:b0:496:ca1f:a428 with SMTP id
 5b1f17b1804b1-4994e7f3562mr78734965e9.19.1785938857353; 
 Wed, 05 Aug 2026 07:07:37 -0700 (PDT)
Received: from p200300ef2f1109007d27a2191b5ea63b.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec23e5efsm9255793f8f.27.2026.08.05.07.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 07:07:37 -0700 (PDT)
Message-ID: <6a7343a9.b251136a.1c2fb1.cf5d@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260805094935.448896-4-pvorel@suse.cz>
Date: Wed, 05 Aug 2026 14:07:36 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] doc: Update linuxdoc, sphinxcontrib-spelling
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
