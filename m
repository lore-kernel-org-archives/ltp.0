Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F04606A323
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=GUHyEuLg;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PHLzalUk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794324398; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type : sender : from;
 bh=Om4qn7YzlUmDvfr17AMO7kzIAY+gptnfBFRRH1rPYiA=;
 b=GUHyEuLghqyOeZ86Oxdz1rS//L+sA8WrizqAl1eNqOcC0u4GodZL4fEENJtbKfbNPFYo/
 yaSPzBcMN1c78R5kqUaM45QeAKMYUk4BIqVA7nDDSAVYT5z5jXMCHJgshXVPqy2XlCUsBsi
 Y3q8DPlIk2yX08IhM10ddbi4n77M4/Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D3023EAC87
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 16:26:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C94A3CB306
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 16:26:19 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AC8251000969
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 16:26:18 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so16400605e9.3
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 07:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794324378; x=1794929178; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=35G8BKdxGvUMJs0Ec6nUy0MswXfPZ9vS8+ftd16qUL8=;
 b=PHLzalUkfQ8hTuFDDN8mezT3vE2Y9DZxgR7MHTV3OWCmFMHM2+lGNHnuNSU9rymrHW
 4TmyRe4GZFc00C2FeAvRnAYNVZctrurkDStNw911MNZmQccpLRA3TTVzIqbuinT5GbvX
 y0LngMweTS4T6b1K/FkoXRkgs+izTN9ilS5deXpy1JYZyw62Mui82b1AMB9xMugDTe/V
 J0aZSj3DKv+aZWVvCDdnA4ds7qPRnSAEfF6gWkRDiEMxCZmKXU+2CnLI80R9Vfb0p9tv
 MRHTHn+WUS+/Y+ZG9w3vSgxd2g3AIwG5syy0yKCLQXsq3sT0jRtQYtnchyRnRa/TemdC
 9qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794324378; x=1794929178;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=35G8BKdxGvUMJs0Ec6nUy0MswXfPZ9vS8+ftd16qUL8=;
 b=u35YVtJrdKCc9Pen77Q2Jo57+vz3KFrsiS+JKtPnpRKIk8hJlLSPnCJudt9unDPtMD
 TLsAx1nI74b1fMZyP43yWOdN8xQqpOd1YUY8gQcnnyvXwV1e7RYNWme6dcwWzjUnVoN4
 fwExkEVXr+uSVZEL9r5h2GqocAkhuYh7UCXnLIl9ISXcyDlphkMHpBRwWfl3kGebD1rT
 rp8Yk+tzZxCWmrRpePBP0DFo657dCP2COCaPLJCFLYkiMsy+/Um1dov7DOdFMZlva0KC
 HwZg7zjclkco+ZPeXplFTqE9ZVIvLaobYXd1xi/n5kvwF9ASXM2TLkWPT+gyMQYa2CTN
 ezGg==
X-Gm-Message-State: APuU4Z+agAusgOXu1zmx/UgPu9b/DQoR2H3YZj/jotB4jAz1lgWY+fms
 JII3jwWJuKi9hq6ALkID6GqswSdMWl3Q+o5RBMlvZLxThHAgI+AKZhCeYaRqQbL3ufw=
X-Gm-Gg: AYBFou1xh38SRVbYbgTlGJ5v+70H6yt37TfYbiRzkp8eamPhSrqFAWi50Fpn0xMwQyp
 NpIwyMr+zZ/4j9mMaDSkhB5tRrVgMqm11xlj4qBRWKaAAfJXoFCHYzk1WMNpaHfq9bnhc797EU7
 SgRP0RQ4OLd0JlafOXrV+VuAu1cySrQIR2r+03z9pEW3G2zPtyUl4GfPyxGYMnN1er+jTH6ivoR
 9shawjlOF3vpzw6+y2sl8tAOSYL7zUG/MhHMVdCMdtK9/NlY8ucH9q99wlRY9U5OneA2UOGpseB
 u5vM+8DqeKthM7psrjqkA7DwFrhbyxmGxrt1IpZwd752+z7rf/JmoiqUZ2UaI6cRfcYWwZurYBI
 Fj1dSHBh23XWc53CyCxfe6WOzZAS+oovGWdX9j4Zb5vTppQN3ks9ASlbJZvWXRKRBK4wJnYwUt+
 WA5BxCxQuLFlxaL/25zbaz2X5ajNtI12DQhZW4o430MekApTmALRnF1pqN0PlLroffnuICRsAlJ
 1SmOZU6MYcpzdCOUChYr59QkIeKEeR9qO4AnJ8dSD6yaBVEzzDvIqqbuLuONuUZd9zupljrZWiJ
 MPLZhT91xQD/F1/KMhgNK9PUVbq8VxDA
X-Received: by 2002:a05:600c:4684:b0:4a1:fa27:df7c with SMTP id
 5b1f17b1804b1-4ba02356509mr52932515e9.34.1794324377643; 
 Tue, 10 Nov 2026 07:26:17 -0800 (PST)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01feee1asm91364785e9.12.2026.11.10.07.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:26:17 -0800 (PST)
Date: Tue, 10 Nov 2026 16:26:15 +0100
To: Wei Gao <wegao@suse.com>
Message-ID: <avM3ieRhvyhTOCOE@localhost.localdomain>
References: <20260929022340.524-1-wegao@suse.com>
 <20260930035332.3360-1-wegao@suse.com>
 <20260930035332.3360-2-wegao@suse.com>
 <atmrQp-ahBUw6x-W@autotest-wegao.qe.prg2.suse.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <atmrQp-ahBUw6x-W@autotest-wegao.qe.prg2.suse.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] memcontrol: Add bind_to_current_cpu()
 helper
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: =?utf-8?q?Michal_Koutn=C3=BD_via_ltp?= <ltp@lists.linux.it>
Reply-To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1338433130=="
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


--===============1338433130==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ycsoacvxcunikgl6"
Content-Disposition: inline


--ycsoacvxcunikgl6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] memcontrol: Add bind_to_current_cpu() helper
MIME-Version: 1.0

On Thu, Oct 22, 2026 at 06:20:50AM +0000, Wei Gao <wegao@suse.com> wrote:
> Hi Michal

Hello Wei.

>=20
> Could you help check this patch? I already change to pinning to the
> single CPU for all arch.

I have nothing more to add to the patch. (Cyril hints better how to
integrate it with existing helpers.)

Maybe I'd add a comment right next to the setup to explain
	/* reduce per CPU stocks for more stable results */


Michal

--ycsoacvxcunikgl6--

--===============1338433130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1338433130==--
