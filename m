From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 02 Jun 2021 11:05:29 +0100
Subject: [LTP] [PATCH v3 0/6] cfs_bandwidth01 and CGroup API
In-Reply-To: <CAEemH2c2W1Z9W3dm2LoyMbtqJxtgZjEBHF8VDU3O1ZSJ2ZQmeA@mail.gmail.com>
References: <20210601105521.27459-1-rpalethorpe@suse.com>
 <CAEemH2c2W1Z9W3dm2LoyMbtqJxtgZjEBHF8VDU3O1ZSJ2ZQmeA@mail.gmail.com>
Message-ID: <87eedkk2dy.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

>> This adds a test scheduler test which uses the cpu controller.
>>
>> Also included are some additions and fixes to the CGroup API related
>> to the test.
>>
>> V3:
>> * Reverse order of writing cpu.cfs_period_us and cpu.cfs_quota_us to fix V1.
>> * Add may_have_waiters to indicate we should try waking and cleaning up
>>   children during cleanup. At worst this can result in timeout warnings if there
>>   are less than 9 children waiting.
>>   Which is probably better than failing to cleanup the CGroups.
>
> I helped to test the patchset and push. Thanks~

Much thanks!

-- 
Thank you,
Richard.
