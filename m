Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1151606A31A
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OniZ/I6x
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80AFD3E98EB
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 21:23:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0E7C3E1BEB
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 21:23:43 +0100 (CET)
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7D5481000377
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 21:23:43 +0100 (CET)
Received: by mail-oi2-x07.google.com with SMTP id
 5614622812f47-4b39374fab5so1124666b6e.1
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 13:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793305422; cv=none;
 d=google.com; s=arc-20260327;
 b=VuZlFuxRg5P1WtVBq4XoDUuGMZHWyLuzgm5E9KhRysvjjJv3p1bogMtg7YsGAOxY5+
 3Yvd9fgpZ74D8i33LkaduYKCbPJpvrsSLiK5ML0SllNjafSTH2cjENDhHVjJmLm6MTdP
 m5KCOefH0YHGZ0CgxqOsxd0jqNd51ieqUJuHgJ2XpRNaaMzBlyn7v33A/9qS3DmuFHLk
 LOpA6NiZZKEQ9wmYIVwrT60VGJJqkfpSQOVPGvltXmPVs4QRFM8ZSFF+A2AgwAHF0xz/
 Z79vy7+tHICvV6hTrgj3LVRpIn596wqw0zvp//vrRQ3Fxg0v/hebVJU0qdO3Jwev5kms
 nf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=auMxMOizUfXGP+mbgYzCGzEP9J6KgHvZo32jLMYibtA=;
 fh=/hJnUO1N7Z0bNEay4+H6I/UlSuHaSzYEPx1FbNoSWk8=;
 b=Muvm3RYYM8zoyTvYrOFR5B4nYlthF2C1rgzIqcwDRUvruokoQrWGeT8L6slCI1Euye
 XkdC7nmhfQ4itkEvj4HX71qHisqaQWNNNzuTuNODg/wjlqcO6rOIzwgEx2FcDVarU6dv
 Q+J5kZHdycQh56PXBjUikcolcKzg1GinNg6dGk8gtnVUIGA+kOsc+Ec9+QsFSuBIR8aI
 lqWFnJgoESr/mTK0iEcjkQzJ4CeENQ0ErRZppI7e5htwT9wufzReXYssNk39audsf1Xb
 /mvRWE+EtFSpHiWEncu4lmpcGv0rCPadXAqIn3PGKyf5Zft7gMiUFivg7Tp/72XgLI3R
 JzfA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793305422; x=1793910222; darn=lists.linux.it;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=auMxMOizUfXGP+mbgYzCGzEP9J6KgHvZo32jLMYibtA=;
 b=OniZ/I6x6ZlprxpUeni+eO4kviOkECZ0Cx+AKPkjlVteubxcITs6RWB8tijZwJkWzB
 zSyQzp98zyOzuFfsbQxtugogDzw9dEE5KdLBcczNibE53QZ4coiCvBxUgO2wqBQ0wjbE
 DNXDiK9tEKwGI3OUO6zgJ3L25j94RdMAoxh38RQoaEG43ZcWgD6hcLzYfdSe8q8kjJOs
 h+bqSNjwFN//+3Gujm+2bx5s/vKlAu2ba1axdJZFw28ffoZiWt7/6htlIXpTCROq8WfA
 Gvj77Ak2FarO9foqhHBhnYNmi44Xgzvm1d2p1Q8S7htOXO/G4OlcnHI+3hhH0r/OW6B4
 Ussg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305422; x=1793910222;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=auMxMOizUfXGP+mbgYzCGzEP9J6KgHvZo32jLMYibtA=;
 b=PHu4sPs42i/Vx+CBgmDOSPUbm45jFqZKC+7YeteI/BHeBDt6gZAtkLvJNNE42w51NC
 tCHsXpxVMnIuB+o1IZRiq/CG2rysseBrt/U2Iqp7K17q2/ltiGPNkB6Ow3+MOeKnyorG
 EF6pvEMow6CmGhPrzMS/Rg5v/SCzH001KYT6WS4OXms1oiLN9ppcqFtL4++xOdky7pHG
 LWxk4+JqvVmFJJGmEwK+oVWvkAU8TKKlz2Fj0xy0C/R7A4cqcAGEQteyl1olElCGxzXR
 8yN2wI/0H1RFMvIaD6KEwp1rQikF8em7f9scxpuyyfHRShBN6QyqIeeTRGyV40Ho3J9T
 tH0g==
X-Gm-Message-State: AFq9FYI2dMZST/kU75Tu8OEUk8SwxzMDKz+9dI70Ff0pM2ejS0JUm27x
 1pxO+fwJBkLvPATxh456BuNzScb6FOzb6mePQTfAfA4hMXQvBqDsnbPqQmaCJ01QZvxKJMgpOTT
 yH9ccY+9ryoLAOGijItatqcrNoKUXtpY=
X-Gm-Gg: AYBFou3BtPTo+poyve/HT0/RwPq5aAF5/EW/jRlM/w9TRuG0QEVJrIA6AjqP8sPwnyE
 ja5FM0/6FS48Ku7Uy0Qjlqot7gmjmSDB1/Z9J2jK303bBlyA545F6xcw/Aon1wgCAi7ZUZrrK7S
 j0Sj6DdURLzg44BBDC4e4TaCX+3Q+h+n9EvWzmlL6rSKTy9AwAZf6GQFS2wOS0VvGq4o0PrnimR
 rq1ufl1dH++2LNYF8Vdc0M6iEyGwDUh9/tFHQfv8TbsO1q1E1FBOl3LVQwBNDLaFO9oQhNRME3h
 HpNdM9QXtfwqyPZhv40IQXFNID1Hc39jiQ+/cjLxwJTJU+kQ32k0zdEncpeLOCqmi1OwGxl4KvV
 9+HoB+kripZPro12pS7oyL4SEXULObb4FnJNDAPXVstisWqeyqGX3eYzHzm2B1IQF6ola0Lo=
X-Received: by 2002:a05:6808:bc6:b0:4f5:e12:b47c with SMTP id
 5614622812f47-5640dfec8e9mr256325b6e.48.1793305422014; Thu, 29 Oct 2026
 13:23:42 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029174907.98721-1-dennylin0707@gmail.com>
 <CAOQ4uxhc6a5jdwj+o_pCByYpwOC20=uHj0mi4D5n3UgrTqR7uQ@mail.gmail.com>
 <CAGEkeHdYqS_9wipk9oy=ofo=KbNpOwccuqVEYPg0LqzCykXUrw@mail.gmail.com>
In-Reply-To: <CAGEkeHdYqS_9wipk9oy=ofo=KbNpOwccuqVEYPg0LqzCykXUrw@mail.gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 29 Oct 2026 13:23:31 -0700
X-Gm-Features: AclHuK_gqon3Y7366bnRQsz4vftvXKAtc8OKsPogIpAJ0NX-SMad2Z0IdA2jLuw
Message-ID: <CAGEkeHctUoNiE_zWUgyL7zoKdfb1JFaMnUuV80iqnrHff03pVQ@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] inotify13: check rename cookie pairing after
 adjacent moves
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Following up on my earlier reply, I'd like to confirm that I've understood
your feedback correctly before sending v4.

Below are example outputs for the seven failure diagnostics.

1. Extra event

    file: got unnecessary event 3: mask=0x40 wd=1 cookie=123 len=16 name="entry"

2. Wrong event mask

    file: got event 1: mask=0x80 (expected 0x40) wd=2 cookie=123 name="entry"

3. Wrong watch descriptor

    file: got event 0: mask=0x40 wd=2 (expected 1) cookie=123 name="entry"

4. Wrong filename

    file: got event 0: mask=0x40 wd=1 cookie=123 len=16 name="other"
(expected "entry")

5. Missing event

    file: didn't get event 2: mask=0x80 wd=2 name="entry"

6. Identical cookies for the two FROM events

    file: got second FROM cookie=123 (expected != 123), wd=1 mask=0x40
name="entry"

7. Mismatched cookies for the second FROM/TO pair

    file: got TO cookie=125 (expected 124 from second FROM), wd=2
mask=0x80 name="entry"

Do these follow the pattern you meant? In particular, would you omit any
of the additional event context, such as wd or cookie in the mask-mismatch
message?

I'd appreciate your feedback before I send v4.

Thanks,
Hungyu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
