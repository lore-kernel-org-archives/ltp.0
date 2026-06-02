Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AB5CD6E4A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 04:06:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0DB23E7250
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 06:06:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FF743E0D5A
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 06:06:04 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AF7251001260
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 06:06:03 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-915336b83adso400372785a.2
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780373162; x=1780977962; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yV4y/R0iCC0A5l3HjIRUyremeM2pWdieY0eWWdTpUqU=;
 b=ZaPUTmlr/EniT3IwJcB02KqFkgRe0Fi5cI0vNAwdNRZ92weO1U5wCv+RdSebFLUFae
 Hyn74oletBtSCno9Nl7kGYCoZ1WpwEnS7yhj/C40qCODoigN0tPaDRq4MBJlJ9h08sCe
 rWM1DIa9ueb2OejXCH80cJZ40/gYrq5EaC25pTEIT6Z+B0+3s+7bBxshDxmQ2IGRpZtx
 7PK2RhHIT1KssC09LORIe79Pt537un7tn8EHWqNbWZ32QQ+kT1+0VTDLno3MDjRV6pW9
 4JHE3Nw6tb5+EJX1UKMwpGgYNdrcstee9QBLm9jS0UlWP26E6pDVC+ZoMCJ1ol8OvPCe
 rymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780373162; x=1780977962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yV4y/R0iCC0A5l3HjIRUyremeM2pWdieY0eWWdTpUqU=;
 b=QJ9uPhMTaXxMqFCm4oQ5BhfKQBfYQthUktuKKta3YvtA9Hq7d/dhH4h5oxBMxb//m2
 1S/2AU+TIaub6tjqy5ycmDLY1pxFBnkUN4CddjJf+goiMc208P6XlKM8xzTQMrtwmvuJ
 khF08KVh5nlepOyOHU2tLfrVwEhwia2C7esVKPZeunnwXCMnrUdJR7B0Io/PN75lwVXl
 1vk/AjnQ6oxSYkFkgO1gHs5YxEHjnLza3dD3mOXQi9KygoP8zhDmPAFqX2Lw/is8r8fF
 VUovi15DRBuXIYIYIqCN1Z1YzSdzQrvmKEORvlGQySzoqBLTBo/dktvrJIclnYmzY6XF
 qKeA==
X-Gm-Message-State: AOJu0Yzwy0B0Zxw+2Plubm+59x6uVysfbqHxa+RjotjOZyozAInrfDg/
 fM+4Vl9YxPvxkunzNRLLM23x85A6ZMxnKskekyLfOMFJaiZtNFaNfBC7
X-Gm-Gg: Acq92OHZ8aBeCXrsUhxliDFztrsdzQ2xhcABgy9Mp5X73q4P7Dn386nZDq+IX4jojoQ
 4nJNlvA2B8XiMO6JA7LT4rWJvniWIS2BuFRFOdNqfPmlmYmerhVwoJsdIG1pAXi+VQXNVn9ellq
 41MSgIWc8hVF5ktIOjq5KdtFBnW1wBOCTzA94N5H+hh+a/K2MIUQMQwwWwaWs76RGPXG9nj5HOB
 6ayiT9L/8cytnAyBvVCQJZXPgVFQFWpGUe6KJyW/EnVPQxeSIxHB/paW/32PdRzIXZu9HFP6HOy
 obvLrpwX39H4J/3qnw1ZwclN9yHDMo4ewt8B3mB/bOj8BC/wR+Nj0Nu0en8FNpt0TEbvd6tdcca
 5DjA9BXzZNFiTDWnXN49vgOvRu21t4XCT+I9gb2qescx23++QWJjIiYMxZGlIKKsgs0Vw58jXNJ
 8bLnuKginyLau6p/fPyJBOjJZOBSt/oQjTcp5oc/kzbE5MVNBk7yXzPgN4vc5uTPp2By1jYJHl0
 Tv/vC4zQSBl8TCN93IovMgwoFUyMVUYWvjWF40fQMXoVyuP31eGSERSNd/TZYg=
X-Received: by 2002:a05:620a:c4b:b0:912:8fd0:4a4e with SMTP id
 af79cd13be357-9153d98e5cbmr2159685285a.25.1780373162292; 
 Mon, 01 Jun 2026 21:06:02 -0700 (PDT)
Received: from
 runnervm3jyl0.huximawhmwiu1p2xc5qsgb550a.bx.internal.cloudapp.net
 ([172.203.253.208]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-915721f7d75sm246630185a.18.2026.06.01.21.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 21:06:02 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Darren Chang <chihsheng@google.com>
Date: Tue,  2 Jun 2026 04:06:01 +0000
Message-ID: <20260602040601.4010-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602010754.190896-1-chihsheng@google.com>
References: <20260602010754.190896-1-chihsheng@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/xattr: Add runtime probe for socket xattr
 backports
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Darren,

On Tue, 02 Jun 2026 01:07:54 +0000, Darren Chang wrote:

> syscalls/xattr: Add runtime probe for socket xattr backports
>
> Upstream commit dc0876b9846d ("xattr: support extended attributes on
> sockets") was merged in v7.1.

Nit: "merged in v7.1" uses the `v` prefix, but the rest of the commit
message writes "7.1" (without `v`). LTP commit bodies should use a
consistent notation. Either drop the `v` here ("merged in 7.1") or use
it throughout.

> Currently, setxattr02 and fsetxattr02
> strictly expect EPERM for sockets on kernels < 7.1.
>
> However, downstream kernels (e.g., Android mainline branches) often
> backport this feature to older kernel versions (such as 7.0). On
> these kernels, the strict version check causes a false positive failure:
> "passed unexpectedly".
>
> This patch introduces a runtime probe in setup() for both tests to
> detect if older kernels have the backported feature. If the xattr
> syscalls succeed on a socket during setup, we assume the patch is
> present and adjust the expected result to pass.

The motivation and approach are clearly explained. Good.

> Signed-off-by: Darren Chang <chihsheng@google.com>
>
> diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
> @@ -19,10 +19,10 @@
>   * - Set attribute to a UNIX domain socket, fsetxattr(2) should
> - *   return -1 and set errno to EPERM on kernels < 7.1.0.
> - *   On kernel 7.1.0+ (dc0876b9846d "xattr: support extended
> - *   attributes on sockets"), returns 0 (success) as sockets now
> - *   support user.* xattrs.
> + *   return -1 and set errno to EPERM on kernels < 7.1, unless the
> + *   feature is detected at runtime (e.g. backport). On kernel 7.1+
> + *   (dc0876b9846d "xattr: support extended attributes on sockets"),
> + *   or when the backport is probed in setup(), returns 0 (success).

The updated doc comment in fsetxattr02.c accurately reflects the new
behaviour, including the backport probe path. Good.

> @@ -209,6 +209,7 @@ static void verify_fsetxattr(unsigned int i)
>  static void setup(void)
>  {
>  	size_t i = 0;
> +	size_t socket_idx = ARRAY_SIZE(tc);

Initialising socket_idx to ARRAY_SIZE(tc) as a sentinel before the
search is correct and safe.

> +	if (!socket_xattr_supported) {
> +		for (i = 0; i < ARRAY_SIZE(tc); i++) {
> +			if (tc[i].issocket) {
> +				socket_idx = i;
> +				break;
> +			}
> +		}
> +
> +		if (socket_idx != ARRAY_SIZE(tc)) {
> +			if (fsetxattr(tc[socket_idx].fd, tc[socket_idx].key,
> +				      tc[socket_idx].value, tc[socket_idx].size,
> +				      tc[socket_idx].flags) == 0) {
> +				tst_res(TINFO, "Socket xattr support detected (backport)");
> +				socket_xattr_supported = true;
> +
> +				SAFE_FREMOVEXATTR(tc[socket_idx].fd, tc[socket_idx].key);
> +			}
> +		}
> +	}

The probe logic is correct:
 - It uses a raw fsetxattr() (not SAFE_) so EPERM does not abort.
 - On success it logs TINFO, sets the flag and removes the xattr with
   SAFE_FREMOVEXATTR before the test iterations run, so the subsequent
   XATTR_CREATE in verify_fsetxattr(6) finds a clean state.
 - On failure for any reason the flag stays false and the test
   conservatively expects EPERM. This is the right default.
 - The probe operates on the real, bound UNIX socket fd, which is the
   same fd used by the test, so there is no mismatch.

> diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
> @@ -196,6 +196,20 @@ static void setup(void)
>  	SAFE_MKNOD(SOCK, S_IFSOCK | 0777, 0);
>
>  	socket_xattr_supported = tst_kvercmp(7, 1, 0) >= 0;
> +
> +	/*
> +	 * Commit dc0876b9846d "xattr: support extended attributes on sockets"
> +	 * merged in 7.1 mainline, but might be backported.
> +	 * Try to set xattr on socket to detect support.
> +	 */
> +	if (!socket_xattr_supported) {
> +		if (setxattr(SOCK, XATTR_TEST_KEY, XATTR_TEST_VALUE,
> +			     XATTR_TEST_VALUE_SIZE, XATTR_CREATE) == 0) {
> +			tst_res(TINFO, "Socket xattr support detected (backport)");
> +			socket_xattr_supported = true;
> +			SAFE_REMOVEXATTR(SOCK, XATTR_TEST_KEY);
> +		}
> +	}

The setxattr02 probe is simpler (path-based, no fd to look up) and
correct for the same reasons as the fsetxattr02 version. The mknod-
created S_IFSOCK inode and a real bound socket are treated identically
by the VFS xattr permission check that dc0876b9846d patches, so the
probe is a valid detector for both path- and fd-based scenarios.

Nit: the doc comment in setxattr02.c was not updated in parallel with
fsetxattr02.c. The existing comment just says:

    - EPERM/SUCCEED - set attribute to a UNIX domain socket (dc0876b9846d ...)

While "SUCCEED" technically covers the backport case, a reader will not
learn that the SUCCEED outcome can now also be triggered on kernels < 7.1
via the runtime probe. fsetxattr02.c makes this explicit. Consider
adding a line to the setxattr02.c comment such as:

    - EPERM/SUCCEED - set attribute to a UNIX domain socket (dc0876b9846d
      "xattr: support extended attributes on sockets"), SUCCEED also when
      the backport is probed at runtime in setup()

---

Overall the approach is sound: probe only when the kernel version check
says the feature is absent, use the real syscall interface, clean up
after a successful probe, and fall back conservatively on any failure.
Both tests are covered consistently.

The two nits above (commit message `v7.1` wording and the missing update
to the setxattr02.c doc comment) are minor; the code itself is correct.

Verdict: Reviewed

LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
