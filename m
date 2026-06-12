Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942D0CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 09:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781255851; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=T1XRuO3t3DDSIi6DvcC6dwJzCHDLv8OGSCRtxtkrTCE=;
 b=dMLiRoK8u7zb3aFCundtUrxx0ve2uavYvDnmGM54jrng4ECGORS4OdxJAhYmdHRnb5b2e
 VivwzZdol4xwjlw4qsbZ+eSb2d0WEatqT5GUj0TO8F0SNuZodr7JBYzUSZb2ithx7Y/krq7
 3IkAWwx5SGuXLOlbp+5rKcBSQEK53hA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DFC93E2C3F
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 11:17:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE9833C0528
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:17:10 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 70F816008F8
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:17:10 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso367505f8f.3
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781255830; x=1781860630; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zNGgJzI0GHdSKsqDhA+PTMn4Zaw4vOWtHXIV3Aef6rw=;
 b=NwjiRs0B38y1PGNfZUM/4b+aIVjsGuoxWpwHtDaO9fsLgbuHeZHf5S3j8sUBYtVy/0
 t5SKdD0P8zLB6GkYaNitIkeC4OSX+4kdmj5y6SVKERsEjBYGLzoqLdRas1Q5Vg18dtjp
 mVndYQzrOtmq3KN095wPLMYfQyj67/Tp2CSPg0mHha21US2nd8phu3trwYdTa4KHZHts
 qii6eerPACZrX5XQ1ut1lCIjxHGXBh/iHPanhdoV5W5wcDpz4yGVXdAPBCbPyeSCs8v6
 OTnuQNMmXy2STtgiNLc/8ubotEUJUKwc0mGPGY74kjJN2U5jeOhcCjVhGLOu0VtKQKMs
 wFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781255830; x=1781860630;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNGgJzI0GHdSKsqDhA+PTMn4Zaw4vOWtHXIV3Aef6rw=;
 b=iixS79e072xsce/EfjvVp2/P3yU55CK1F0v3jkfEU53demHQB23NHQKPprtfRGrMoj
 xxvp5RVPeBRROmDTwJEXVvA9qjk5iBX7FRy9YjtKvUhLb8JMGVgLksN3DJSeAoVR7Bjk
 dvApUI2iwMxCh1f/VZla3KK1I8qk+3F/Q47/SEivGVE5VSonq5Jr4nNp1TxsyEMQL79o
 tNwqKyLZaJl8jgsho6OqYnohqqi8K50c+cx125KbcEQCEIqSvntnSBWnGXpIlFMQBsn2
 0FieZWEyxwwmC0Vjt54mQOjfh6UuhFABDV6OgDPMShjfr6FTBBQcjd75sBD/4ICEHR7A
 uFKA==
X-Gm-Message-State: AOJu0YxHubsZs7EEIVj+t88o1lO65ZUl5u3kXeIJBRqO4uT1AUba0iuK
 aOtq/ITrfzNa1THk3lxTuvZussw5xeYk+8jHm681Y6fy6KwI4cbvFMGxR4fek71TweDq76dHv4s
 Nw99f6VsXEQ==
X-Gm-Gg: Acq92OED9TmcmlggoRSCi7Lf1kgz7D9vfgJQwbnrPbXSaLZrroZY+JqvBZbi8x8jSGM
 D1QPHj/kfQcZsa5b3Y4dGRr5Sw1wvd1Q+SrpNRfn9mES82geG5zyVh1oB98mIyDWsKpu7q50JcV
 ZBJvDsXAUMziA6fFlFr8OM+XpkrOhWYDNiR80hHE5QSocTkHURgK1McAhEQ2duZUTACsk7wfw/V
 0gr0xmM+sIGwXzm9tAXSKq2kuG3Y2kwi2JtaFP+NYzxpeLmRQCjj2sbidK6/OPozVNB+U1aix+i
 BWbz/K3ADlDRpSKsUqFLUUCyk2OdKvNCpuBHQLB0la84l1MNcMtE05VULQk2FrZXyzyJEP9Mvrl
 lUlNnuWav/mJADwKtDbw2i8NoLMHxIVhsPhQZesAiBF4St1uVeOJMTnd1laWIlGb44O8Vx6z85n
 wUM6FdC9XXkfL4tq8A9gvZjFFOv5KB/aSnJ/u/3euLjfndYBaEJDFgZkCwoIEMxqLTg7CjT3bqO
 nW7mLaL/Y0tqcEsvEgHsMrH9w7ZfVobV/z2nHYXuWFbkf+hljVhYalSvTvUdvKVecSGA0S/qOoX
 +Q==
X-Received: by 2002:a05:6000:2004:b0:460:f36:79b0 with SMTP id
 ffacd0b85a97d-4606da778a7mr2642899f8f.19.1781255829703; 
 Fri, 12 Jun 2026 02:17:09 -0700 (PDT)
Received: from p200300ef2f13eb00017f7d76deb7e8bb.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f23fsm3869175f8f.9.2026.06.12.02.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 02:17:09 -0700 (PDT)
Message-ID: <6a2bce95.53cb9477.13cf23.7006@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260524154221.2064-1-always.starving0@gmail.com>
Date: Fri, 12 Jun 2026 09:17:08 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] power_management: rewrite runpwtests04.sh in C
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

Hi Jinseok,

for some reasons I didn't receive your [3] in my ML, but I have
the CI results and the patch-set needs to be fixed because it
doesn't apply:

https://github.com/linux-test-project/ltp/actions/runs/27367707128

Please send v4.

Thanks,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
