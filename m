From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Aug 2020 18:58:26 +0200
Subject: [LTP] [PATCH v3] Add mincore() test for pages cached by another
 process
In-Reply-To: <20200803071312.4140-1-shwetha@zilogic.com>
References: <20200803071312.4140-1-shwetha@zilogic.com>
Message-ID: <20200803165826.GC4914@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> It tests the result of mincore when memory is mapped and cached by
> another process. A file is mapped in both parent and child
> process.Then the mapped memory is accessed in the child process. The
> results of mincore are tested in the parent process.

> References:#460

> Signed-off-by: Shwetha Subramanian. <shwetha@zilogic.com> 
> Reviewed-by:Vijay Kumar B. <vijaykumar@zilogic.com>

Thanks for your patch, merged!

Kind regards,
Petr
