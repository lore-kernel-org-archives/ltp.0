From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Aug 2018 07:06:05 -0400 (EDT)
Subject: [LTP] [PATCH v4] Test for memfd_create() syscall with
 MFD_HUGETLB	flag.
In-Reply-To: <20180801080815.7398-1-vishnu@zilogic.com>
References: <20180801080815.7398-1-vishnu@zilogic.com>
Message-ID: <1893457857.39484268.1533726365506.JavaMail.zimbra@redhat.com>
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
>                   MFD_HUGE_1GB,... used in conjunction with
>                   MFD_HUGETLB flag.
> 
> -- major changes from v3 to v4 --
> 
> * memfd_create03:
> 
> ** OR TERRNO with TFAIL for debugging purpose.
> 
> ** Move helper functions from memfd_create_hugetlb.c to the
>    main test code.
> 
> * memfd_create04:
> 
> ** Replace huge pages support check using procfs with sysfs.

Hi,

+1 for making it simpler (code has been reduced by ~33%).

There is a small problem with setup() in memfd_create03:
# ./memfd_create03
tst_test.c:1017: INFO: Timeout per run is 0h 05m 00s
safe_file_ops.c:220: BROK: Expected 1 conversions got 0 at memfd_create03.c:211

We should check also that "/sys/kernel/mm/hugepages" exists.
"/proc/sys/vm/nr_hugepages" exists even on systems which do not support huge pages.
# cat /proc/sys/vm/nr_hugepages
cat: /proc/sys/vm/nr_hugepages: Operation not supported

memfd_create04 is checking for it already, and reports TCONF.

---

Other than that v4 looks OK to me. I'm still looking at
testing it on aarch64.

Regards,
Jan
