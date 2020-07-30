From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 30 Jul 2020 10:16:31 +0200
Subject: [LTP] [PATCH v2 0/7] tst_net.sh: Remove rsh,
 update docs add debug & test
In-Reply-To: <20200710172044.21592-1-pvorel@suse.cz>
References: <20200710172044.21592-1-pvorel@suse.cz>
Message-ID: <20200730081631.GA26795@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey, Xiao,

...
> Petr Vorel (7):
>   tst_net.sh: Remove rsh support
>   tst_net.sh: Use ssh in LTP_RSH
>   net: Remove rsh, rcp, rlogin tests
>   net: Update README.md
>   tst_net.sh: Drop 'sh -c' use from ssh in tst_rhost_run
>   net/test: Add basic testing for tst_rhost_run
>   tst_net.sh/tst_rhost_run: Add debugging

I merged all but these to patches, which I'll resend:

*   net: Remove rsh, rcp, rlogin tests
@Alexey: I'd like to get your ack.

*   net: Update README.md
I'll fixes package and service names (Xiao) + move networking related doc from
INSTALL to testcases/network/README.md.

Kind regards,
Petr
