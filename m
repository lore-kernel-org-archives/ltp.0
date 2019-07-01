From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 1 Jul 2019 06:51:56 -0400 (EDT)
Subject: [LTP] [PATCH v5 2/2] pkey: add test for memory protection keys
In-Reply-To: <20190701081917.32051-2-liwang@redhat.com>
References: <20190701081917.32051-1-liwang@redhat.com>
 <20190701081917.32051-2-liwang@redhat.com>
Message-ID: <548654065.31002613.1561978316851.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Memory Protection Keys for Userspace (PKU aka PKEYs) is a Skylake-SP
> server feature that provides a mechanism for enforcing page-based
> protections, but without requiring modification of the page tables
> when an application changes protection domains. It works by dedicating
> 4 previously ignored bits in each page table entry to a "protection key",
> giving 16 possible keys.
> 
> Basic method for PKEYs test:
>   1. test allocates a pkey(e.g. PKEY_DISABLE_ACCESS) via pkey_alloc()
>   2. pkey_mprotect() apply this pkey to a piece of memory buffer
>   3. check if the access right of buffer has been changed and take effect
>   4. remove the access right(pkey) from this buffer via pkey_mprotect()
>   5. check if buffer area can be read or write after removing pkey
>   6. pkey_free() releases the pkey after using it
> 
> Looping around this basic test on diffenrent types of memory.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>

for series:
Acked-by: Jan Stancek <jstancek@redhat.com>

