From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 21 Aug 2018 07:36:15 -0400 (EDT)
Subject: [LTP] [PATCH v5] Test for memfd_create() syscall with
 MFD_HUGETLB	flag.
In-Reply-To: <20180809071005.12702-1-vishnu@zilogic.com>
References: <20180809071005.12702-1-vishnu@zilogic.com>
Message-ID: <1717047909.41606943.1534851375090.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> * memfd_create03: Tests the syscall for the flag MFD_HUGETLB.
> 
> * memfd_create04: Tests the syscall for the flags MFD_HUGE_2MB,
>                   MFD_HUGE_1GB, ... used in conjunction with
>                   MFD_HUGETLB flag.
> 
> -- major changes from v4 to v5 --
> 
> * memfd_create03:
> 
> ** Add system huge page support check using sysfs.
> 
> Signed-off-by: Sikkandar Sulaiman A <sikkandarsulaiman@zilogic.com>
> Signed-off-by: Vishnu K <vishnu@zilogic.com>

Tests look good on x86, ppc and aarch64. Pushed.

Regards,
Jan
