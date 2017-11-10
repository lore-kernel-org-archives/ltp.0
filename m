From: Li Wang <liwang@redhat.com>
Date: Fri, 10 Nov 2017 16:19:14 +0800
Subject: [LTP] [PATCH 2/2] mm: enlarge mmap HIGH_ADDR value for s390 arch
In-Reply-To: <754021090.38693522.1510299948451.JavaMail.zimbra@redhat.com>
References: <20171025033006.32463-1-liwang@redhat.com>
 <20171025033006.32463-2-liwang@redhat.com>
 <436712851.37925655.1510128799182.JavaMail.zimbra@redhat.com>
 <CAEemH2eX=pXhvV04RgAHN7DTnYxkv-9edv-2k1k60WtgOQpEpw@mail.gmail.com>
 <754021090.38693522.1510299948451.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2f=TKtO+Kfc6FfiMn5xgwbj_Be-Wvq_dCJNp_L7dQHJWQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Nov 10, 2017 at 3:45 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
>> On Wed, Nov 8, 2017 at 4:13 PM, Jan Stancek <jstancek@redhat.com> wrote:
>> >
>> >
>> > ----- Original Message -----
>> >> The kernel commit 1aea9b3f92 (s390/mm: implement 5 level pages tables)
>> >> enlarge the maximum address in the tasks address space from (1UL << 53)
>> >> to (-PAGE_SIZE) on s390 platform.
>> >>
>> >> We have to increase the HIGH_ADDR in ltp testcases accordingly otherwise
>> >> that would be failed with succeeded mmap into high region:
>> >>
>> >> mmap15.c:
>> >> mmap15  1  TFAIL  :  mmap15.c:77: mmap into high region succeeded
>> >> unexpectedly
>> >>
>> >> mmapstress03.c:
>> >> mmapstress03: errno = 25: really large mmap didn't fail
>> >> mmapstress03    0  TINFO  :  uname.machine=s390x kernel is 32bit
>> >
>> >                                      Isn't this the problem? ^^
>>
>> No, It is an misinformation (for s390 platform) from LTP
>> tst_kernel_bits() function.
>
> That number is used to calculate size for mmap in mmapstress03.
> Are you saying that after commit 1aea9b3f92, mmap for size "(1 << 63) - pagesize"
> will succeed?

Hmm no, mmap for size "(1 << 63) - pagesize" still failed as we
expected on kernel-v4.14-rc8.
Indeed, now we have no need to change anything in mmapstress03.c.


-- 
Li Wang
liwang@redhat.com
