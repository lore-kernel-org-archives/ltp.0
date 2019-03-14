From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Mar 2019 14:33:38 +0100
Subject: [LTP] [PATCH 2/2] lib/tst_net.sh: use SO_BINDTODEVICE in
 tst_netload()
In-Reply-To: <20190226182709.GC27937@dell5510>
References: <1551198213-10024-1-git-send-email-alexey.kodanev@oracle.com>
 <1551198213-10024-2-git-send-email-alexey.kodanev@oracle.com>
 <20190226182709.GC27937@dell5510>
Message-ID: <20190314133338.GA29729@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > Since we have the information about the device, enable the
> > usage of the option, when starting netstress.

> > It can be disabled with TST_NETLOAD_BINDTODEVICE=0.

Having any reason not to push this patch?

Kind regards,
Petr
