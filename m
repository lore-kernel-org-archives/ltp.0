From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 10 Feb 2020 03:19:12 -0500 (EST)
Subject: [LTP] [PATCH v6 1/2] safe_macros: Use tst_umount() in
 safe_umount()
In-Reply-To: <20200207155730.GB16951@rei.lan>
References: <20200207144105.19947-1-pvorel@suse.cz>
 <20200207152406.GA16951@rei.lan>
 <285421765.6549099.1581090469387.JavaMail.zimbra@redhat.com>
 <20200207155730.GB16951@rei.lan>
Message-ID: <748200464.6799894.1581322752135.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > My expectation is that retrying on EBUSY will not break anything. Jan
> > > what do you think?
> > 
> > I agree. Though I'd like to point out that tst_umount() currently loops
> > on any error, not just EBUSY.
> 
> Right, I guess that we should change that to be on the safe side, it was
> never intended to retry anything else than EBUSY.
> 
> What about?
> 
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 89b9c96de..52a5b37fd 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -371,6 +371,9 @@ int tst_umount(const char *path)
>                                  "mounted fs, kill it to speed up tests.");
>                 }
>  
> +               if (err != EBUSY) {
> +                       errno = err;
> +                       return ret;
> +               }
> +
>                 usleep(100000);
>         }

Works for me too, I don't recall seeing anything else than EBUSY.

