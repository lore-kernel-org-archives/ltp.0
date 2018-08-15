From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 15 Aug 2018 18:22:15 +0300
Subject: [LTP] [PATCH RFC 1/4] lib/tst_test.c: add 'needs_drivers'
 option with tst_check_drivers cmd
In-Reply-To: <20180814170627.GA30905@dell5510>
References: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
 <20180814170627.GA30905@dell5510>
Message-ID: <18bd2ceb-23b0-5b87-4808-b0a598bf8a51@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/14/2018 08:06 PM, Petr Vorel wrote:
> Hi Alexey,
> 
>> The drivers are checked with modprobe. If modrpobe is not available
>                                             ^ typo modrpobe>> on the system, the checks are silently skipped.
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Acked-by: Petr Vorel <pvorel@suse.cz>
> 
>> ---
>>  include/tst_test.h                |    5 +++++
>>  lib/tst_test.c                    |   26 ++++++++++++++++++++++++++
>>  testcases/lib/.gitignore          |    1 +
>>  testcases/lib/Makefile            |    2 +-
>>  testcases/lib/tst_check_drivers.c |   24 ++++++++++++++++++++++++
>>  5 files changed, 57 insertions(+), 1 deletions(-)
>>  create mode 100644 testcases/lib/tst_check_drivers.c
> 
> It'd be nice to add some docs into doc/test-writing-guidelines.txt.
> 

Hi Petr,

Sure, thanks for review!

BTW, it feels like tst_kernel.h is the better place for tst_check_drivers().

Thanks,
Alexey
