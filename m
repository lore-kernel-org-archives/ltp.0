From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 27 Nov 2017 15:36:59 +0300
Subject: [LTP] [PATCH 1/1] network/ipsec: TCONF instead of TFAIL when
 operation not supported
In-Reply-To: <20171123121523.c3zqwgbdu2ayawfi@dell5510>
References: <20171123115027.12966-1-pvorel@suse.cz>
 <20171123121523.c3zqwgbdu2ayawfi@dell5510>
Message-ID: <61a52c2d-2298-6669-02c1-3cf51c6410bf@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/23/2017 03:15 PM, Petr Vorel wrote:
>> This happens when kernel module ip_vti resp. ip6_vti is missing.
> And I propose to parse this and also TCONF it:
> Garbage instead of arguments "local ...". Try "ip link help".

Is it because iproute doesn't support it?

Thanks,
Alexey


>
> I find it on 3.16 (quite old kernel), but IMHO worth of taking care of it.
>
> Kind regards,
> Petr
>

