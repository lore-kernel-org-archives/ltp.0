From: Li Wang <liwang@redhat.com>
Date: Mon, 15 Mar 2021 13:23:48 +0800
Subject: [LTP] [PATCH 0/3] shell test timeout handling
In-Reply-To: <20210312173201.27708-1-pvorel@suse.cz>
References: <20210312173201.27708-1-pvorel@suse.cz>
Message-ID: <CAEemH2fLdFSFt99Lgn=4o4=MMNvd_0UNMaObSF=E13Jv+358LQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Mar 13, 2021 at 1:32 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> changes before previous attempt [1]
> * _tst_kill_test() (Cyril)
> * added test timeout03.sh
> * update trap message (Joerg)
>
> NOTE: we have no way to print summary from _tst_do_exit if cleanup get
> stuck, but IMHO there is no simple way how to solve it (we'd have to use
> mapped memory to increment counter also in shell API as Cyril suggested)
>
> [1]
> https://patchwork.ozlabs.org/project/ltp/patch/20210301220222.22705-7-pvorel@suse.cz/
>
> Petr Vorel (3):
>   tst_test.sh: Run cleanup also after test timeout
>   test: Adding timeout03.sh for testing _tst_kill_test()
>   zram: Increase timeout according to used devices
>

Nice work!

For series:
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210315/d14a3ccf/attachment.htm>
