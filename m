From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 4 Dec 2019 10:07:04 +0100
Subject: [LTP] [PATCH] Unshare KSM pages before setting max_page_sharing
In-Reply-To: <20191202032936.GA32335@dell5510>
References: <20191128163147.4377-1-mdoucha@suse.cz>
 <20191202032936.GA32335@dell5510>
Message-ID: <b4489aba-9f59-ff44-e2b3-3af6d9cd3cb1@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/2/19 4:29 AM, Petr Vorel wrote:
> BTW at least ksm01 will fail on VM host with running VMs,
> but that's another story not related to this patch.
> 
> mem.c:251: FAIL: pages_shared is not 1 but 3629.
> mem.c:251: FAIL: pages_sharing is not 98302 but 113789.
> mem.c:251: FAIL: pages_volatile is not 0 but 12.
> mem.c:251: FAIL: pages_unshared is not 1 but 48519.

I'm aware of other KSM tests failing but the failures are rare and quite
random so they'll be tricky to debug. The snippet you've sent looks like
interference from another process running on the same VM but the
failures I see in OpenQA look like some sort of race condition in kernel
itself.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
