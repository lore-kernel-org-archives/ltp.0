From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 28 Dec 2020 21:03:57 +0100
Subject: [LTP] [PATCH 1/1] tst_net.sh: Require veth for netns
In-Reply-To: <20201217134620.10128-1-pvorel@suse.cz>
References: <20201217134620.10128-1-pvorel@suse.cz>
Message-ID: <20201228200357.GA18526@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> new error message is more informative:
> tcp_fastopen_run 1 TCONF: veth driver not available

> then the old one:
> Error: Unknown device type.
> tcp_fastopen_run 1 TBROK: ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2 failed

Merged.

Kind regards,
Petr
