From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Oct 2017 12:05:31 +0100
Subject: [LTP] [PATCH 05/18] hugeshmctl02: Fix allocation size for odd
 number of hugepages
In-Reply-To: <20171026141447.26749-6-punit.agrawal@arm.com>
References: <20171026141447.26749-1-punit.agrawal@arm.com>
 <20171026141447.26749-6-punit.agrawal@arm.com>
Message-ID: <20171031110531.GE14550@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The test tries to allocate 2 * (half the number of available hugepages).
> If we have odd number hugepages, the calculated allocation size is not
> page-aligned and allocation fails.
> 
> e.g, (use -s option to trigger it manually)
> 
> $ hugeshmctl02 -s 7 -i 5
> hugeshmctl02    0  TINFO  :  set nr_hugepages to 7
> hugeshmctl02    1  TBROK  :  hugeshmctl02.c:153: shmget #2: errno=ENOMEM(12): Cannot allocate memory
> hugeshmctl02    2  TBROK  :  hugeshmctl02.c:153: Remaining cases broken
> hugeshmctl02    0  TINFO  :  set nr_hugepages to 0
> 
> Align the size to hugepage_size.

This one is obviously OK.

-- 
Cyril Hrubis
chrubis@suse.cz
