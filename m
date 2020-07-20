From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jul 2020 10:43:29 +0200
Subject: [LTP] [PATCH v2 2/7] tst_net.sh: Use ssh in LTP_RSH
In-Reply-To: <5F155335.8080901@cn.fujitsu.com>
References: <20200710172044.21592-1-pvorel@suse.cz>
 <20200710172044.21592-3-pvorel@suse.cz>
 <5F155335.8080901@cn.fujitsu.com>
Message-ID: <20200720084329.GE11397@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,
> Hi Petr,

> Some very old stress tests use check_envval(instead of tst_net.sh) to
> init LTP_RSH,
> Do you think if we need to change it as well:
> --------------------------------------
> # LTP_RSH
> LTP_RSH=${LTP_RSH:=}
> if [ x"${LTP_RSH}" = x ]; then
> LTP_RSH="rsh -n"
> elif [ "$LTP_RSH" = "rsh" ]; then
> LTP_RSH="rsh -n"
> fi
> --------------------------------------

No, I wouldn't touch this legacy code. The goal is to rewrite this old code,
there is a ticket for it:
https://github.com/linux-test-project/ltp/issues/440

> Thanks,
> Xiao Yang

Kind regards,
Petr
