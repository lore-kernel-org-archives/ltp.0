Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED086606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VFhXaJE1
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E4AE3E5E9C
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 07:31:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCA5C3E1B9B
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 07:31:28 +0100 (CET)
Received: from mail-dy2-x0a.google.com (mail-dy2-x0a.google.com
 [IPv6:2607:f8b0:4864:36::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A27D6200AFC
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 07:31:28 +0100 (CET)
Received: by mail-dy2-x0a.google.com with SMTP id
 5a478bee46e88-33e5ae86ff2so176631eec.0
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 23:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793341887; x=1793946687; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ia0M6RP6hns0vE4jUYZWPP01LXCK8Z1YBcgYm9AkolM=;
 b=VFhXaJE16KuH/YYqy4GfSRwqEwq3wX52FXDcACYgqzC7tul+Lg22LAUhBZE+omrbG8
 /1ROfSrYBW8/d7errwlPdWFS99o1w1V5I+4WAK+5HIFepUfBRnjiKc9H5cwv2tZA/vQu
 Nuw/oFXQ1JGh101I8ssPcipnXEknPPLwa2jWXOwwMGkqZ4jvtzOLIahakgcKwUgzhyiI
 1v3oNIlOgnbf9ioS4DRy7qh2q/3S8I3l8VGEyV4WsAoYj67vTT84rFtk7hG+LnxOsiRt
 6CwNui84ZAwmb1HCtHCfNIx7d0U5mMoeQGe+5OE2DCFSeSn87STLdE1FOFpdkITwNOYI
 j9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793341887; x=1793946687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ia0M6RP6hns0vE4jUYZWPP01LXCK8Z1YBcgYm9AkolM=;
 b=XcY86S+8hI+IWo88x+OfMpY6xnOY5TZdIKH/e44xtqa48MluKdVwv0EnUaIO+44q9s
 ZOSU+MGgsyPRWqOzsM7aBIvBUOFVUrXS9Iged/xcOWvn6jY6k91+tVWzQdStQWmvqxfw
 GtycqAJp3IGiAF2girzzile4DF0wgfnLMsOnhx8LULRUyM+dPViJMw5EFSn8NQzwCSxq
 qG8DTf1mJFKHn0Q2PgLY8UeEBx8nM+/+bd2ZsMS8lbzGrKh2Sn31rrA3RyeGEJ7G875d
 UkFJoynK/1t5BnTHLSVlM529N3Q6HL08YGzLWxbUKalwqrP3HA1O3j/5qvL4V8wFNkhZ
 n2Hg==
X-Gm-Message-State: AFq9FYK0yphcYzEaliQRAQ3HHKNUCft57CQUDf/0uAvnWBTYFSunVHnn
 /bGCvkcjpn3G3+OtYv0tTcLLsR4OchUeCRtcOdr1/YUgc6GtV7zdUwN2
X-Gm-Gg: AYBFou1OmjgEP1wcAqP9rMiGT2aYg01EfA7KPL9T2Gg+i46YD9Fs0huDn2is80cVzNs
 hc/aoy+Wh4pM6aWwL5VLlJoZ3gobQk3nPgOXOwejqeFVvhpOlNFseWdolFex7tqgHyiaBgTq2PO
 VGXiws07n/tlzTR4y+jmfQkuNE5FWmVOssqjAMg0TgoQ98e7jBOEerYh0Tsf//g653S17dL86xg
 V3tlB5voTKM+cRIYKrcX6H9XLsiqJzEQr1NrOa477sICCKMbXGKB7NgXU99gjXmp0MdYh518O9m
 w2iq/1v8EvPgJlt5dToB5gfUaXdR+phxLQEiJwTllrWBajx1yq1/exBYRWdAJGYCYE9cldQx7ic
 +iZZKBhqwzAckZ4zjZsSDJJxH4/ZS4oHc14xIsX4lYinwAKm+ONYXR7SXr/t95UGAnClNu6emO2
 iDfrmTWnuGxk2NQc/dC2POqaOyVT4O1kOMFdQ5kZF2SHaeDNSY4vxN/LnMSuNgRr2BiS9zupl6X
 ykKbUfMauBXuANHIplUvraI/3zoGCWj1BrpGrIxGTCLkHk/gif5PJkazQSer8Ftgk+jdFvdGgBj
 kwKuFf7GxX5vsIF+ArT5+qyiU44mk0Kt8lkWH4cSJ+kauPxWR/x1d2Hwcz301ZqVZDoyMpaSJ3y
 hdZlyAeGNd0eYYnlRK5/Iocwcduu7mBLSFiojKyO0oUD3ZMOXJUtxUVA++y7IeIlb
X-Received: by 2002:a05:693c:894f:20b0:369:d992:e3 with SMTP id
 5a478bee46e88-36a4242b2ebmr2195110eec.32.1793341886847; 
 Thu, 29 Oct 2026 23:31:26 -0700 (PDT)
Received: from
 runnervmnwato.03fzkgyjk4sufb0lu3udtljy1h.phxx.internal.cloudapp.net
 ([20.163.39.224]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm4850986eec.20.2026.10.29.23.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 23:31:26 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Fri, 30 Oct 2026 06:31:25 +0000
Message-ID: <20261030063125.3552-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030031329.354771-1-wakel@google.com>
References: <20261030031329.354771-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] splice08: Keep calling splice() until all bytes are
 spliced
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

Hi Wake,

On Fri Oct 30 03:13:28 2026 +0000, Wake Liu <wakel@google.com> wrote:
> splice08: Keep calling splice() until all bytes are spliced

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
