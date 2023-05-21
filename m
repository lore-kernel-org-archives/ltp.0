Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BC5C77B73
	for <ltp@archiver.kernel.org>; Mon, 22 May 2023 08:45:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 632393CD39C
	for <ltp@archiver.kernel.org>; Mon, 22 May 2023 10:45:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6CA13CB179
 for <ltp@lists.linux.it>; Sun, 21 May 2023 10:44:23 +0200 (CEST)
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 190C01A00707
 for <ltp@lists.linux.it>; Sun, 21 May 2023 10:44:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.cs.ucla.edu (Postfix) with ESMTP id 48BD73C02213D;
 Sun, 21 May 2023 01:44:21 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id IYPGi4LlAL37; Sun, 21 May 2023 01:44:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.cs.ucla.edu (Postfix) with ESMTP id BD91B3C09FA29;
 Sun, 21 May 2023 01:44:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu BD91B3C09FA29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
 s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1684658660;
 bh=sL/RPzLJDsRdyhXITfgA2EKT2gjftU43L/9bE3slwBU=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=fIXO5TOQZo7Gu1DK+lejqUeUK8H2Te+Kec6xAsGUtDMFEPMG/q3IoX99UuTnpcgpW
 OwWv4VwtEH//1nR7F6cbtF+0aR6wDeyNZX2ehY4hdayPL+fbWaxpvFY194/TjEYLoo
 h9XtCUo+UlxQECT2a5dAKVE4NkqvY3csQ79pbQvMepSjsXDIn7UlNKwpycSHSPiiBF
 S4V8e0xvKqZ203FqxDKUIbF4BAdk/OmZw2KnuBebIBJQNWIH0AweAan/+j0nmXlURU
 /tnMnxm+bQ2nXl8/x2qNDbtBm2jUiBi0BZxPqBpoexw8j4vE238YhpMde46uSuM6zS
 dhPSgi7AhF97A==
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id qu4112sjTa3n; Sun, 21 May 2023 01:44:20 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com
 [172.91.119.151])
 by mail.cs.ucla.edu (Postfix) with ESMTPSA id 78AA53C02213D;
 Sun, 21 May 2023 01:44:20 -0700 (PDT)
Message-ID: <94bbcea2-0a29-b4d6-ad5e-7615bc239941@cs.ucla.edu>
Date: Sun, 21 May 2023 01:44:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Andreas Schwab <schwab@linux-m68k.org>
References: <lxnjka-9sevacf455zj-1fthj246gvr4-712jsi8w59t4969pqyxmxkaq-l3n4z6dp0ybpuvpiuudtnfot-dl7onwkii2tq8gtprte6cu4fgip6f-ikuh33-a5p9ixcl44cx2h7mimcgl3xt-13bjom.1684553069255@email.android.com>
 <0cb83efa85ae32d956f81e6b9d4966c38fd54bcb.camel@xry111.site>
 <1c688849-f992-029e-30e8-8990c311c8a3@cs.ucla.edu>
 <87zg5yqec3.fsf@linux-m68k.org>
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <87zg5yqec3.fsf@linux-m68k.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 22 May 2023 10:44:30 +0200
Subject: Re: [LTP] [PATCH] Increase judgment on buf.
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
Cc: "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
 Peng Fan <fanpeng@loongson.cn>, Carlos O'Donell <carlos@redhat.com>,
 Xi Ruoyao <xry111@xry111.site>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 lixing <lixing@loongson.cn>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2023-05-21 01:27, Andreas Schwab wrote:
>> +	if (tcases[tc_num].exp_err == EFAULT && WIFSIGNALED(status)) {
> Can this condition ever be true?

I don't see why not, if fstat(fd_ok, 0) does a SIGABRT or similar. But 
perhaps we're interpreting "Can" differently.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
