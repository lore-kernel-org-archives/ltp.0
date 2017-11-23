From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 23 Nov 2017 13:15:23 +0100
Subject: [LTP] [PATCH 1/1] network/ipsec: TCONF instead of TFAIL when
 operation not supported
In-Reply-To: <20171123115027.12966-1-pvorel@suse.cz>
References: <20171123115027.12966-1-pvorel@suse.cz>
Message-ID: <20171123121523.c3zqwgbdu2ayawfi@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> This happens when kernel module ip_vti resp. ip6_vti is missing.
And I propose to parse this and also TCONF it:
Garbage instead of arguments "local ...". Try "ip link help".

I find it on 3.16 (quite old kernel), but IMHO worth of taking care of it.

Kind regards,
Petr

