From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 14:02:03 +0200
Subject: [LTP] [PATCH v2 1/3] tst_test.sh: Use LTP_TIMEOUT_MUL in
 TST_RETRY_FN()
In-Reply-To: <20190911165225.2122-1-cfamullaconrad@suse.de>
References: <20190911085536.25546-1-cfamullaconrad@suse.de>
 <20190911165225.2122-1-cfamullaconrad@suse.de>
Message-ID: <20191011120201.GA26698@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clemens,

> Because of timeout problems when using TST_RETRY_FN() we do now use
> LTP_TIMEOUT_MUL to adopt the timeout value.

> Introduced tst_adjut_timeout function to have a generic place to
> adopt timeout values.

@Li, Cyril, Jan acking this?

Acked-by: Petr Vorel <pvorel@suse.cz>
for whole patchset, with suggestion to use $(( )) instead of $(expr ) [1].
(was used originaly, but when you're touching the code, could you please change it?)

I'm for merging this patchset, but I'd rather merge my "v5 shell: Introduce
TST_TIMEOUT variable" [2] [3] patchset first.
I can rebase this patchset before merge.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1161157/#2258600
[2] https://patchwork.ozlabs.org/patch/1175082/
[3] https://patchwork.ozlabs.org/project/ltp/list/?series=135548&state=*
