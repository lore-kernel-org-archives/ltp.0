From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Dec 2018 10:17:27 +0100
Subject: [LTP] [PATCH 1/1] tst_test.sh: Add info about LTP_TIMEOUT_MUL
 into TBROK message
In-Reply-To: <20181130181444.26565-1-pvorel@suse.cz>
References: <20181130181444.26565-1-pvorel@suse.cz>
Message-ID: <20181217091727.GA471@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

..
> +++ b/testcases/lib/tst_test.sh
...
> -	sleep $sec && tst_res TBROK "test killed, timeout!" && kill -9 -$pid &
> +	sleep $sec && tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9 -$pid &

FYI: pushed.

Kind regards,
Petr
