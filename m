From: Li Wang <liwang@redhat.com>
Date: Wed, 18 May 2016 17:04:02 +0800
Subject: [LTP] [PATCH 3/6] syscalls/madvise03: Convert to new test API
In-Reply-To: <20160517162054.GC13705@rei.suse.cz>
References: <1463042993-398-1-git-send-email-liwang@redhat.com>
 <1463042993-398-2-git-send-email-liwang@redhat.com>
 <1463042993-398-3-git-send-email-liwang@redhat.com>
 <20160517162054.GC13705@rei.suse.cz>
Message-ID: <20160518090402.GA9916@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 17, 2016 at 06:20:55PM +0200, Cyril Hrubis wrote:
> Hi!
> 
> I also wonder if these testcases could be moved to madvise01.

Good idea! I'd like to merge madvise0[3|4] into madvise01. But for
madvise02.c, there probably should be taken more consideration.
If that mix up the codes, I'd prefer to keep it individual.

Additionally, thanks for the comments upon, all accepted.

Li Wang

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
