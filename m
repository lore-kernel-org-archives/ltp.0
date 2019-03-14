From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Mar 2019 17:20:40 +0100
Subject: [LTP] [PATCH 2/2] lib/tst_net.sh: use SO_BINDTODEVICE in
 tst_netload()
In-Reply-To: <5129c4d6-6246-be45-a3ff-3bdf1ab691bf@oracle.com>
References: <1551198213-10024-1-git-send-email-alexey.kodanev@oracle.com>
 <1551198213-10024-2-git-send-email-alexey.kodanev@oracle.com>
 <20190226182709.GC27937@dell5510> <20190314133338.GA29729@dell5510>
 <5129c4d6-6246-be45-a3ff-3bdf1ab691bf@oracle.com>
Message-ID: <20190314162040.GA13232@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> >>> Since we have the information about the device, enable the
> >>> usage of the option, when starting netstress.

> >>> It can be disabled with TST_NETLOAD_BINDTODEVICE=0.

> > Having any reason not to push this patch?


> Yes, at least this patch breaks mpls and ipsec/vti tests.
Right, all but mpls01 are broken, haven't noticed this.
Any idea why?

Kind regards,
Petr
