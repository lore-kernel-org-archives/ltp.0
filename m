From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Aug 2021 14:11:24 +0200
Subject: [LTP] [PATCH 2/3] network/tst_net.sh: fix busybox/sysctl in
 tst_set_sysctl()
In-Reply-To: <48500320-6cc6-591a-fc3d-708e88fd8640@bell-sw.com>
References: <20210804120446.32835-1-aleksei.kodanev@bell-sw.com>
 <20210804120446.32835-2-aleksei.kodanev@bell-sw.com>
 <YR+HXE01R1RE8TTH@pevik>
 <48500320-6cc6-591a-fc3d-708e88fd8640@bell-sw.com>
Message-ID: <YSTh7DeKY5J0SSyv@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

..
> >> -	tst_net_run $safe $rparam "sysctl -q -w $name=$value"
> >> +	tst_net_run $safe $rparam "sysctl -q -w" "$name=$value"

> > I wonder if it were a bit clearer if we moves all params to second arg:
> > 	tst_net_run $safe "sysctl" "$name=$value -q -w"

> OK, but changed to "sysctl" "-q -w $name=$value" because the other
> options should also be placed before the key/value pair:

>     Usage: sysctl -p [-enq] [FILE...] / [-enqaw] [KEY[=VALUE]]...
Thanks for addressing it!

Kind regards,
Petr
