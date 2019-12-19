From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Dec 2019 19:17:33 +0100
Subject: [LTP] [PATCH 1/1] iptables: Reduce code duplicity
In-Reply-To: <0805dbe9-e769-1073-10e0-ca42c9d06052@oracle.com>
References: <20191219072638.31824-1-pvorel@suse.cz>
 <0805dbe9-e769-1073-10e0-ca42c9d06052@oracle.com>
Message-ID: <20191219181733.GA23391@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Lgtm, except the removing of the variables, which were initializing
> with 0 (including cleanup_ ones). I know, it's very unlikely, but what
> if someone use the same name already elsewhere, then we get unexpected
> results for the test:

> # export use_iptables=1
> # nft01.sh 
> nft01 1 TINFO: timeout per run is 0h 5m 0s
> nft01 1 TINFO: INIT: Flushing all rules
> nft01 1 TINFO: iptables -L -t filter will list all rules in table filter
> nft01 1 TINFO: iptables -L -t filter lists rules

Right, this makes sense. Thanks for review, merged with variables kept.

Kind regards,
Petr
