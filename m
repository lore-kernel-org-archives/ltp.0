From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 Feb 2020 17:10:33 +0100
Subject: [LTP] [PATCH v6 1/2] safe_macros: Use tst_umount() in
 safe_umount()
In-Reply-To: <20200207155730.GB16951@rei.lan>
References: <20200207144105.19947-1-pvorel@suse.cz>
 <20200207152406.GA16951@rei.lan>
 <285421765.6549099.1581090469387.JavaMail.zimbra@redhat.com>
 <20200207155730.GB16951@rei.lan>
Message-ID: <20200207161033.GA27725@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > I agree. Though I'd like to point out that tst_umount() currently loops
> > on any error, not just EBUSY.

> Right, I guess that we should change that to be on the safe side, it was
> never intended to retry anything else than EBUSY.

> What about?
Acked-by: Petr Vorel <pvorel@suse.cz>


> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 89b9c96de..52a5b37fd 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -371,6 +371,9 @@ int tst_umount(const char *path)
>                                  "mounted fs, kill it to speed up tests.");
>                 }

> +               if (err != EBUSY) {
> +                       errno = err;
> +                       return ret;
> +               }
> +
>                 usleep(100000);
>         }

Kind regards,
Petr
