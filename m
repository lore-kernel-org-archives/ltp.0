Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5AD606A31F
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UryY5vGO
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2DC33E60E3
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 19:55:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E11413E1B79
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 19:54:57 +0100 (CET)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 73C561000D40
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 19:54:57 +0100 (CET)
Received: by mail-qk2-x01.google.com with SMTP id
 d75a77b69052e-5332a0f6dbbso20150181cf.1
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793386496; x=1793991296; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ezV9cBVv+ck46J9uEjtkHTt45p1UgffHXCJXZPeFASw=;
 b=UryY5vGO7R6Q4La1jyYwQsADRu09zLO/HFOhTTAwgWnxrkEW9UEvyX1tIbjOKN+WGT
 z1SKXBSEBsJL5vrMprBRELydOAQsz95844ZpfambiIUGuuWa1UDuY7PIn8B+9s8LxPGv
 aY7ObcCLIZcGNYGqF4dP2xUE1Nech9xgmZ4q6qACDAhqTTz4bjrvniel1+v6Q3zVETwu
 zwgwQ0OMmlfqCYl0JwmtFAf/qsizJqmJXPWWmFwjdk/EghWld06T3tOvrGLKTzI8FZAq
 6FsgwPE0O7plJeBdQo84aBV+pRaivz8vyZ/FmBKoZ6raYL5PRNJ49apBGp/GdI55lXKM
 n8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386496; x=1793991296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ezV9cBVv+ck46J9uEjtkHTt45p1UgffHXCJXZPeFASw=;
 b=XmCRwxINIJdPjynoSEMqHY3yWLqf03Izos/MVD/s97B9AdcKYjMVQHqqdukAt4JV/9
 Xj8+YKifN+1RtAaW0z4BpElJ7SaG0LyLB+MrsKfW60Xh0ogREKuZeB/zko3rn06JUzOy
 8aVwHYJpUFBDBm0o+UaBSPRN2f/D7RdpVDQHBGscxLbJI8vHE2JTQIeEBKSShL4Seua+
 2xA7YY4mWvMzICXUGNqj99rBIifItC2RilH1F5gnqlRNNy3nHDLjbOEd9HAhWZZsx1P+
 JxxKLddhEOU7jj17x59RMqJa8NRysxfjtCRDWVDCQ3Zpj4ou6MR4FmUaAQLKDQ9+VIiR
 5RbA==
X-Gm-Message-State: AFq9FYJUPTLtgZh6vgvgZmIrVqM9eYcmESeaL0WsYvfTLb4JccI1vE/X
 opTy7WqDvNk6UyuzLwEWy7GLHpXk6XwAknf23M6dprB3oFBC6ioOwTrT
X-Gm-Gg: AYBFou2DNemFHXNZ6Yxjd8/j8GziJh0ADyQdCLer6+3e6TD1gUedTgDJSV2MNGMhikd
 udFtVMxV0ZNqda/oJmed7UjUWaKAUGXTKbbMG3Zhy1drHi2mKZUPNWMlOo4NtQAeiiVwzhWqzPI
 xE6/FHNGjQ2oeWZp+1a+g1cqsS1ItvyIzMW/dhXpB/iExU3PpmHbokxiYxHBBwUfn07TBa4XLWu
 ef6a1XFK5WdMmHuMmZYWYIuUIBpdhC0hP7TRMPVW4oLrf/rGjjnObuw3nnfg3LKT+99ayutzFrT
 BpLhzEEy3DqUOqRBB3uUUlxQGKRh/Dh1MXYDFYDFfCvYTAg0g4snmbZKcw0sy5quebih8yGXJQo
 EnjrTsxbOv54ARaEYTHMKsHmdywDOUNZzebf6Wq4ErCiikxIj6pX1nMgqUxMOwBlclNq5GY2E/N
 f16m68NCxwnrJFDokoObaoeB9GXLkndf898f9IV3B+aPr3byouSZBEabhtw63rB3QqnY3tL3iMa
 5r5wpXSzrwWZknR0lJTK+PLzNvU0Fz1eVZWcmSsKNrnQKgSQ7AyrXOCFmOvwmqy2sUAp3tHHcpX
 3qv8wFyQaKnrs6HOqBDQqQsBifP41sW/NIcrhE78PqEYVHR8YVLesc7GkCnAC8ua3HOgndnrEG8
 teq2MVOcd3a88SUZvvsQI1mY10eTa0uOu01lpAxQnzg==
X-Received: by 2002:a05:622a:410f:b0:535:2314:6280 with SMTP id
 d75a77b69052e-542b639bf45mr49371331cf.17.1793386495927; 
 Fri, 30 Oct 2026 11:54:55 -0700 (PDT)
Received: from
 runnervmnwato.5ytjgfrvparuvbxwxzkd3qyide.bx.internal.cloudapp.net
 ([48.217.148.83]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca8082914sm21892546d6.42.2026.10.30.11.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:54:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Oct 2026 18:54:54 +0000
Message-ID: <20261030185454.3746-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030154001.8928-1-pvorel@suse.cz>
References: <20261030154001.8928-1-pvorel@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_net.sh: Allow test to force netns
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

Hi Petr,

On Fri Oct 30 16:40:00 2026 +0100, Petr Vorel <pvorel@suse.cz> wrote:
> tst_net.sh: Allow test to force netns

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
