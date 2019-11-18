From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 18 Nov 2019 17:18:55 +0100
Subject: [LTP] [PATCH] fallocate05: increase FALLOCATE_SIZE
In-Reply-To: <d8ad4bab26557fdf70e7ebc3f771bbb37ae889d7.1574093242.git.jstancek@redhat.com>
References: <d8ad4bab26557fdf70e7ebc3f771bbb37ae889d7.1574093242.git.jstancek@redhat.com>
Message-ID: <202fcb5a-c110-abdf-c305-7a0f5b6c1efc@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/18/19 5:08 PM, Jan Stancek wrote:
> write() returning ENOSPC doesn't guarantee that filesystem after
> some internal book-keeping, flushing, finishing transactions, etc.
> won't still find some extra space.
> 
> Increase FALLOCATE_SIZE to minimize chance of hitting sporadic
> failures when that happens.

We're planning to rewrite fallocate05 this week and FALLOCATE_SIZE will
be removed entirely. The test must use a multiple of the real file
system block size, otherwise it'll test different things on different
platforms.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
