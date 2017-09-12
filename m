From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Sep 2017 11:24:31 -0400 (EDT)
Subject: [LTP] [PATCH 1/2] [COMMITTED] syscalls/shmat01: Fix test on
 32bit
In-Reply-To: <20170912151827.20551-1-chrubis@suse.cz>
References: <20170912151827.20551-1-chrubis@suse.cz>
Message-ID: <1458338308.13858491.1505229871475.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The problem there is that the address casted to intptr_t yields negative
> number which when divided then multiplied by SHMLBA aligns the value up
> instead of down.
> 
> The fix is simple, we cast the pointer to uintptr_t instead of intptr_t
> and also include stdint.h explicitly.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

You have beat me by ~3 minutes. I was just going to push,
did final 'git pull --rebase' and my commit disappeared :-).

Regards,
Jan
