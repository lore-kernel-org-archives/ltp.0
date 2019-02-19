From: Matthias =?unknown-8bit?q?M=C3=A4nnich?= <maennich@google.com>
Date: Tue, 19 Feb 2019 14:28:22 +0000
Subject: [LTP] [PATCH v2 2/2] rt_sigpending: add rt_sigpending02 test
	case
In-Reply-To: <2ad02580-8de8-b4a9-38a6-c14f507d8741@google.com>
References: <20190207155153.41816-1-maennich@google.com>
 <20190212161236.74385-1-maennich@google.com>
 <20190212161236.74385-3-maennich@google.com>
 <2ad02580-8de8-b4a9-38a6-c14f507d8741@google.com>
Message-ID: <5e4da8a6-f495-ebe6-f457-1a564f4ebc4d@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi!

On 16/02/2019 00:01, Steve Muckle wrote:
> On 02/12/2019 08:12 AM, 'Matthias Maennich' via kernel-team wrote:
>> This is effectively a copy of the sigpending/sigpending02 test case.
>> Both of them are now bypassing any syscall wrapper.
>>
>> Signed-off-by: Matthias Maennich <maennich@google.com>
>> ---
>>   runtest/syscalls                              |  1 +
>>   .../kernel/syscalls/rt_sigpending/.gitignore  |  1 +
>>   .../kernel/syscalls/rt_sigpending/Makefile    | 23 +++++++++
>>   .../syscalls/rt_sigpending/rt_sigpending02.c  | 48 +++++++++++++++++++
>>   4 files changed, 73 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/rt_sigpending/.gitignore
>>   create mode 100644 testcases/kernel/syscalls/rt_sigpending/Makefile
>>   create mode 100644 
>> testcases/kernel/syscalls/rt_sigpending/rt_sigpending02.c
> 
> I believe this new test should also be added to runtest/syscalls.
> 
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 668c87cd1..6280034d0 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -990,6 +990,7 @@ rmdir03A symlink01 -T rmdir03
>>   rt_sigaction01 rt_sigaction01
>>   rt_sigaction02 rt_sigaction02
>>   rt_sigaction03 rt_sigaction03
>> +rt_sigpending02 rt_sigpending02
>>   rt_sigprocmask01 rt_sigprocmask01
>>   rt_sigprocmask02 rt_sigprocmask02
>>   rt_sigqueueinfo01 rt_sigqueueinfo01 

I added rt_sigpending02 to runtest/syscalls here. sigpending02 has 
already been there before.

Cheers,
Matthias
