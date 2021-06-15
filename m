From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Jun 2021 10:06:34 +0200
Subject: [LTP] [PATCH] icmp_rate_limit01: Require CONFIG_VETH
In-Reply-To: <20210615075104.24870-1-rpalethorpe@suse.com>
References: <20210615075104.24870-1-rpalethorpe@suse.com>
Message-ID: <YMhfini/+dDFnrAY@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> The test fails with TBROK if it can not create a virtual ethernet
> pair. So add it to the kconfigs.

Thanks, merged!

Kind regards,
Petr
