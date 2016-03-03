From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Mar 2016 14:35:48 +0100
Subject: [LTP] [PATCH v2 2/2] numa_helper: add min_nodes parameter to
	is_numa()
In-Reply-To: <11305bbeff8a3b83ee9da6c4a17fc1cd9c37b9f5.1456220777.git.jstancek@redhat.com>
References: <83c57fb26e06f81d4b71cb89dfcd36706bf28093.1456220777.git.jstancek@redhat.com>
 <11305bbeff8a3b83ee9da6c4a17fc1cd9c37b9f5.1456220777.git.jstancek@redhat.com>
Message-ID: <20160303133548.GA3055@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> get_allowed_nodes() can fail if callers request more nodes than
> are available. This patch changes is_numa() by adding a parameter
> to it, which allows to easily check that system supports NUMA and
> has at least certain number of nodes and it also updates tests
> that used get_allowed_nodes() without checking node count first.

Shouldn't we pass the NH_MEMS/NH_CPUS flags to the is_numa() as well?

Otherwise the patchset looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
