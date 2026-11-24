Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F32606A33A
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=e7HuSyJ6;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TbPZWJ4G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795509800; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=QAn1jay+pRyhTO2HFHKXBH4BKyaWuNxEhNhaHVwrX5k=;
 b=e7HuSyJ61vBmr+xtTIz2aYfJKuWiNfrsmYmacEdj/KzayR0Wecwer4Mks5od2tZCg+Sus
 cksyYl1XQFuKgcm66XiO9evVSNZSrHwwTWJucuk3sXQcvnusFuyaMO1ziVLGz7TRDIXy/+S
 fIJgPctopfhhNKOLFNJ4U2aMDvuoICQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 590F23E981F
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 09:43:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D7DE3C8540
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 09:42:39 +0100 (CET)
Received: from mail-pl1-x645.google.com (mail-pl1-x645.google.com
 [IPv6:2607:f8b0:4864:20::645])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4B8352002C9
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 09:42:39 +0100 (CET)
Received: by mail-pl1-x645.google.com with SMTP id
 d9443c01a7336-2f04561ee04so24861135ad.1
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 00:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795509757; x=1796114557; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sXsO910sYeL6Dqvs9z0YfF4n1aUrA82hvbIYu9TROrQ=;
 b=TbPZWJ4GuoII1thbKgOxGrfVFnF3SL5Nj5ejHYHDFclUDJj0DZXO8TJjB+4zl7B8ff
 Wtw6GbVx6qnuou8859LjMmQ/LnJKQJ+Wbqy283A2s02l4qBtAlCH1AOPWuT/Fr+hddGm
 kM1EyTX6114BYy7skh1+Mnkpfteyr/Rm7Gnax9FKPiNYiCNsV1dxSdBa3pNMMkFEqXt/
 O9rxrMsCRGmRjHFxzFcQEYOzl4k63wpDrr3wLcI7JddjrsEkCsFQ0sWMH7y16zRNxkoc
 IOK3te6ZyYgg4HdSQbgcmIDyl+h897aseVHD0maXI11e4TwpLCFNFfxzJp+D2xBRoYPW
 g5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795509757; x=1796114557;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sXsO910sYeL6Dqvs9z0YfF4n1aUrA82hvbIYu9TROrQ=;
 b=R+hp42nU20tU246FiGEs8FHhqI6BK1wbviWA52AawZq+BwXjKRlEe/a8/oa6zVhle8
 SHFXqxX4RbKIl8JI/9BASKaDjrbz63jsFgtYEf0lE336zI8qizGS0c02rrbJQwYJip+q
 H47fNCgffNxY4k2l84K1jcM7B543cKEqDt/lI2TIp8HMe2FrPwWybclJqZw3gzholF7b
 5QJxj3Sgt+XQ8JXHPChz3dZNhpPmP/cmCj0Zx8P+yo76+e74J3vKcfgHfviCX67fFTog
 k4qtXrdIY+/h8kxipRH1v3IBVvySBgx3TC13+y00zhEjzzaiUzFWRI0kzORFfgCrb57g
 lDPg==
X-Gm-Message-State: APuU4Z9cnDp++avqgto6rKw/YGy8KXl+X2/vX9fRAKgSUugcg47MDm90
 uXM7InfFcx1nmE/KnoL9YHUAUuOeggFwkSwZ9VfNgd1Ma3Y62Ksnw9f8D73uAc+5xVWn8jLgG40
 V0lXh7mGjuB+nrs9lPZ2t2JmnbP/EDlGNzO7FsH5JHngCLLf/kRteKwkhnboKgSW5lg/czkr8iG
 Qa8UP7+ChJDrJH+TxD/6vpnlA/9A==
X-Received: from plho13.prod.google.com ([2002:a17:903:23cd:b0:2e4:afb6:7889])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db11:b0:2e5:54c6:e5c9
 with SMTP id d9443c01a7336-2f03ef870c8mr140660315ad.2.1795509757276; Tue, 24
 Nov 2026 00:42:37 -0800 (PST)
Date: Tue, 24 Nov 2026 08:42:34 +0000
In-Reply-To: <20261116142206.3151308-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261116142206.3151308-1-wakel@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124084234.2967267-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/4] Don't derive kernel granularities from
 getpagesize()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>, Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Gentle ping on this v2 series:
https://patchwork.kernel.org/project/ltp/list/?series=1212845

Please let me know if you have any feedback or questions.

Thanks,
Wake

On Mon, Nov 16, 2026 at 02:22:02PM +0000, Wake Liu wrote:
> Several tests derive kernel internal granularities from getpagesize():
> the size of a pipe buffer, the granularity memory is faulted in and
> cached with, or the page size reported by PROCMAP_QUERY. On mainline
> kernels all of these are the same value, so the assumption never shows.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
