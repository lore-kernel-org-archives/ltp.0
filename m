From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 14 Jul 2021 14:43:50 +0100
Subject: [LTP] [PATCH v2 0/8] Sparse based checker and rule proposal
In-Reply-To: <YO7JQU9QjNEGkaMx@pevik>
References: <20210714071158.15868-1-rpalethorpe@suse.com>
 <YO7JQU9QjNEGkaMx@pevik>
Message-ID: <87k0ltnh7t.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
> thanks for this work! I'm looking forward enabling it in CI after we
> merge it.

Thanks. Perhaps only in the lib directory for now though. Also it will
only really be checking the checker itself doesn't crash or fail to
build. There are some errors which need fixing in the library before we
can enforce the checks in CI.

>
> Kind regards,
> Petr


-- 
Thank you,
Richard.
