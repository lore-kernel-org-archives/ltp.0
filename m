From: Li Wang <liwang@redhat.com>
Date: Tue, 14 Sep 2021 10:27:12 +0800
Subject: [LTP] [RFC PATCH 1/1] sched: Remove process.c
In-Reply-To: <20210913100022.14501-1-pvorel@suse.cz>
References: <20210913100022.14501-1-pvorel@suse.cz>
Message-ID: <CAEemH2ety5_Ps0J=Y_1wRhAqV3higYy=OVEnok69LGgadyC1PA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Sep 13, 2021 at 6:00 PM Petr Vorel <pvorel@suse.cz> wrote:

> Test was removed as buggy from the runtest file nearly 20 years ago in:
> 576f1ee56 ("Removed a test that was not correctly running.")
>
> Test is probably obsolete, not using even legacy API, non-zero exit:
>
> $ ./process -d 8 -b 2 -t 1; echo $?
> total number of process to be created nodesum (511) is greater
>  than the allowed SEMMSL value (250)
> reseting the value of nodesum to SEMMSL
> Terminated
> 143
>
> + leaving very high load after being terminated.
>
> Reported-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210914/8a2d8425/attachment.htm>
