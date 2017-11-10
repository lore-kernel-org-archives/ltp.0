From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 10 Nov 2017 03:27:54 -0500 (EST)
Subject: [LTP] [PATCH v2 2/2] mm: raise mmap HIGH_ADDR value for s390
	arch
In-Reply-To: <20171110080721.12355-2-liwang@redhat.com>
References: <20171110080721.12355-2-liwang@redhat.com>
Message-ID: <2107764768.38703684.1510302474140.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The kernel commit 1aea9b3f92 (s390/mm: implement 5 level pages tables)
> enlarge the maximum address in the tasks address space from (1UL << 53)
> to (-PAGE_SIZE) on s390 platform.
> 
> We have to increase the HIGH_ADDR in ltp testcases accordingly otherwise
> that would be failed with succeeded mmap into high region:
> 
> mmap15  1  TFAIL  :  mmap15.c:77: mmap into high region succeeded
> unexpectedly
> 

Pushed. I had to fix small compilation error in munmap(), variable name
changed.

Regards,
Jan
