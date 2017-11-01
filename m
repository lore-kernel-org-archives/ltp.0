From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 1 Nov 2017 15:32:34 +0300
Subject: [LTP] [PATCH 1/3] lib: setup rhost TST_TMPDIR if net test sets
 TST_NEEDS_TMPDIR
In-Reply-To: <20171031102222.hkchibhw7qnb2oyc@dell5510>
References: <1507812041-2068-1-git-send-email-alexey.kodanev@oracle.com>
 <20171031102222.hkchibhw7qnb2oyc@dell5510>
Message-ID: <f965ee61-50e2-4fde-2aa0-4800d1b721e5@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/31/2017 01:23 PM, Petr Vorel wrote:
>> tst_tmpdir() in test_net.sh should be removed when network tests
>> converted to newer lib.
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
>> ---
>>  testcases/lib/test.sh     |    2 ++
>>  testcases/lib/test_net.sh |   12 ++++++++++++
>>  testcases/lib/tst_test.sh |    2 ++
>>  3 files changed, 16 insertions(+), 0 deletions(-)
> LGTM.
>
> <snip>
>> +if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
> I prefer "1", but that's only a detail:

Yes, quite optional here, I followed the style that is used in
test.sh/tst_test.sh already.

Applied.

Thanks,
Alexey

