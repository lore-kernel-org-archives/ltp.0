From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 6 Dec 2017 10:44:19 +0300
Subject: [LTP] IPsec DCCP stress tests: udp6_ipsec_vti[01]*,
 icmp4-uni-vti17: too big message size
In-Reply-To: <20171204150031.6kjf2xn3zcs67sed@dell5510>
References: <20171204150031.6kjf2xn3zcs67sed@dell5510>
Message-ID: <4e2eae3b-1f8e-2f3e-a315-b87089bfc1f6@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/04/2017 06:00 PM, Petr Vorel wrote:
> Hi Alexey,
>
> I found IPsec DCCP stress tests I've found that udp6_ipsec_vti[01]* tests have too big
> message size 65527.

Hi Petr,

Interesting, I'm using 9000 mtu on the underlying device and
it works fine (vti6 always sets 1500). I see that we not
adjusting mtu on the newly created vti device, it should be
less than output device but right now it's the same.

> And icmp4-uni-vti17 has too big message size 1500.

New test-case... I thought after compression it won't fragment
this, but ipcomp works after vti fragments icmp packets, so we
should lower the size (current ip_vti mtu is 1332).

I'll prepare the patches.

>
> I tested it on several distros and got the same result. Should we lower / delete the value?
>
> I also think that tst_ipsec_setup_vti() (in ipsec_lib.sh) should has trap to int:
> trap "tst_brkm TBROK 'test interrupted'" INT

Yes, we could add it to the library.

Thanks,
Alexey

