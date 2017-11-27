From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Nov 2017 14:06:05 +0100
Subject: [LTP] [PATCH 1/1] network/ipsec: TCONF instead of TFAIL when
 operation not supported
In-Reply-To: <c0b4f298-bc1d-0e5f-2df9-73e96079f772@oracle.com>
References: <20171123115027.12966-1-pvorel@suse.cz>
 <c0b4f298-bc1d-0e5f-2df9-73e96079f772@oracle.com>
Message-ID: <20171127130605.6j3zhvxxsq353v5s@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On 11/23/2017 02:50 PM, Petr Vorel wrote:
> > This happens when kernel module ip_vti resp. ip6_vti is missing.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
...
> Right, we should handle this case.Acked.
Pushed, thanks!


Kind regards,
Petr
