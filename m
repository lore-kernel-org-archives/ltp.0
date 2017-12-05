From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Dec 2017 09:53:05 +0100
Subject: [LTP] [PATCH v3 02/12] thp: ensure hugetlbfs is available
In-Reply-To: <20171204163655.8838-3-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
 <20171204163655.8838-3-punit.agrawal@arm.com>
Message-ID: <20171205085305.krg4xqzg6wavooml@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> From: Will Deacon <will.deacon@arm.com>

> The THP tests thp02 and thp03 depend on the presence of hugetlbfs to get
> the default hugepage size. If hugetlbfs is not enabled, /proc/meminfo
> does not contain "Hugepagesize" and the tests fail with -

> safe_file_ops.c:220: BROK: Expected 1 conversions got 0 at thp03.c:85

> which is hard to relate to the missing support for hugetlbfs.

> Add tests for the presence of hugetlbfs for tests relying on this kernel
> feature.

> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
Acked-by: Petr Vorel <pvorel@suse.cz>
