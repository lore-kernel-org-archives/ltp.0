From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Jan 2021 16:23:57 +0100
Subject: [LTP] [PATCH] Reduce ksm06 memory footprint
In-Reply-To: <20210119134057.17785-1-mdoucha@suse.cz>
References: <20210119134057.17785-1-mdoucha@suse.cz>
Message-ID: <YAb5jcFvCNdhrcrp@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -ksm06_2 ksm06 -n 10000
> +ksm06_2 ksm06 -n 8000

Applied, since this is a sensible fix for the release.

Ideally we should change the test to be able to scale with the available
memory later on.

I guess that we can easily add array of free memory per node for the
tst_numa.h nodeamp, then we can select subset of nodes based on
allocation size or allocating size based on the set of nodes.

-- 
Cyril Hrubis
chrubis@suse.cz
