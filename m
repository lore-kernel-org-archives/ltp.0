From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Jan 2021 15:47:44 +0100
Subject: [LTP] [PATCH 1/1] if-mtu-change.sh: Lower CHANGE_INTERVAL to 1
In-Reply-To: <dced71df-28f6-056e-9518-338cccce4c11@oracle.com>
References: <20210107120247.31465-1-pvorel@suse.cz>
 <d7eba485-08db-1cc7-abe6-38d23c244bfb@oracle.com>
 <X/7+vk6WsJ2LDJlC@pevik>
 <dced71df-28f6-056e-9518-338cccce4c11@oracle.com>
Message-ID: <YABZkHIQmDUnKFZF@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,

> Do you mean "sleep $NS_DURATION" in mcast-pktfld02.sh is not needed
Yes: sleep $NS_DURATION in mcast-pktfld02.sh and other mcast*.sh tests in:
https://patchwork.ozlabs.org/project/ltp/patch/20201125053459.3314021-2-lkml@jv-coder.de/
https://patchwork.ozlabs.org/project/ltp/patch/20201125053459.3314021-1-lkml@jv-coder.de/

> or something else?

Kind regards,
Petr
