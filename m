From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Dec 2020 15:45:03 +0100
Subject: [LTP] [PATCH 1/1] if-mtu-change.sh: Add max packet size
 detection for IPv4
In-Reply-To: <53607e8b-176f-5aaf-4b5f-9efabd1d756f@oracle.com>
References: <20201215190545.19939-1-pvorel@suse.cz>
 <53607e8b-176f-5aaf-4b5f-9efabd1d756f@oracle.com>
Message-ID: <X9odb308xDv/W+Ou@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,

> Another option would be to limit max size according to the size of
> the set mtu, so that we test packets with and without fragmentation,
> i.e. tst_ping -s "1 $((mtu / 2)) $mtu $((5 * mtu))", where "$mtu"
> size - for minor fragmentation.
Yes, that would fix the problem as well.

> Anyway the patch looks good, minor comments below.
I would prefer to also test higher MTU, thus I'll merge my patchset with all
changes you're suggested.

Thanks a lot for your review.

Kind regards,
Petr
