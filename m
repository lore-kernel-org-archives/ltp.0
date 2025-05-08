Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9726DC3ABC3
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 07:52:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AED73CC17F
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 09:52:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38DF23CC0B7
 for <ltp@lists.linux.it>; Thu,  8 May 2025 18:07:11 +0200 (CEST)
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5DDC01400C5C
 for <ltp@lists.linux.it>; Thu,  8 May 2025 18:07:10 +0200 (CEST)
Received: from r6.localdomain (82-217-174-174.cable.dynamic.v4.ziggo.nl
 [82.217.174.174])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by gnu.wildebeest.org (Postfix) with ESMTPSA id A91F0303C2A0;
 Thu,  8 May 2025 18:07:09 +0200 (CEST)
Received: by r6.localdomain (Postfix, from userid 1000)
 id 03A69340687; Thu, 08 May 2025 18:07:08 +0200 (CEST)
Message-ID: <adfcd1e3f129c97c2132a138e70599642566886a.camel@klomp.org>
From: Mark Wielaard <mark@klomp.org>
To: Cyril Hrubis <chrubis@suse.cz>, Martin Cermak <mcermak@redhat.com>
Date: Thu, 08 May 2025 18:07:08 +0200
In-Reply-To: <aBt8PJNmiJNuSEB5@yuki.lan>
References: <20250429052247.GA144682@pevik> <aBSVO8uOE86UGIcp@yuki.lan>
 <4428939d-dc71-488b-9728-030accaca3e8@suse.cz> <aBh9Z4QA2YcdOFq1@rei.lan>
 <20250506080520.GA64990@pevik>
 <20250507151148.yhrnckco7zkrpfzw@lida.tpb.lab.eng.brq.redhat.com>
 <aBt8PJNmiJNuSEB5@yuki.lan>
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 09 May 2025 09:52:10 +0200
Subject: Re: [LTP] LTP in valgrind :)
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

Hi Cyril, Hi ltp hackers,

On Wed, 2025-05-07 at 17:29 +0200, Cyril Hrubis wrote:
> > > > > 
> > > > Maybe we can even add an option to the test library to supress the
> > > > messages in output, that would be fairly simple.
> > > 
> > > @Martin @Mark: feel free to comment what we can do for you :).
> > > Whole thread:
> > > https://lore.kernel.org/ltp/20250505195003.GB137650@pevik/T/#t
> > 
> > Nice to see you noticed!  Primarily we're trying to identify
> > valgrind gaps and bugs.  For our use-case it's good to have
> > reproducible test runs in a sense of identical test results for
> > repeated test runs.  We got pretty close to this by only taking
> > into account the testcase summaries at the very end of the test
> > logs.  Any steps to get closer to reproducible test runs on the
> > LTP side are interesting for us, and we'll try to reflect those!
> 
> I've proposed a simple solution that would cut the message from tests
> only to contain the line numbers and results in:
> 
> https://lore.kernel.org/ltp/20250505195003.GB137650@pevik/T/#m98317262b25ede62704b005fcefc63c62198bb90
> 
> If that works for you we can get this in LTP before the next release.
> 

That looks pretty interesting, I just tried it and it turns:

$ ./testcases/kernel/syscalls/dup/dup01 
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_dupbmNNGn as tmpdir (tmpfs filesystem)
tst_test.c:1907: TINFO: LTP version: VALGRIND_3_25_0-10-g0ce068434ec3
tst_test.c:1911: TINFO: Tested kernel: 6.13.11-200.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 10 19:02:09 UTC 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.13.11-200.fc41.x86_64/build/.config'
tst_test.c:1729: TINFO: Overall timeout per run is 0h 00m 30s
dup01.c:24: TPASS: dup(fd) returned fd 4
dup01.c:27: TPASS: buf1.st_ino == buf2.st_ino (6921515)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0

into:

$ LTP_REPRODUCIBLE_OUTPUT=1 ./testcases/kernel/syscalls/dup/dup01 
tst_tmpdir.c:316: 
tst_test.c:1907: 
tst_test.c:1911: 
tst_kconfig.c:88: 
tst_test.c:1729: 
dup01.c:24: 
dup01.c:27: 

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0

So that still shows the "code flow" and the test results Summary (all
output goes to stderr). I think this would indeed be useful to compare
if a testcase runs the same "native" and under valgrind.

Thanks,

Mark

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
