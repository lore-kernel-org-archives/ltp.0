From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Jun 2018 17:07:40 +0200
Subject: [LTP] [PATCH 1/4] network/busy_poll: use smaller packets and a
 single thread
In-Reply-To: <1528992297-23920-1-git-send-email-alexey.kodanev@oracle.com>
References: <1528992297-23920-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180615150740.es6jxocmhaifss7w@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> This should make the results more stable for better performance
> comparison with/without busy polling.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Petr Vorel <pvorel@suse.cz>
> ---
Unfortunately I don't have any machine with busy polling,
but I suppose you know what you're doing.

> Tested on ixgbe NIC


Kind regards,
Petr
