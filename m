Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73C3CA0EE4
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755524939; h=to :
 mime-version : date : message-id : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Zl0RZJqB/WWb3mRz/N4Vu4zPWsaU0JN/yX1GyjJyJC4=;
 b=ZMvHEuTPSskIB4dRLDMaYuY9QM1l8mE1HKU/kEkqxbw0cTU19bUuiYMwEEhGMVBTu8K4V
 DQZLYLQ4lhsuEXH/8PbBGw/DKlIN+wfSnsmv87xei1Rld9og/NeBwkjE0dh+wlJ/Pu1BpoV
 39LjSlvcu7Dn3LjqGeaKbs2kcfbDwbQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6FD33CC7DC
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 15:48:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id 6145E3C75F1
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 15:48:39 +0200 (CEST)
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com
 [203.205.221.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with UTF8SMTPS id B402E60011D
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 15:48:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1755524907; bh=yTTncLA5X///QjDZHDnGJoYVxQtPztgjw7PQAnvNnpg=;
 h=From:To:Cc:Subject:Date;
 b=kquEkIHoSzjjLrv4i4cRK6IQCv8WDTkxWJDOGsdV6ANn7Svow40QHuMr+pk568IaY
 kNss16w0wCjRFhCWKPpHC5tr9vPxDa60gwSQMnZ71/HF8N9XWGpECU6qszFjcs8qMq
 nSAfHcjae0jmSe5K4NITsKHo1GvjThL8CCNM7IJ8=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-XMAILINFO: NnI3P4Mh74EPc/crEdeV77n5NKpWL2qRboQHdn2crDZH0Lyx9bXUI6Hl6JAKtc
 PxMjynKWNFKcBRFria+wnXQVDJlib3uyOdWfN+T2uFps1v09RuKy9E5NwhFbcpcl9hFagl1pqk6I6
 eYT/3OXIBh8YYPkAlik7UY5Fc3GsWdldZafP5iSpUW1mJd2uq77MfYaG6rnMJ1ojyxm50blshPVl5
 Sjxibdm9BJbwX+P4Y5b3hPFfPm16wt0sgoX6kPuotA/3JLwNKhwYuw3dpztctARfmAeZ3ZQ/aA8YK
 mFaDokLqaz6Qv1F4z8tfTkFHw9NAtvjgeGsx8GdTge2s0FCITaOqwMn/Q8h8P1ptvQq0xg/qSYLVe
 IIjvii8bxAUdQyM3seMMc7m33re/bbS9P/dwFyRDUaytNh/8G34moKgt1ICyMxqxtxBVmnjFKC4Mr
 MFnkioZYEy21KwRIoAzRH2BMAD7JmcGzLz7A2gY3oGra1dqAGPweWmH44fAaYYOH1AApwdkJwtdkE
 yEGLH9CIBh/6aHLumRYVReQsVkkTPVrEST0nTVNFBsTbRsHCz7bQwdNISum8jd6smv14qMFaWvFHm
 /cDvPtsDuChXStUDhfEK1/Utj0G+DKr+T1e2wfmYQK0GHmELja+bVV5UO3+FFcrRGeSze45ztR/Dm
 1QRk7/wsXyC54QJ00Z1Lpab7ltb4IOF2f8LyUFtJsiFI0H7I21nUTdAtMt+fv2v5uiNHNH79KJs73
 qxygKQj/hbgJtrjVZ+mhE6L1wF/sfKT+i+TGrJ4c1M+ZW8Ry48KwOOEZhsHWW+0W3nZWH6Y5jmWhj
 vBNxl1YDFk6atvo8RSgC8ppjhyAG9OGhF3+QXzlyuG8ED0DVcLk9i2jDGE2u5mXg6q+j14StqRsc3
 HTgqU9KXMaaLHtGjCqfjIRDoqKF+EnoDZkY6LWwpalx+0vHGRWTfI7Q1oF+f4GROZPJLyNvc4hVIh
 IC4Ct8qg/jBjbaT8gaxHYxuMFhw6/hO7COiUCuF8Bjg6emRDR0KVSH0ayvIMspffVRVoSr8J0kKim
 65/5rNl098mlrqE8tGgV+zRSFl4nQYAH5TQmi
To: "=?utf-8?B?UGV0ciBWb3JlbA==?=" <pvorel@suse.cz>
Mime-Version: 1.0
Date: Mon, 18 Aug 2025 21:48:27 +0800
X-Priority: 3
Message-ID: <tencent_D831D00568C246AE9FBCAE9EF5DDAD0B6B05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezb29-0t1755524907tprx8l271
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] sigaltstack01: Fix check about alternative stack
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
From: =?utf-8?b?6ZmI5Yqb5oGSIHZpYSBsdHA=?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?6ZmI5Yqb5oGS?= <791960492@qq.com>
Cc: =?utf-8?B?bHRw?= <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr Vorel,


Recently I want to test if Gramine-SGX (emulates Linux in Intel SGX trusted execution environment) works exactly like Linux, and avoid it from harming users.


sigaltstack01 mallocs a buffer with size SIGSTKSZ (8192) and uses this buffer as an alternative stack. However, in Gramine-SGX, it needs to reserve a large memory to save xstate, sigframe, and restorer's address, thus it needs to reserve memory larger than 11452 bytes, which overflows SIGSTKSZ. In this situation, I noticed the wrong check we talked about. (Detail: https://github.com/gramineproject/gramine/issues/2153&nbsp;, is it OK to paste a link?)


Kind regards,
Liheng Chen


------------------&nbsp;Original&nbsp;------------------


Hi Liheng,

&gt; Hi all,

&gt; This check seems should be (alt_stk < sigstk.ss_sp) || (alt_stk &gt; (sigstk.ss_sp + SIGSTKSZ)), not &amp;&amp;

You're right. IMHO the error goes down to the original addition in
865695bbc89088b9526ea9045410e5afb70a985c

Out of curiosity, did you find a system where it should fail but it didn't?

Reviewed-by: Petr Vorel <pvorel@suse.cz&gt;

&gt; Kind regards,
&gt; Liheng Chen

&gt; Signed-off-by: Liheng Chen <791960492@qq.com&gt;
&gt; ---
&gt;&nbsp; testcases/kernel/syscalls/sigaltstack/sigaltstack01.c | 2 +-
&gt;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)

&gt; diff --git a/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c b/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
&gt; index 9a2e3a440..147659467 100644
&gt; --- a/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
&gt; +++ b/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
&gt; @@ -142,7 +142,7 @@ int main(int ac, char **av)
&gt;&nbsp; 			 * Check that main_stk is outside the
&gt;&nbsp; 			 * alternate stk boundaries.
&gt;&nbsp; 			 */
&gt; -			if ((alt_stk < sigstk.ss_sp) &amp;&amp;
&gt; +			if ((alt_stk < sigstk.ss_sp) ||
&gt;&nbsp; 			&nbsp;&nbsp;&nbsp; (alt_stk &gt; (sigstk.ss_sp + SIGSTKSZ))) {
&gt;&nbsp; 				tst_resm(TFAIL,
&gt;&nbsp; 					 "alt. stack is not within the "

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
