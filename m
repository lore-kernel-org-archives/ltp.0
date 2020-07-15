From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Jul 2020 11:52:42 +0200
Subject: [LTP] [PATCH 2/2] ioperm: Convert to new API
In-Reply-To: <20200709085237.10158-2-liwang@redhat.com>
References: <20200709085237.10158-1-liwang@redhat.com>
 <20200709085237.10158-2-liwang@redhat.com>
Message-ID: <20200715095242.GD7741@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Erico Nunes <ernunes@redhat.com>
> ---
>  testcases/kernel/syscalls/ioperm/ioperm01.c | 167 +++---------
>  testcases/kernel/syscalls/ioperm/ioperm02.c | 273 +++++---------------
>  testcases/kernel/syscalls/iopl/iopl02.c     |   2 +-

If anything the change to iopl02.c belongs to the previous patch.

And most of the comments for iopl apply for these patches as well.

Otherwise it's really nice cleanup.

-- 
Cyril Hrubis
chrubis@suse.cz
