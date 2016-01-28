From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 28 Jan 2016 18:28:50 +0300
Subject: [LTP] [PATCH v2 6/6] kernel/syscalls/open14: openat03: add new
 test-cases
In-Reply-To: <20160128140109.GB16175@rei.lan>
References: <1453984132-6240-1-git-send-email-alexey.kodanev@oracle.com>
 <1453984132-6240-7-git-send-email-alexey.kodanev@oracle.com>
 <20160128140109.GB16175@rei.lan>
Message-ID: <56AA33B2.6000600@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 01/28/2016 05:01 PM, Cyril Hrubis wrote:
> Hi!
>> * create multiple directories and related temporary files;
>>
>> * create multiple directories and link files into them. Check
>>    that files permissions correspond to the ones specified with
>>    open()/openat().
> I would say that for newly added code it makes more sense to add new
> files in one patch. It's kind of strange to add more code to files you
> have added in previous one.

The previous patch was sent in the end of Dec, the last one quite recently.
I thought it would be easier to notice that the last one is included here
right now. Agree, it looks strange in the one patch set. Will squash it into
the previous.

Thanks,
Alexey

