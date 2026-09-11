Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7C2C88E4A
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789121399; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=ky6PPU8JkC7wDtvZy/CfCagYorOlKIy6iKKEishCVM0dTph37QkhiNQE1tW1hl/Olf1cN
 WaN4g9qrhezeFIXvc2myeE39ewmFyY1wDdjkMu72QQp5mfMi/1NESmDA4CCR1tnlIsF2Ive
 fRKhzme46e1dc39m0w1uLzPSwdDe0H8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF91E3E91FF
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 12:09:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C1813C248F
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 12:09:40 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8C84A1400DEB
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 12:09:39 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4859b45abadso73957f8f.2
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789121379; x=1789726179; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Ou+VAC9wevORp3lZhwtWM1ZfRBl2M8nHK6jzUVcSOt+sG8VY/5K0v3zvQpoTMEd07Y
 6A6juoWUaS3gWxx1DRnIS5lDF/iE7hV42urSogFQoa5rFyl9h9aMGOBVNKc6mwdiPsA9
 gszz5py/JkHQ6uKdBFazvrbJPZWQt3BmgD/J4o81RajpZWgOSLQMzX/NflbP414ads7D
 LX/RH7e9SIDsaAmdtK8XDv7zaPv9JZHeOl9CSS9ua/m++VibxGLhv0x/ESiXC8bf0E49
 NmxtngkTOvnlVHQ/dmkFAnGHdDZp41hl1CEYaAg6811CtIwKETt6gV/nGow9IGMUjpwr
 vDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121379; x=1789726179;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=AVRB38cvqKU7Ovi0tNndYhRWdb/mjszbSJqCWRMSEQdAggtawapitZK4eD5a7bB7xI
 VkOtemkgq5RoDiMgHMIqZLJbGg14ewkFp5yyLrlJTwqyVn5nRHnXVAhQnm1H1aS1mMES
 9dReFPVnMdIrkRDCxrDr7opmP2+tSERZrzTWAJmBxhPb3j8/KOgwAkC3zCaY1C8GPChb
 E/dv8Yqae/Zsv5Wur3wWYoriNdy9Let0ZCRP3exOhSA6/shs5f8f36XRBaSLIRqSXGod
 E1UsYQDrRk1gEb7UZGyyMHviTleXPWe99VUTVwTHwFEOFliwbvs5oqtno6Ahq7wJlnhX
 o0CQ==
X-Gm-Message-State: AFuF++nKH487TldgH9dyFcpoiNljysU/cZMMQPL8Go6YeJPTPHN+FfkZ
 M+2eOaZNezLXvsp08vVH+KCZ9F0I6qsHPemnCWUh1GlFHF68L34FS3Die1DwvUKEdQc=
X-Gm-Gg: AYBFou3fsPmhvsq+CWUqErsJ+gDaJ+SftmrZBqyOXKcRnLJkL2WPLFZixnO5ZLa+Fd5
 7+yuCi50iXtCM2razEnMJW/hdSJPMtbpTs9Ng6gbMIAlYRQoZbEVPs7QmKsyFtCIlG4IAfwkNjM
 JMzoeu7icZrSXrjJbIWj3+G0G1bUcPV3F729pTcUQp55pBCkh1lt0hMl6wHSBkYfVjcPhjAnQ5r
 HdCsQkmgkdU5tP6VJGALm0QNHCrVSL/eMcbtDYKPiWZrGEPVg3sNGMXqBOO4/zTcmgQiCQ9r3XS
 duFdjQDdW0s7XeBdFRh7VIQ+xnziQ2GHr2VY5g+u75Urmc6OEhS0goWNYRAgNn0EVX+yjjvKShW
 WB5mLS1K2Z2sE8d9dhKTXg4UHX48PfpYIy9WMR0jRUTTBdoEIcVeYHWjDaX+ViAYsedGxyH7GF6
 VFVPCQsLuKFt0/t+mXXWgXb4Xb90OnjVvKkTd7j8LXO/ivLMLGZV5JGgWAR1PN4lKGJR8JBctFh
 WUsjw9YRx5q8hkw0lb+MppVjhZu2kny3a7uREbU3MA5sBDTKhTWzP7lBJZEbDT5Zponw4wq6cdE
 Rjv7kQ==
X-Received: by 2002:a05:600c:c48f:b0:49c:cee2:a508 with SMTP id
 5b1f17b1804b1-49e619c18edmr43719795e9.16.1789121378783; 
 Fri, 11 Sep 2026 03:09:38 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm37824125e9.1.2026.09.11.03.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:09:38 -0700 (PDT)
Message-ID: <6aa3d362.232cdbff.2b2c6c.b5bd@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260911-fix_core_leak_astra-v1-1-bc5cb35a182a@suse.com>
Date: Fri, 11 Sep 2026 10:09:37 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_af_alg: Fix control buffer memory leak
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
