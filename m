From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 3 Feb 2016 17:24:03 +0300
Subject: [LTP] [PATCH v3] syscalls/fchmodat: fix test,
 don't use test current directory
In-Reply-To: <20160203124313.GB30788@rei.lan>
References: <1454429469-4915-1-git-send-email-alexey.kodanev@oracle.com>
 <20160203124313.GB30788@rei.lan>
Message-ID: <56B20D83.3000500@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 02/03/2016 03:43 PM, Cyril Hrubis wrote:
> Hi!
>> * use tmp directory for the test files,
>> * remove hard-coded tmp directory path,
>> * test fails with more than one iteration - cleanup after
>>    each iteration,
>> * make use of safe macros.
> Acked.

Patch applied.

Thanks,
Alexey
