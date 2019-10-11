From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Oct 2019 14:53:45 +0200
Subject: [LTP] [PATCH v2 1/3] tst_test.sh: Use LTP_TIMEOUT_MUL in
 TST_RETRY_FN()
In-Reply-To: <20191011120201.GA26698@dell5510>
References: <20190911085536.25546-1-cfamullaconrad@suse.de>
 <20190911165225.2122-1-cfamullaconrad@suse.de>
 <20191011120201.GA26698@dell5510>
Message-ID: <20191011125345.GE2591@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm for merging this patchset, but I'd rather merge my "v5 shell: Introduce
> TST_TIMEOUT variable" [2] [3] patchset first.
> I can rebase this patchset before merge.

Well, we still need to ceil the LTP_TIMEOUT_MUL in the shell version of
the TST_RETRY_FN_EXP_BACKOFF. So I would say that your patch has to go
first, then we need to export the part that ceils the timeout multiplier
as a function and finally use it in the first patch of this patchset.

-- 
Cyril Hrubis
chrubis@suse.cz
