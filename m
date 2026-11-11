Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3E9606A32A
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=cFjcriFy;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JA1Zy2wM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794419259; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type : sender : from;
 bh=W/DFGWzELROQy+qQDdNDP2F9y6RADVdjcXin+fuBKgY=;
 b=cFjcriFyoDuh3BZ1mVO91EJBwwWZydNilPjg04Wi0m6hwo2yZc7TyHDc/4t+XnO6yBRLa
 uIAC1sGa3MoeOMFeRV6Tdr9FXeoUWDzg5xWYN8ezZcGO/tjiNRhw2Oiu0RKbVOQcPEUoewA
 XDLjrlshlGosh4Xg4EYjNMeksoRmnNg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECC363EA0E1
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 18:47:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 942FB3C1924
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 18:47:18 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DB5791A008B9
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 18:47:16 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so42676365e9.3
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 09:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794419236; x=1795024036; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/xQBb6MxcZtktYDOD4sSemr08z70fBqhbp5t9cDMHqg=;
 b=JA1Zy2wMv3svhqq/LPWa33IxhCvPPEy7UlYY+3KD8C/xXQCqdawg7iCbMqzom+FbzO
 gEDuhYe+iov3v/Y7fTcax/BOVBoAsIB6+35fySQIjpaKDvus/bj2g9omzmGFU7IB8upN
 YjthNiTGvakbsvowgoywVVgXJRepiHo/O3BEf91iEqLcVYDjQ9yOgpIQjG9gYWqT1I28
 tkCBv/eCZKPWcoG9/V7crzPG6j6jfRMo/Or6djy9lFK8JbGc/Z1v+sOHsC46k2EX39HD
 SHw8zrxcclmBkGl7O992Qii1oth4psaQ4zZYaaQ7X61aQQxruh8IDJnzhL/JNWX6bNEZ
 pGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794419236; x=1795024036;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/xQBb6MxcZtktYDOD4sSemr08z70fBqhbp5t9cDMHqg=;
 b=conj9J8WjWfb8E18EhBDbvANsPCW8ujqZcKtmi4lEnmvFbezLOrf1CfGOEz2EW4nwm
 mRrLynacNOi552cmCYDZq8hy+dvAMBqWSFwkglL06wXdOoH7u1FYp3L4FWazv4gEPUaZ
 r3yIbbduPGOl4oZKpwTJiWpwBaRN/wxCQQ87GBEaoPGBNRTBfVqzzQwOtHTm9E3YT9Tq
 JrTL9ve851rVG3DZWSUIO47CEMHi8c+hBEO53iEAgx6LqDZ1pOZa3flEBTDVrmd2kL2T
 mErJMjyB2eSJ808367t0wMcGLWecyZpxNsKmC/IbPRd7yBrdBoWWKkL+1PBkCJnS59is
 c0lw==
X-Gm-Message-State: APuU4Z/nlLALKywZFkOyYYT0NS8LaQaOQmGitbpsnb3dvoSKhyMR1yE2
 KGQCd5JBmJYlGkbY4dgq60z6od2HfcnqNKQ3NYe15EuZiicamwHZBFvc1ic8Ck7YC+0=
X-Gm-Gg: AYBFou3dGFzKaOXWuOObXhBdHNRJk09OBZiTDUy8ngeNn8xY8XZBkz1l4f1+UDQmh3i
 VYb00LUja6cCYXfAvabnmRofDtwNYAJl6aoBHNs7CkxI191PGwFo9ecmFaExfnnDl76gvAbYDK7
 BGMhTjlShK88s2b4oH9tWKBXnrhdThJHl9uKV0spdJ3aFODLIa7DSrclBWTaD7DHyt0S4h31S+R
 RG1k2DXyKqBQz9UhmODdjhMLg3tQutWpFoCmMhTodt6GH09qi0Whj+xk+vVKzAXQFsQeoKxYHo3
 STZ6wQvLSGwXxW97J0e2QKcVuI8FrBUdStt5ecSHJ6IVbDizLv1x71Mjrlx+5XlxMNhKTrk6uxW
 qlb/c2ca2IIIGo2pnpGK1Pr7pctn6MEWhHWvo7UdFAvgN7yWCL+1gPicxXP0teLktskXZpry+Tt
 ijvu2vFF3CvjNU9aNVwXhT25CjPVIzH31lcKV50nYJ4tcsurlCtw3u9RYKHMbMpkBGmIrVkIoLV
 j6CbQM3S4dVl76Tshn3slnTfvE/xZFmVQs/GnpSiumHAnwsSqnFEv5EgRrE/rCAYf3Q4twtcoBC
 VOeHxACAM34j1Wb6c9mA61xwhd4uTpii
X-Received: by 2002:a05:600c:6095:b0:4a2:10f9:37ce with SMTP id
 5b1f17b1804b1-4ba09381439mr60935695e9.15.1794419236217; 
 Wed, 11 Nov 2026 09:47:16 -0800 (PST)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2538b9sm8544675e9.1.2026.11.11.09.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:47:15 -0800 (PST)
Date: Wed, 11 Nov 2026 18:47:13 +0100
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <avSp8HV3he2he28I@localhost.localdomain>
References: <20261108062034.41022-1-pavrampu@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261108062034.41022-1-pavrampu@linux.ibm.com>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v8] memcg/memcontrol05: add cgroup v2 task
 migration charge accounting test
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
Content-Type: multipart/mixed; boundary="===============0312245362=="
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


--===============0312245362==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rz354un3dcgm5zec"
Content-Disposition: inline


--rz354un3dcgm5zec
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v8] memcg/memcontrol05: add cgroup v2 task migration
 charge accounting test
MIME-Version: 1.0

Hello.

On Sun, Nov 08, 2026 at 11:50:34AM +0530, Pavithra <pavrampu@linux.ibm.com> wrote:
> Verify that in cgroup v2, memory charges remain pinned to the cgroup
> that allocated them when a task migrates, and that new allocations after
> migration are charged to the destination cgroup.

The staticness of memory charges is "non-functional" feature of cgroup
v2. Could you explain more the real word motivation behind this case?

(Each such testcase is subject to noise and it's good to understand
what/why are the expectations.)

Thanks,
Michal

--rz354un3dcgm5zec--

--===============0312245362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0312245362==--
