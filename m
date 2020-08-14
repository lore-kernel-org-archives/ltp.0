From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Aug 2020 17:42:17 +0200
Subject: [LTP] [PATCH 4/4] Add taint check to syscalls/ptrace08
In-Reply-To: <20200811130502.12010-4-mdoucha@suse.cz>
References: <20200811130502.12010-1-mdoucha@suse.cz>
 <20200811130502.12010-4-mdoucha@suse.cz>
Message-ID: <20200814154217.GD30390@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> The test may pass on some kernels despite triggering a kernel segfault. Check
> for kernel taint just in case.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
