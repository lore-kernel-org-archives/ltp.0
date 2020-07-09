From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 9 Jul 2020 03:46:58 -0400 (EDT)
Subject: [LTP] [PATCH] Use fallocate() to create loop device backing file
In-Reply-To: <20200702141503.2556-1-mdoucha@suse.cz>
References: <20200702141503.2556-1-mdoucha@suse.cz>
Message-ID: <270712218.1348506.1594280818466.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Creating large loop device backing files using tst_fill_file() on shared
> testing machines  may lead to performance issues and timeouts. Preallocating
> space using fallocate() is fast and sufficient.
> 
> Space allocation will fall back to tst_fill_file() if fallocate() fails for
> any
> other reason than lack of space.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

Acked-by: Jan Stancek <jstancek@redhat.com>

