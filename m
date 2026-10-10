Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A94CA6017
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 09:07:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38B8B3E2E1C
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 11:07:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCD3B3E2904
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:06:58 +0200 (CEST)
Received: from mta0.migadu.com (out-153.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::99])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E1D4D2001B6
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:06:57 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=ZLc1hjGYT3OJ6tHUnLSby9RpY/x2ICkWjy6HpAPctLA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791623216; v=1; x=1792228016;
 b=if8LVlgKYKeMXWD8lRxuPZ2ltZLQUz1m9ndxlahzlEBdL1lT5GWoayCPclzStxG/RgGVrCFZ
 t5oHtN5Hd7caIuSttsY4UTBdtWOmpPY9oyVh+L2A5txfeVBrTKsyrb35dWAe0IYiH+djz+IsShq
 c+UMXqBIQuTXFlRKrbOgxPjE=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 9cdf419edc1adf0f;
 Sat, 10 Oct 2026 09:06:56 +0000
X-Mizu-Trace-ID: 9cdf419edc1adf0f
X-Migadu-Flow: FLOW_OUT
Date: Sat, 10 Oct 2026 17:06:49 +0800
From: Li Wang <li.wang@linux.dev>
To: linuxtestproject.agent@gmail.com
Message-ID: <asoAKV-Wd-TK5XUe@linux.dev>
Mail-Followup-To: linuxtestproject.agent@gmail.com,
 Jan Stancek <jstancek@redhat.com>, ltp@lists.linux.it
References: <24014310ac600340c4ef9720980eac1c047f4b6f.1791543115.git.jstancek@redhat.com>
 <20261009172601.34695-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261009172601.34695-1-linuxtestproject.agent@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timers/twoevtimers: Wait for both timer signals
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

Hi Jan,

linuxtestproject.agent@gmail.com wrote:

> Hi Jan,
> 
> On Fri, 9 Oct 2026, Jan Stancek via ltp wrote:
> > openposix: timers/twoevtimers: Wait for both timer signals
> 
> > +	PTS_WRITE_MSG("Caught abort signal\n");
> > +	PTS_WRITE_MSG("Caught alarm signal\n");
> > +		if (errno != EINTR) {
> > +			perror("nanosleep() did not return success\n");
> > +			return PTS_UNRESOLVED;
> > +		}
> 
> Medium: PTS_WRITE_MSG() calls write() without preserving errno. If the
> second signal arrives after nanosleep() sets EINTR but before the new
> errno check, a failed handler write (e.g. EAGAIN on a full nonblocking
> stdout pipe) causes a spurious unresolved result even when both timers
> fired. Save errno on entry and restore it before returning in both
> handlers.

The race condition pointed out by the AI seems plausible. Would it make
sense to save and restore errno in the signal handlers, like this:

static void handler_abrt(int signo PTS_ATTRIBUTE_UNUSED)
 {
+       int saved_errno = errno;
+
        PTS_WRITE_MSG("Caught abort signal\n");
        caughtabort++;
+
+       errno = saved_errno;
+
 }

 static void handler_alrm(int signo PTS_ATTRIBUTE_UNUSED)
 {
+       int saved_errno = errno;
+
        PTS_WRITE_MSG("Caught alarm signal\n");
        caughtalarm++;
+
+       errno = saved_errno;
 }

The rest part looks good to me.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
