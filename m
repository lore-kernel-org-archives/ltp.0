From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 04 Nov 2020 13:32:16 +0000
Subject: [LTP] [PATCH v4 1/2] lib: Add generic boolean expression parser
 and eval
In-Reply-To: <20201103161052.13260-2-chrubis@suse.cz>
References: <20201103161052.13260-1-chrubis@suse.cz>
 <20201103161052.13260-2-chrubis@suse.cz>
Message-ID: <87wnz1459b.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Add a simple and generic boolean expression parser and evaluator. This
> is a first step in order to implement more complex kconfig expressions,
> but since we are likely to reuse the parser for other purposes in the
> future it's implemented as a generic boolean parser.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

LGTM!

-- 
Thank you,
Richard.
