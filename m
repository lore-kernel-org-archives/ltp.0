From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 02 Oct 2017 13:00:54 +0200
Subject: [LTP] [PATCH 1/1] syscalls, lib: Use SAFE_{BIND, LISTEN,
	SOCKET} macros
In-Reply-To: <20170929231036.32262-1-pvorel@suse.cz>
References: <20170929231036.32262-1-pvorel@suse.cz>
Message-ID: <87bmlpx195.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello Petr,

Petr Vorel writes:

> instead of tst_brk{,m}(TBROK, ...)
>
> Patch was made thanks to Coccinelle.
>

Very good. Also how about including the Coccinelle patch in the tools or
scripts folder?

-- 
Thank you,
Richard.
