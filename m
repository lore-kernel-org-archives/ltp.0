From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Nov 2020 12:30:41 +0100
Subject: [LTP] [PATCH] net/host: update to new api
In-Reply-To: <80a391bf-b305-13ab-df79-169c8d4a0a28@oracle.com>
References: <20201116101840.15433-1-kory.maincent@bootlin.com>
 <20201116184143.GA171432@pevik>
 <80a391bf-b305-13ab-df79-169c8d4a0a28@oracle.com>
Message-ID: <20201117113041.GA43177@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > do_test()
> > {
> > 	local rhost=${RHOST:-$(hostname)}

> Hi Petr, Kory

> For new API we shouldn't use RHOST. Also the naming is misleading,
> it can be a local host name.

Thanks for catching it. Suppose this version is ok.

Kind regards,
Petr

TST_TESTFUNC="do_test"
TST_NEEDS_CMDS="awk host hostname"

. tst_net.sh

do_test()
{
	local lhost="$(hostname)"
	local addr

	tst_res TINFO "test basic functionality of the host command"

	if addr=$(host $lhost); then
		addr=$(echo "$addr" | awk '{print $NF}')
		EXPECT_PASS host $addr \>/dev/null
	else
		tst_brk TFAIL "host $lhost on local machine failed"
	fi
}

tst_run
