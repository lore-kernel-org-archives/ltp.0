Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1BBD58CDF
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 06:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774248355; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=xIeAvzEAyqnA6NfIyqkxa2SZlvjgpNbGeBD9/BPK0OU=;
 b=gJCisdRISeD7O+FLseCjOR9RDBGzceFpJi4CDrTHVHXlBu4ZMWT2Fc3ZGTt3uDcgpK4mU
 UfjRcv8ASxK5fRlwq0AjTw5nti2ubV3e519Dn5wGDuYB0Bv07RL45L4N97XiZ9O4UwCLf1X
 S3tqls5NVs3IlvUUIREtNVjXWnoTlHQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 249B63E1D75
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 07:45:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D4A33C6147
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 07:45:30 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7A7766009D6
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 07:45:30 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so22700335e9.3
 for <ltp@lists.linux.it>; Sun, 22 Mar 2026 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774248330; x=1774853130; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WG4klHk/oOkbcYSRNwsCAGUEinBgoxdSuIRtcMXAlKg=;
 b=KUVvYuoRM0PW97EQAhcICwK2XnVLIlmPLTEKCCBaj3nSaUADxawckg/IAhkfWpb1B3
 SZY35x7/+uZgmYr8B2E5AjlgN9r81IEL21oOPulZQbdicsrsM01ONRkLGSLicYi7oL10
 kaYEOhXOAU7aR+O5+wpgk/LN70ur3FRqVm9wQDbTZ3UePgWnTyt29Dm/5OLo+EPCsQ17
 sHcTuA357zToZ3wlhQU4eXgnpm+n7EtqeBi9pLXq3EgFMDusv+uNnkpgNWcjiH8kFrZa
 TM6E1mzPyuJL7AWpUQZpaTEfcTyfCsFzFsV06Sl1u7I6qnYt227LWPp1FpZbpy5unstw
 feEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774248330; x=1774853130;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WG4klHk/oOkbcYSRNwsCAGUEinBgoxdSuIRtcMXAlKg=;
 b=ggyL6MxX4nJyG/rreb5kNVgNQKaC+OnM79sLBT3wiY42oY81SMw1SLhJp/My5mOV9f
 5doZD9hGJuloPvU4sEx3JihZ6hEBCTYDOSylMDi0mNFKKMCvG23OPTFdEZ+IxWUTots1
 yd/LnA7yP+EjWpc/RfTd1ztceLHEoN0uX4WPbjIXbxSLm+53TD55D1hobiqKBNwng/bm
 gyLhn24+US2zswl3yAnl4veLioFCh05n8LfeDK0RZbslFPYR6hmUnddVik59JbfhrHen
 h1gVZnx3FzFbM+4ck4MvFv/McAzkximC6SE6lCzfz1IMf4OW7RuWqKH/MaK04KvFsvIt
 SvvA==
X-Gm-Message-State: AOJu0Yz3BRwtRs6cqilfj/julecDxWG9h08ac+2BSeXwijO1jwMDXciw
 R5qglEbrKbfKph8G+onrL+0DR9FhbTYotr6Pk78S/RrTmuWlxeUJi4hvt1roAF5FLGA=
X-Gm-Gg: ATEYQzzJz2virzMhLXbPs2ajAptkecVR569bgpM+hpYhmzJsNTwNcNf5PwLJNwN4y2s
 +LF1jQoDjGgJRWPDNp3mXlFQjjG2EsZx1ZN6n1opGzNjxR6CAWtmo8b5ftPyIRqo7YsZv9GfQhH
 Wgh0azo7WeM7a1Cg7srHMTnj1XIxtVQU/eMi30EzRPjpugEhtnWR6UL5LNFHYxxkl3U5C+U8y5k
 h7pbvArTteAwHrO9fwoKj8NEgG04z6pEFjjbGecG+aLMLZ7rH9J5W4o1ZE+Yb7lEBLUU0TlKMUE
 2HiaOhzH0GZnD6xlSAQhjO6o/Nxuo/nj9FFcj3fS5cSkck0gxZ51HfHWoyU7c6rhberoRhCeS8n
 TP8UOVi7Y6r/tkm2wf+jutl7ue38oBM1yY7IUXcbqEuBnWNpQ/HziA3603/KykBWHhdR7gTmnOv
 rlKX5tKR3Jw75JL/J6J3Z5KiswUpwxAeut/Oh+njE4uQ==
X-Received: by 2002:a05:600c:3546:b0:485:3e20:4013 with SMTP id
 5b1f17b1804b1-486fee292b5mr156061205e9.28.1774248329773; 
 Sun, 22 Mar 2026 23:45:29 -0700 (PDT)
Received: from localhost.localdomain ([37.160.205.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm106234795e9.8.2026.03.22.23.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 23:45:29 -0700 (PDT)
Message-ID: <69c0e189.050a0220.8a4b1.49b0@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260321140819.4157-1-always.starving0@gmail.com>
Date: Mon, 23 Mar 2026 06:45:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] open: fix cleanup condition and use snprintf
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

Hi!

Since we are cleaning up the test, we can just do this instead:

static void cleanup(void)
{
	if (first >= 0) {
		int limit = fds_limit - first;

		for (int i = 0; i < limit; i++) {
			if (fds[i] != -1)
				SAFE_CLOSE(fds[i]);
		}
	}

	free(fds);
}

We don't need to calculate the index twice every iteration. Also, free(NULL)
is noop and we can safely call it without checking if it's NULL.

And please remove the `i` definition at static level. We don't really need that.
We can safely use `for (int i = 0`.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
