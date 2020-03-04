From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Mar 2020 12:48:21 +0100
Subject: [LTP] [PATCH 1/1] memcg/stress: Lower swap memory use
In-Reply-To: <20200117063600.3451-1-pvorel@suse.cz>
References: <20200117063600.3451-1-pvorel@suse.cz>
Message-ID: <20200304114821.GA24724@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ji,

> -	MEM=$(( $mem_free + $swap_free / 2 ))
> +	MEM=$(( $mem_free + $swap_free / 1O ))
Sorry, this is a typo, it's "o", but it must be 0.
MEM=$(( $mem_free + $swap_free / 10 ))

Kind regards,
Petr
