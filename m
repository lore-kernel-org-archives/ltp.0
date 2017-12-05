From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Dec 2017 09:52:25 +0100
Subject: [LTP] [PATCH v3 01/12] Move check_hugepage() helper to mem/lib
In-Reply-To: <20171204163655.8838-2-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
 <20171204163655.8838-2-punit.agrawal@arm.com>
Message-ID: <20171205085225.wuwqdjmdtgth7dxl@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Move the check_hugepage() helper to mem/lib to be more widely available
> to testcases. Specifically, it will be used in a subsequent commit to
> check for the presence of hugepage support when running the thp tests.

> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
Acked-by: Petr Vorel <pvorel@suse.cz>
