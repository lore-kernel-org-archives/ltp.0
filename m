Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26EAC61DBE
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787666410; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=JajD2enEVU7D4OyGqQn7g4Wb7n62G/Sa9PlFaF6fR3ryXi/vzwPphuFOPOnpmlr1arIFN
 c3ZvHf6VIeUwudlARhZ165P7Qtlz7JF9lys4OiKeioOw1awZrjJmP4RJZ855GvUVdli4ZTE
 gvcT+UBU3UuIj/LQzWaxb84tNHqvx70=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E7363C55EA
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 16:00:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 195BD3C062E
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 15:59:49 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A21E31000544
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 15:59:48 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so9193926a12.2
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787666388; x=1788271188; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=gWwiRpqT+dBJLYzmgMBXl+LcaD9dd0NzkFzEIR42zwHZBedpVrsOexyM5TrVA4gniF
 +huaYnhe+MINcFAPTq/n2bOF8aDBOF7V2+VgZ6GKI6I11UkKawodzUzSEvJskF9TV2jx
 HuweyxcMa3SVlNIGYhno3OUoO0az0GOUarOF9ZEE6AoCAJQMsgkXEjTrog4n2UhyjzMt
 a2Rtg/FI9rPTG8fTadZ9OmKcLqVgi+pMvvr/xwQhkIcCP4tWMjrLgIDtxTSx4fUUszzc
 19Oc1IoT328KbMmWdeRs0aTF7vNhHflz44dz+vNA9zKGO4uPMShl0K1/bwjgDyb1Rq4t
 eiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787666388; x=1788271188;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Xwt1YbIHCtsOiifzyGeaomk+BjNmaHemlbadpDtha6aiQ3kwrMFWZyUzAPsDNulpy5
 7XucxejxZvsFtYMKFkj6VJUiJ9XiM2PLwvAW+eug9F8UDgya5+7iYbyC8yfzpDUl+BGO
 T1ekCrnsDvB+e+nZlFpTFBC1LOCth+4DHmWcYG/lMpYpm3BbTxeJRI9oimCYeECwWAIO
 cNacaFlqrWww8utpeED/IHX8Vpmc22c/fw5gOWLCmhyKoX+OCNMU7A0vNe7FaVP9Cfu5
 TnVDLap/+wwIkCh9WRzPkjQ+QuMdabkB+jbpsofT5PTug67h7VRcr4ZHe/TBXONanuYG
 76jQ==
X-Gm-Message-State: AFuF++l5Rtr2B5NPJCgQfgz4Ox207fo2b1cAlPWWTb6q0jCkw1LkYNge
 Vk4zg6rzPAhMEwagif91YiJqZwJQf03wnaKxVq1tjtpK4d47XH0yIn/VviHo1yaLMuU=
X-Gm-Gg: AR+sD11OsinJPBdBTyT3b4THNDFKPYKY86fYRA7a4zVuOUoiVvPZXvpxtIYbDthe1wo
 xd92hAZcgsLfNqxKAn6KsITFqeEDplUS9Im48aeDrWaBiRSxTI3eW4k8tpkGld7DyDxXrqcSkI0
 Jt4d/qaW+qD+p8WLy7UQD8LdmvfxyKS3oboPX8GUUE8FxCQYtrgCAUtaAoF6g6t3n8sc3EWaHGI
 51QNI3slQZdIgZlsQDc3EmOrSAcNob6uPNlE1f2EzsG2GfqKAjmmfLgGNYNvDD1KDXeU8SwfhKR
 M7IhUzOEMiJ0F+/Dpbgxd8hBK6Mv6chupx9R4C7aeTn0sMR2hgRMlL73UQ5XSr1aDkSpfCLuWmx
 u8sS0yjCGH9Tyg0lmnwfqmw4KYQEhjUmQqgO/qV3oMoMnxfgKzTCyhfAjKSIDvUFeyw4wkUkBh0
 qQ9fO7+hOPELwu5u4C+JeiZVOinD+6ym6a5UMqzPGeL/xhoU8bhZrr5Hywn53jUB/dF5K5NpgAg
 tWxIRRe0Ohxo6WQPtloaqbksDw+JTf0SRHz
X-Received: by 2002:a05:6402:3224:b0:6a0:a492:1f46 with SMTP id
 4fb4d7f45d1cf-6a582b2851dmr35218591a12.8.1787666387982; 
 Tue, 25 Aug 2026 06:59:47 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e199767sm14247211a12.15.2026.08.25.06.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 06:59:47 -0700 (PDT)
Message-ID: <6a8d9fd3.592506ef.27239b.79d5@mx.google.com>
To: "Disha Goel" <disgoel@linux.ibm.com>
In-Reply-To: <20260818121436.1397-1-disgoel@linux.ibm.com>
Date: Tue, 25 Aug 2026 13:59:46 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] memcg/memcontrol02: fix fd leak in cleanup
 path
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
