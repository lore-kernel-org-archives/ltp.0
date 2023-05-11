Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1B2C77B7C
	for <ltp@archiver.kernel.org>; Thu, 11 May 2023 19:32:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF51E3CE05A
	for <ltp@archiver.kernel.org>; Thu, 11 May 2023 21:32:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 446403CB4AE
 for <ltp@lists.linux.it>; Thu, 11 May 2023 21:31:50 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7BFF9601140
 for <ltp@lists.linux.it>; Thu, 11 May 2023 21:31:49 +0200 (CEST)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-50bc22805d3so13769393a12.1
 for <ltp@lists.linux.it>; Thu, 11 May 2023 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683833509; x=1686425509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vj0gab54tNFDHF4AgItt0N57uWrA19OfYLhrk6q8CVw=;
 b=plFLbdiNdfz8sLKz/TjSTc8vNgNd+JnEEbSitEKaifZBTbyOIRRU5fnDNRqdBpppv8
 eTBJnj+bc7EUrkMFMLfxj0KJu/Bw+mSk7NQv6EpzfOFKbHmrV4RoJ8eq1OvsPsPo2IwN
 cdB/wZRqVoLXxIUrllBL4/BQEHXdrHbCCgsIi+tILf89KU0ZIE3mLrVIH1N7mM3AA88A
 rBIEti8Oei25z0gqyi1ohTPxaakQLU7qC/uweKx2SDYJu9Ev+3JUPrzp5wbgKEY9zOnB
 nGcJZ7HOxoUZynlA6nFz9kwyU5g/X2QOGKgk3kWDwVHP/L3MKawIdG+jLx3ivV/ReJ0e
 tFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683833509; x=1686425509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vj0gab54tNFDHF4AgItt0N57uWrA19OfYLhrk6q8CVw=;
 b=FWdp+lYWpdKEMVOGTKE4z0rqvb1zB2FYd10ExILIBjBGlcGYeOEjlsAGwFbPwyTxVv
 s0aHK6CqJC9KGL3gRB5gzxsMXD57ND5VnqrTQNokXro3vIIbKq+t/8HBOt03IQNBjCjn
 WDva3GphLNL7m54xGpkhdogPlRumtJ+3r6PqgmdHrnE+lMmSqhpkI8y+j/fTf5CqjBe+
 Ukq0n+anVKIM440WjyD9gmYwDPHEmyDoBaLcDY68bXOfz61VXQmiq54b5oHoEaEisAXY
 yP22Wv3cvIG/FJ6abJV02+0rseDnLlMPTTbZEmhDrrORyGTWtsC94fTs/hn5ZNgbYlcq
 rG3Q==
X-Gm-Message-State: AC+VfDzwXnoE7/0VXEu475hvI4CfNzP0F9pnI0F99/UShVJZNSHaUuVB
 KregJC5SuSRIW06pycGwXvGsIDS7dL4RucqHqXs=
X-Google-Smtp-Source: ACHHUZ5cc4U0GUFLEXIg0GH8jAdon6bOTwdhGh5YdWlpFgskK0Km2jZ3SyYLDPC08J+x6/x3fXiDK7QEhcjMlaVeSt8=
X-Received: by 2002:a17:907:98d:b0:94e:cf72:8147 with SMTP id
 bf13-20020a170907098d00b0094ecf728147mr20945946ejc.48.1683833508759; Thu, 11
 May 2023 12:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230506184424.105501-1-pvorel@suse.cz>
In-Reply-To: <20230506184424.105501-1-pvorel@suse.cz>
From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 11 May 2023 21:31:37 +0200
Message-ID: <CAB1t1CzDFw_F79rhD55XQLYTDKiSKsHW_oACfELFRBsg614naw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v2 1/1] lapi: Add sysinfo.h to fix build with
 older MUSL toolchain
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

Hi all,

> diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo01.c b/testcases/kernel/syscalls/sysinfo/sysinfo01.c
> index 2ea44a2be..a237345ef 100644
> --- a/testcases/kernel/syscalls/sysinfo/sysinfo01.c
> +++ b/testcases/kernel/syscalls/sysinfo/sysinfo01.c
> @@ -69,7 +69,7 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/signal.h>
> -#include <sys/sysinfo.h>
> +#include "lapi/sysinfo.h"

NOTE: sysinfo0[1-3].c (and any new sysinfo test) will need to use
<sys/sysinfo.h> due sysinfo() signature in it (that's not in
<linux/sysinfo.h>).
Following fix would be needed for this patch. But as there is no
feedback, I don't even send v3.

Kind regards,
Petr

diff --git testcases/kernel/syscalls/sysinfo/sysinfo01.c
testcases/kernel/syscalls/sysinfo/sysinfo01.c
index a237345ef..2ea44a2be 100644
--- testcases/kernel/syscalls/sysinfo/sysinfo01.c
+++ testcases/kernel/syscalls/sysinfo/sysinfo01.c
@@ -69,7 +69,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/signal.h>
-#include "lapi/sysinfo.h"
+#include <sys/sysinfo.h>

 #include "test.h"

diff --git testcases/kernel/syscalls/sysinfo/sysinfo02.c
testcases/kernel/syscalls/sysinfo/sysinfo02.c
index 61fa1ab75..7ad0e8bdc 100644
--- testcases/kernel/syscalls/sysinfo/sysinfo02.c
+++ testcases/kernel/syscalls/sysinfo/sysinfo02.c
@@ -65,7 +65,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/signal.h>
-#include "lapi/sysinfo.h"
+#include <sys/sysinfo.h>
 #include <stdint.h>

 #include "test.h"
diff --git testcases/kernel/syscalls/sysinfo/sysinfo03.c
testcases/kernel/syscalls/sysinfo/sysinfo03.c
index 0b6ffb49b..13b0de806 100644
--- testcases/kernel/syscalls/sysinfo/sysinfo03.c
+++ testcases/kernel/syscalls/sysinfo/sysinfo03.c
@@ -14,9 +14,9 @@
  */

 #include "lapi/posix_clocks.h"
-#include "lapi/sched.h"
-#include "lapi/sysinfo.h"
+#include <sys/sysinfo.h>
 #include "tst_test.h"
+#include "lapi/sched.h"

 static int offsets[] = {
  10,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
