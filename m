From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 31 Oct 2019 14:21:53 +0100
Subject: [LTP] [PATCH] net/dhcp: Don't start dhclient when wicked is
 running
In-Reply-To: <20191022140745.12777-1-pvorel@suse.cz>
References: <20191022140745.12777-1-pvorel@suse.cz>
Message-ID: <20191031132153.GC28424@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> This is a rework of wicked workaround. Commit f5b28dbb0 stopped wicked
> (if running) as it's conflicting with dhclient. But for systems which
> use wicked is better to actually test wicked as client side, because
> dhclient is not actually used.

> Fixes: f5b28dbb0 ("net/dhcp: Add support for wicked")

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Merged.

Kind regards,
Petr
