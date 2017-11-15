From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 15 Nov 2017 14:56:47 +0300
Subject: [LTP] [PATCH 1/3] netstress: allow to resend requests for udp
 and dccp
In-Reply-To: <20171031105116.b5os2d7myz7yybtl@dell5510>
References: <1507813427-3737-1-git-send-email-alexey.kodanev@oracle.com>
 <20171031105116.b5os2d7myz7yybtl@dell5510>
Message-ID: <f35cc7d2-5b27-6da0-489d-c9594fa62db9@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/31/2017 01:51 PM, Petr Vorel wrote:
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
>> ---
>>  testcases/network/netstress/netstress.c |   20 ++++++++++++++++++++
>>  1 files changed, 20 insertions(+), 0 deletions(-)

I've pushed slightly modified version where timeout variable is
thread-local, also there are fixed number of retries and timeout
doubles with each failed requests up to 3 sec, so when there is
no connection, test will fail after ~30 seconds with "protocol
timeout" error.

Thanks,
Alexey

