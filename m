From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Nov 2017 03:13:19 -0500 (EST)
Subject: [LTP] [PATCH 2/2] mm: enlarge mmap HIGH_ADDR value for s390 arch
In-Reply-To: <20171025033006.32463-2-liwang@redhat.com>
References: <20171025033006.32463-1-liwang@redhat.com>
 <20171025033006.32463-2-liwang@redhat.com>
Message-ID: <436712851.37925655.1510128799182.JavaMail.zimbra@redhat.com>
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
> mmap15.c:
> mmap15  1  TFAIL  :  mmap15.c:77: mmap into high region succeeded
> unexpectedly
> 
> mmapstress03.c:
> mmapstress03: errno = 25: really large mmap didn't fail
> mmapstress03    0  TINFO  :  uname.machine=s390x kernel is 32bit

                                     Isn't this the problem? ^^

> mmapstress03    1  TFAIL  :  mmapstress03.c:212: Test failed
> 

Regards,
Jan
