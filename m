From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jun 2018 14:28:20 +0200
Subject: [LTP] [RFC PATCH 8/9] syscalls/ipc: Remove msgctl07
In-Reply-To: <20180612154631.435-9-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
 <20180612154631.435-9-chrubis@suse.cz>
Message-ID: <20180613122820.pda634vnoun4c7lm@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> The test is very similar to msgrcv01, does not test msgctl() and the
> code is messed up, hence it makes sense to remove it rather than moving
> it to msgrcv directory.
Make sense.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
