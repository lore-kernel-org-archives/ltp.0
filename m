Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E4606A31B
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=OXQMsiP0;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=LobJDT9b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792576050; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=fwxFElsoNRlC6KlyvJel/ZyMETPtsw0oenMbJSkfUNA=;
 b=OXQMsiP0CdBhoMyPltJNpGKCYCvf2HQ/qPiBVu8TZX8cTg2qOaMhWabWDlGwXbW3xq01B
 OKuglqzNFQCG+x7JbfpO0RhdwIzYgfsDT3DXv0K8AleS4/9G4S+woCkRgMXCac75FHDfquw
 0fI2xmbhKHA9vasHFgzglZm1ZDNkXk0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E3273CAF4F
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:47:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8FFD3CAB90
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:47:10 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5F5A16009E8
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:47:10 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso521394f8f.2
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 02:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792576030; x=1793180830; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lG/HLzBxpZn5o3GJoP80yGQI+zwviWsIYdBTr7F1g44=;
 b=LobJDT9bke4n2BnpJKfhIQb/dcqFaqOEfRva3FcRFrri6lJENFZWISNHwnGAKA/EPc
 SgW9wTkVflC/XqNYeIF4DaRBgnzPygoHR5U51tXx+EOZcFYxYQvg8pnOTEPSE7KNjRLX
 syFr5c9vDrRz9749Q5NTtfLX3n5REvkAaK8mJ+7yOQxD0jiVF8izg9GWXju9XWmLXxmc
 qKfxUPWkZaOK3EtiuRa/Xg4bwfqLPJqTVyYa6wEr5ILD2qDaWSOyQeUifYWwPOyNzU21
 O2bub+FjX/p0LOv0/SzKHPoSYpU0lJwI04/N3d9NPffYN2PVKmKyC/HADKihLY+nlc3J
 PM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792576030; x=1793180830;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lG/HLzBxpZn5o3GJoP80yGQI+zwviWsIYdBTr7F1g44=;
 b=d49NuyB0dkQIHAn5RwzXjjE8KBID0674naZGbzlxIXhZPZGd2l4ZTTph1rUsCraGQL
 Z6RQXxgV30LV3489rnNgRNT3YfEOGfsA029/J9uwfxAkBWcIbuLqn2Hbm9BC2ireSBqe
 4PgsLX/Q7Ue1FuK7+lP1tWTdCE5xxgwch18FY3nvjLg75bPJEXs5olmObOHAwNxHls9D
 nVdybVoM6upXDMy0E3w18J+70R32J9Q/OcUdDLzktrWYnrVDlXB/Hd3GtNFATMh7lM/F
 yfB+KuYeSO8Pv1Of/U3CgtjmFrRwJv2jltuIAw2KMYLiFR0z+wZ5oxWZAfOqBYRQoTDI
 yQRA==
X-Gm-Message-State: AFq9FYKJdUJz+1SmaZVABBiM3I43pYKAD3LMGATI4zwQOCQyoOSPFJ3V
 mUCUcy1phv3HcWqKKEQ7Oo5DM0Y+5VrhZHsZCuaFVdV1EUySiLBEYJ4Ojqf3JhcFv+3GFjS5njQ
 VfR1eSdU=
X-Gm-Gg: AYBFou0oqmPqiX89CRXyyrh6ZpU4efiTZWfu90iPCgqnhixfdBfdvbgtB73KhcSTRY7
 0btaU0QkjOoSeEe/m4tCshrP4KQ9a0weewOKlmiaFkmJ5PB+iEf1DogvcOs6eSZEnvPlf4rRFr8
 fGoWiNZLaPfQ6hTHHNnIB+Hm2Etlcck6Il3iFylTTNbY04sdIpnQBFZjqIWGc2xQOwqy4phJqZ+
 Va8WRnp3+tb3O8T5Gsfaz5RmOShV2jDjfhrPe86IEoththBIWWShoMXThI9Turf1v2UTPyGnpOL
 13gUcT5TxVjG95rznm6QkBAAK3Eaj785tVhBE5buA6lOFYdw16sA6h7NRVnkJPVV6aSUpSWryGo
 7Turv1QBHKZ3SZKBh67qX0+PQLgMCo+TyrYgyeDUdi2YCuJLx8fvhq0SU593QtCJarjZkpGMV6z
 pOu4uDAXCR1dPpnEYDjx0bs6EB4ME5v/gddWeFZ9bHIQa/x4oD0J0ExP+m93SY/ZF9L/ccn7FV7
 QwkbGs0UkZc+10Y1Pt/DgYuH3ZDrNnOe4A1UHoJcYqDxJ6LBePdIi1AoD2g41hj7sAy3hYyxvJr
 A9I+4c/PHxviSmAqx99mj//tIRBwfDXgQ1t0Rqx/1dZ6GoMJqgvy0/jE/go=
X-Received: by 2002:a05:6000:2dc9:b0:48d:fbdd:4132 with SMTP id
 ffacd0b85a97d-48e264a6345mr3009097f8f.18.1792576029672; 
 Wed, 21 Oct 2026 02:47:09 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25841fe4sm4658647f8f.53.2026.10.21.02.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:47:09 -0700 (PDT)
Message-ID: <1K7ZVw9h5VIY7Ci5Tj2lvX4vNdDfmn6kkAzA@localhost.localdomain>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20261008074428.480353-1-cyyang772@andestech.com>
Date: Wed, 21 Oct 2026 09:47:08 +0000
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Update call sites of SAFE_WRITE() to use the enum
 values
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Victor,

can you send a new version? This patch doesn't apply:
https://github.com/linux-test-project/ltp/actions/runs/37746844459

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
