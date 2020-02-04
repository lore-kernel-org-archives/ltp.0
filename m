From: Rachel Sibley <rasibley@redhat.com>
Date: Tue, 4 Feb 2020 13:06:23 -0500
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E18-rc1-6213eed=2Ecki_=28stable=29?=
In-Reply-To: <1905459596.5574249.1580806970915.JavaMail.zimbra@redhat.com>
References: <cki.A43C5F6701.3LH2WNZUVM@redhat.com>
 <1905459596.5574249.1580806970915.JavaMail.zimbra@redhat.com>
Message-ID: <fd899990-b29d-7b5d-208c-aa89e5d67859@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 2/4/20 4:02 AM, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>>
>> Hello,
>>
>> We ran automated tests on a recent commit from this kernel tree:
>>
>>         Kernel repo:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>>              Commit: 6213eed0e444 - Linux 5.4.18-rc1
>>
>> The results of these automated tests are provided below.
>>
>>      Overall result: FAILED (see details below)
>>               Merge: OK
>>             Compile: OK
>>               Tests: FAILED
>>
>> All kernel binaries, config files, and logs are available for download here:
>>
>>    https://artifacts.cki-project.org/pipelines/419091
>>
>> One or more kernel tests failed:
>>
>>      ppc64le:
>>       ? LTP
> 
> b45d82cfbabc ("max_map_count: use default overcommit mode")
> should address that. CKI job is currently at LTP commit:
>    baf4ca1653a9 ("syscalls/capset01: Cleanup & convert to new library")

Thanks for the reminder :-) I will update LTP to a recent commit today to pull
in this change.

-Rachel
> 
> 

