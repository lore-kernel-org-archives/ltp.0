From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Oct 2017 09:16:31 +0200
Subject: [LTP] [PATCH 1/2] ltp: typos correction
In-Reply-To: <20171025033006.32463-1-liwang@redhat.com>
References: <20171025033006.32463-1-liwang@redhat.com>
Message-ID: <20171025071631.GA4244@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static struct tst_test test = {
> -	.tid = "nanosleep()",
> +	.tid = "clock_nanosleep()",
>  	.sample = sample_fn,

The .tid field should not be set in the tests since a5bf5254ca9
(tst_test.c: set the test id automatically).

Just remove it from the test structure here.

I guess that we may as well remove it from the test structure completely
and keep it hidden in the test library.

-- 
Cyril Hrubis
chrubis@suse.cz
