From: Li Wang <liwang@redhat.com>
Date: Fri, 10 Nov 2017 14:04:11 +0800
Subject: [LTP] [PATCH 2/2] mm: enlarge mmap HIGH_ADDR value for s390 arch
In-Reply-To: <436712851.37925655.1510128799182.JavaMail.zimbra@redhat.com>
References: <20171025033006.32463-1-liwang@redhat.com>
 <20171025033006.32463-2-liwang@redhat.com>
 <436712851.37925655.1510128799182.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2fuCDa9zCEco5Cbc=AEG0=9TS8mX2szMtLLJJLF0E46Lw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 8, 2017 at 4:13 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
>> The kernel commit 1aea9b3f92 (s390/mm: implement 5 level pages tables)
>> enlarge the maximum address in the tasks address space from (1UL << 53)
>> to (-PAGE_SIZE) on s390 platform.
>>
>> We have to increase the HIGH_ADDR in ltp testcases accordingly otherwise
>> that would be failed with succeeded mmap into high region:
>>
>> mmap15.c:
>> mmap15  1  TFAIL  :  mmap15.c:77: mmap into high region succeeded
>> unexpectedly
>>
>> mmapstress03.c:
>> mmapstress03: errno = 25: really large mmap didn't fail
>> mmapstress03    0  TINFO  :  uname.machine=s390x kernel is 32bit
>
>                                      Isn't this the problem? ^^

I did more test on s390x platform with upstream kernel-v4.14-rc8. It
has been proved that the mmapstress03.c failures was only caused by
wrong kernel_bits value.

So I think we have no need to raise the mmap high address in
mmapstress03.c test, but mmap15 testcase should be fixed at least.

Just adding debugging sentence temporarily to show something:
==============
--- a/testcases/kernel/mem/mmapstress/mmapstress03.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress03.c
@@ -140,6 +140,14 @@ int main(void)
                anyfail();
        }

+# define HIGH_ADDR_MAX (void *)(-pagesize)
+printf("HIGH_ADDR_MAX = %p\n", HIGH_ADDR_MAX);
+
+void * map_addr = (void*) (((uintptr_t)1) << ((sizeof(void*)<<3) -
1)) - pagesize;
+size_t map_size = (size_t) (1ULL << (kernel_bits - 1)) - pagesize;
+printf("map_addr = %p\n", map_addr);
+printf("map_size = %p\n", map_size);
+
        /* Ask for a ridiculously large mmap region@a high address */
        if (mmap((void*) (((uintptr_t)1) << ((sizeof(void*)<<3) - 1))
- pagesize,
                 (size_t) ((1ULL << (kernel_bits - 1)) - pagesize),



============
# uname -rm
4.14.0-rc8+ s390x

# ./mmapstress03
mmapstress03    0  TINFO  :  uname.machine=s390x kernel is 64bit
HIGH_ADDR_MAX = 0xfffffffffffff000
map_addr = 0x7ffffffffffff000
map_size = 0x7ffffffffffff000
mmapstress03    1  TPASS  :  Test passed


I'd like to format two new patches for kernel-bit detection and mmap15 issue.

-- 
Li Wang
liwang@redhat.com
