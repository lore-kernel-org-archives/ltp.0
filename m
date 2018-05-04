From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 4 May 2018 16:46:21 +0300
Subject: [LTP] [PATCH v3 1/3] lib/tst_checksum: add crc32c checksum
In-Reply-To: <b2cc2d7f-7ff7-3c4d-a01d-bebc726e56e2@oracle.com>
References: <1524914997-27080-1-git-send-email-alexey.kodanev@oracle.com>
 <20180503130608.fv43iyrtep2diwzz@dell5510>
 <b2cc2d7f-7ff7-3c4d-a01d-bebc726e56e2@oracle.com>
Message-ID: <c14d9d02-2fb8-0276-d0aa-9cdecbe5a8b7@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04.05.2018 13:50, Alexey Kodanev wrote:
> On 05/03/2018 04:06 PM, Petr Vorel wrote:
>> Hi Alexey,
>>
>>> It will be used to make a SCTP packet in the test.
>>
>>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
>>> ---
>>> v3: use SPDX License-Identifier
>>
>>> v2: As suggested by Cyril:
>>>     * updated the docs, added section 2.2.25
>>>     * added 'tst_' prefix
>>>     * changed type 'int' to 'size_t' for the buffer length
>>
>>>  doc/test-writing-guidelines.txt |    6 +++
>>>  include/tst_checksum.h          |   16 ++++++++
>>>  lib/tst_checksum.c              |   81 +++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 103 insertions(+), 0 deletions(-)
>>>  create mode 100644 include/tst_checksum.h
>>>  create mode 100644 lib/tst_checksum.c
>>
>> Whole patchset LGTM.

Removed sending the packet three times, fixed SPDX License-Identifier and
applied. Thanks!
