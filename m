From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Mar 2018 19:30:58 +0200
Subject: [LTP] [RFC PATCH 0/3] Rewritting network tests into new shell
	API
In-Reply-To: <20180329154537.32711-1-pvorel@suse.cz>
References: <20180329154537.32711-1-pvorel@suse.cz>
Message-ID: <20180329173058.GA18702@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> I'd like to test_net.sh using new shell API, it's useful from several
> perspectives, but it's a huge task:

> $ git grep -l -e '\. test_net.sh' -e '\. test_net_stress.sh' |wc -l
> 79

> So I decided to extend test_net.sh to support and rewrite into new API
> tests which uses test_net_stress.sh (all stress/interface tests and part
> of stress/multicast tests).
> test_net.sh got cluttered by it, but hope not for long time.

I'd also like to rename:
test_net.sh => tst_net.sh
test_net_stress.sh => tst_net_stress.sh


Kind regards,
Petr
