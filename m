From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 13 Mar 2020 16:42:40 +0800
Subject: [LTP] [PATCH v5] Add test for misaligned fallocate()
In-Reply-To: <0c8d0d4a-8eca-bd42-4c88-5cb7b87ba861@suse.cz>
References: <20200224100932.10349-1-mdoucha@suse.cz>
 <20200226135748.GD24080@rei> <0d875613-07a4-b9fe-9c83-76c2e403d6dc@suse.cz>
 <20200227141356.GA29089@rei>
 <f3cbdd28-e89c-02e1-7f4b-0b62278b6edb@cn.fujitsu.com>
 <0c8d0d4a-8eca-bd42-4c88-5cb7b87ba861@suse.cz>
Message-ID: <233e1d29-b433-ce77-f361-a5f94bb7493b@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin


> On 13. 03. 20 5:31, Yang Xu wrote:
>> Hi Cyril, Martin
>>
>> When I test this case by using btrfs, this case failed as below:
>>
>> ...
>>
>> It failed when we fill fs and not using cow. Is it a known issue(I see
>> the previous eamils, but found nothing)?
>> I also used 5.6-rc3 kernel to test, it still failed.
> 
> Yes, this is a known issue. Upstream kernel fix is currently being reviewed:
> https://patchwork.kernel.org/patch/11357415/
Thanks for a quick response.

Best Regards
Yang Xu
> 


