From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 4 Dec 2017 16:00:31 +0100
Subject: [LTP] IPsec DCCP stress tests: udp6_ipsec_vti[01]*,
 icmp4-uni-vti17: too big message size
Message-ID: <20171204150031.6kjf2xn3zcs67sed@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

I found IPsec DCCP stress tests I've found that udp6_ipsec_vti[01]* tests have too big
message size 65527.
And icmp4-uni-vti17 has too big message size 1500.

I tested it on several distros and got the same result. Should we lower / delete the value?

I also think that tst_ipsec_setup_vti() (in ipsec_lib.sh) should has trap to int:
trap "tst_brkm TBROK 'test interrupted'" INT


Kind regards,
Petr
