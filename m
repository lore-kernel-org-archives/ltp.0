From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 Feb 2020 13:44:20 +0100
Subject: [LTP] [PATCH v6 1/2] safe_macros: Use tst_umount() in
 safe_umount()
In-Reply-To: <748200464.6799894.1581322752135.JavaMail.zimbra@redhat.com>
References: <20200207144105.19947-1-pvorel@suse.cz>
 <20200207152406.GA16951@rei.lan>
 <285421765.6549099.1581090469387.JavaMail.zimbra@redhat.com>
 <20200207155730.GB16951@rei.lan>
 <748200464.6799894.1581322752135.JavaMail.zimbra@redhat.com>
Message-ID: <20200210124420.GA14605@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > +               if (err != EBUSY) {
> > +                       errno = err;
> > +                       return ret;
> > +               }
> > +
> >                 usleep(100000);
> >         }

> Works for me too, I don't recall seeing anything else than EBUSY.

Thanks!
Just in case I've sent this commit as v2, followed with "safe_macros: Use
tst_umount() in safe_umount()" (without Zorro's fsmount commit).
IMHO now is docs about tst_umount() correct.

https://patchwork.ozlabs.org/patch/1235811/

Kind regards,
Petr
