From: Li Wang <liwang@redhat.com>
Date: Wed, 2 Jun 2021 15:02:44 +0800
Subject: [LTP] [PATCH v3 0/6] cfs_bandwidth01 and CGroup API
In-Reply-To: <20210601105521.27459-1-rpalethorpe@suse.com>
References: <20210601105521.27459-1-rpalethorpe@suse.com>
Message-ID: <CAEemH2c2W1Z9W3dm2LoyMbtqJxtgZjEBHF8VDU3O1ZSJ2ZQmeA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> This adds a test scheduler test which uses the cpu controller.
>
> Also included are some additions and fixes to the CGroup API related
> to the test.
>
> V3:
> * Reverse order of writing cpu.cfs_period_us and cpu.cfs_quota_us to fix V1.
> * Add may_have_waiters to indicate we should try waking and cleaning up
>   children during cleanup. At worst this can result in timeout warnings if there
>   are less than 9 children waiting.
>   Which is probably better than failing to cleanup the CGroups.

I helped to test the patchset and push. Thanks~

-- 
Regards,
Li Wang

