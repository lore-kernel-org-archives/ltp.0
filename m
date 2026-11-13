Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6E606A31C
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 04:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=H0+4B7K+;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Cm/bkJtA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794544696; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=b8yT/vaW0lvbRbmKHFdg4VEU/nPAE3Mw6NTrmvxYhLM=;
 b=H0+4B7K+bSWhhXV/BRBJGojmmhhBx4xqw8cbeGtkC/6Jp6bW3+BhX+UPrWxn6ef/f/bCj
 U/fuv6nrpT+Dhzhv13h/rS8+Qd1OOgajcA0kxwS4uCT8Tv2VED2OUT9GA7WvrbAfux7B2yA
 piytFN1K5RmEY/+EJ7pj6cxS9xnQp6w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F26E23EBD0F
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 05:38:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C40783EBC5F
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 05:37:55 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2F9FD200AD6
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 05:37:55 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so453723f8f.0
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 20:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794544674; x=1795149474; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dmq7JQ83L5StaqGtIhfK2XbTOOZIuw7U3z7mEPc6tA4=;
 b=Cm/bkJtAL4+9OeBzZRhIH0KwjKAXJscJhvS9EUAmPW2VPIRFt7QC8jIwG0Sh6/HCN2
 MhgMSgD/em95oe0FV3FmQ6FUAejRnkykDUrKUrTv6BNnN1RxcOUhT/8Tf41B6t7SBN7G
 I+zTEu7JMKKGftPXVgbXkNUmuJWGf8bGk2nJqtTNtz/STB0L5RyVBd0abf31Ys83m+iB
 2/HfVhHAyzegYcbnirz2NrAuyznSe1NxkkwVC2Z5p7BDTD6AM6lEmW42h38y7rzY8AhN
 RtItlNOGxpD8xWyiC89iGzVhccQSldyCaOcPM22zQ8jLnaWvlYjYpiRZJKANwyIt4bWL
 6ZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794544674; x=1795149474;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dmq7JQ83L5StaqGtIhfK2XbTOOZIuw7U3z7mEPc6tA4=;
 b=cYMZLe6bXu4ezr7XpFNpfPZATFm+iYiRmWh4Akd6Z0R5NU6JiWQfwDB2pX6h8fyqcX
 2AU508kNlJgYdJeFJF52nqjua5w3fTfVUFUvlhkfdnBJhXmJgCO9X7UgRVmLSqjG76ZQ
 YB/M+RxlxOcyXtiMumzMHuzbCJWBvC+YgyJ3bizzcukMwZWhLqjfKAeuR2UrGiWuc0Mb
 jpSN9TwtKx8m030401aYsI9lYDsMNiAcRrAbgQmclHTfnE8iOos9tAXycdSsH80SZOFW
 +pHx4AnjYwPzZKjZAMNB9SD2R3ncuaUWF5SITKQr39SPlxf+36M3ZJk+fVCizpjh/uc2
 QkAw==
X-Gm-Message-State: APuU4Z+dthxRXmqN1dpTO+75SfsbVljKesG2jBasU37w4gQOqSqdQtIz
 uEmJE9z1y2hYNr7zM94oqrwuN5RTEwEJvZm35KvJte6SpKVI3r08QRWJAx/sQhp1Rpx5AKo02LW
 6fI1EbQ==
X-Gm-Gg: AYBFou2mrgPtqCQC8C3FkaP3i5s1+O0SuNgBqZKk6atz5RxVgvp/zmqy5+3/sTrf0mU
 lfO1IxvKHpsJDi76FoSMHp4gMMbSoT9WvbTcwOGIxeEvqN9qCATBbBW9jpoJ/Iu4SC2wIkkfvve
 XBCgJ+8Oykb1UuCq9JXeG1yaJNOJ9q7Ltrpy5HkkUQ4P4LXHs+NdfEIAdd3K5FGMbRW+l/tnRMT
 3xhpSOkeyfzk9RHW+eMqDKr1R9/lbT5+snLEfufTOl8Y2JmAWxW2f32Qid1a24JMIdyfOeNpS1J
 yQPX9JBtaKMWuFQ+Swy0jyaiXPn+EHV07hoINFkvg020Bmt9pX7fkdAOp90ojQCtlX8yboqKpqy
 SuJB2/H/4qXFU91LrBZavgMxWJOD6p88LZ0v4O3LWqv/Gn1Dv3BcADHKt7fVbateQpriC8c22P5
 NK4e4WF8IiUv0kI/5OJukz8cW7jRX9jBgmTYYHhCw/TAn28Z/g4egfGUyiPh0abK8gEU4QcpPxn
 jdaNri5ZTJQ8a6h+zItSuIdtDQoAlSk48nRl/M6w8tj3QxmJoiidj+Pv0dR/pkTGH3N/V8bqetw
 lawxdUnfeP36/nnsfn7T5ktfQ3QxG/zWVIV3kJ+PiYIpsPCi8I3rUBoxDQ+Q0A6XlPoPWtZlmjY
 RuvLF07ApHbNXn66HYCFGMRJsjhv2+CzP/wgnpEveiY2X7jU7GuS7MTmAsGB3ZLU=
X-Received: by 2002:a05:6000:610:b0:48d:e696:8a65 with SMTP id
 ffacd0b85a97d-49c72ab0c18mr2914385f8f.46.1794544674563; 
 Thu, 12 Nov 2026 20:37:54 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d03b10fsm3346121f8f.1.2026.11.12.20.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 20:37:54 -0800 (PST)
Date: Fri, 13 Nov 2026 04:37:52 +0000
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Message-ID: <avaUINSz3FG0JUwo@autotest-wegao.qe.prg2.suse.org>
References: <20260929022340.524-1-wegao@suse.com>
 <20260930035332.3360-1-wegao@suse.com>
 <20260930035332.3360-2-wegao@suse.com>
 <atmrQp-ahBUw6x-W@autotest-wegao.qe.prg2.suse.org>
 <avM3ieRhvyhTOCOE@localhost.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <avM3ieRhvyhTOCOE@localhost.localdomain>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] memcontrol: Add bind_to_current_cpu()
 helper
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 10, 2026 at 04:26:15PM +0100, Michal Koutn=FD wrote:
> On Thu, Oct 22, 2026 at 06:20:50AM +0000, Wei Gao <wegao@suse.com> wrote:
> > Hi Michal
> =

> Hello Wei.
> =

> > =

> > Could you help check this patch? I already change to pinning to the
> > single CPU for all arch.
> =

> I have nothing more to add to the patch. (Cyril hints better how to
> integrate it with existing helpers.)
> =

> Maybe I'd add a comment right next to the setup to explain
> 	/* reduce per CPU stocks for more stable results */
> =

Thanks, new patch has been sent:
https://patchwork.kernel.org/project/ltp/patch/20261113041136.17102-5-wegao=
@suse.com/
> =

> Michal



-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
