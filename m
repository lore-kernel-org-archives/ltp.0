From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 8 Nov 2017 14:23:40 +0300
Subject: [LTP] [PATCH 1/1] netstress: Add imports for TCP_FASTOPEN
	definition
In-Reply-To: <20171031134537.11034-1-pvorel@suse.cz>
References: <20171031134537.11034-1-pvorel@suse.cz>
Message-ID: <5c30e7d7-e511-b796-c184-eef7a4b3daa7@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/31/2017 04:45 PM, Petr Vorel wrote:
> + add necessary autoconf checks for these headers.

Looks good but I wouldn't include it in the test itself
but move these defines with your changes into lapi/tcp.h,
others like MSG_FASTOPEN, SOL_DCCP, SO_BUSY_POLL can be
moved to lapi/socket.h.

Thanks,
Alexey

