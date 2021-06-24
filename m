From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Jun 2021 20:32:54 +0200
Subject: [LTP] [PATCH] fix rpc_suite/rpc:add check returned value
In-Reply-To: <20210617070806.174220-1-dongshijiang@inspur.com>
References: <20210617070806.174220-1-dongshijiang@inspur.com>
Message-ID: <YNTP1iJAwrCXXbVw@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi dongshijiang,

> "Segmentation fault (core dumped)" due to the failure of svcfd_create during the rpc test, so you need to check the return value of the "svcfd_create" function
Merged (with removed useless (SVCXPRT *) cast and svcr = NULL; also added more
cleanup in additional commit.

Thanks!

Kind regards,
Petr
