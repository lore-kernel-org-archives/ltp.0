From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Apr 2018 19:00:29 +0200
Subject: [LTP] [RFC PATCH v6 3/7] network.sh: Migrate to new shell API
In-Reply-To: <fcdbaf75-7003-ff02-4fb6-6acfc0b504a2@oracle.com>
References: <20180406123118.21309-1-pvorel@suse.cz>
 <20180406123118.21309-4-pvorel@suse.cz>
 <fcdbaf75-7003-ff02-4fb6-6acfc0b504a2@oracle.com>
Message-ID: <20180410170029.dpl6q3ytkvqataql@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > --- a/testscripts/network.sh
> > +++ b/testscripts/network.sh
> > @@ -89,7 +89,7 @@ shift $(($OPTIND - 1))
> >  TST_TOTAL=1
> >  TCID="network_settings"
> Do we need these variables in the new API?

Yes, good catch, both are redundant.

TCID is invalid, it was required, but with the fix you pointed out (see below) TCID is
redundant.

TST_ID:
 TST_ID="network_settings" would keep previous name:
network_settings 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface

without TST_ID is the name of the script (set by tst_test.sh: filename=$(basename $0) ):
network 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface

Unless you have any preference I'd user the later (removing TST_ID)
+ removing TST_TOTAL.

> For TCID, I guess we would also need this change in tst_test.sh:

> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 6c2ee6a..b7aa4a7 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -102,7 +102,7 @@ tst_res()

>         tst_inc_res "$res"

> -       printf "$TCID $TST_COUNT "
> +       printf "$TST_ID $TST_COUNT "
>         tst_print_colored $res "$res: "
>         echo "$@"
>  }

Thanks a lot for pointing out my old copy-paste error!
Pushed as:
958969f4d tst_test.sh: Fix using correct test ID variable
with you as Reported-by.


Kind regards,
Petr
