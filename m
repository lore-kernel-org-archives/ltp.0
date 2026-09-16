Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B44C88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 00:38:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 847A53EA38E
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 02:38:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06C8A3CC9B1
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 02:38:23 +0200 (CEST)
Received: from mta0.migadu.com (out-160.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::a0])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 18979600045
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 02:38:22 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=eS5/6yJADqvQZ7iYmVnqk9MHsLuZ/65yN6RydCyYN9w=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789519101; v=1; x=1790123901;
 b=W3Gu+o1IFavyh9ssJ95cvJTdussG35HhUYEz0LRMnNrfRVu2jmrLBJ4u0cV3WPGhrmKZ0d8A
 rN1VnTZWBS8i7YxCncw6khxBxPoDJqBpwza5I2En4IiTewakjKjszrjn3WTepB5fMgqD9eWab9a
 rywYUi6bLwFrhBjm8bBRcscc=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 8043cabb9ecbbaf2;
 Wed, 16 Sep 2026 00:38:21 +0000
X-Mizu-Trace-ID: 8043cabb9ecbbaf2
X-Migadu-Flow: FLOW_OUT
Date: Wed, 16 Sep 2026 08:38:17 +0800
From: Li Wang <li.wang@linux.dev>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <aqnk-YHcQb5AmeuZ@linux.dev>
Mail-Followup-To: Avinesh Kumar <avinesh.kumar@suse.com>,
	ltp@lists.linux.it
References: <20260915153738.78189-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260915153738.78189-1-avinesh.kumar@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] uevent0[123]: make check fixes
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

Patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
