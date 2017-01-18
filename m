From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Jan 2017 13:59:54 +0100
Subject: [LTP] FYI: networking: broken multicast test due upstream bug
In-Reply-To: <d244f109-d08e-d3d9-7a4c-79610a7cde33@oracle.com>
References: <20170118083100.myaindbkf2nsoqp2@dell5510>
 <d244f109-d08e-d3d9-7a4c-79610a7cde33@oracle.com>
Message-ID: <20170118125954.t2texsk36xjiorpk@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Thanks! May be we should workaround it as it will be skipped without doing
> anything on most distros.

> I see two options:
> * parse 'ip maddr show' without dev as a workaround if the first attempt
> fails, or
> * parse /proc/net/igmp, looking for 0x010000E0 (1.0.0.224).

Thanks for tips, posted implementation of parsing /proc/net/igmp.


Kind regards,
Petr
