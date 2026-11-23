Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFBB606A31E
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tU2DSreq
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F8F53E9EEC
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 21:36:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A88133C6F35
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 21:35:56 +0100 (CET)
Received: from mail-dy2-x09.google.com (mail-dy2-x09.google.com
 [IPv6:2607:f8b0:4864:36::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 35E141000434
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 21:35:56 +0100 (CET)
Received: by mail-dy2-x09.google.com with SMTP id
 5a478bee46e88-35adc681e1aso1076512eec.0
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 12:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795466154; x=1796070954; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZiUoZIrgmt8812E15sDOWUNDeSr9AO+wA3QqzdqyrUI=;
 b=tU2DSreq0mLsP18Dhswq0y7IH12AczOQIqQtuO1/G1Qzfvaa5mgEpypclVmotLmrDZ
 IXbjq3nyIer9D7zs5KDkXqy9pcoXHDGfVnD+2tqeQ9LrKYTNmqiSScUIjPOIlhazznI0
 0xfCyKJvxBl68ByUYc2wAyl7ikKkQb77c6Vwos6FdkiUCGswkUYK+FD/+4x+hchtpdvv
 W/JOOHMM/vk/YHzDES2u+deM9bVmhxhM+kRPNn3ky/CONCXrkPENst/rrFyqQn0MdFwz
 N9U+dmXwnrj+WTCWNHxXjM3oxzD7ly9dmtYTvlNAoShRdFdhXFbv5pZBhp0+ve6cFHie
 aNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795466154; x=1796070954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZiUoZIrgmt8812E15sDOWUNDeSr9AO+wA3QqzdqyrUI=;
 b=i5W7raNjf2/3JnkmNrUlGsG16wHXV3Mh6qM0L5N2orBmG1/eeKSukWm2Db2oK17DQ1
 6kPpS85+j8TDEvxW8PGdXPNQiSv33fj6SIvlgy+6GUjuKup7Suc7PA0phAbSSsPQr/m1
 TLNHIEeLYbfieijdE+DbLSQBTyRZKhag9EtE24z8AtLOE2u9wQjksuiUnQPUxajlRQ+C
 RmmUW3Euqm4KMf+fLdGQqz9soE+EBDz5xpy/bx67kg9QE7qY5Ia3V2pzwA+2lFHdLtKt
 zgoDWnfnEeTPoAY3xX5WbEtekTouGRki+tNtqBQeF9PnuiDoiLNzu7WIqwdHgEES/zo3
 YFdg==
X-Gm-Message-State: APuU4Z84AljcWgAbmr7uhT/egpxr352UZjVyMZoB9RufONMQFzaqBUe6
 XzMiYh7wktAdTqQ4DtPShPv5QKfDzVtzOkcxcxIwyi0UYoB6eYnh9XgZ
X-Gm-Gg: AZFdTZfKibT5taFVNiW5yyZ9giNqVkXTHZ8qDWPSabHpDpfB/S5syXkJWlMPL6Qws9n
 xYrswBE+BCasAKPkraR9NmuLRlZdLkRT8MqR6hcJRxspsVCk8ulWAYOuBUGCT/h6INiUAU4QugM
 vUdTGEli8628Qs5aF/tVIjP0PbGHGSghRMoz70LbDmij5JqrvrnsYOwfLn9MPxSYoq9msO8WIOj
 GcuNQ2f5O84Yw+MYk6+cK0ewp3TeORWvuAL2u82B8aJFVDKsSV07tGjAIhjC/tloc7sQB0H2Bwy
 ffdrHKE/kjoBTHFlXIewG5vYPCSZr4/wjXosQwckYQFChhWGbuwuTKlBx5EoKqEYYoECni0+a72
 T/Ue+Q/SJ1IklrKSvaTfkgGp2FnGhy+U9CD5u5lMV9HXGAFQWvXvP3kGckRxLXZmUiIWpCrUbn/
 E0EA009hYPZjc8BIhdB8ub7iZCOBVhJNGZWClaVS8bzURgMTgXjzdEETqZx8MjULdI/SEv+8cII
 zdTDawUFf/qEQlAgCEZNr2GfQFR4TiMgi3GvwUFU50lzWV2Qte7aT9s32LJT8RDwijnNp885QPu
 Vcjj+GHrlCbyipKnZcr3EDRZLDi7IJx1qTUPBB0O+yKe2KEnRbL+egzOKXHjrep4HJS9DzeYz8W
 uvDwak7/ckrwkiwl7ktiX765nTX7v+StJrQYxAcE4og==
X-Received: by 2002:a05:7300:b597:b0:386:9e36:df0a with SMTP id
 5a478bee46e88-3869e36e011mr13128074eec.13.1795466154401; 
 Mon, 23 Nov 2026 12:35:54 -0800 (PST)
Received: from
 runnervm0hi8g.ph0myjrepz3epc52e35dqg2ijg.phxx.internal.cloudapp.net
 ([20.169.15.21]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385672ce402sm35828510eec.16.2026.11.23.12.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 12:35:54 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Nov 2026 20:35:52 +0000
Message-ID: <20261123203552.3753-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123162357.256048-2-chrubis@suse.cz>
References: <20261123162357.256048-2-chrubis@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tools/apicmds: Remove tst_fs_has_free
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On Mon Nov 23 17:23:56 2026 +0100, Cyril Hrubis <chrubis@suse.cz> wrote:
> tools/apicmds: Remove tst_fs_has_free

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
