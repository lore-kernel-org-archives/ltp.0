From: Li Wang <liwang@redhat.com>
Date: Sat, 12 Oct 2019 10:46:52 +0800
Subject: [LTP] [PATCH v2 1/3] tst_test.sh: Use LTP_TIMEOUT_MUL in
 TST_RETRY_FN()
In-Reply-To: <20191011125345.GE2591@rei>
References: <20190911085536.25546-1-cfamullaconrad@suse.de>
 <20190911165225.2122-1-cfamullaconrad@suse.de>
 <20191011120201.GA26698@dell5510> <20191011125345.GE2591@rei>
Message-ID: <CAEemH2eL-y9LU+TyObw2_LqD_=S3R1VH350wRNoQFYF4Q8Bp7w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Oct 11, 2019 at 8:53 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > I'm for merging this patchset, but I'd rather merge my "v5 shell:
> Introduce
> > TST_TIMEOUT variable" [2] [3] patchset first.
> > I can rebase this patchset before merge.
>
> Well, we still need to ceil the LTP_TIMEOUT_MUL in the shell version of
> the TST_RETRY_FN_EXP_BACKOFF. So I would say that your patch has to go
> first, then we need to export the part that ceils the timeout multiplier
> as a function and finally use it in the first patch of this patchset.
>

Agreed.

@Petr, I have no more comments, feel free to merge this with the changing
as we discussed.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191012/13570177/attachment.htm>
